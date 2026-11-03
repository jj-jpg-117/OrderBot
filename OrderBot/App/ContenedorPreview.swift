import Foundation
import SwiftData

/// Contenedor en memoria para previews y pruebas.
///
/// Evita tocar la base de datos real y hace que los `#Preview` de las
/// pantallas que usan el `PedidoViewModel` funcionen sin configuración.
extension ModelContainer {

    static var preview: ModelContainer {
        let configuracion = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            return try ModelContainer(
                for: PedidoEntity.self, ItemPedidoEntity.self,
                configurations: configuracion
            )
        } catch {
            fatalError("No se pudo crear el contenedor de preview: \(error)")
        }
    }
}
