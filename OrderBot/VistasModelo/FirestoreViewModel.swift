import Foundation
import Observation

/// Maneja la lógica de negocio de la conexión remota:
/// carga los pedidos de Firestore y envía nuevos,
/// exponiendo el estado a la UI.
///
/// `StateFlow` + `viewModelScope.launch` se traducen a propiedades
/// observables y funciones `async`.
@MainActor
@Observable
final class FirestoreViewModel {

    private let repositorio: FirestoreRepository

    private(set) var pedidos: [PedidoRemoto] = []
    private(set) var cargando = false
    private(set) var error: String?

    init(repositorio: FirestoreRepository? = nil) {
        self.repositorio = repositorio ?? FirestoreRepository()
    }

    /// Lee los pedidos desde Firestore.
    func cargarPedidos() async {
        cargando = true
        error = nil
        do {
            pedidos = try await repositorio.obtenerPedidos()
        } catch {
            self.error = "Sin conexión o error al cargar: \(error.localizedDescription)"
        }
        cargando = false
    }

    /// Envía un pedido nuevo a Firestore y refresca la lista.
    func enviarPedido(_ pedido: PedidoRemoto) async {
        cargando = true
        error = nil
        do {
            _ = try await repositorio.enviarPedido(pedido)
            await cargarPedidos()
        } catch {
            self.error = "No se pudo enviar: \(error.localizedDescription)"
        }
        cargando = false
    }
}
