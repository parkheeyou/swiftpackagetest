@available(iOS 13.0, *)
public struct SwiftPackageTest {
    public private(set) var text = "Hello, World!"
    
    public init() {
    }
    
    public func hello() {
        print("package test hello")
    }
    
    public func getUUID() -> String {
        return CommonUtils().deviceUUID
    }
}
