import Foundation
import Observation

/// Estado del pedido compartido por todas las pantallas.
///
/// Sustituye a `PedidoViewModel` + `MutableStateFlow`: con el macro
/// `@Observable` las propiedades son directamente observables por
/// SwiftUI (no hace falta `collectAsState`).
///
/// La UI es "tonta": solo lee `items`, `direccion`, `metodoPago` y
/// `resumen`, y delega las acciones aquí.
@MainActor
@Observable
final class PedidoViewModel {

    private let repositorio: PedidoRepository

    private(set) var items: [ItemPedido] = []
    var direccion: String = ""
    var metodoPago: MetodoPago = .efectivo

    /// Estado de la escritura en disco (para mostrar progreso o errores).
    private(set) var guardando = false
    private(set) var mensajeError: String?

    var resumen: ResumenPedido {
        ResumenPedido(items: items)
    }

    init(repositorio: PedidoRepository) {
        self.repositorio = repositorio
    }

    /// Suma una unidad del producto (o lo agrega con cantidad 1).
    func agregar(_ producto: Producto) {
        if let indice = items.firstIndex(where: { $0.producto.id == producto.id }) {
            items[indice] = items[indice].conCantidad(items[indice].cantidad + 1)
        } else {
            items.append(ItemPedido(producto: producto, cantidad: 1))
        }
    }

    /// Resta una unidad; si llega a cero, saca el producto del carrito.
    func quitar(_ producto: Producto) {
        guard let indice = items.firstIndex(where: { $0.producto.id == producto.id }) else {
            return
        }
        let actual = items[indice]
        if actual.cantidad > 1 {
            items[indice] = actual.conCantidad(actual.cantidad - 1)
        } else {
            items.remove(at: indice)
        }
    }

    func setDireccion(_ valor: String) {
        direccion = valor
    }

    func setMetodoPago(_ metodo: MetodoPago) {
        metodoPago = metodo
    }

    /// Agrega los complementos ofrecidos en la pantalla de recomendación.
    func aceptarRecomendacion() {
        agregar(Catalogo.papas)
        agregar(Catalogo.bebida)
    }

    /// Guarda el pedido en disco y devuelve su número; limpia el carrito.
    ///
    /// En Kotlin era `confirmar(onNumeroPedido: (Int) -> Unit)` con
    /// `viewModelScope.launch`; aquí el callback se sustituye por
    /// `async/await` y el valor de retorno.
    func confirmar() async -> Int? {
        guardando = true
        defer { guardando = false }

        do {
            let numero = try repositorio.guardarPedido(
                resumen,
                direccion: direccion,
                metodoPago: metodoPago
            )
            items = []
            direccion = ""
            metodoPago = .efectivo
            mensajeError = nil
            return numero
        } catch {
            mensajeError = "No se pudo guardar el pedido: \(error.localizedDescription)"
            return nil
        }
    }
}
