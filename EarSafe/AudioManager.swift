//
//  AudioManager.swift
//  EarSafe
//
//  Created by Abhishek Ruhela on 3/14/26.
//
import Foundation
import AppKit
import Combine

class AudioManager: ObservableObject {
    
    func setSystemVolume(_ value: Double) {
        let script = "set volume output volume \(Int(value))"
        
        if let scriptObject = NSAppleScript(source: script) {
            scriptObject.executeAndReturnError(nil)
        }
    }
    
    func applyPreset(_ preset: String) {
        switch preset {
        case "Balanced":
            setSystemVolume(70)
        case "Smooth":
            setSystemVolume(60)
        case "Clear":
            setSystemVolume(75)
        case "Sensitive":
            setSystemVolume(55)
        default:
            setSystemVolume(65)
        }
    }
}
