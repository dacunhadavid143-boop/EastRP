from PIL import Image, ImageDraw, ImageFilter
import sys; sys.path.insert(0,'/root/tools')
from paa import write_paa
S=512
def new(): return Image.new('RGBA',(S,S),(0,0,0,0))
def fin(img,name):
    sh=img.split()[3].filter(ImageFilter.GaussianBlur(10))
    shadow=Image.new('RGBA',(S,S),(0,0,0,0)); shadow.putalpha(sh.point(lambda v:int(v*0.35)))
    base=Image.new('RGBA',(S,S),(0,0,0,0)); base.alpha_composite(shadow,(8,10)); base.alpha_composite(img)
    out=base.resize((128,128),Image.LANCZOS)
    out.save(f'/root/eastrp_core/preview_{name}.png')
    write_paa(out,f'/root/eastrp_core/data/{name}_ca.paa')

# Bouteille d'eau
im=new(); d=ImageDraw.Draw(im)
d.rounded_rectangle((200,40,312,90),12,fill=(30,90,200,255))            # bouchon
d.rectangle((215,90,297,130),fill=(170,215,245,200))                    # goulot
d.polygon([(215,130),(297,130),(350,190),(162,190)],fill=(170,215,245,210))
d.rounded_rectangle((162,185,350,470),30,fill=(150,205,245,215))       # corps
d.rectangle((162,270,350,370),fill=(25,110,210,255))                    # étiquette
d.text((205,300),"EAU",fill=(255,255,255,255),font_size=60)
d.rounded_rectangle((185,200,210,450),10,fill=(255,255,255,110))        # reflet
fin(im,'water')

# Sandwich
im=new(); d=ImageDraw.Draw(im)
d.polygon([(60,330),(452,330),(256,90)],fill=(225,180,110,255))        # pain dessus
d.polygon([(85,320),(427,320),(256,115)],fill=(245,215,160,255))
d.rounded_rectangle((55,330,457,355),10,fill=(90,180,70,255))          # salade
d.rounded_rectangle((60,352,452,378),8,fill=(215,60,50,255))           # tomate
d.rounded_rectangle((60,375,452,400),8,fill=(240,200,80,255))          # fromage
d.rounded_rectangle((55,398,457,445),14,fill=(225,180,110,255))        # pain dessous
fin(im,'sandwich')

# Ration
im=new(); d=ImageDraw.Draw(im)
d.polygon([(90,170),(330,120),(430,170),(190,220)],fill=(140,140,90,255))  # dessus
d.polygon([(90,170),(190,220),(190,420),(90,370)],fill=(95,100,60,255))   # côté
d.polygon([(190,220),(430,170),(430,370),(190,420)],fill=(115,120,72,255))# face
d.polygon([(210,270),(410,228),(410,290),(210,332)],fill=(230,225,200,255))
d.text((240,262),"RATION",fill=(60,60,40,255),font_size=44)
fin(im,'ration')
print('ok')
