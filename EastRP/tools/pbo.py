"""Construit un .pbo non compressé (avec préfixe) depuis un dossier."""
import os, struct, hashlib, sys, time
def build(src, out, prefix):
    files=[]
    for root,_,fs in os.walk(src):
        for f in sorted(fs):
            p=os.path.join(root,f); rel=os.path.relpath(p,src).replace('/','\\')
            files.append((rel,open(p,'rb').read()))
    files.sort(key=lambda x:x[0].lower())
    h=b'\0'+struct.pack('<5I',0x56657273,0,0,0,0)+b'prefix\0'+prefix.encode()+b'\0\0'
    ts=int(time.time())
    for rel,d in files:
        h+=rel.encode('utf-8')+b'\0'+struct.pack('<5I',0,len(d),0,ts,len(d))
    h+=b'\0'+b'\0'*20
    data=h+b''.join(d for _,d in files)
    open(out,'wb').write(data+b'\0'+hashlib.sha1(data).digest())
if __name__=='__main__': build(sys.argv[1],sys.argv[2],sys.argv[3])
