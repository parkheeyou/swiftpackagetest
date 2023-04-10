//
//  WebViewHandlerDelegate.swift
//  WebViewTest
//
//  Created by hugh paak on 2023/04/05.
//

import Foundation

// 웹 -> 앱 데이터 전달 처리
@available(iOS 13.0, *)
protocol WebViewHandlerDelegate {
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}
