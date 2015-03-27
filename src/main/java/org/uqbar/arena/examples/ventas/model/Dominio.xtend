package org.uqbar.arena.examples.ventas.model

import java.text.SimpleDateFormat
import java.util.Date
import org.uqbar.commons.utils.Observable

@Observable
class Cliente {
	@Property long id = System.currentTimeMillis
	@Property String nombre
	@Property String apellido

	override toString() { '''(«id») «apellido», «nombre»''' }
}

@Observable
class Pedido {
	@Property Date fecha = new Date
	@Property Cliente cliente
	@Property Producto producto
	@Property int cantidad
	override toString() {
		'''[«new SimpleDateFormat("dd/MM/yy").format(fecha)»] «cliente.apellido»: «cantidad» x «producto.descripcion»'''
	}
}
@Observable
class Producto {
	@Property long codigo = System.currentTimeMillis
	@Property String descripcion
	@Property int stock = 0

	override toString() { '''(«codigo») «descripcion»''' }
	
	def buscarPedidos(GestorVentas gestor, Date fechaDesde, Date fechaHasta) {
		gestor.pedidos.filter[p|
			p.producto == this && 
			(fechaDesde == null || p.fecha.after(fechaDesde))
			&& (fechaHasta == null || p.fecha.before(fechaHasta))
		].toList
	}

}