//
//  AppDelegate.swift
//  EarSafe
//
//  Created by Abhishek Ruhela on 3/14/26.
//
import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    var popover = NSPopover()
    var advancedWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let contentView = ContentView()
        
        popover.contentSize = NSSize(width: 440, height: 620)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "waveform", accessibilityDescription: nil)
            button.action = #selector(togglePopover)
            button.target = self
        }
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
    func openAdvancedWindow() {
        if advancedWindow == nil {
            advancedWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 760, height: 560),
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered,
                defer: false
            )
            
            advancedWindow?.center()
            advancedWindow?.title = "Advanced Equalizer"
            advancedWindow?.contentView = NSHostingView(rootView: AdvancedEQView())
        }
        
        advancedWindow?.makeKeyAndOrderFront(nil)
        advancedWindow?.orderFrontRegardless()
    }
}
