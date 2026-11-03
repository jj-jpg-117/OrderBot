import SwiftUI

/// Esquema de colores de marca, con los mismos roles que el
/// `ColorScheme` de Material 3 (ver `ui/theme/Theme.kt`).
///
/// Las vistas leen la paleta desde el entorno con
/// `@Environment(\.paletaOrderBot)`, por lo que el tema oscuro
/// funciona automáticamente sin valores fijos.
struct PaletaOrderBot {
    let primario: Color
    let sobrePrimario: Color
    let contenedorPrimario: Color
    let sobreContenedorPrimario: Color
    let secundario: Color
    let sobreSecundario: Color
    let terciario: Color
    let contenedorTerciario: Color
    let fondo: Color
    let sobreFondo: Color
    let superficie: Color
    let sobreSuperficie: Color
    let sobreSuperficieVariante: Color

    static let claro = PaletaOrderBot(
        primario: .azulOrderBot,
        sobrePrimario: .white,
        contenedorPrimario: .azulClaroOrderBot,
        sobreContenedorPrimario: .textoPrincipal,
        secundario: .textoSecundario,
        sobreSecundario: .white,
        terciario: .verdeOrderBot,
        contenedorTerciario: .verdeClaroOrderBot,
        fondo: .fondoOrderBot,
        sobreFondo: .textoPrincipal,
        superficie: .white,
        sobreSuperficie: .textoPrincipal,
        sobreSuperficieVariante: .textoSecundario
    )

    static let oscuro = PaletaOrderBot(
        primario: .azulOrderBotOscuro,
        sobrePrimario: .textoPrincipal,
        contenedorPrimario: .azulContenedorOscuro,
        sobreContenedorPrimario: .textoPrincipalOscuro,
        secundario: .textoSecundarioOscuro,
        sobreSecundario: .textoPrincipal,
        terciario: .verdeOrderBotOscuro,
        contenedorTerciario: .verdeContenedorOscuro,
        fondo: .fondoOscuro,
        sobreFondo: .textoPrincipalOscuro,
        superficie: .superficieOscura,
        sobreSuperficie: .textoPrincipalOscuro,
        sobreSuperficieVariante: .textoSecundarioOscuro
    )
}

// MARK: - Entorno

private struct ClavePaletaOrderBot: EnvironmentKey {
    static let defaultValue = PaletaOrderBot.claro
}

extension EnvironmentValues {
    /// Paleta activa según el modo de tema elegido.
    var paletaOrderBot: PaletaOrderBot {
        get { self[ClavePaletaOrderBot.self] }
        set { self[ClavePaletaOrderBot.self] = newValue }
    }
}

// MARK: - Modificador de tema

/// Equivalente a `OrderBotTheme { ... }`.
///
/// Aplica la paleta y fija el esquema de color de la app; `nil`
/// significa "seguir al sistema".
struct OrderBotTema: ViewModifier {
    let oscuro: Bool
    let esquemaPreferido: ColorScheme?

    func body(content: Content) -> some View {
        content
            .environment(\.paletaOrderBot, oscuro ? .oscuro : .claro)
            .preferredColorScheme(esquemaPreferido)
    }
}

extension View {
    /// Aplica el tema de OrderBot a un árbol de vistas.
    func orderBotTema(oscuro: Bool, esquemaPreferido: ColorScheme? = nil) -> some View {
        modifier(OrderBotTema(oscuro: oscuro, esquemaPreferido: esquemaPreferido))
    }
}
