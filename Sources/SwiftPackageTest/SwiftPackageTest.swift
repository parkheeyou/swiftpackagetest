import Foundation
@available(iOS 13.0, *)
public struct SwiftPackageTest {
    let commonUtils = CommonUtils()
    
    public private(set) var text = "Hello, World!"
    
    public init() {
    }
    
    public func hello() {
        print("package test hello")
    }
    
    public func getUUID() -> String {
        return commonUtils.deviceUUID
    }
    
    public func getOsVersion() -> String {
        return commonUtils.osVersion
    }
    
    public func getOsVersionName() -> String {
        return commonUtils.osVersionName
    }
    
    public func getVersion() -> String? {
        return commonUtils.version
    }
    
    // 클립보드에 복사
    public func copyTest(_ data: String) {
        commonUtils.copyTest(data)
    }
    
    // 클립보드에 복사한 텍스트 가져오기
    public func getstoredString() -> String? {
        commonUtils.storedString
    }
    
    // 앱 종료
    public func appFinish() {
        commonUtils.appFinish()
    }
    
    // 외부 브라우저 열기
    public func openSafariAction(_ url: String) {
        commonUtils.openSafariAction(url)
    }
    
    // 스키마로 외부 앱 실행, 앱 미설치시 앱스토어로 연결
    public func checkInstalledApp(_ scheme: String, _ appId: String) {
        commonUtils.checkInstalledApp(scheme, appId)
    }
}
