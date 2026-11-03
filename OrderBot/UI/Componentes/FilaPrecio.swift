import SwiftUI

/// Fila "concepto -> precio" usada en el resumen del pedido.
///
/// - Parameter destacado: `true` para la fila del total
///   (más grande y con el color primario).
struct FilaPrecio: View {

    @Environment(\.paletaOrderBot) private var paleta

    let nombre: String
    let precio: String
    var destacado: Bool = false

    var body: some View {
        HStack {
            Text(nombre)
                .font(destacado ? FuentesOrderBot.cuerpoGrandeDestacado : FuentesOrderBot.detalle)
                .foregroundStyle(destacado ? paleta.sobreSuperficie : paleta.sobreSuperficieVariante)
            Spacer(minLength: 12)
            Text(precio)
                .font(destacado ? FuentesOrderBot.cuerpoGrandeDestacado : FuentesOrderBot.detalleDestacado)
                .foregroundStyle(destacado ? paleta.primario : paleta.sobreSuperficie)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 5)
    }
}
