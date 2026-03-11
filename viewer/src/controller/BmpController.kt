package controller

import model.Bmp24Model
import model.Bmp8Model
import sun.awt.image.ImageFormatException
import view.BmpViewer
import java.io.File
import java.io.FileInputStream

class BmpController (val ImageViewer: BmpViewer): Controller {
    override fun validateFormat(filepath: String) {
        val extension = filepath.substring(filepath.length - 4)

        if (extension != ".bmp" && extension != ".dib")
            throw ImageFormatException("Wrong file type!")
    }

    override fun chooseModel(filepath: String) {
        val file = File(filepath)
        val fileBytes = ByteArray(file.length().toInt())

        val FileInputStream = FileInputStream(file)
        FileInputStream.read(fileBytes)
        FileInputStream.close()

        if (getBiBitCount(fileBytes) == 8) {
            val model = Bmp8Model()
            model.addObserver(ImageViewer)
            model.parseFile(filepath)
        }
        else if (getBiBitCount(fileBytes) == 24) {
            val model = Bmp24Model()
            model.addObserver(ImageViewer)
            model.parseFile(filepath)
        }
        else {
            return
        }
    }

    private fun getBiBitCount(byteArray: ByteArray): Int {
        var data: Int = 0

        for (i in 1 downTo 0) {
            var tmp: Int = byteArray[0x1C + i].toInt()

            if (tmp < 0)
                tmp += 256

            data = data shl 8
            data += tmp
        }

        return data
    }
}