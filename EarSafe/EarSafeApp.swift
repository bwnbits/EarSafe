//
//  EarSafeApp.swift
//  EarSafe
//
//  Created by Abhishek Ruhela on 3/14/26.
//
import SwiftUI

@main
struct EarSafeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            SettingsView()
        }
    }
}
