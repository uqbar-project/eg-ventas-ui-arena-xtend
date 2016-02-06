package ar.edu.ventas.ui

import org.uqbar.arena.Application

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