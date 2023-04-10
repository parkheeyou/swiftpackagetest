//
//  Coordinator.swift
//  WebViewTest
//
//  Created by hugh paak on 2023/04/05.
//

import Foundation
import Combine
import WebKit

// 탐색 변경을 수락 또는 거부하고 탐색 요청의 진행 상황을 추적
// WKNavigationDelegate : 탐색 변경을 수락 또는 거부하고 탐색 요청의 진행 상황을 추적
@available(iOS 13.0, *)
class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    var delegate: WebViewHandlerDelegate?
    
    var foo: AnyCancellable? = nil
    var back: AnyCancellable? = nil
    
    // 생성자
    init(_ uiWebView: WebView) {
        self.parent = uiWebView
        self.delegate = parent
    }
    
    // 소멸자
    deinit {
        foo?.cancel()
    }
    
    // 지정된 기본 설정 및 작업 정보를 기반으로 새 컨텐츠를 탐색할 수 있는 권한을 대리인에게 요청
    // 외부 앱등 호출시 여기서 설정 - android should overriding url
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("웹뷰 설정")
        // url 추적
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)

        // web -> app 값 보내기
        self.parent.viewModel.bar.send(false)
        
        // 받은 값 출력
        self.foo = self.parent.viewModel.foo
            .receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                print(value)
            })
        
        self.back = self.parent.viewModel.back
            .receive(on: RunLoop.main)
            .sink(receiveValue : { value in
                print(value)
                if webView.canGoBack {
                    webView.goBack()
                }
            })
        
        // 오류 처리 - url이 널인 경우 중지
        guard let url = navigationAction.request.url else {
            return decisionHandler(.cancel)
        }
        
        //
        if url.absoluteString.contains("//") {
            return decisionHandler(.allow)
        } else {
            return decisionHandler(.cancel)
        }
    }
    
    // url 추적
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString {
            print("url = \(url)")
        }
    }
    
    // 기본 프레임에서 탐색이 시작되었음 - android page start
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("기본 프레임에서 탐색이 시작되었음")
    }
    
    // 웹보기가 기본 프레임에 대한 내용을 수신하기 시작했음 - loading
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("내용을 수신하기 시작")
    }
    
    // 탐색이 완료 되었음 - android page finish
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("탐색이 완료")
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            let originUserAgent = result as! String
            print("after user agent : \(originUserAgent)")
        }
    }
    
    // 초기 탐색 프로세즈 중에 오류가 발생했음 - Error Handler
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("초기 탐색 프로세스 중에 오류가 발생했음 : \(error)")
    }
    
    // 탐색 중에 오류가 발생했음 - Error Handler
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("탐색 중에 오류가 발생했음")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            let url = self.parent.url.absoluteString
            
            print(url)
        }
    }
}

@available(iOS 13.0, *)
extension Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "test" {
            let body = message.body as! [String: Any?]
            delegate?.receivedJsonValueFromWebView(value: body)
        } else if let body = message.body as? String {
            delegate?.receivedStringValueFromWebView(value: body)
        }
    }
}
