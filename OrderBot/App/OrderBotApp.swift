import SwiftUI
import SwiftData

/// Punto de entrada de la app.
///
/// `MainActivity` + `setContent { OrderBotApp() }` + `enableEdgeToEdge()`
/// se reducen a un `App` de SwiftUI (iOS gestiona los márgenes seguros
/// de forma nativa).
///
/// Aquí se construyen los ViewModels una sola vez, igual que hacía
/// `viewModel()` en Compose: viven mientras viva la app y se comparten
/// entre pantallas. El contenedor de SwiftData sustituye a la
/// instancia única de Room (`AppDatabase.getInstance`).
@main
struct OrderBotApp: App {

    private let contenedor: ModelContainer

    @State private var temaViewModel: TemaViewModel
    @State private var pedidoViewModel: PedidoViewModel
    @State private var firestoreViewModel: FirestoreViewModel
    @State private var router: AppRouter

    init() {
        let contenedor: ModelContainer
        do {
            contenedor = try ModelContainer(for: PedidoEntity.self, ItemPedidoEntity.self)
        } catch {
            fatalError("No se pudo crear la base de datos local (orderbot.db): \(error)")
        }
        self.contenedor = contenedor

        let repositorio = PedidoRepository(contexto: contenedor.mainContext)

        _temaViewModel = State(initialValue: TemaViewModel())
        _pedidoViewModel = State(initialValue: PedidoViewModel(repositorio: repositorio))
        _firestoreViewModel = State(initialValue: FirestoreViewModel())
        _router = State(initialValue: AppRouter())
    }

    var body: some Scene {
        WindowGroup {
            RootView(
                temaViewModel: temaViewModel,
                pedidoViewModel: pedidoViewModel,
                firestoreViewModel: firestoreViewModel,
                router: router
            )
        }
        .modelContainer(contenedor)
    }
}
