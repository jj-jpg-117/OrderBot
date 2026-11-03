import SwiftUI

/// Pantalla 1: bienvenida y beneficios de OrderBot.
///
/// - Parameters:
///   - onComenzar: navega a la pantalla de conversación.
///   - modoTema: modo de tema activo (para el botón de cambio).
///   - onCambiarTema: alterna claro → oscuro → automático.
struct PantallaInicio: View {

    @Environment(\.paletaOrderBot) private var paleta

    let onComenzar: () -> Void
    var onVerCreditos: () -> Void = {}
    let modoTema: ModoTema
    let onCambiarTema: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Selector de tema en la esquina superior derecha.
            HStack {
                Spacer(minLength: 0)
                BotonModoTema(modo: modoTema, alPulsar: onCambiarTema)
            }

            // Logo
            Image("logo_bot1")
                .resizable()
                .scaledToFit()
                .padding(18)
                .frame(width: 160, height: 160)
                .background(
                    paleta.contenedorPrimario,
                    in: RoundedRectangle(cornerRadius: 44, style: .continuous)
                )
                .accessibilityLabel(L.t("logo_descripcion"))

            Spacer().frame(height: 24)

            Text(L.t("app_name"))
                .font(FuentesOrderBot.nombreApp)
                .foregroundStyle(paleta.sobreFondo)

            Spacer().frame(height: 8)

            Text(L.t("inicio_eslogan"))
                .font(FuentesOrderBot.eslogan)
                .foregroundStyle(paleta.primario)
                .multilineTextAlignment(.center)

            Spacer().frame(height: 32)

            TarjetaBeneficio(
                icono: "⚡",
                titulo: L.t("inicio_beneficio_rapido_titulo"),
                descripcion: L.t("inicio_beneficio_rapido_desc")
            )

            Spacer().frame(height: 12)

            TarjetaBeneficio(
                icono: "✨",
                titulo: L.t("inicio_beneficio_sugerencias_titulo"),
                descripcion: L.t("inicio_beneficio_sugerencias_desc")
            )

            Spacer().frame(height: 32)

            BotonPrimario(texto: L.t("inicio_boton_comenzar"), accion: onComenzar)

            Spacer().frame(height: 10)

            BotonSecundario(texto: L.t("inicio_boton_creditos"), accion: onVerCreditos)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(24)
        .background(paleta.fondo.ignoresSafeArea())
    }
}

#Preview {
    PantallaInicio(
        onComenzar: {},
        modoTema: .sistema,
        onCambiarTema: {}
    )
    .orderBotTema(oscuro: false)
}
