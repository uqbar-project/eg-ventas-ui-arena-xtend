package org.uqbar.arena.examples.ventas.model

import java.util.Date
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

/**
 * App model
 */
@Observable
class DetalleProducto {
	GestorVentas gestor
	@Property Producto producto
	@Property Date fechaDesde
	@Property Date fechaHasta
	@Property List<Pedido> pedidos
	
	new(GestorVentas gestor, Producto producto) {
		this.gestor = gestor
		this.producto = producto
	}
	
	def buscar() {
		pedidos = producto.buscarPedidos(gestor, fechaDesde, fechaHasta)
		ObservableUtils.firePropertyChanged(this, "resumenBusqueda", resumenBusqueda)
	}
	
	def getResumenBusqueda() {
		if (fechaDesde != null && fechaHasta != null)
			'''«pedidos.size» encontrados en «daysBetween(fechaDesde, fechaHasta)» dias'''
		else
			""
	}
	
	def int daysBetween(Date d1, Date d2) {
       ((d2.time - d1.time) / (1000 * 60 * 60 * 24)) as int
    }
}