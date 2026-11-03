import Foundation

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif

/// Repositorio que gestiona la conexión con Cloud Firestore.
///
/// Sustituye a `FirestoreRepository` de Kotlin: en lugar de
/// `suspend` + `await()` (Tasks de Firebase) usa `async/await` nativo.
///
/// El bloque `#if canImport(FirebaseFirestore)` permite compilar y
/// probar el resto de la app antes de añadir el paquete de Firebase;
/// al agregarlo por SPM, este archivo se activa solo.
final class FirestoreRepository {

    /// Errores propios del repositorio remoto.
    enum ErrorFirestore: LocalizedError {
        case noDisponible

        var errorDescription: String? {
            switch self {
            case .noDisponible:
                return "Firebase no está agregado al proyecto."
            }
        }
    }

    #if canImport(FirebaseFirestore)
    private let db = Firestore.firestore()
    private var coleccion: CollectionReference { db.collection("pedidos") }
    #endif

    /// Lee todos los pedidos una sola vez (asíncrono).
    func obtenerPedidos() async throws -> [PedidoRemoto] {
        #if canImport(FirebaseFirestore)
        let snapshot = try await coleccion.getDocuments()
        return snapshot.documents.compactMap { documento in
            guard var pedido = try? documento.data(as: PedidoRemoto.self) else { return nil }
            // El id vive en el documento, no en sus campos.
            pedido.id = documento.documentID
            return pedido
        }
        #else
        throw ErrorFirestore.noDisponible
        #endif
    }

    /// Envía un pedido nuevo y devuelve el id generado.
    func enviarPedido(_ pedido: PedidoRemoto) async throws -> String {
        #if canImport(FirebaseFirestore)
        let referencia = try coleccion.addDocument(from: pedido)
        return referencia.documentID
        #else
        throw ErrorFirestore.noDisponible
        #endif
    }
}
