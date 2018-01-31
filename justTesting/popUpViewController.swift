//
//  popUpViewController.swift
//  justTesting
//
//  Created by Michael Hendrick on 1/27/18.
//  Copyright © 2018 MHendrick. All rights reserved.
//

import Cocoa

@objc protocol PopupViewControllerDelegate: class {
    func popupViewController(viewController: popUpViewController, didEnterName name: String, didRecieveImg: String)
}

class popUpViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @discardableResult
    func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    //shell("./Users/MichaelHendrick/Desktop/justTesting/paneless/bestos")
    //shell("./bestos")
    
    
    @IBOutlet weak var delegate: PopupViewControllerDelegate?
    
    @IBOutlet weak var newScreenName: NSTextFieldCell!
    
    let incomeString = "hi"

    
    //let task = Process()
    
    
    @IBAction func confirmAdd(_ sender: Any) {
        
        
        
        
        self.delegate?.popupViewController(viewController: self, didEnterName: self.newScreenName.stringValue, didRecieveImg: self.incomeString)
        }
}
