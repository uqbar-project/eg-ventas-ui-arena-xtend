# Gestor de ventas

Una aplicación que vende

* un producto
* para un cliente

![image](https://cloud.githubusercontent.com/assets/4549002/17306526/dc88f8ec-5806-11e6-9e08-92447768fdde.png)

Esto va generando pedidos en una determinada fecha.

## Conceptos interesantes

* Tiene un layout complejo
* Tiene un application model que maneja el estado no trivial del caso de uso de la venta
* Hay widgets interesantes como el spinner, el list box, el radio button que establece el criterio de ordenamiento
* Tanto el cliente como el producto tienen una búsqueda rápida (se escribe un valor y eso selecciona los elementos del listbox)
* Hay una segunda ventana que permite filtrar por un rango de fechas y tiene su propio appmodel.
