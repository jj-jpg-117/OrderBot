import XCTest
@testable import OrderBot

/// Pruebas del formateo de precios en pesos colombianos.
///
/// Migración de `app/src/test/.../FormatoPrecioTest.kt`.
final class FormatoPrecioTests: XCTestCase {

    func testFormateaMilesConPunto() {
        XCTAssertEqual(29_000.aPrecio, "$29.000")
    }

    func testFormateaMillones() {
        XCTAssertEqual(1_234_567.aPrecio, "$1.234.567")
    }

    func testFormateaCero() {
        XCTAssertEqual(0.aPrecio, "$0")
    }

    func testFormateaNumeroSinSeparador() {
        XCTAssertEqual(500.aPrecio, "$500")
    }
}
