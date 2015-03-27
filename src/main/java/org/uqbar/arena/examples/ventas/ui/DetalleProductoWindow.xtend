package org.uqbar.arena.examples.ventas.ui

import org.uqbar.arena.bindings.DateAdapter
import org.uqbar.arena.examples.ventas.model.DetalleProducto
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.ColumnLayout

/**
 * @author jfernandes
 */
class DetalleProductoWindow extends SimpleWindow<DetalleProducto> {

	new(WindowOwner parent, DetalleProducto model) {
		super(parent, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		new Label(mainPanel) => [
			fontSize = 22
			bindValueToProperty("producto.descripcion")	
		]
		
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			
			new Label(it).text = "Codigo:"
			new Label(it).bindValueToProperty("producto.codigo")
			
			new Label(it).text = "Stock:"
			new Label(it).bindValueToProperty("producto.stock")
		]
		
		new Label(mainPanel) => [
			text = "Pedidos"
			fontSize = 18
		]
		new Panel(mainPanel) => [
			layout = new HorizontalLayout
			
			new Label(it).text = "Desde"	
			new TextBox(it) => [
				width = 80
				bindValueToProperty("fechaDesde").transformer = new DateAdapter
			]	
			
			new Label(it).text = "Hasta"	
			new TextBox(it)  => [
				width = 80
				bindValueToProperty("fechaHasta").transformer = new DateAdapter
			]
			new Button(it) => [
				caption = "Buscar"
				onClick[| modelObject.buscar ]
			] 
		]
		new List(mainPanel) => [
			bindItemsToProperty("pedidos")
			height = 250
		]
		new Label(mainPanel).bindValueToProperty("resumenBusqueda")
	}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Cerrar"
			onClick[| close ]
		]
	}
	
}