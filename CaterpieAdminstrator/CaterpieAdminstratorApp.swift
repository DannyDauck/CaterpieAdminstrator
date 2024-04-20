//
//  CaterpieAdminstratorApp.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 25.03.24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct CaterpieAdminstratorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var vm =  LoginViewViewmodel()
    
    var body: some Scene {
        WindowGroup {
            if vm.authorized{
                MainScreenView()
            
            }else{
                LoginView(vm: vm)
            }
        }
    }
}
