//
//  SwiftFulSpotifyApp.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 25/06/25.
//

import SwiftUI
import SwiftfulRouting // iOS 16+

@main
struct SwiftFulSpotifyApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

//MARK: - Gesto delizar View para esquerda
extension UINavigationController: UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad ()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
