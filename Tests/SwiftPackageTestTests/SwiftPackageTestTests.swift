import XCTest
@testable import SwiftPackageTest

@available(iOS 13.0, *)
final class SwiftPackageTestTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftPackageTest().text, "Hello, World!")
    }
}
