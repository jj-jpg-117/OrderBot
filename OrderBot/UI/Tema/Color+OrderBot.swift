import SwiftUI

/// Paleta de marca OrderBot (equivalente a `ui/theme/Color.kt`).
///
/// Todos los colores del tema claro y oscuro viven aquí; ninguna vista
/// debería usar valores fijos, igual que en Compose se leían desde
/// `MaterialTheme.colorScheme`.
extension Color {

    /// Crea un color desde un literal hexadecimal (`0x2563EB`).
    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: 1
        )
    }

    // Paleta de marca (tema claro).
    static let azulOrderBot = Color(hex: 0x2563EB)
    static let azulClaroOrderBot = Color(hex: 0xEFF6FF)
    static let fondoOrderBot = Color(hex: 0xF8FAFC)
    static let textoPrincipal = Color(hex: 0x172033)
    static let textoSecundario = Color(hex: 0x64748B)
    static let verdeOrderBot = Color(hex: 0x16A34A)
    static let verdeClaroOrderBot = Color(hex: 0xE8F5E9)

    // Variantes para el tema oscuro.
    static let azulOrderBotOscuro = Color(hex: 0x9DB9FB)
    static let azulContenedorOscuro = Color(hex: 0x1E3A8A)
    static let fondoOscuro = Color(hex: 0x0F172A)
    static let superficieOscura = Color(hex: 0x1E293B)
    static let textoPrincipalOscuro = Color(hex: 0xE2E8F0)
    static let textoSecundarioOscuro = Color(hex: 0x94A3B8)
    static let verdeOrderBotOscuro = Color(hex: 0x4ADE80)
    static let verdeContenedorOscuro = Color(hex: 0x14532D)
}
