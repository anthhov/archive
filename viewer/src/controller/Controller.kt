package controller

interface Controller {
    fun validateFormat(filepath: String)

    fun chooseModel(filepath: String)
}