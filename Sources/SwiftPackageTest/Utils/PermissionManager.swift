//
//  PermissionManager.swift
//  WebViewTest
//
//  Created by hugh on 2023/04/03.
//

import Foundation
import AVFoundation

@available(iOS 13.0, *)
public class PermissionManager: ObservableObject {
    @Published public var permissionGranted = false
    
    public init() {
    }
    
    /**
     * 카메라 권한을 요청
     *
     */
    public func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            if granted {
                print("카메라 권한 허용")
            } else {
                print("카메라 권한 거부")
            }
        })
    }
}
