import SwiftUI

/// Tarjeta de producto del catálogo.
///
/// Usa una API de "slots" (`accion`): quien la invoca decide qué poner
/// al final de la fila (un botón, un selector de cantidad, nada).
/// Así la misma tarjeta sirve para productos seleccionables y para
/// productos "próximamente", sin duplicar el layout.
///
/// - Parameters:
///   - descripcion: texto secundario, o `nil` para ocultarlo.
///   - precio: texto del precio, o `nil` para ocultarlo.
///   - accion: contenido opcional al final de la fila.
struct TarjetaProducto<Accion: View>: View {

    @Environment(\.paletaOrderBot) private var paleta

    private let emoji: String
    private let nombre: String
    private let descripcion: String?
    private let precio: String?
    private let accion: Accion

    init(
        emoji: String,
        nombre: String,
        descripcion: String? = nil,
        precio: String? = nil,
        @ViewBuilder accion: () -> Accion
    ) {
        self.emoji = emoji
        self.nombre = nombre
        self.descripcion = descripcion
        self.precio = precio
        self.accion = accion()
    }

    var body: some View {
        OrderBotCard {
            HStack(alignment: .center, spacing: 14) {
                Text(emoji)
                    .font(FuentesOrderBot.emojiGrande)

                VStack(alignment: .leading, spacing: 0) {
                    Text(nombre)
                        .font(FuentesOrderBot.subtitulo)
                        .foregroundStyle(paleta.sobreSuperficie)

                    if let descripcion {
                        Text(descripcion)
                            .font(FuentesOrderBot.pie)
                            .foregroundStyle(paleta.sobreSuperficieVariante)
                    }

                    if let precio {
                        Text(precio)
                            .font(FuentesOrderBot.detalleDestacado)
                            .foregroundStyle(paleta.primario)
                            .padding(.top, 4)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                if !(accion is EmptyView) {
                    accion
                        .padding(.leading, 12)
                }
            }
        }
    }
}

extension TarjetaProducto where Accion == EmptyView {

    /// Variante sin acción al final de la fila.
    init(emoji: String, nombre: String, descripcion: String? = nil, precio: String? = nil) {
        self.init(
            emoji: emoji,
            nombre: nombre,
            descripcion: descripcion,
            precio: precio,
            accion: { EmptyView() }
        )
    }
}
