import SwiftUI
import SwiftData

/// Raíz de la app: decide el tema a partir del `TemaViewModel` y
/// monta la navegación.
///
/// Sustituye a `OrderBotApp` + `AppNavigation` de Compose:
/// - `NavHost` -> `NavigationStack` con `navigationDestination`.
/// - `collectAsStateWithLifecycle` -> observación directa del
///   `@Observable` (SwiftUI solo re-dibuja lo que cambia).
/// - `isSystemInDarkTheme()` -> `@Environment(\.colorScheme)`.
struct RootView: View {

    @Environment(\.colorScheme) private var esquemaSistema

    let temaViewModel: TemaViewModel
    let pedidoViewModel: PedidoViewModel
    let firestoreViewModel: FirestoreViewModel
    @Bindable var router: AppRouter

    /// Detección de la preferencia del sistema; solo aplica en modo
    /// SISTEMA. Es el equivalente de `isSystemInDarkTheme()`.
    private var temaOscuro: Bool {
        switch temaViewModel.modoTema {
        case .sistema: esquemaSistema == .dark
        case .claro: false
        case .oscuro: true
        }
    }

    /// `nil` = seguir al sistema (`preferredColorScheme(nil)`).
    private var esquemaPreferido: ColorScheme? {
        switch temaViewModel.modoTema {
        case .sistema: nil
        case .claro: .light
        case .oscuro: .dark
        }
    }

    var body: some View {
        NavigationStack(path: $router.camino) {
            PantallaInicio(
                onComenzar: { router.irA(.conversacion) },
                onVerCreditos: { router.irA(.creditos) },
                modoTema: temaViewModel.modoTema,
                onCambiarTema: { temaViewModel.cambiarModoTema() }
            )
            .navigationDestination(for: Ruta.self) { ruta in
                pantalla(ruta)
                    // Las pantallas dibujan su propio encabezado, igual
                    // que en Compose (que no tenía top app bar).
                    .toolbar(.hidden, for: .navigationBar)
            }
        }
        .tint(temaOscuro ? .azulOrderBotOscuro : .azulOrderBot)
        .environment(\.paletaOrderBot, temaOscuro ? .oscuro : .claro)
        .preferredColorScheme(esquemaPreferido)
    }

    /// Un `composable<...> { ... }` por cada ruta de `Rutas.kt`.
    @ViewBuilder
    private func pantalla(_ ruta: Ruta) -> some View {
        switch ruta {
        case .creditos:
            PantallaCreditos(
                onVolver: { router.volver() },
                modoTema: temaViewModel.modoTema,
                onCambiarTema: { temaViewModel.cambiarModoTema() }
            )

        case .conversacion:
            PantallaConversacion(
                items: pedidoViewModel.items,
                onAgregar: { producto in pedidoViewModel.agregar(producto) },
                onQuitar: { producto in pedidoViewModel.quitar(producto) },
                onContinuar: { router.irA(.recomendacion) },
                modoTema: temaViewModel.modoTema,
                onCambiarTema: { temaViewModel.cambiarModoTema() }
            )

        case .recomendacion:
            PantallaRecomendacion(
                onAceptar: {
                    pedidoViewModel.aceptarRecomendacion()
                    router.irA(.entrega)
                },
                onRechazar: { router.irA(.entrega) },
                modoTema: temaViewModel.modoTema,
                onCambiarTema: { temaViewModel.cambiarModoTema() }
            )

        case .entrega:
            PantallaEntrega(
                direccion: pedidoViewModel.direccion,
                metodoPago: pedidoViewModel.metodoPago,
                onCambiarDireccion: { valor in pedidoViewModel.setDireccion(valor) },
                onCambiarMetodoPago: { metodo in pedidoViewModel.setMetodoPago(metodo) },
                onContinuar: { router.irA(.resumen) },
                modoTema: temaViewModel.modoTema,
                onCambiarTema: { temaViewModel.cambiarModoTema() }
            )

        case .resumen:
            PantallaResumen(
                resumen: pedidoViewModel.resumen,
                direccion: pedidoViewModel.direccion,
                metodoPago: pedidoViewModel.metodoPago,
                onConfirmar: confirmarPedido,
                modoTema: temaViewModel.modoTema,
                onCambiarTema: { temaViewModel.cambiarModoTema() }
            )

        case .confirmacion(let numeroPedido):
            PantallaConfirmacion(
                numeroPedido: numeroPedido,
                onVolverInicio: { router.volverAlInicio() },
                modoTema: temaViewModel.modoTema,
                onCambiarTema: { temaViewModel.cambiarModoTema() }
            )
        }
    }

    /// Confirma el pedido localmente y lo replica en Firestore.
    ///
    /// La escritura remota es "fire and forget": su error no se muestra
    /// en el flujo principal, igual que en la versión Android.
    private func confirmarPedido() {
        let direccion = pedidoViewModel.direccion
        let metodoPago = pedidoViewModel.metodoPago
        let total = pedidoViewModel.resumen.total

        Task {
            await firestoreViewModel.enviarPedido(
                PedidoRemoto(
                    direccion: direccion,
                    metodoPago: metodoPago.rawValue,
                    total: total
                )
            )
        }

        Task {
            if let numero = await pedidoViewModel.confirmar() {
                router.mostrarConfirmacion(numero: numero)
            }
        }
    }
}

#Preview {
    RootView(
        temaViewModel: TemaViewModel(),
        pedidoViewModel: PedidoViewModel(repositorio: PedidoRepository(contexto: ModelContext(ModelContainer.preview))),
        firestoreViewModel: FirestoreViewModel(),
        router: AppRouter()
    )
}
