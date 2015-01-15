//
//  WindowController.swift
//  WebP
//
//  Created by A12993 on 2015/01/09.
//  Copyright (c) 2015年 1000ch.net. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    func registerForDraggedTypes(pasteboardTypes: [AnyObject]) {
        println(pasteboardTypes)
    }
}
