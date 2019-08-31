//
//  AppDelegate.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import Cocoa
import XCoordinator

class AppDelegate: NSObject, NSApplicationDelegate {
    let window: NSWindow! = NSWindow(contentRect: NSRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0),
                                     styleMask: [.titled, .closable, .miniaturizable, .resizable],
                                     backing: .buffered,
                                     defer: false)
    let router = AppCoordinator().anyRouter

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        router.setRoot(for: window)
    }
}
