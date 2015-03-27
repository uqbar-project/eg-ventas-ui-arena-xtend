package org.uqbar.arena.examples.ventas.model

import java.util.List
import org.uqbar.commons.utils.Observable

import static org.uqbar.commons.model.ObservableUtils.firePropertyChanged
import org.eclipse.xtext.xbase.lib.Functions.Function1

@Observable
class GestorVentas {
	@Property Cliente clienteSeleccionado
	@Property List<Cliente> clientes

	@Property Producto productoSeleccionado
	@Property String busquedaProducto
	@Property List<Producto> productos
	 
	@Property List<Pedido> pedidos = newArrayList
	@Property int cantidadIngresada = 1;
	
	new() {
		filtrarClientes
		filtrarProductos
	}
	
	def crearPedido() {
		pedidos += new Pedido => [
			cliente = clienteSeleccionado
			producto = productoSeleccionado
			cantidad = cantidadIngresada 
		]
		firePropertyChanged(this, "pedidos", pedidos)
		productoSeleccionado = null
		cantidadIngresada = 1
		ordenarPedidos
	}
	
	@Property String descripcionDeProducto
	def crearProducto() {
		VentasObjectSet.getInstance.agregarProducto(new Producto => [
			descripcion = descripcionDeProducto
		])
		firePropertyChanged(this, "productos", clientes)
		descripcionDeProducto = null
		filtrarProductos
	}
	
	def void setBusquedaProducto(String nuevoValor) {
		_busquedaProducto = nuevoValor
		filtrarProductos
	}
	def filtrarProductos() {
		productos = VentasObjectSet.getInstance.todosLosProductos.filter[busquedaProducto == null || descripcion.toLowerCase.contains(busquedaProducto.toLowerCase)].toList
	}

	@Property String busquedaCliente
	@Property String nombreCliente
	@Property String apellidoCliente
	
	def void setBusquedaCliente(String nuevoValor) {
		_busquedaCliente = nuevoValor
		filtrarClientes
	}
	
	def crearCliente() {
		VentasObjectSet.getInstance.agregarCliente(new Cliente => [
			nombre = nombreCliente
			apellido = apellidoCliente
		])
		firePropertyChanged(this, "clientes", clientes)
		//
		nombreCliente = null
		apellidoCliente = null
		filtrarClientes()
	}
	def filtrarClientes() {
		clientes = VentasObjectSet.getInstance
			.todosLosClientes.filter[
				busquedaCliente == null // 
				|| nombre.toLowerCase.contains(busquedaCliente.toLowerCase) //
				|| apellido.toLowerCase.contains(busquedaCliente.toLowerCase)
				|| id.toString.contains(busquedaCliente)
		].toList
	}
	
	@Property Criterio criterioSeleccionado = Criterio.CRITERIO_FECHA
	
	def getCriteriosOrdenPedidos() {
		#[
			Criterio.CRITERIO_FECHA,
			new Criterio("cliente", [cliente.apellido]),
			new Criterio("cantidad", [cantidad])
		]
	}
	
	def void setCriterioSeleccionado(Criterio nuevo) {
		_criterioSeleccionado = nuevo
		ordenarPedidos()
	}
	
	def ordenarPedidos() {
		pedidos.sortInplaceBy(criterioSeleccionado.closure)
		firePropertyChanged(this, "pedidos", pedidos)
	}
	
}

class Criterio {
	@Property String nombre;
	@Property Function1<Pedido,Comparable> closure;
	
	new(String nombre, (Pedido)=>Comparable closure) {
		this.nombre = nombre
		this.closure = closure
	}
	
	override toString() { nombre }
	
	public static val CRITERIO_FECHA = new Criterio("fecha", [fecha]);
}