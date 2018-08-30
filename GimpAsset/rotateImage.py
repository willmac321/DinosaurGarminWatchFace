import math
from PIL import Image

def rotateAndSaveImages():
    ##Grab the images, rotate them and save to a folder
    im1 = Image.open("DinosaurBody2.png")
    im2 = Image.open("DinosaurArm2.png")

    for ang in range(0, 360, 6):
        im3 = im1.rotate(ang)
        im4 = im2.rotate(ang)
        im3.save("BodyRotate/dinoBody" + str(ang) + ".png", format="png")
        im4.save("ArmRotate/dinoArm" + str(ang) + ".png", format="png")

def smallifyToMap():
    ##Combine the save images into one spritemap and create a font file
    for name in ("Body", "Arm"):
        row = 0
        col = 0
        blank_image = Image.new("RGB", (1440,2400))
        blank_text = "info face=outBody size=50 bold=0 italic=0 charset=ascii unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=0,0 outline=0"
        blank_text += "\ncommon lineHeight=240 base=240 scaleW=256 scaleH=256 pages=1 packed=0"
        blank_text +=    "\npage id=0 file=\"out" + name + ".png\""
        blank_text +=    "\nchars count=60"
        for ang in range(0, 5, 6):
            im3 = Image.open(name + "Rotate/dino" + name + str(ang) + ".png")
            height = 24
            width = 24
            imgwidth, imgheight = im3.size
            for i in range(0,imgheight,height):
                for j in range(0,imgwidth,width):
                    #box = (240, 240, 240+j,240+i)
                    box = (j, i, j+width, i+height)
                    print(box)
                    a = im3.crop(box)
                    try:
                        o = a.crop(box)
                        if ang/6 % 6 == 0 and ang != 0:
                            row += 240
                            col = 0
                        #print(col, row)
                        blank_image.paste(o, (i,j))
                        #print('x: ' + str(j),'y: '  + str(i))
                        blank_text += "\nchar id=" + str(int(ang/6+i/24 + j/24 +33)) + " x=" + str(row+i/24) + " y=" + str(col+i/24) + " width=240 height=240 xoffset=0 yoffset=0 xadvance=240 page=0 chnl=15"
                        col +=240
                        blank_image.save("out" + name + ".png")
                        with open("fontOut"+ name + ".fnt", "w") as text_file:
                            text_file.write(blank_text)
                    except:
                        print("error")

def main():
    smallifyToMap()

if __name__ == "__main__":
    main()
