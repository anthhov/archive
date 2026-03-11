package model

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import java.awt.image.BufferedImage
import java.io.File
import java.io.FileInputStream
import java.util.ArrayList
import javax.imageio.ImageIO

internal class Bmp24ModelTest {
    fun compareImages(imgA: BufferedImage, imgB: BufferedImage): Boolean {
        if (imgA.width == imgB.width && imgA.height == imgB.height) {
            val width = imgA.width
            val height = imgA.height

            for (i in 0..width - 1)
                for (j in 0..height - 1)
                    if (imgA.getRGB(i, j) != imgB.getRGB(i, j))
                        return false
            }
        else
            return false

        return true
    }

    @Test
    fun convertToImage() {
        val paths = ArrayList<String>()

        paths.add("/home/anton/Desktop/PictureViewer/bmp/beaut_24bit.bmp")
        paths.add("/home/anton/Desktop/PictureViewer/bmp/dodj_24bit.bmp")
        paths.add("/home/anton/Desktop/PictureViewer/bmp/haker_24bit.bmp")
        paths.add("/home/anton/Desktop/PictureViewer/bmp/love_24bit.bmp")
        paths.add("/home/anton/Desktop/PictureViewer/bmp/ogon_24bit.bmp")
        paths.add("/home/anton/Desktop/PictureViewer/bmp/per_24bit.bmp")
        paths.add("/home/anton/Desktop/PictureViewer/bmp/su85_24bit.bmp")
        paths.add("/home/anton/Desktop/PictureViewer/bmp/taet_led_24bit.bmp")
        paths.add("/home/anton/Desktop/PictureViewer/bmp/warrios_24bit.bmp")

        for (filepath in paths) {
            val file = File(filepath)
            val fileBytes = ByteArray(file.length().toInt())

            val FileInputStream = FileInputStream(file)
            FileInputStream.read(fileBytes)
            FileInputStream.close()

            val model = Bmp24Model()
            model.parseFile(filepath)

            println(filepath)
            assertEquals(compareImages(model.image!!, ImageIO.read(file)), true)
        }
    }
}