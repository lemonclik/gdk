import XCTest
import Foundation

import PromiseKit

import ga.wally

@testable import GreenAddress

class GreenAddressTests : XCTestCase {

    let DEFAULT_MNEMONIC: String = "tragic transfer mesh camera fish model bleak lumber never capital animal era " +
                                   "coffee shift flame across pitch pipe shiver castle crawl noble obtain response"


    fileprivate func doLogin(network: Network) throws -> Session {
        let session : Session = try Session()

        let ex = expectation(description: "")

        let p1 = retry(session: session, network: network) { wrap { try session.connect(network: network, debug: true) } }
        let p2 = retry(session: session, network: network) { wrap { try session.registerUser(mnemonic: self.DEFAULT_MNEMONIC) } }
        let p3 = wrap { try session.login(mnemonic: self.DEFAULT_MNEMONIC) }

        _ = when(fulfilled: p1, p2, p3).done { _, _, _ in ex.fulfill(); }
        waitForExpectations(timeout: 15, handler: nil)

        return session
    }

    func testValidateMnemonic() {
        let valid: String = self.DEFAULT_MNEMONIC;
        let invalid: String = String(valid.reversed());

        XCTAssert(bip39_mnemonic_validate(nil, valid) == WALLY_OK)
        XCTAssert(bip39_mnemonic_validate(nil, invalid) == WALLY_EINVAL)
        XCTAssert(try validateMnemonic(mnemonic: valid))
        XCTAssertFalse(try validateMnemonic(mnemonic: invalid))
    }
}

extension GreenAddressTests {
    static var allTests : [(String, (GreenAddressTests) -> () throws -> Void)] {
        return [
            ("testValidateMnemonic", testValidateMnemonic)
        ]
    }
}
