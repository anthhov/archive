package model

import view.Observer
import java.awt.Color
import java.awt.image.BufferedImage
import java.io.File
import java.io.FileInputStream
import java.util.*

class Bmp8Model: Model, Observable {
    var observers = LinkedList<Observer>()

    override fun addObserver(o: Observer) {
        observers.add(o)
    }

    override fun removeObserver(o: Observer) {
        observers.remove(o)
    }

    override fun notifyObservers() {
        for (observer in observers)
            observer.update(image!!)
    }

    var image: BufferedImage? = null

    val imageInfo = HashMap<String, Long>()

    override fun parseFile(filepath: String) {
        val file = File(filepath)
        val fileBytes = ByteArray(file.length().toInt())

        val FileInputStream = FileInputStream(file)
        FileInputStream.read(fileBytes)
        FileInputStream.close()

        if (fileBytes[0].toChar() != 'B' || fileBytes[1].toChar() != 'M') {
            println("File is not identified as BM")
            return
        }

        if (getData(fileBytes, 0x0E, 4).toInt() == 40) {
            imageInfo.put("bfType", getData(fileBytes, 0x00, 2))
            imageInfo.put("bfSize", getData(fileBytes, 0x02, 4))
            imageInfo.put("bfOffBits", getData(fileBytes, 0x0A, 4))

            imageInfo.put("biSize", getData(fileBytes, 0x0E, 4))
            imageInfo.put("biWidth", getData(fileBytes, 0x12, 4))
            imageInfo.put("biHeight", getData(fileBytes, 0x16, 4))
            imageInfo.put("biPlanes", getData(fileBytes, 0x1A, 2))
            imageInfo.put("biBitCount", getData(fileBytes, 0x1C, 2))
            imageInfo.put("biCompression", getData(fileBytes, 0x1E, 2))
            imageInfo.put("biSizeImage", getData(fileBytes, 0x22, 4))
            imageInfo.put("biXPelsPerMeter", getData(fileBytes, 0x26, 4))
            imageInfo.put("biYPelsPerMeter", getData(fileBytes, 0x2A, 4))
            imageInfo.put("biClrUsed", getData(fileBytes, 0x2E, 4))
            imageInfo.put("biClrImportant", getData(fileBytes, 0x32, 4))
        }
        else
            return

        convertToImage(fileBytes)
        notifyObservers()
    }

    override fun convertToImage(fileBytes: ByteArray) {
        val colorTable = fileBytes.copyOfRange(0x36, imageInfo["bfOffBits"]!!.toInt() - 1)
        val pixelArray = fileBytes.copyOfRange(imageInfo["bfOffBits"]!!.toInt(), imageInfo["bfSize"]!!.toInt())

        val height = imageInfo["biHeight"]!!.toInt()
        val width = imageInfo["biWidth"]!!.toInt()

        image = BufferedImage(width, height, 1)

        var index = pixelArray.size - 1
        val shift = (index + 1) / height - width

        for (i in 0..height - 1) {
            index -= shift

            for (j in width - 1 downTo 0) {
                var pix = pixelArray[index--].toInt()
                if (pix < 0)
                    pix += 256

                pix = pix shl 2

                var blue = colorTable[pix++].toInt()
                if (blue < 0)
                    blue += 256

                var green = colorTable[pix++].toInt()
                if (green < 0)
                    green += 256

                var red = colorTable[pix].toInt()
                if (red < 0)
                    red += 256

                val rgb = Color(red, green, blue).rgb

                image!!.setRGB(j, i, rgb)
            }
        }
    }

    private fun getData(byteArray: ByteArray, index: Int, length: Int): Long {
        var data: Long = 0

        for (i in length - 1 downTo 0) {
            var tmp: Long = byteArray[index + i].toLong()

            if (tmp < 0)
                tmp += 256

            data = data shl 8
            data += tmp
        }

        return data
    }
}