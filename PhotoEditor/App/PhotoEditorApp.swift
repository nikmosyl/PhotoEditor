//
//  PhotoEditorApp.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct PhotoEditorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var coordinator = NavigationCoordinator()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
        .environmentObject(coordinator)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
