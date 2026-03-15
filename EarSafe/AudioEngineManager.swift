//
//  AudioEngineManager.swift
//  EarSafe
//
//  Created by Abhishek Ruhela on 3/15/26.
//
import Foundation
import AVFoundation
import Combine

final class AudioEngineManager: ObservableObject {
    
    let engine: AVAudioEngine
    let eq: AVAudioUnitEQ
    
    init() {
        engine = AVAudioEngine()
        eq = AVAudioUnitEQ(numberOfBands: 3)
        
        setupEQ()
    }
    
    private func setupEQ() {
        
        let bands = eq.bands
        
        bands[0].filterType = .parametric
        bands[0].frequency = 80
        bands[0].bandwidth = 1
        bands[0].gain = 0
        
        bands[1].filterType = .parametric
        bands[1].frequency = 1000
        bands[1].bandwidth = 1
        bands[1].gain = 0
        
        bands[2].filterType = .parametric
        bands[2].frequency = 8000
        bands[2].bandwidth = 1
        bands[2].gain = 0
    }
    
    func setBass(_ value: Double) {
        eq.bands[0].gain = Float(value)
    }
    
    func setMid(_ value: Double) {
        eq.bands[1].gain = Float(value)
    }
    
    func setTreble(_ value: Double) {
        eq.bands[2].gain = Float(value)
    }
}
