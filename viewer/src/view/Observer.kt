package view

import java.awt.image.BufferedImage

interface Observer {
    fun update(bufferedImage: BufferedImage)
}