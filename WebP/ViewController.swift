//
//  ViewController.swift
//  WebP
//
//  Created by A12993 on 2015/01/09.
//  Copyright (c) 2015年 1000ch.net. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var customButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onButtonClick(view: NSButton) {
        println(view)
    }
    
    
    func registerForDraggedTypes(pasteboardTypes: [AnyObject]) {
        println(pasteboardTypes)
    }
}

