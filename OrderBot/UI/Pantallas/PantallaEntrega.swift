import SwiftUI

/// Pantalla 4: dirección de entrega y método de pago.
///
/// El botón "Ver resumen" se habilita solo cuando hay dirección.
///
/// `TextField(value:onValueChange:)` + `RadioButton` de Compose se
/// traducen a `TextField` con un `Binding` manual y filas de botón con
/// icono de selección (el patrón nativo en iOS).
struct PantallaEntrega: View {

    @Environment(\.paletaOrderBot) private var paleta

    let direccion: String
    let metodoPago: MetodoPago
    let onCambiarDireccion: (String) -> Void
    let onCambiarMetodoPago: (MetodoPago) -> Void
    let onContinuar: () -> Void
    let modoTema: ModoTema
    let onCambiarTema: () -> Void

    /// Enlaza el texto del campo con el estado global sin duplicarlo.
    private var enlaceDireccion: Binding<String> {
        Binding(
            get: { direccion },
            set: { nuevo in onCambiarDireccion(nuevo) }
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(L.t("entrega_titulo"))
                    .font(FuentesOrderBot.titulo)
                    .foregroundStyle(paleta.sobreFondo)
                Spacer(minLength: 0)
                BotonModoTema(modo: modoTema, alPulsar: onCambiarTema)
            }

            Spacer().frame(height: 20)

            Text(L.t("entrega_direccion_titulo"))
                .font(FuentesOrderBot.cuerpoDestacado)
                .foregroundStyle(paleta.sobreSuperficie)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer().frame(height: 8)

            TextField(L.t("entrega_direccion_placeholder"), text: enlaceDireccion)
                .font(FuentesOrderBot.cuerpo)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.sentences)
                .submitLabel(.done)

            Spacer().frame(height: 24)

            Text(L.t("entrega_metodo_pago_titulo"))
                .font(FuentesOrderBot.cuerpoDestacado)
                .foregroundStyle(paleta.sobreSuperficie)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer().frame(height: 8)

            ForEach(MetodoPago.allCases) { metodo in
                botonMetodoPago(metodo)
            }

            Spacer(minLength: 24)

            BotonPrimario(
                texto: L.t("entrega_boton_continuar"),
                habilitado: !direccion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                accion: onContinuar
            )
        }
        .padding(20)
        .background(paleta.fondo.ignoresSafeArea())
    }

    private func botonMetodoPago(_ metodo: MetodoPago) -> some View {
        let seleccionado = metodo == metodoPago
        return Button {
            onCambiarMetodoPago(metodo)
        } label: {
            HStack(spacing: 10) {
                Image(systemName: seleccionado ? "largecircle.fill.circle" : "circle")
                    .font(.system(size: 20))
                    .foregroundStyle(paleta.primario)
                Text(metodo.etiqueta)
                    .font(FuentesOrderBot.cuerpo)
                    .foregroundStyle(paleta.sobreSuperficie)
                Spacer(minLength: 0)
            }
            .padding(.vertical, 6)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(seleccionado ? .isSelected : [])
    }
}

#Preview {
    PantallaEntrega(
        direccion: "",
        metodoPago: .efectivo,
        onCambiarDireccion: { _ in },
        onCambiarMetodoPago: { _ in },
        onContinuar: {},
        modoTema: .sistema,
        onCambiarTema: {}
    )
    .orderBotTema(oscuro: false)
}
