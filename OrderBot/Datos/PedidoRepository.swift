import Foundation
import SwiftData

/// Puerta de acceso única a la base de datos local.
///
/// Sustituye a `PedidoRepository` + `PedidoDao` de Room: SwiftData no
/// necesita DAO aparte, así que el guardado transaccional vive aquí.
@MainActor
final class PedidoRepository {

    private let contexto: ModelContext

    init(contexto: ModelContext) {
        self.contexto = contexto
    }

    /// Persiste el pedido y devuelve su número.
    ///
    /// Inserta pedido + ítems y hace un único `save()`, el equivalente
    /// a la función `@Transaction` de Room: o se guarda todo o nada.
    func guardarPedido(
        _ resumen: ResumenPedido,
        direccion: String,
        metodoPago: MetodoPago
    ) throws -> Int {
        let numero = siguienteNumero()

        let pedido = PedidoEntity(
            numeroPedido: numero,
            direccion: direccion,
            metodoPago: metodoPago.rawValue,
            subtotal: resumen.subtotal,
            costoEnvio: resumen.precioEnvio,
            total: resumen.total
        )
        contexto.insert(pedido)

        for item in resumen.items {
            let entidad = ItemPedidoEntity(
                productoId: item.producto.id,
                cantidad: item.cantidad,
                pedido: pedido
            )
            contexto.insert(entidad)
        }

        do {
            try contexto.save()
        } catch {
            contexto.rollback()
            throw error
        }

        return numero
    }

    /// Número siguiente al último guardado (empieza en 1, como SQLite).
    private func siguienteNumero() -> Int {
        var descriptor = FetchDescriptor<PedidoEntity>(
            sortBy: [SortDescriptor(\.numeroPedido, order: .reverse)]
        )
        descriptor.fetchLimit = 1
        let ultimo = (try? contexto.fetch(descriptor))?.first?.numeroPedido ?? 0
        return ultimo + 1
    }
}
