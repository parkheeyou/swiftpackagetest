//
//  Utils.swift
//  WebViewTest
//
//  Created by hugh paak on 2023/04/06.
//

import Foundation
import UIKit

// 공통 모듈 필요기능 구현
@available(iOS 13.0, *)
final class CommonUtils {
    // UUID
    var deviceUUID: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    // os version 가져오기
    var osVersion: String {
        return UIDevice.current.systemVersion
    }
    
    // os name 가져오기
    var osVersionName: String {
        return UIDevice.current.systemName
    }
    
    // 앱버전, 빌드버전 가져오기
    var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
                let version = dictionary["CFBundleShortVersionString"] as? String,
                let build = dictionary["CFBundleVersion"] as? String else { return nil }
        
        let versionAndBuild: String = "version: \(version), build: \(build)"
        
        return versionAndBuild
    }
    
    // 클립보드에 복사
    func copyTest(_ data: String) {
        UIPasteboard.general.string = data
    }
    
    // 클립보드에 복사한 텍스트 가져오기
    var storedString: String? {
        guard let storedString = UIPasteboard.general.string else { return nil }
        return storedString
    }
    
    // 앱 종료
    func appFinish() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
    }
    
    // 외부 브라우저 열기
    func openSafariAction(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // 스키마로 외부 앱 실행, 앱 미설치시 앱스토어로 연결
    func checkInstalledApp(_ scheme: String, _ appId: String) {
        let appScheme = "\(scheme)://"
        let storeUrl = "itms-apps://itunes.apple.com/app/\(appId)"
        
        if let openApp = URL(string: appScheme),
           UIApplication.shared.canOpenURL(openApp) {
            UIApplication.shared.open(openApp, options: [:], completionHandler: nil)
        } else {
            if let openStore = URL(string: storeUrl),
               UIApplication.shared.canOpenURL(openStore) {
                UIApplication.shared.open(openStore, options: [:], completionHandler: nil)
            }
        }
    }
}
