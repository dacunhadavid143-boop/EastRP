# EastRP - Transfert d'une animation (FBX SayMotion / Mixamo / DeepMotion) vers le squelette Arma 3 (OFP2_ManSkeleton)
# Utilisation : Blender > onglet Scripting > Open > ce fichier > bouton Lecture (Run Script, ▶)
# Il faut dans la scène : le squelette Arma (os "Pelvis") et le squelette importé du FBX (os "Hips").
# Le mouvement est copié os par os (orientation des membres), le bassin suit la hauteur (pour se mettre à genoux).
import bpy, math
from mathutils import Matrix, Vector

NOM_ACTION = "eastrp_releve_compteur_v2"   # nom de l'animation créée (à changer pour chaque nouvelle animation)

# (os Arma, os source, (enfant Arma, enfant source) = direction principale, (gauche/droite Arma, gauche/droite source) = côté, facultatif)
EPAULES_T = ("LeftShoulder", "RightShoulder")
EPAULES_S = ("LeftShoulder", "RightShoulder")
CHAINE = [
    ("Pelvis", "Hips", ("Spine", "Spine"), (("LeftUpLeg", "RightUpLeg"), ("LeftUpLeg", "RightUpLeg"))),
    ("Spine", "Spine", ("Spine1", "Spine1"), (EPAULES_T, EPAULES_S)),
    ("Spine1", "Spine1", ("Spine2", "Spine2"), (EPAULES_T, EPAULES_S)),
    ("Spine2", "Spine2", ("Spine3", "Neck"), (EPAULES_T, EPAULES_S)),
    ("neck", "Neck", ("head", "Head"), None),
]
for c in ("Left", "Right"):
    CHAINE += [
        (c + "Shoulder", c + "Shoulder", (c + "Arm", c + "Arm"), None),
        (c + "Arm", c + "Arm", (c + "ForeArm", c + "ForeArm"), None),
        (c + "ForeArm", c + "ForeArm", (c + "Hand", c + "Hand"), None),
        (c + "Hand", c + "Hand", (c + "HandMiddle1", c + "HandMiddle1"),
            ((c + "HandIndex1", c + "HandPinky1"), (c + "HandIndex1", c + "HandPinky1"))),
        (c + "UpLeg", c + "UpLeg", (c + "Leg", c + "Leg"), None),
        (c + "Leg", c + "Leg", (c + "Foot", c + "Foot"), None),
        (c + "Foot", c + "Foot", (c + "ToeBase", c + "ToeBase"), None),
    ]

def norme(nom):
    """Nom d'os unifié : 'mixamorig:LeftUpLeg', 'LeftUpLeg' et 'l_upleg_JNT' (DeepMotion) -> 'leftupleg'."""
    n = nom.split(":")[-1].lower()
    if n.endswith("_jnt"):
        n = n[:-4]
    if n.startswith("l_"):
        n = "left" + n[2:]
    elif n.startswith("r_"):
        n = "right" + n[2:]
    return n.replace("_", "")

def trouve_armature(nom_os):
    for o in bpy.data.objects:
        if o.type == 'ARMATURE' and any(norme(b.name) == norme(nom_os) for b in o.data.bones):
            return o
    return None

def os_de(obj, nom):
    n = norme(nom)
    for pb in obj.pose.bones:
        if norme(pb.name) == n:
            return pb
    return None

def base(p, s):
    x = p.normalized()
    z = x.cross(s).normalized()
    y = z.cross(x)
    return Matrix((x, y, z)).transposed()

tgt = trouve_armature("Pelvis")
src = trouve_armature("Hips")
if tgt is None or src is None:
    raise Exception("Il faut le squelette Arma (os Pelvis) ET le squelette du FBX (os Hips) dans la scène.")

# Os utilisés (on ignore ceux qui n'existent pas)
chaine = []
for (t, s, prim, sec) in CHAINE:
    if os_de(tgt, t) and os_de(src, s) and os_de(tgt, prim[0]) and os_de(src, prim[1]):
        if sec and not all(os_de(tgt, n) for n in sec[0]) or (sec and not all(os_de(src, n) for n in sec[1])):
            sec = None
        chaine.append((t, s, prim, sec))
    else:
        print("[EastRP] os ignoré :", t, "<-", s)

act = src.animation_data.action if src.animation_data else None
if act is None:
    raise Exception("Le squelette du FBX n'a pas d'animation.")
f0, f1 = int(act.frame_range[0]), int(act.frame_range[1])
scene = bpy.context.scene
scene.frame_start, scene.frame_end = f0, f1

def pos_src(nom):
    return src.matrix_world @ os_de(src, nom).head

def pos_tgt(nom):
    return tgt.matrix_world @ os_de(tgt, nom).head

# Remise à zéro du squelette Arma
for pb in tgt.pose.bones:
    pb.rotation_mode = 'QUATERNION'
    pb.matrix_basis = Matrix.Identity(4)
bpy.context.view_layer.update()

# Référence : première image
scene.frame_set(f0)
def plat(v): return Vector((v.x, v.y, 0))
ss = plat(pos_src("RightUpLeg") - pos_src("LeftUpLeg"))
ts = plat(pos_tgt("RightUpLeg") - pos_tgt("LeftUpLeg"))
angle = math.atan2(ss.x * ts.y - ss.y * ts.x, ss.dot(ts))
R_yaw = Matrix.Rotation(angle, 3, 'Z')          # oriente le personnage source comme le squelette Arma
echelle = (pos_tgt("LeftUpLeg") - pos_tgt("LeftFoot")).length / max((pos_src("LeftUpLeg") - pos_src("LeftFoot")).length, 1e-6)
hips0 = R_yaw @ pos_src("Hips")
pelvis0 = pos_tgt("Pelvis")
print("[EastRP] rotation %.1f deg, echelle %.3f, images %d -> %d" % (math.degrees(angle), echelle, f0, f1))

# Nouvelle action pour le squelette Arma
if tgt.animation_data is None:
    tgt.animation_data_create()
action = bpy.data.actions.new(NOM_ACTION)
tgt.animation_data.action = action

for f in range(f0, f1 + 1):
    scene.frame_set(f)
    P = {}
    for (t, s, prim, sec) in chaine:
        for n in [s, prim[1]] + (list(sec[1]) if sec else []):
            if n not in P:
                P[n] = R_yaw @ pos_src(n)
    if "Hips" not in P:
        P["Hips"] = R_yaw @ pos_src("Hips")
    for pb in tgt.pose.bones:
        pb.matrix_basis = Matrix.Identity(4)
    bpy.context.view_layer.update()
    tw = tgt.matrix_world
    for (t, s, prim, sec) in chaine:
        pbT = os_de(tgt, t)
        head = tw @ pbT.head
        vt = (tw @ os_de(tgt, prim[0]).head) - head
        vs = P[prim[1]] - P[s]
        if vt.length < 1e-6 or vs.length < 1e-6:
            continue
        if sec:
            st = (tw @ os_de(tgt, sec[0][1]).head) - (tw @ os_de(tgt, sec[0][0]).head)
            sv = P[sec[1][1]] - P[sec[1][0]]
            R = base(vs, sv) @ base(vt, st).transposed()
        else:
            R = vt.rotation_difference(vs).to_matrix()
        M = tw @ pbT.matrix
        newM = Matrix.Translation(head) @ R.to_4x4() @ Matrix.Translation(-head) @ M
        if t == "Pelvis":
            newM.translation = pelvis0 + (P["Hips"] - hips0) * echelle
        pbT.matrix = tw.inverted() @ newM
        bpy.context.view_layer.update()
    for pb in tgt.pose.bones:
        pb.keyframe_insert("rotation_quaternion", frame=f, group=pb.name)
        pb.keyframe_insert("location", frame=f, group=pb.name)

scene.frame_set(f0)
print("[EastRP] Transfert terminé : action '%s', %d images." % (NOM_ACTION, f1 - f0 + 1))
