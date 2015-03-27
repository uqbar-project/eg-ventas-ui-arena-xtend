package org.uqbar.arena.examples.ventas.model

import java.util.List

/**
 * @author jfernandes
 */
class VentasObjectSet {
	static val INSTANCE = new VentasObjectSet
	static var idCliente = 0
	@Property List<Cliente> todosLosClientes = newArrayList
	static var codigoProducto = 0
	@Property List<Producto> todosLosProductos = newArrayList
	
	new() {
		agregarCliente(new Cliente => [ nombre = "Juan" apellido = "Perez" ])
		agregarCliente(new Cliente => [ nombre = "Emilio" apellido = "Disi" ])
		agregarCliente(new Cliente => [ nombre = "Maria" apellido = "Lopez" ])
		agregarCliente(new Cliente => [ nombre = "Alberto" apellido = "Suarez" ])
		
		agregarProducto(new Producto => [ descripcion = "Cable HDMI" ])
		agregarProducto(new Producto => [ descripcion = "MousePad" ])
		agregarProducto(new Producto => [ descripcion = "Bluetooth USB" ])
		agregarProducto(new Producto => [ descripcion = "WDTV" ])
		agregarProducto(new Producto => [ descripcion = "Disco Externo 1TB" ])
	}
	
	def static getInstance() { 
		INSTANCE
	}
	
	def agregarCliente(Cliente cliente) {
		cliente.id = idCliente++
		todosLosClientes += cliente
	}
	
	def agregarProducto(Producto producto) {
		producto.codigo = codigoProducto++
		todosLosProductos += producto
	}
}