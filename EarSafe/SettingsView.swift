//
//  SettingsView.swift
//  EarSafe
//
//  Created by Abhishek Ruhela on 3/15/26.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var launchAtLogin = false
    @State private var safeLimit = 70
    @State private var notifications = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("EarSafe Settings")
                .font(.title2.bold())
            
            Toggle("Launch at Login", isOn: $launchAtLogin)
            
            Toggle("Notifications", isOn: $notifications)
            
            VStack(alignment: .leading) {
                Text("Safe Volume Limit: \(safeLimit)%")
                Slider(value: Binding(
                    get: { Double(safeLimit) },
                    set: { safeLimit = Int($0) }
                ), in: 30...100)
            }
            
            Spacer()
        }
        .padding(24)
        .frame(width: 420, height: 240)
    }
}
