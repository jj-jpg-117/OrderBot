import SwiftUI

/// Pantalla 4: detalle del pedido antes de confirmar.
///
/// Recibe un `ResumenPedido` ya calculado: la pantalla solo muestra
/// datos, no contiene lógica de negocio.
///
/// - Parameters:
///   - direccion: dirección escrita en la pantalla de entrega.
///   - metodoPago: método de pago elegido en la pantalla de entrega.
///   - onConfirmar: guarda el pedido y navega a la confirmación.
///
/// En iOS el contenido va dentro de un `ScrollView` para que no se
/// corte en pantallas pequeñas; el botón queda fijo abajo, igual que
/// en la versión Compose.
struct PantallaResumen: View {

    @Environment(\.paletaOrderBot) private var paleta

    let resumen: ResumenPedido
    let direccion: String
    let metodoPago: MetodoPago
    let onConfirmar: () -> Void
    let modoTema: ModoTema
    let onCambiarTema: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Título con el selector de tema a la derecha.
            HStack {
                Text(L.t("resumen_titulo"))
                    .font(FuentesOrderBot.titulo)
                    .foregroundStyle(paleta.sobreFondo)
                Spacer(minLength: 0)
                BotonModoTema(modo: modoTema, alPulsar: onCambiarTema)
            }

            Spacer().frame(height: 20)

            ScrollView {
                VStack(spacing: 16) {
                    tarjetaProductos
                    tarjetaEntrega
                }
            }
            .scrollIndicators(.hidden)

            Spacer().frame(height: 20)

            BotonPrimario(texto: L.t("resumen_boton_confirmar"), accion: onConfirmar)
        }
        .padding(20)
        .background(paleta.fondo.ignoresSafeArea())
    }

    /// Productos y totales
    private var tarjetaProductos: some View {
        OrderBotCard {
            Text(L.t("resumen_seccion_productos"))
                .font(FuentesOrderBot.tituloSeccion)
                .foregroundStyle(paleta.sobreSuperficie)

            Spacer().frame(height: 14)

            // Una fila por ítem: "🍔 Hamburguesa ×2" con su total.
            ForEach(resumen.items) { item in
                let sufijo = item.cantidad > 1 ? " ×\(item.cantidad)" : ""
                FilaPrecio(
                    nombre: "\(item.producto.emoji) \(item.producto.nombre)\(sufijo)",
                    precio: item.total.aPrecio
                )
            }

            Divider()
                .padding(.vertical, 12)

            FilaPrecio(
                nombre: L.t("resumen_subtotal"),
                precio: resumen.subtotal.aPrecio
            )
            FilaPrecio(
                nombre: L.t("resumen_envio"),
                precio: resumen.precioEnvio.aPrecio
            )

            Divider()
                .padding(.vertical, 8)

            FilaPrecio(
                nombre: L.t("resumen_total"),
                precio: resumen.total.aPrecio,
                destacado: true
            )
        }
    }

    /// Datos de entrega
    private var tarjetaEntrega: some View {
        OrderBotCard {
            Text(L.t("resumen_seccion_entrega"))
                .font(FuentesOrderBot.tituloSeccion)
                .foregroundStyle(paleta.sobreSuperficie)

            Spacer().frame(height: 8)

            Text(L.t("resumen_direccion", direccion))
                .foregroundStyle(paleta.sobreSuperficieVariante)

            Text(L.t("resumen_pago", metodoPago.etiqueta))
                .foregroundStyle(paleta.sobreSuperficieVariante)
        }
    }
}

#Preview {
    PantallaResumen(
        resumen: ResumenPedido(items: [
            ItemPedido(producto: Catalogo.hamburguesa, cantidad: 1),
            ItemPedido(producto: Catalogo.papas, cantidad: 1),
            ItemPedido(producto: Catalogo.bebida, cantidad: 1)
        ]),
        direccion: "Calle 123 #45-67",
        metodoPago: .efectivo,
        onConfirmar: {},
        modoTema: .sistema,
        onCambiarTema: {}
    )
    .orderBotTema(oscuro: false)
}
