import XCTest
@testable import OrderBot

/// Pruebas de la lógica de negocio del pedido.
///
/// Migración de `app/src/test/.../ResumenPedidoTest.kt`. No necesitan
/// simulador ni servicios: solo el modelo puro.
final class ResumenPedidoTests: XCTestCase {

    func testItemCalculaSuTotal() {
        let item = ItemPedido(producto: Catalogo.hamburguesa, cantidad: 3)
        XCTAssertEqual(item.total, 60_000)
    }

    func testSubtotalSumaTodosLosItems() {
        let resumen = ResumenPedido(items: [
            ItemPedido(producto: Catalogo.hamburguesa, cantidad: 2),
            ItemPedido(producto: Catalogo.papas, cantidad: 1)
        ])
        XCTAssertEqual(resumen.subtotal, 45_000)
    }

    func testTotalIncluyeElEnvioPorDefecto() {
        let resumen = ResumenPedido(items: [
            ItemPedido(producto: Catalogo.pizza, cantidad: 1)
        ])
        XCTAssertEqual(resumen.precioEnvio, Catalogo.precioEnvio)
        XCTAssertEqual(resumen.total, 17_000)
    }

    func testTotalRespetaUnEnvioPersonalizado() {
        let resumen = ResumenPedido(
            items: [ItemPedido(producto: Catalogo.bebida, cantidad: 1)],
            precioEnvio: 0
        )
        XCTAssertEqual(resumen.total, 4_000)
    }

    func testResumenVacio() {
        let resumen = ResumenPedido(items: [])
        XCTAssertTrue(resumen.estaVacio)
        XCTAssertEqual(resumen.subtotal, 0)
        XCTAssertEqual(resumen.total, Catalogo.precioEnvio)
    }
}
