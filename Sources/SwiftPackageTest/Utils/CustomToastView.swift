//
//  CustomToastView.swift
//  WebViewTest
//
//  Created by hugh on 2023/04/03.
//

import Foundation
import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
        }
        .transition(.move(edge: .bottom))
    }
}
