//
//  CustomWebView.swift
//  WebViewTest
//
//  Created by hugh on 2023/03/30.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import WebKit

@available(iOS 13.0, *)
struct WebView: UIViewRepresentable, WebViewHandlerDelegate {
    //var url: String
    var url: URL
    
    @ObservedObject var viewModel: WebViewModel
    
    // 변경 사항을 전달하는데 사용하는 사용자 지정 인스턴스
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func receivedJsonValueFromWebView(value: [String : Any?]) {
        print("received json value : \(value)")
    }
    
    func receivedStringValueFromWebView(value: String) {
        print("received string value : \(value)")
    }
    
    // 뷰 객체를 생성하고 초기 상태를 구성. 딱 한번만 호출
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        // Javascript가 사용자 상호 작용없이 창을 열 수 있는지 여부
        preferences.javaScriptCanOpenWindowsAutomatically = false
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController.add(self.makeCoordinator(), name: "test")
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator    // 웹보기의 탐색 동작을 관리하는데 사용하는 객체
        webView.allowsBackForwardNavigationGestures = true  // 가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리커하는지 여부
        webView.scrollView.isScrollEnabled = true   // 웹보기와 관련된 스크롤 보기에서 스크롤 가능 여부
        
        // 유저 에이전트 추가 세팅
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            let originUserAgent = result as! String
            print("before user agent : \(originUserAgent)")
            let agent = originUserAgent + " iOSAPP"
            webView.customUserAgent = agent
        }
        
        // 로드할 파일의 URL 및 액세스 권한 설정
        if url.absoluteString.hasPrefix("file://") {
            let fileAccessURL = url.deletingLastPathComponent()
            let readAccessURL = fileAccessURL.absoluteURL
            print("url : \(url), fileAccessURL : \(fileAccessURL), readAccessURL : \(readAccessURL)")
            webView.loadFileURL(url, allowingReadAccessTo: url)
        } else {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    // 지정된 뷰의 상태를 다음의 새 정보로 업데이트
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 업데이트 내용
        //uiView.loadFileURL(request.url!, allowingReadAccessTo: request.url!.deletingLastPathComponent())
        print("웹 이동")
    }
}
