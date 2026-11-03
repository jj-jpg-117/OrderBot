import Foundation
import SwiftData

/// Pedido persistido localmente (tabla `pedidos` de Room).
///
/// SwiftData identifica cada objeto con `PersistentIdentifier`, por eso
/// se conserva `numeroPedido` como número visible: ocupa el lugar del
/// `id` autogenerado por SQLite que veía el usuario.
@Model
final class PedidoEntity {

    /// Número de pedido visible (equivalente al `id` autoincremental).
    @Attribute(.unique) var numeroPedido: Int
    var direccion: String
    var metodoPago: String
    var subtotal: Int
    var costoEnvio: Int
    var total: Int
    var fecha: Date

    /// Relación 1:N con borrado en cascada (igual que `onDelete = CASCADE`).
    @Relationship(deleteRule: .cascade, inverse: \ItemPedidoEntity.pedido)
    var items: [ItemPedidoEntity] = []

    init(
        numeroPedido: Int,
        direccion: String,
        metodoPago: String,
        subtotal: Int,
        costoEnvio: Int,
        total: Int,
        fecha: Date = .now
    ) {
        self.numeroPedido = numeroPedido
        self.direccion = direccion
        self.metodoPago = metodoPago
        self.subtotal = subtotal
        self.costoEnvio = costoEnvio
        self.total = total
        self.fecha = fecha
    }
}

/// Renglón de un pedido (tabla `items_pedido` de Room).
@Model
final class ItemPedidoEntity {

    var productoId: String
    var cantidad: Int

    /// Lado inverso de la relación; SwiftData lo rellena al insertar.
    var pedido: PedidoEntity?

    init(productoId: String, cantidad: Int, pedido: PedidoEntity? = nil) {
        self.productoId = productoId
        self.cantidad = cantidad
        self.pedido = pedido
    }
}
