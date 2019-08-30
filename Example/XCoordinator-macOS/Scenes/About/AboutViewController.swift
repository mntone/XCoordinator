//
//  AboutViewController.swift
//  XCoordinator_macOS_Example
//
//  Created by mntone on 29.08.19.
//  Copyright © 2019 QuickBird Studios. All rights reserved.
//

import AppKit

class AboutViewController: NSViewController {

    // MARK: - Overrides

    override func loadView() {
        let view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        view.wantsLayer = true
        view.layer!.backgroundColor = NSColor.green.cgColor
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "About"

        let closeGesture = NSClickGestureRecognizer(target: self, action: #selector(closeDidClick))
        viewController.view.addGestureRecognizer(closeGesture)
    }

    // MARK: - Private methods

    @objc private func closeDidClick(sender: NSClickGestureRecognizer!) {
        dismiss(self)
    }
}
