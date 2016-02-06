package ar.edu.ventas.ui

import org.uqbar.arena.bindings.DateTransformer
import org.uqbar.arena.examples.ventas.model.DetalleProducto
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

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
			value <=> "producto.descripcion"	
		]
		
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			
			new Label(it).text = "Codigo:"
			new Label(it).value <=> "producto.codigo"
			
			new Label(it).text = "Stock:"
			new Label(it).value <=> "producto.stock"
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
				(value <=> "fechaDesde").transformer = new DateTransformer
			]	
			
			new Label(it).text = "Hasta"	
			new TextBox(it)  => [
				width = 80
				(value <=> "fechaHasta").transformer = new DateTransformer
			]
			new Button(it) => [
				caption = "Buscar"
				onClick[| modelObject.buscar ]
			] 
		]
		new List(mainPanel) => [
			items <=> "pedidos"
			height = 250
		]
		new Label(mainPanel).value <=> "resumenBusqueda"
	}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Cerrar"
			onClick[| close ]
		]
	}
	
}