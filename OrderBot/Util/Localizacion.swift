import Foundation

/// Acceso a los textos localizados.
///
/// Sustituye a `stringResource(R.string...)` de Compose: las claves son
/// exactamente las mismas que usa el proyecto Android (`strings.xml`) y
/// viven en `Recursos/Localizable.xcstrings`.
///
/// Al mantener las mismas claves, la app queda traducible sin tocar el
/// código y es trivial comparar ambas versiones.
enum L {

    /// Devuelve el texto de una clave. Si la clave no existe en el
    /// catálogo, devuelve la propia clave (útil en desarrollo).
    static func t(_ clave: String) -> String {
        Bundle.main.localizedString(forKey: clave, value: clave, table: nil)
    }

    /// Igual que `t(_:)` pero aplica argumentos a los marcadores del
    /// texto, como `stringResource(id, args)` en Android.
    ///
    /// Ojo con los marcadores: Android usa `%1$s` para texto, mientras
    /// que `String(format:)` en Apple espera `%1$@` (los `%s` son
    /// cadenas de C). Por eso el catálogo usa `%1$@`.
    /// Tampoco se pasa `locale:`: con locale, `%1$d` añadiría separador
    /// de miles y un número de pedido saldría como "1.024".
    static func t(_ clave: String, _ argumentos: CVarArg...) -> String {
        String(format: t(clave), arguments: argumentos)
    }
}
