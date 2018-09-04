import math
from PIL import Image, ImageStat
from functools import reduce

def rotateAndSaveImages():
    ##Grab the images, rotate them and save to a folder
    im1 = Image.open("DinosaurBody2.png")
    im2 = Image.open("DinosaurArm2.png")
    im5 = Image.open("DinosaurBodyPnk.png")
    print('rotating images')
    for ang in range(0, 360, 6):
        im3 = im1.rotate(-ang)
        im4 = im2.rotate(-ang)
        im6 = im5.rotate(-ang)
        im3.save("BodyRotate/dinoBody" + str(ang) + ".png", format="png")
        im4.save("ArmRotate/dinoArm" + str(ang) + ".png", format="png")
        im6.save("BodyPnkRotate/dinoBodyPnk" + str(ang) + ".png", format="png")
    print('finished rotating')

def smallifyToMap():
    ##Combine the save images into one spritemap and create a font file

    with open("ArraysForWatch.txt", "w+") as text_file:
        text_file.write("//Arrays: ")

    for name in ("Body","BodyPnk", "Arm"):
        width = 24
        height = 24
        pIX, pIY = 600, 600
        pX, pY = 0,0
        fileAng = 0
        charOffset = 0

        ##do this for each image representing a minute/every 6 degrees
        for ang in range(0, 360, 6):
            charOffset += ang/6
            currT = ang/6
            if pY >= pIY or (pY == 0 and pX == 0) or currT == 30 or currT == 15 or currT == 45:
                if pY >= pIY or ang/6 == 30 or ang/6 == 15 or currT == 45:
                    enc_Arr += "]] </jsonData>"
                    with open("ArraysForWatch.txt", "a+") as text_file:
                        text_file.write("\n" + enc_Arr)
                    blank_image.save("out" + name + str(fileAng) +".png")
                blank_image = Image.new("RGB", (pIX, pIY))
                blank_text = "info face=out" + name + str(ang) + " size=50 bold=0 italic=0 charset=ascii unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=0,0 outline=0"
                blank_text += "\ncommon lineHeight=24 base=24 scaleW=256 scaleH=256 pages=1 packed=0"
                blank_text += "\npage id=0 file=\"out" + name + str(ang) + ".png\""
                blank_text += "\nchars count=60"
                enc_Arr = 	"<jsonData id=\"" + name + str(int(currT)) + "\"> [["
                #enc_Arr = "const " + name + str(ang) + " = [["
                pX, pY, charOffset = 0, 0, 0
                fileAng = ang
                print('working on ' + name + str(fileAng))
            im3 = Image.open(name + "Rotate/dino" + name + str(ang) + ".png")
            if not (pY == 0 and pX == 0):
                enc_Arr += "]"
            imgwidth, imgheight = im3.size
            for i in range(0, imgwidth, width):
                for j in range(0, imgheight, height):
                    #box = (240, 240, 240+j,240+i)
                    box = (j, i, j+height, i+width,)
                    a = im3.crop(box)
                    t = ImageStat.Stat(a).sum
                    if any(g > 0 for g in t):
                        try:
                            if pX >= pIX:
                                pX = 0
                                pY += height
                            blank_image.paste(a, (pX, pY))
                            blank_text += "\nchar id=" + str(int(charOffset + 33)) + " x=" + str(int(pX)) + " y=" + str(int(pY)) + " width=24 height=24 xoffset=0 yoffset=0 xadvance=24 page=0 chnl=15"
                            # print(str(int(charOffset + 33)) + " " + str(pX) + " " + str(pY))
                            # print(bin((int(charOffset + 33) << 20) ^ ((pX) << 10 ) ^ pY))
                            temp = str(((int(charOffset + 33) << 20) ^ ((j) << 10 ) ^ i))
                            if enc_Arr.endswith("["):
                                enc_Arr += temp
                            elif enc_Arr.endswith("]"):
                                enc_Arr += ", [" + temp
                            else:
                                enc_Arr +=  ", " + temp
                            charOffset += 1
                            pX += width
                            with open("fontOut"+ name + str(fileAng) +".fnt", "w") as text_file:
                                text_file.write(blank_text)
                        except Exception as e:
                            print(e)
        blank_image.save("out" + name + str(fileAng) +".png")
        with open("ArraysForWatch.txt", "a+") as text_file:
            text_file.write("\n" + enc_Arr + "]] </jsonData>")
    print('finished tiling')

def main():
    rotateAndSaveImages()
    smallifyToMap()
    print("done")

if __name__ == "__main__":
    main()
