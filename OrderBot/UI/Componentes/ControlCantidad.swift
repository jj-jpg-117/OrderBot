import SwiftUI

/// Selector de cantidad: [−] n [+].
///
/// Los botones usan etiquetas de accesibilidad en lugar de texto plano
/// para que VoiceOver anuncie la acción correcta, igual que
/// `semantics { contentDescription = ... }` en Compose.
struct ControlCantidad: View {

    @Environment(\.paletaOrderBot) private var paleta

    let cantidad: Int
    let onAgregar: () -> Void
    let onQuitar: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            boton(simbolo: "−", etiqueta: L.t("cantidad_quitar"), accion: onQuitar)
            Text("\(cantidad)")
                .font(.system(size: 17))
                .foregroundStyle(paleta.sobreSuperficie)
                .frame(width: 20)
                .multilineTextAlignment(.center)
            boton(simbolo: "+", etiqueta: L.t("cantidad_agregar"), accion: onAgregar)
        }
    }

    private func boton(simbolo: String, etiqueta: String, accion: @escaping () -> Void) -> some View {
        Button(action: accion) {
            Text(simbolo)
                .font(.system(size: 20))
                .foregroundStyle(paleta.primario)
                .frame(minWidth: 40, minHeight: 40)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(etiqueta)
    }
}
