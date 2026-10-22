"""Ecrit des textures Arma .paa (DXT5) depuis des images PIL. Encodeur DXT5 simple (boite englobante)."""
import struct, numpy as np
from PIL import Image

def _c565(c):
    r,g,b = [int(x) for x in c]
    return ((r>>3)<<11)|((g>>2)<<5)|(b>>3)
def _u565(v):
    r=(v>>11)&31; g=(v>>5)&63; b=v&31
    return np.array([(r<<3)|(r>>2),(g<<2)|(g>>4),(b<<3)|(b>>2)],float)

def _block(px):  # px: 16x4 uint8 RGBA
    a = px[:,3].astype(int)
    a0,a1 = a.max(), a.min()
    if a0==a1:
        ab = struct.pack('<BB',a0,a1)+b'\0'*6
    else:
        pal=[a0,a1]+[((7-i)*a0+i*a1)//7 for i in range(1,7)]
        idx=[int(np.argmin([abs(x-p) for p in pal])) for x in a]
        bits=0
        for i,v in enumerate(idx): bits|=v<<(3*i)
        ab=struct.pack('<BB',a0,a1)+bits.to_bytes(6,'little')
    rgb=px[:,:3].astype(float)
    w = (a>8)
    src = rgb[w] if w.any() else rgb
    mx, mn = src.max(0), src.min(0)
    c0,c1=_c565(mx),_c565(mn)
    if c0<c1: c0,c1=c1,c0
    if c0==c1:
        return ab+struct.pack('<HHI',c0,c1,0)
    e0,e1=_u565(c0),_u565(c1)
    pal=[e0,e1,(2*e0+e1)/3,(e0+2*e1)/3]
    bits=0
    for i in range(16):
        d=[((rgb[i]-p)**2).sum() for p in pal]
        bits|=int(np.argmin(d))<<(2*i)
    return ab+struct.pack('<HHI',c0,c1,bits)

def dxt5(img):
    a=np.asarray(img.convert('RGBA'))
    h,w,_=a.shape
    out=bytearray()
    for by in range(0,h,4):
        for bx in range(0,w,4):
            out+=_block(a[by:by+4,bx:bx+4].reshape(16,4))
    return bytes(out)

def write_paa(img, path):
    img=img.convert('RGBA')
    w,h=img.size
    mips=[]; cur=img
    while True:
        mips.append(cur)
        if cur.size[0]<=4 or cur.size[1]<=4: break
        cur=cur.resize((max(4,cur.size[0]//2),max(4,cur.size[1]//2)),Image.LANCZOS)
    arr=np.asarray(img).reshape(-1,4)
    avg=arr.mean(0).astype(int); mxc=arr.max(0)
    def tag(name,data): return b'GGAT'+name[::-1].encode()+struct.pack('<I',len(data))+data
    # couleurs stockées en BGRA
    head=b'\x05\xff'
    head+=tag('AVGC',bytes([avg[2],avg[1],avg[0],avg[3]]))
    head+=tag('MAXC',bytes([mxc[2],mxc[1],mxc[0],mxc[3]]))
    head+=tag('FLAG',bytes([1,255,255,255]))
    offs_pos=len(head)+12
    head+=tag('OFFS',b'\0'*64)
    head+=b'\0\0'  # palette vide
    body=bytearray(); offs=[]
    for m in mips:
        offs.append(len(head)+len(body))
        d=dxt5(m)
        body+=struct.pack('<HH',m.size[0],m.size[1])+len(d).to_bytes(3,'little')+d
    body+=b'\0'*6
    head=bytearray(head)
    head[offs_pos:offs_pos+64]=struct.pack('<16I',*(offs+[0]*(16-len(offs))))
    open(path,'wb').write(bytes(head)+bytes(body))
