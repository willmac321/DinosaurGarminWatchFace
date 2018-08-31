import math
from PIL import Image, ImageStat
from functools import reduce

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
    charOffset = 0
    ##for name in ("Body", "Arm"):
    name = "Body"
    width = 24
    height = 24
    pIX, pIY = 1440,2400
    pX, pY = 0,0
    fileAng = 0
    print('working on ' + name + str(fileAng))
    blank_image = Image.new("RGB", (pIX, pIY))
    blank_text = "info face=out" + name + " size=50 bold=0 italic=0 charset=ascii unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=0,0 outline=0"
    blank_text += "\ncommon lineHeight=24 base=24 scaleW=256 scaleH=256 pages=1 packed=0"
    blank_text += "\npage id=0 file=\"out" + name + ".png\""
    blank_text += "\nchars count=60"
    ##do this for each image representing a minute/every 6 degrees
    for ang in range(0, 360, 6):
        if pY >= pIY:
            blank_image = Image.new("RGB", (pIX, pIY))
            blank_text = "info face=out" + name + str(ang) + " size=50 bold=0 italic=0 charset=ascii unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=0,0 outline=0"
            blank_text += "\ncommon lineHeight=24 base=24 scaleW=256 scaleH=256 pages=1 packed=0"
            blank_text += "\npage id=0 file=\"out" + name + str(ang) + ".png\""
            blank_text += "\nchars count=60"
            pX, pY, charOffset = 0, 0, 0
            fileAng = ang
            print('working on ' + name + str(fileAng))
        im3 = Image.open(name + "Rotate/dino" + name + str(ang) + ".png")
        im3
        imgwidth, imgheight = im3.size
        for i in range(0, imgwidth, width):
            for j in range(0, imgheight, height):
                #box = (240, 240, 240+j,240+i)
                box = (j, i, j+height, i+width,)
                a = im3.crop(box)
                t = ImageStat.Stat(a).sum
                if any(l > 0 for l in t):
                    try:
                        if pX >= pIX:
                            pX = 0
                            pY += height
                        blank_image.paste(a, (pX, pY))
                        blank_text += "\nchar id=" + str(int(ang/6 + charOffset + 33)) + " x=" + str(int(pX)) + " y=" + str(int(pY)) + " width=24 height=24 xoffset=0 yoffset=0 xadvance=24 page=0 chnl=15"
                        charOffset += 1
                        pX += width
                        blank_image.save("out" + name + str(fileAng) +".png")
                        with open("fontOut"+ name + str(fileAng) +".fnt", "w") as text_file:
                            text_file.write(blank_text)
                    except:
                        print("error")

def main():
    smallifyToMap()
    print("done")

if __name__ == "__main__":
    main()
