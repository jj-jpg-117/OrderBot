import Foundation

/// Producto del menú.
///
/// - `id`: clave estable usada en `ForEach` y en la base de datos.
/// - Los textos son claves de localización (equivalente a `@StringRes`)
///   para respetar la localización de la app.
/// - El precio siempre es un entero en pesos (nunca texto).
struct Producto: Identifiable, Hashable {
    let id: String
    let claveNombre: String
    let emoji: String
    let precio: Int
    var claveDescripcion: String? = nil

    /// Texto visible del nombre, resuelto contra el catálogo de textos.
    var nombre: String { L.t(claveNombre) }

    /// Texto secundario opcional.
    var descripcion: String? { claveDescripcion.map { L.t($0) } }
}

/// Catálogo: única fuente de verdad para productos y precios.
/// Agregar un producto al menú es agregarlo aquí y nada más.
enum Catalogo {

    static let precioEnvio = 5_000

    static let hamburguesa = Producto(
        id: "hamburguesa",
        claveNombre: "producto_hamburguesa",
        emoji: "🍔",
        precio: 20_000,
        claveDescripcion: "producto_hamburguesa_desc"
    )
    static let pizza = Producto(
        id: "pizza",
        claveNombre: "producto_pizza",
        emoji: "🍕",
        precio: 12_000,
        claveDescripcion: "producto_pizza_desc"
    )
    static let tacos = Producto(
        id: "tacos",
        claveNombre: "producto_tacos",
        emoji: "🌮",
        precio: 15_000,
        claveDescripcion: "producto_tacos_desc"
    )
    static let burrito = Producto(
        id: "burrito",
        claveNombre: "producto_burrito",
        emoji: "🌯",
        precio: 14_000,
        claveDescripcion: "producto_burrito_desc"
    )
    static let pollo = Producto(
        id: "pollo",
        claveNombre: "producto_pollo",
        emoji: "🍗",
        precio: 18_000,
        claveDescripcion: "producto_pollo_desc"
    )
    static let hotdog = Producto(
        id: "hotdog",
        claveNombre: "producto_hotdog",
        emoji: "🌭",
        precio: 8_000,
        claveDescripcion: "producto_hotdog_desc"
    )
    static let ensalada = Producto(
        id: "ensalada",
        claveNombre: "producto_ensalada",
        emoji: "🥗",
        precio: 10_000,
        claveDescripcion: "producto_ensalada_desc"
    )
    static let papas = Producto(
        id: "papas",
        claveNombre: "producto_papas",
        emoji: "🍟",
        precio: 5_000
    )
    static let bebida = Producto(
        id: "bebida",
        claveNombre: "producto_bebida",
        emoji: "🥤",
        precio: 4_000
    )
    static let helado = Producto(
        id: "helado",
        claveNombre: "producto_helado",
        emoji: "🍦",
        precio: 6_000,
        claveDescripcion: "producto_helado_desc"
    )

    /// Menú completo mostrado en la conversación.
    static let menu: [Producto] = [
        hamburguesa, pizza, tacos, burrito, pollo,
        hotdog, ensalada, papas, bebida, helado
    ]

    static func porId(_ id: String) -> Producto? {
        menu.first { $0.id == id }
    }
}
