package view

import controller.BmpController
import java.awt.image.BufferedImage
import javax.swing.JFrame

class BmpViewer: Viewer, Observer {
    override fun update(bufferedImage: BufferedImage) {
        displayImage(bufferedImage)
    }

    override fun displayImage(bufferedImage: BufferedImage) {
        val frame = JFrame("Display image")
        frame.defaultCloseOperation = JFrame.EXIT_ON_CLOSE

        val panel = DrawImage(bufferedImage)
        frame.contentPane.add(panel)
        frame.setSize(bufferedImage.width, bufferedImage.height)
        frame.isVisible = true
    }

    companion object {
        @JvmStatic fun main(args: Array<String>) {
            val bmpViewer = BmpViewer()

            while(true) {
                println("Type file path...")
                val path = readLine()!!

                BmpController(bmpViewer).validateFormat(path)
                BmpController(bmpViewer).chooseModel(path)
            }
        }
    }
}