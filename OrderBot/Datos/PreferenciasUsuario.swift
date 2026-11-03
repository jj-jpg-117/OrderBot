import Foundation

/// Persistencia del modo de tema.
///
/// Sustituye a `DataStore Preferences` (`preferencias_usuario`): en iOS
/// el equivalente nativo es `UserDefaults`, que también sobrevive a
/// que el proceso muera. Se conserva la misma clave (`modo_tema`) y los
/// mismos valores (`SISTEMA` / `CLARO` / `OSCURO`).
///
/// DataStore exponía un `Flow` porque leer el disco es asíncrono;
/// `UserDefaults` es síncrono, así que aquí no hace falta flujo: el
/// `@Observable` del `TemaViewModel` ya notifica los cambios a la UI.
@MainActor
final class PreferenciasUsuario {

    private enum Claves {
        static let modoTema = "modo_tema"
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    /// Modo de tema guardado (`SISTEMA` si no hay nada).
    var modoTema: ModoTema {
        get {
            guard let guardado = defaults.string(forKey: Claves.modoTema) else {
                return .sistema
            }
            return ModoTema(rawValue: guardado) ?? .sistema
        }
        set {
            defaults.set(newValue.rawValue, forKey: Claves.modoTema)
        }
    }
}
