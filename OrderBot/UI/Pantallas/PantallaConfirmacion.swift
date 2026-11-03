import SwiftUI

/// Pantalla 5: confirmación del pedido realizado.
///
/// - Parameters:
///   - numeroPedido: número generado al confirmar; llega como
///     argumento tipado de la ruta de navegación.
///   - onVolverInicio: reinicia el flujo volviendo a la pantalla inicial.
struct PantallaConfirmacion: View {

    @Environment(\.paletaOrderBot) private var paleta

    let numeroPedido: Int
    let onVolverInicio: () -> Void
    let modoTema: ModoTema
    let onCambiarTema: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Selector de tema en la esquina superior derecha.
            HStack {
                Spacer(minLength: 0)
                BotonModoTema(modo: modoTema, alPulsar: onCambiarTema)
            }

            // Ícono de éxito: usa el color "terciario" del tema
            // (verde de marca) en lugar de un valor fijo.
            Text("✓")
                .font(.system(size: 58, weight: .bold))
                .foregroundStyle(paleta.terciario)
                .frame(width: 100, height: 100)
                .background(
                    paleta.contenedorTerciario,
                    in: Circle()
                )

            Spacer().frame(height: 24)

            Text(L.t("confirmacion_titulo"))
                .font(FuentesOrderBot.titulo)
                .foregroundStyle(paleta.sobreFondo)
                .multilineTextAlignment(.center)

            Spacer().frame(height: 10)

            Text(L.t("confirmacion_mensaje"))
                .font(FuentesOrderBot.cuerpo)
                .foregroundStyle(paleta.sobreSuperficieVariante)
                .multilineTextAlignment(.center)

            Spacer().frame(height: 24)

            // Información del pedido
            OrderBotCard {
                Text(L.t("confirmacion_numero_pedido", numeroPedido))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(paleta.sobreSuperficie)

                Spacer().frame(height: 10)

                Text(L.t("confirmacion_entrega_estimada"))
                    .foregroundStyle(paleta.sobreSuperficieVariante)

                Spacer().frame(height: 6)

                Text(L.t("confirmacion_metodo_pago"))
                    .foregroundStyle(paleta.sobreSuperficieVariante)

                Spacer().frame(height: 6)

                Text(L.t("confirmacion_estado"))
                    .foregroundStyle(paleta.sobreSuperficieVariante)
            }

            Spacer().frame(height: 24)

            BotonPrimario(texto: L.t("confirmacion_boton_seguir")) {
                // Pendiente: conectar con el seguimiento en vivo.
            }

            Spacer().frame(height: 10)

            BotonSecundario(texto: L.t("confirmacion_boton_volver"), accion: onVolverInicio)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(24)
        .background(paleta.fondo.ignoresSafeArea())
    }
}

#Preview {
    PantallaConfirmacion(
        numeroPedido: 1024,
        onVolverInicio: {},
        modoTema: .sistema,
        onCambiarTema: {}
    )
    .orderBotTema(oscuro: false)
}
