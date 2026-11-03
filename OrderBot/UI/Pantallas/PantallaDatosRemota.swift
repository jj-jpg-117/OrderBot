import SwiftUI

/// Pantalla de ejemplo que pinta datos remotos de Firestore.
///
/// No está conectada al flujo de navegación (igual que en Android):
/// sirve para comprobar la integración con la nube.
struct PantallaDatosRemota: View {

    @Environment(\.paletaOrderBot) private var paleta
    @State private var viewModel = FirestoreViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L.t("remota_titulo"))
                .font(FuentesOrderBot.tituloCompacto)
                .foregroundStyle(paleta.sobreFondo)

            if viewModel.cargando {
                ProgressView()
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundStyle(.red)
            } else if viewModel.pedidos.isEmpty {
                Text(L.t("remota_vacia"))
                    .foregroundStyle(paleta.sobreSuperficieVariante)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.pedidos) { pedido in
                            Text("📍 \(pedido.direccion) — Total: \(pedido.total.aPrecio)")
                                .foregroundStyle(paleta.sobreSuperficie)
                        }
                    }
                }
            }

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(paleta.fondo.ignoresSafeArea())
        .task {
            await viewModel.cargarPedidos()
        }
    }
}

#Preview {
    PantallaDatosRemota()
        .orderBotTema(oscuro: false)
}
