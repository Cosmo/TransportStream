import XCTest
@testable import TransportStream

final class TransportStreamTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TransportStream().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
