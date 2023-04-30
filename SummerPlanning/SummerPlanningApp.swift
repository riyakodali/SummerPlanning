//
//  SummerPlanningApp.swift
//  SummerPlanning
//
//  Created by Riya Kodali on 4/26/23.
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
struct SummerPlanningApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var summerToDosVM = SummerToDosViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(summerToDosVM)
        }
    }
}
