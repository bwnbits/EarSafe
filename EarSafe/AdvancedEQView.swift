//
//  AdvancedEQView.swift
//  EarSafe
//
//  Created by Abhishek Ruhela on 3/14/26.
//
import SwiftUI
import AVFoundation
import Combine


struct AdvancedEQView: View {
    
    @StateObject private var engine = AudioEngineManager()
    
    @State private var bass: Double = 0
    @State private var mid: Double = 0
    @State private var treble: Double = 0
    
    @State private var selectedPreset = "Sensitive Ear"
    
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
            .onChange(of: selectedPreset) {
                applyPreset(selectedPreset)
            }
            
            Divider()
            
            HStack(spacing: 40) {
                
                sliderColumn("Bass", value: $bass) {
                    engine.setBass(bass)
                }
                
                sliderColumn("Mid", value: $mid) {
                    engine.setMid(mid)
                }
                
                sliderColumn("Treble", value: $treble) {
                    engine.setTreble(treble)
                }
            }
            
            Divider()
            
            HStack {
                Button("Save Custom 1") {
                    savePreset(slot: 1)
                }
                
                Button("Save Custom 2") {
                    savePreset(slot: 2)
                }
                
                Button("Save Custom 3") {
                    savePreset(slot: 3)
                }
            }
        }
        .padding(24)
        .frame(width: 760, height: 520)
    }
    
    func sliderColumn(_ title: String,
                      value: Binding<Double>,
                      action: @escaping () -> Void) -> some View {
        
        VStack {
            Slider(value: value, in: -12...12)
                .rotationEffect(.degrees(-90))
                .frame(height: 140)
                .onChange(of: value.wrappedValue) {
                    action()
                }
            
            Text(title)
            
            Text(String(format: "%.1f dB", value.wrappedValue))
                .font(.caption)
        }
    }
    
    func applyPreset(_ preset: String) {
        
        switch preset {
            
        case "Super Safe Sensitive Ear":
            bass = -6
            mid = 2
            treble = -7
            
        case "Sensitive Ear":
            bass = -4
            mid = 1
            treble = -5
            
        case "Baby Ear":
            bass = -8
            mid = 1
            treble = -8
            
        case "Long Hour Lectures":
            bass = -3
            mid = 4
            treble = -2
            
        case "Dialogues":
            bass = -2
            mid = 5
            treble = 2
            
        case "Bass Songs":
            bass = 6
            mid = 0
            treble = 2
            
        case "Custom 1":
            loadPreset(slot: 1)
            
        case "Custom 2":
            loadPreset(slot: 2)
            
        case "Custom 3":
            loadPreset(slot: 3)
            
        default:
            break
        }
        
        engine.setBass(bass)
        engine.setMid(mid)
        engine.setTreble(treble)
    }
    
    func savePreset(slot: Int) {
        UserDefaults.standard.set(bass, forKey: "bass\(slot)")
        UserDefaults.standard.set(mid, forKey: "mid\(slot)")
        UserDefaults.standard.set(treble, forKey: "treble\(slot)")
    }
    
    func loadPreset(slot: Int) {
        bass = UserDefaults.standard.double(forKey: "bass\(slot)")
        mid = UserDefaults.standard.double(forKey: "mid\(slot)")
        treble = UserDefaults.standard.double(forKey: "treble\(slot)")
    }
}
