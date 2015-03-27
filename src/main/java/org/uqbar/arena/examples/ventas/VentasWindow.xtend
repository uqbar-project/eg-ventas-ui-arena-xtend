package org.uqbar.arena.examples.ventas

import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.examples.ventas.model.DetalleProducto
import org.uqbar.arena.examples.ventas.model.GestorVentas
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Spinner
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.examples.ventas.model.Cliente
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.widgets.RadioSelector
import org.uqbar.lacar.ui.impl.jface.radiogroup.RadioGroup

/**
 * @author jfernandes
 */
class VentasWindow extends SimpleWindow<GestorVentas> {
	
	new(WindowOwner owner) {
		super(owner, new GestorVentas)
		title = "Gestor de Ventas"
	}
	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [	
			layout = new HorizontalLayout
		
			crearPanelDeClientes(it)
			crearPanelDeProductos(it)
			crearPanelDePedidos(it)
		]
	}
	
	def crearPanelDeClientes(Panel mainPanel) {
		new Panel(mainPanel) => [
			new Label(it) => [ text = "Clientes" fontSize = 18 ]
			new TextBox(it).bindValueToProperty("busquedaCliente")
			
			new List(it) => [
				bindItemsToProperty("clientes")
				bindValueToProperty("clienteSeleccionado")
				width = 220
				height = 220
			]
			
			new Label(it).text = "Nombre"
			new TextBox(it).bindValueToProperty("nombreCliente")
			
			new Label(it).text = "Apellido"
			new TextBox(it).bindValueToProperty("apellidoCliente")
			
			new Button(it) => [
				caption = "Agregar"
				onClick[| modelObject.crearCliente ]				
			]
		]
	}
	
	def crearPanelDeProductos(Panel mainPanel) {
		new Panel(mainPanel) => [
			new Label(it) => [ text = "Productos" fontSize = 18 ]
			new TextBox(it).bindValueToProperty("busquedaProducto")
			new Panel(it) => [
				layout = new HorizontalLayout
				new List(it) => [
					bindItemsToProperty("productos")
					bindValueToProperty("productoSeleccionado")
					width = 220
					height = 220
				]
				new Button(it) => [
					caption = "Detalle"
					onClick[|
						val nextModel = new DetalleProducto(modelObject, modelObject.productoSeleccionado)
						val window = new DetalleProductoWindow(this, nextModel)
						window.open()
					]
					bindEnabled(new NotNullObservable("productoSeleccionado"))
				]
			]
			
			new Label(it).text = "Descripcion"
			new TextBox(it).bindValueToProperty("descripcionDeProducto")
			
			new Button(it) => [
				caption = "Agregar"
				onClick[| modelObject.crearProducto ]				
			]
		]
	}
	
	def crearPanelDePedidos(Panel mainPanel) {
		new Panel(mainPanel) => [
			new Label(it) => [ text = "Pedidos" fontSize = 18 ]
			
			new RadioSelector(it) => [
				bindItemsToProperty("criteriosOrdenPedidos")
				bindValueToProperty("criterioSeleccionado")
			]
			
			new List(it) => [
				bindItemsToProperty("pedidos")
				width = 300
				height = 220
			]
			new Panel(it) => [
				layout = new HorizontalLayout
				new Label(it).text = "Cliente"
				new Label(it) => [ bindValueToProperty("clienteSeleccionado"); width = 200 ]
			]	
			new Panel(it) => [
				layout = new HorizontalLayout		
				new Label(it).text = "Producto"
				new Label(it) => [ bindValueToProperty("productoSeleccionado.descripcion"); width = 200 ]
			]
			new Panel(it) => [
				layout = new HorizontalLayout	
				new Label(it).text = "Cantidad"
				new Spinner(it) => [ bindValueToProperty("cantidadIngresada"); width = 200 ]
			]
			
			new Button(it) => [
				caption = "Crear"
				onClick[| modelObject.crearPedido ]				
			]
		]
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
}