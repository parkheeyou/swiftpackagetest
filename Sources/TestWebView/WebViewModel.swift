//
//  WebViewModel.swift
//  WebViewTest
//
//  Created by hugh on 2023/03/30.
//

import Foundation
import Combine
import UIKit

@available(iOS 13.0, *)
public class WebViewModel: ObservableObject {
    var foo = PassthroughSubject<String, Never>() // app -> web
    var back = PassthroughSubject<String, Never>()  // app -> web
    var bar = PassthroughSubject<Bool, Never>() // web -> app
    var count = 0
    
    let homeUrl = Bundle.main.url(forResource: "home", withExtension: "html", subdirectory: "www/html/home") ?? URL(string: "https://velog.io/")
    //let homeUrl = Bundle.main.path(forResource: "www/html/home/home", ofType: "html") ?? "https://velog.io/"
    
    func clicks() -> Int {
        count = count + 1
        
        return count
    }
    
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let currentTime = Date()
        let timeString = dateFormatter.string(from: currentTime)
        
        return timeString
    }
}
