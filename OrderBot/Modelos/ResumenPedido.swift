import Foundation

/// Un renglón del pedido: un producto y cuántas unidades se pidieron.
struct ItemPedido: Identifiable, Hashable {
    let producto: Producto
    let cantidad: Int

    /// La clave de `ForEach` es el producto: así la fila no se recrea
    /// cuando cambia la cantidad.
    var id: String { producto.id }

    init(producto: Producto, cantidad: Int) {
        precondition(cantidad > 0, "La cantidad debe ser positiva, era \(cantidad)")
        self.producto = producto
        self.cantidad = cantidad
    }

    /// Precio unitario × cantidad.
    var total: Int { producto.precio * cantidad }

    /// Devuelve una copia del renglón con otra cantidad
    /// (equivalente a `data class .copy(cantidad = ...)` en Kotlin).
    func conCantidad(_ nuevaCantidad: Int) -> ItemPedido {
        ItemPedido(producto: producto, cantidad: nuevaCantidad)
    }
}

/// Lógica de negocio del pedido.
///
/// Extraída de la UI para que sea testeable con pruebas unitarias
/// simples (ver `Pruebas/ResumenPedidoTests.swift`).
struct ResumenPedido: Equatable {
    let items: [ItemPedido]
    let precioEnvio: Int

    init(items: [ItemPedido], precioEnvio: Int = Catalogo.precioEnvio) {
        self.items = items
        self.precioEnvio = precioEnvio
    }

    /// Suma de (precio × cantidad) de todos los ítems.
    var subtotal: Int { items.reduce(0) { $0 + $1.total } }

    /// Subtotal más el costo de envío.
    var total: Int { subtotal + precioEnvio }

    var estaVacio: Bool { items.isEmpty }
}
