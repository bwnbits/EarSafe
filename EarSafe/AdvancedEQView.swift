//
//  AdvancedEQView.swift
//  EarSafe
//
//  Created by Abhishek Ruhela on 3/14/26.
//

import SwiftUI

struct AdvancedEQView: View {
    
    @State private var bass: Double = 0
    @State private var mid: Double = 0
    @State private var treble: Double = 0
    
    @State private var leftEar: Double = 50
    @State private var rightEar: Double = 50
    
    @State private var peakLimiter = true
    @State private var dialogueBoost = false
    @State private var earFatigueProtection = true
    @State private var bassSoftener = false
    
    @State private var selectedPreset = "Super Safe Sensitive Ear"
    
    let presets = [
        "Super Safe Sensitive Ear",
        "Sensitive Ear",
        "Baby Ear",
        "Long Hour Lectures",
        "Dialogues",
        "Bass Songs",
        "Custom 1",
        "Custom 2",
        "Custom 3"
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Advanced Equalizer")
                .font(.title.bold())
            
            Picker("Preset", selection: $selectedPreset) {
                ForEach(presets, id: \.self) { preset in
                    Text(preset)
                }
            }
            .pickerStyle(.menu)
            
            Divider()
            
            HStack(spacing: 40) {
                knobSlider("Bass", value: $bass)
                knobSlider("Mid", value: $mid)
                knobSlider("Treble", value: $treble)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Left Ear Volume")
                Slider(value: $leftEar, in: 0...100)
                
                Text("Right Ear Volume")
                Slider(value: $rightEar, in: 0...100)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                Toggle("Peak Limiter", isOn: $peakLimiter)
                Toggle("Dialogue Clarity Boost", isOn: $dialogueBoost)
                Toggle("Ear Fatigue Protection", isOn: $earFatigueProtection)
                Toggle("Bass Softener", isOn: $bassSoftener)
            }
            
            Divider()
            
            HStack {
                Button("Save Custom 1") {}
                Button("Save Custom 2") {}
                Button("Save Custom 3") {}
            }
        }
        .padding(24)
        .frame(width: 760, height: 560)
    }
    
    func knobSlider(_ title: String, value: Binding<Double>) -> some View {
        VStack {
            Slider(value: value, in: -12...12)
                .rotationEffect(.degrees(-90))
                .frame(height: 140)
            
            Text(title)
                .font(.headline)
            
            Text(String(format: "%.1f dB", value.wrappedValue))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
