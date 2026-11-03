import SwiftUI

// Altura y esquinas unificadas para todos los botones de la app.
private let alturaBoton: CGFloat = 52
private let radioBoton: CGFloat = 14

/// Botón principal de la app (`Button` de Material 3).
///
/// Centraliza forma, altura y colores para no repetirlos en cada
/// pantalla. `habilitado` reproduce el estado `enabled` de Compose.
struct BotonPrimario: View {

    @Environment(\.paletaOrderBot) private var paleta

    let texto: String
    let accion: () -> Void
    var habilitado: Bool

    init(texto: String, habilitado: Bool = true, accion: @escaping () -> Void) {
        self.texto = texto
        self.habilitado = habilitado
        self.accion = accion
    }

    var body: some View {
        Button(action: accion) {
            Text(texto)
                .font(FuentesOrderBot.cuerpoDestacado)
                .foregroundStyle(paleta.sobrePrimario)
                .frame(maxWidth: .infinity)
                .frame(height: alturaBoton)
                .background(
                    habilitado ? paleta.primario : paleta.primario.opacity(0.38),
                    in: RoundedRectangle(cornerRadius: radioBoton, style: .continuous)
                )
                .contentShape(RoundedRectangle(cornerRadius: radioBoton, style: .continuous))
        }
        .buttonStyle(.plain)
        .disabled(!habilitado)
    }
}

/// Variante secundaria (con borde) de `BotonPrimario`.
struct BotonSecundario: View {

    @Environment(\.paletaOrderBot) private var paleta

    let texto: String
    let accion: () -> Void

    init(texto: String, accion: @escaping () -> Void) {
        self.texto = texto
        self.accion = accion
    }

    var body: some View {
        Button(action: accion) {
            Text(texto)
                .font(FuentesOrderBot.cuerpo)
                .foregroundStyle(paleta.primario)
                .frame(maxWidth: .infinity)
                .frame(height: alturaBoton)
                .background(
                    paleta.superficie,
                    in: RoundedRectangle(cornerRadius: radioBoton, style: .continuous)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: radioBoton, style: .continuous)
                        .stroke(paleta.secundario.opacity(0.45), lineWidth: 1)
                )
                .contentShape(RoundedRectangle(cornerRadius: radioBoton, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
