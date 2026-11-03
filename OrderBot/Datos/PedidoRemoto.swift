import Foundation

/// Modelo de datos que se guarda en Firestore (colección "pedidos").
///
/// Los valores por defecto permiten decodificar documentos antiguos o
/// incompletos sin fallar, igual que los valores por defecto de la
/// `data class` de Kotlin.
struct PedidoRemoto: Codable, Identifiable, Hashable {
    var id: String = ""
    var direccion: String = ""
    var metodoPago: String = ""
    var total: Int = 0
    var fechaMillis: Int64 = Int64(Date().timeIntervalSince1970 * 1000)
}
