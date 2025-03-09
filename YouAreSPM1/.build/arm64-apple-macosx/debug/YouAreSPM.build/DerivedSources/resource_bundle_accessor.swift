import Foundation

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = Bundle.main.bundleURL.appendingPathComponent("YouAreSPM_YouAreSPM.bundle").path
        let buildPath = "/Users/lisa.qu/Desktop/YouAre/YouAreSPM1/.build/arm64-apple-macosx/debug/YouAreSPM_YouAreSPM.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            // Users can write a function called fatalError themselves, we should be resilient against that.
            Swift.fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}