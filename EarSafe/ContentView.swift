//
//  ContentView.swift
//  EarSafe
//
//  Created by Abhishek Ruhela on 3/14/26.
//
//
import SwiftUI
import AppKit

struct ContentView: View {
    
    @StateObject private var audioManager = AudioManager()
    
    @State private var harshCut: Double = -4
    @State private var vocalBoost: Double = 1
    @State private var warmth: Double = 0
    @State private var safeVolume: Double = 70
    @State private var earProtection = true
    
    @State private var selectedPreset = "Sensitive"
    @State private var selectedOutput = "MacBook Air Speakers"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("EarSafe")
                .font(.title.bold())
            
            Picker("Output", selection: $selectedOutput) {
                Text("MacBook Air Speakers").tag("MacBook Air Speakers")
                Text("External Headphones").tag("External Headphones")
            }
            .pickerStyle(.menu)
            
            Text("Preset: \(selectedPreset)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Divider()
            
            sliderRow("Harsh Cut", value: $harshCut)
            sliderRow("Voice Clarity", value: $vocalBoost)
            sliderRow("Warmth", value: $warmth)
            
            sliderRow("Safe Volume", value: $safeVolume, range: 30...100)
                .onChange(of: safeVolume) {
                    audioManager.setSystemVolume(safeVolume)
                }
            
            Text("System Volume: \(Int(safeVolume))%")
                .font(.caption2)
                .foregroundColor(.secondary)
            
            Toggle("Ear Protection", isOn: $earProtection)
            
            Divider()
            
            HStack {
                presetButton("Balanced")
                presetButton("Smooth")
            }
            
            HStack {
                presetButton("Clear")
                presetButton("Sensitive")
            }
            
            Divider()
            
            HStack {
                Button("Advanced EQ") {
                    if let delegate = NSApp.delegate as? AppDelegate {
                        delegate.openAdvancedWindow()
                    }
                }
                
                Spacer()
                
                Button("Settings") {
                    NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                }
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }
        }
        .padding(20)
        .frame(width: 440)
    }
    
    func sliderRow(_ title: String,
                   value: Binding<Double>,
                   range: ClosedRange<Double> = -12...12) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
            
            Slider(value: value, in: range)
            
            Text(String(format: "%.1f", value.wrappedValue))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
    
    func presetButton(_ name: String) -> some View {
        Button(name) {
            selectedPreset = name
            audioManager.applyPreset(name)
        }
        .buttonStyle(.borderedProminent)
    }
}
