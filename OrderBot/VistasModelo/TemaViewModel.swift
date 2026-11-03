import Foundation
import Observation

/// Expone el modo de tema actual y permite alternarlo.
///
/// El estado viene de `UserDefaults`, así que sobrevive a reinicios
/// (patrón UDF: la UI solo observa y delega).
///
/// Kotlin usaba `StateFlow` + `stateIn(WhileSubscribed)`; con
/// `@Observable` el valor se lee directamente y SwiftUI se suscribe
/// solo a lo que cada vista consume.
@MainActor
@Observable
final class TemaViewModel {

    private let preferencias: PreferenciasUsuario

    private(set) var modoTema: ModoTema

    init(preferencias: PreferenciasUsuario? = nil) {
        let preferencias = preferencias ?? PreferenciasUsuario()
        self.preferencias = preferencias
        self.modoTema = preferencias.modoTema
    }

    /// Alterna SISTEMA -> CLARO -> OSCURO -> SISTEMA y lo persiste.
    func cambiarModoTema() {
        modoTema = modoTema.siguiente
        preferencias.modoTema = modoTema
    }
}
