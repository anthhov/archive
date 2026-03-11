package view

import java.awt.image.BufferedImage

interface Viewer {
    fun displayImage(bufferedImage: BufferedImage)
}