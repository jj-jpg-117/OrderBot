import Foundation

/// Métodos de pago aceptados por OrderBot.
///
/// El `rawValue` es el mismo texto que guardaba Android con `name`
/// ("EFECTIVO", "TARJETA", "BILLETERA_DIGITAL"), así los pedidos
/// guardados en Room/Firestore mantienen el formato.
///
/// `claveEtiqueta` es la referencia al texto visible; nunca se guarda
/// el texto literal para respetar la localización.
enum MetodoPago: String, CaseIterable, Identifiable {
    case efectivo = "EFECTIVO"
    case tarjeta = "TARJETA"
    case billeteraDigital = "BILLETERA_DIGITAL"

    var id: String { rawValue }

    var claveEtiqueta: String {
        switch self {
        case .efectivo: "pago_efectivo"
        case .tarjeta: "pago_tarjeta"
        case .billeteraDigital: "pago_billetera"
        }
    }

    var etiqueta: String { L.t(claveEtiqueta) }
}
