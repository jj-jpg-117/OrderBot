import Foundation

/// Formateo de pesos colombianos.
///
/// `es-CO` usa "." como separador de miles, igual que
/// `NumberFormat.getInstance(Locale.forLanguageTag("es-CO"))` en Android.
///
/// Se usa `FormatStyle` en lugar de un `NumberFormatter` global:
/// `formatted(_:)` cachea el formateador internamente, así que sigue
/// siendo barato y además es seguro entre hilos.
extension Int {

    /// Convierte un valor en pesos a texto legible.
    ///
    /// Ejemplo: `29_000.aPrecio` -> `"$29.000"`
    var aPrecio: String {
        "$" + formatted(.number.locale(Locale(identifier: "es_CO")))
    }
}
