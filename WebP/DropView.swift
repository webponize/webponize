//
//  DropView.swift
//  WebP
//
//  Created by A12993 on 2015/01/09.
//  Copyright (c) 2015年 1000ch.net. All rights reserved.
//

import Cocoa

class DropView: NSView, NSDraggingDestination {
    
    override init(frame: NSRect) {
        super.init(frame: frame)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        registerForDraggedTypes([
            NSPasteboardTypePNG,
            NSColorPboardType,
            NSFilenamesPboardType
        ])
        //NSImage.imagePasteboardTypes()
        println(self.registeredDraggedTypes)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect)  {
        super.drawRect(dirtyRect)
        NSColor.whiteColor().set()
        NSRectFill(dirtyRect)
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation  {
        println("draggingEntered")
        return NSDragOperation.Copy
    }
    
    override func draggingEnded(sender: NSDraggingInfo?) {
        println("draggingEnded")
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        
        let pboard = sender.draggingPasteboard()
        
        println(pboard)
        
        let draggedFilePaths = pboard.propertyListForType(NSFilenamesPboardType) as NSArray
        
        println(draggedFilePaths)
        
        return true
    }
}
