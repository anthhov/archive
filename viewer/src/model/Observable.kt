package model

import view.Observer

interface Observable {
    fun addObserver(o: Observer)

    fun removeObserver(o: Observer)

    fun notifyObservers()
}