import SwiftUI

/// Botón que alterna el modo de tema y muestra el estado actual
/// con un emoji: ☀️ claro, 🌙 oscuro, 🌗 automático.
///
/// Sustituye a `IconButton` de Material; se conserva el área mínima de
/// toque (44 pt) y la etiqueta de accesibilidad.
struct BotonModoTema: View {

    @Environment(\.paletaOrderBot) private var paleta

    let modo: ModoTema
    let alPulsar: () -> Void

    var body: some View {
        Button(action: alPulsar) {
            Text(emoji)
                .font(FuentesOrderBot.iconoTema)
                .foregroundStyle(paleta.sobreSuperficie)
                .frame(minWidth: 44, minHeight: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(descripcionAccesible)
    }

    private var emoji: String {
        switch modo {
        case .claro: "☀️"
        case .oscuro: "🌙"
        case .sistema: "🌗"
        }
    }

    /// `IconButton` anunciaba la acción; aquí se añade el modo actual.
    private var descripcionAccesible: String {
        let claveModo = switch modo {
        case .claro: "tema_modo_claro"
        case .oscuro: "tema_modo_oscuro"
        case .sistema: "tema_modo_sistema"
        }
        return "\(L.t("tema_cambiar")) (\(L.t(claveModo)))"
    }
}
