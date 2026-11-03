import SwiftUI

/// Pantalla de créditos / acerca de: logo, versión, derechos de
/// autor y equipo de desarrollo.
struct PantallaCreditos: View {

    @Environment(\.paletaOrderBot) private var paleta

    let onVolver: () -> Void
    let modoTema: ModoTema
    let onCambiarTema: () -> Void

    /// `Calendar.getInstance().get(Calendar.YEAR)` en versión Swift.
    private var anioActual: Int {
        Calendar.current.component(.year, from: .now)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Selector de tema en la esquina superior derecha.
            HStack {
                Spacer(minLength: 0)
                BotonModoTema(modo: modoTema, alPulsar: onCambiarTema)
            }

            // Logo de la app
            Image("logo_bot1")
                .resizable()
                .scaledToFit()
                .padding(16)
                .frame(width: 140, height: 140)
                .background(
                    paleta.contenedorPrimario,
                    in: RoundedRectangle(cornerRadius: 38, style: .continuous)
                )
                .accessibilityLabel(L.t("logo_descripcion"))

            Spacer().frame(height: 20)

            Text(L.t("creditos_titulo"))
                .font(FuentesOrderBot.tituloCompacto)
                .foregroundStyle(paleta.sobreFondo)
                .multilineTextAlignment(.center)

            Spacer().frame(height: 8)

            Text(L.t("creditos_version", "1.0.0"))
                .font(FuentesOrderBot.cuerpo)
                .foregroundStyle(paleta.primario)

            Spacer().frame(height: 4)

            Text(L.t("creditos_derechos", anioActual))
                .font(FuentesOrderBot.secundario)
                .foregroundStyle(paleta.sobreSuperficieVariante)
                .multilineTextAlignment(.center)

            Spacer().frame(height: 28)

            // Equipo de desarrollo
            OrderBotCard {
                Text(L.t("creditos_equipo_titulo"))
                    .font(FuentesOrderBot.tituloSeccion)
                    .foregroundStyle(paleta.sobreSuperficie)

                Spacer().frame(height: 10)

                Text(L.t("creditos_integrante_1"))
                    .font(FuentesOrderBot.cuerpo)
                    .foregroundStyle(paleta.sobreSuperficie)

                Text(L.t("creditos_integrante_2"))
                    .font(FuentesOrderBot.cuerpo)
                    .foregroundStyle(paleta.sobreSuperficie)
            }

            Spacer().frame(height: 28)

            BotonSecundario(texto: L.t("creditos_boton_volver"), accion: onVolver)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(24)
        .background(paleta.fondo.ignoresSafeArea())
    }
}

#Preview {
    PantallaCreditos(
        onVolver: {},
        modoTema: .sistema,
        onCambiarTema: {}
    )
    .orderBotTema(oscuro: false)
}
