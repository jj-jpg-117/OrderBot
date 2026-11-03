import Foundation
import Observation

/// Rutas type-safe de navegación.
///
/// Equivale a `navigation/Rutas.kt`: allí cada pantalla era un objeto
/// `@Serializable`; en SwiftUI un `enum Hashable` cumple la misma
/// función y además transporta el argumento tipado de la confirmación.
enum Ruta: Hashable {
    case conversacion
    case recomendacion
    case entrega
    case resumen
    /// Antes `Confirmacion(val numeroPedido: Int)`.
    case confirmacion(numeroPedido: Int)
    case creditos
}

/// Estado de navegación de la app.
///
/// Sustituye al `NavHostController` de Compose: `camino` es la pila
/// de destinos y los métodos replican `navigate`, `popBackStack` y las
/// opciones `popUpTo`.
@MainActor
@Observable
final class AppRouter {

    /// Pila de destinos sobre la pantalla inicial (`Inicio` es la raíz).
    var camino: [Ruta] = []

    func irA(_ ruta: Ruta) {
        camino.append(ruta)
    }

    /// `popBackStack()`: vuelve a la pantalla anterior.
    func volver() {
        guard !camino.isEmpty else { return }
        camino.removeLast()
    }

    /// `navigate(Confirmacion) { popUpTo(Inicio) }`: la confirmación
    /// queda directamente sobre el inicio, sin el resto del flujo.
    func mostrarConfirmacion(numero: Int) {
        camino = [.confirmacion(numeroPedido: numero)]
    }

    /// `navigate(Inicio) { popUpTo(Inicio) { inclusive = true } }`:
    /// reinicia el flujo dejando solo la pantalla inicial.
    func volverAlInicio() {
        camino.removeAll()
    }
}
