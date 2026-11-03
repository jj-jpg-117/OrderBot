import SwiftUI

/// Tipografía de la app.
///
/// Equivale a `ui/theme/Type.kt`. Material 3 trabaja con roles
/// (`bodyLarge` = 16 sp, interlineado 24 sp, letterSpacing 0.5);
/// en SwiftUI se declaran tamaños y pesos explícitos, que es el mismo
/// criterio que ya usaban las pantallas de Compose.
enum FuentesOrderBot {
    static let nombreApp = Font.system(size: 34, weight: .bold)
    static let titulo = Font.system(size: 28, weight: .bold)
    static let tituloCompacto = Font.system(size: 26, weight: .bold)
    static let tituloSeccion = Font.system(size: 18, weight: .bold)
    static let eslogan = Font.system(size: 20, weight: .semibold)
    static let subtitulo = Font.system(size: 17, weight: .bold)
    static let cuerpo = Font.system(size: 16)
    static let cuerpoDestacado = Font.system(size: 16, weight: .bold)
    static let cuerpoGrande = Font.system(size: 18)
    static let cuerpoGrandeDestacado = Font.system(size: 18, weight: .bold)
    static let detalle = Font.system(size: 15)
    static let detalleDestacado = Font.system(size: 15, weight: .bold)
    static let secundario = Font.system(size: 14)
    static let pie = Font.system(size: 13)
    static let emojiGrande = Font.system(size: 40)
    static let emojiMuyGrande = Font.system(size: 70)
    static let iconoTema = Font.system(size: 22)

    /// Ejemplo de mapeo de `bodyLarge` (16/24 con tracking 0.5).
    static let cuerpoGrandeInterlineado: CGFloat = 8
}
