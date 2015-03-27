package org.uqbar.arena.examples.ventas.ui

import org.uqbar.arena.Application
import org.uqbar.arena.examples.ventas.VentasWindow

/**
 * @author jfernandes
 */
class VentasApplication extends Application {
	
	override protected createMainWindow() {
		new VentasWindow(this)		
	}
	
	def static void main(String[] args) {
		new VentasApplication().start
	}
	
}