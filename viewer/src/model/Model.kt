package model

interface Model {
    fun parseFile(filepath: String)

    fun convertToImage(fileBytes: ByteArray)
}