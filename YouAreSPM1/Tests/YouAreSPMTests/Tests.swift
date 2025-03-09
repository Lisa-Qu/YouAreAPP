import YouAreSPM
import XCTest
import UIKit

class Tests: XCTestCase {
    func testConfettiViewIsNotInteractiveByDefault() {
        XCTAssertFalse(ConfettiView().isUserInteractionEnabled)
    }
}
