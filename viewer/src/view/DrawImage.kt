package view

import java.awt.Graphics
import java.awt.Panel
import java.awt.image.BufferedImage

class DrawImage(var bufferedImage: BufferedImage): Panel() {
    override fun paint(g: Graphics) {
        g.drawImage(bufferedImage, 0, 0, this)
    }
}