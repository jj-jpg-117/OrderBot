import Foundation

/// Opciones de tema de la app.
///
/// `siguiente` implementa el ciclo del botón de cambio de tema:
/// SISTEMA -> CLARO -> OSCURO -> SISTEMA.
///
/// El `rawValue` conserva el nombre que Android guardaba en DataStore
/// (`ModoTema.name`), así la preferencia es compatible entre versiones.
enum ModoTema: String, CaseIterable {
    case sistema = "SISTEMA"
    case claro = "CLARO"
    case oscuro = "OSCURO"

    /// Equivalente a `fun siguiente(): ModoTema` de Kotlin.
    var siguiente: ModoTema {
        switch self {
        case .sistema: .claro
        case .claro: .oscuro
        case .oscuro: .sistema
        }
    }
}
