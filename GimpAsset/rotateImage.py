import math
import os
from PIL import Image, ImageStat
from functools import reduce

#set the input file names **only takes .png
#files are all files to be tiled
#rotateMe is files that will tell time or be rotated around the axes
#stayStill are files that are statically located but need to be tiled anyways
files = ["DinosaurArm2","DinosaurArmO2", "DinosaurBody2", "DinosaurBodyPnk"]
rotateMe = ["DinosaurArm2","DinosaurArmO2", "DinosaurBody2", "DinosaurBodyPnk"]
stayStill = []

#set the out image size in pixels
pIX, pIY = 600, 600
# set the tile size
width, height = 24, 24


def moveImage():
    for name in stayStill:
        if not os.path.exists(os.path.dirname(name + "ManImage/")):
            try:
                os.makedirs(os.path.dirname(name + "ManImage/"))
            except OSError as exc: # Guard against race condition
                if exc.errno != errno.EEXIST:
                    raise
        im1 = Image.open(name + ".png")
        print('moving images')

        im1.save(name + "ManImage/" + name + str(0) + ".png", format="png")

        print('finished moving')

def rotateAndSaveImages():
    ##Grab the images, rotate them and save to a folder
    for name in rotateMe:
        if not os.path.exists(os.path.dirname(name + "ManImage/")):
            try:
                os.makedirs(os.path.dirname(name + "ManImage/"))
            except OSError as exc: # Guard against race condition
                if exc.errno != errno.EEXIST:
                    raise
        im1 = Image.open(name + ".png")
        print('rotating images')
        for ang in range(0, 360, 6):
            im3 = im1.rotate(-ang)

            im3.save(name + "ManImage/" + name + str(ang) + ".png", format="png")

        print('finished rotating')

def smallifyToMap():
    ##Combine the save images into one spritemap and create a font file
    for name in files:
        if not os.path.exists(os.path.dirname("out/")):
            try:
                os.makedirs(os.path.dirname("out/"))
            except OSError as exc: # Guard against race condition
                if exc.errno != errno.EEXIST:
                    raise
    with open("out/ArraysForWatch.txt", "w+") as text_file:
        text_file.write("//Arrays: ")
    with open("out/fontsToPaste.txt", "w+") as text_file:
        text_file.write("<fonts>\n")
    with open("out/constFontArrs.txt", "w+") as text_file:
        text_file.write("var fontArr = [")
    with open("out/constJSONArrs.txt", "w+") as text_file:
        text_file.write("var jsonArr = [")
    firstRun = True
    for name in files:
        pX, pY = 0,0
        fileAng = 0
        charOffset = 0
        oldpX = 0
        oldChar = 0
        maxAng = 360
        onlyFiles = next(os.walk(name + "ManImage"))[2]
        ##do this for each image representing a minute/every 6 degrees unless there is one files
        if len(onlyFiles) > 1:
            maxAng = 360
        else:
            maxAng = 6
        if not firstRun:
            for filename in ["out/constFontArrs.txt", "out/constJSONArrs.txt"]:
                with open(filename, 'rb+') as filehandle:
                    filehandle.seek(-1, os.SEEK_END)
                    filehandle.truncate()
                with open(filename, 'a+') as filehandle:
                    filehandle.write("],")
        firstRun = False
        with open("out/constFontArrs.txt", "a+") as text_file:
            text_file.write("[")
        with open("out/constJSONArrs.txt", "a+") as text_file:
            text_file.write("[")
        for ang in range(0, maxAng, 6):
            #charOffset += ang/6
            currT = ang/6
            if pY >= pIY or (pY == 0 and pX == 0) or currT == 30 or currT == 15 or currT == 45:

                addLineToArrOut(name, currT, ang)

                if pY >= pIY or ang/6 == 30 or ang/6 == 15 or currT == 45:
                    enc_Arr += "]] </jsonData>"

                    with open("out/ArraysForWatch.txt", "a+") as text_file:
                        text_file.write("\n" + enc_Arr)

                    blank_image.save("out/out" + name + str(fileAng) +".png")

                blank_image = Image.new("RGB", (pIX, pIY))
                blank_text = "info face=out" + name + str(ang) + " size=50 bold=0 italic=0 charset=ascii unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=0,0 outline=0"
                blank_text += "\ncommon lineHeight=24 base=24 scaleW=256 scaleH=256 pages=1 packed=0"
                blank_text += "\npage id=0 file=\"out" + name + str(ang) + ".png\""
                blank_text += "\nchars count=255"
                enc_Arr = 	"<jsonData id=\"" + name + str(int(currT)) + "\"> [["

                #enc_Arr = "const " + name + str(ang) + " = [["
                pX, pY, charOffset = 0, 0, 0
                fileAng = ang
                print('working on ' + name + str(fileAng))
            im3 = Image.open(name + "ManImage/" + name + str(ang) + ".png")
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
                            if pX + width > pIX: #pX >= pIX or
                                pX = 0
                                pY += height
                            blank_image.paste(a, (pX, pY))
#Used to see if there is any weird character skipping or offsetting happening
                            if (pX - width != oldpX and pX != 0):
                                print(name, charOffset + 33, pX, pY)
                            if oldChar + 1 != charOffset:
                                print(name, charOffset + 33, pX, pY, oldChar + 33, oldpX)
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
                            oldChar = charOffset
                            charOffset += 1
#Watch wont print any character at char 173... so skip it
                            if charOffset + 33 == 173:
                                charOffset +=1
                            oldpX = pX
                            pX += width
                            with open("out/fontOut"+ name + str(fileAng) +".fnt", "w") as text_file:
                                text_file.write(blank_text)
                        except Exception as e:
                            print("error")
                            print(e)
        blank_image.save("out/out" + name + str(fileAng) +".png")
        with open("out/ArraysForWatch.txt", "a+") as text_file:
            text_file.write("\n" + enc_Arr + "]] </jsonData>")

        # with open("out/constFontArrs.txt", "a+") as text_file:
        #     text_file.write("Rez.Fonts.fnt" + name + str(int(currT)) + "], ")
    for filename in ["out/constFontArrs.txt", "out/constJSONArrs.txt"]:
        with open(filename, 'rb+') as filehandle:
            filehandle.seek(-1, os.SEEK_END)
            filehandle.truncate()
        with open(filename, 'a+') as filehandle:
            filehandle.write("]];")
    with open("out/fontsToPaste.txt", "a+") as text_file:
        text_file.write("</fonts>")
    print('finished tiling')

def addLineToArrOut(name, currT, ang):
    with open("out/fontsToPaste.txt", "a+") as text_file:
        text_file.write("<font id=\"fnt" + name + str(int(currT)) + "\"  filename=\"fonts/fontOut" + name + str(int(ang)) + ".fnt\" antialias=\"true\"/>\n")

    with open("out/constFontArrs.txt", "a+") as text_file:
        text_file.write("Rez.Fonts.fnt" + name + str(int(currT)) + ",")

    with open("out/constJSONArrs.txt", "a+") as text_file:
        text_file.write("Rez.JsonData." + name + str(int(currT)) + ",")

def main():
    moveImage()
    rotateAndSaveImages()
    smallifyToMap()
    print("done")

if __name__ == "__main__":
    main()
