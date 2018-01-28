//
//  ViewController.swift
//  justTesting
//
//  Created by Michael Hendrick on 1/27/18.
//  Copyright © 2018 MHendrick. All rights reserved.
//

import Cocoa
import HotKey

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, PopupViewControllerDelegate {
    
    func initContents(){
        contents.append(("Test", "IMG_3136", hkScreen1, "HotKey = Command + Option + 1", "leScript"))
        contents.append(("Hello", "slider-turtle", hkScreen2, "HotKey = Command + Option + 2", "leScript"))
        contents.append(("World", "slider-turtle", hkScreen3, "HotKey = Command + Option + 3", "leScript"))
    }
    var contents: [(String, String, HotKey, String, String)] = []
    
    let hkScreen1 = HotKey(key: .one, modifiers: [.command, .option])
    let hkScreen2 = HotKey(key: .two, modifiers: [.command, .option])
    let hkScreen3 = HotKey(key: .three, modifiers: [.command, .option])
    let hkScreen4 = HotKey(key: .four, modifiers: [.command, .option])
    let hkScreen5 = HotKey(key: .five, modifiers: [.command, .option])
    
    
    let newKey: Key = .b
    
    var addedName: String = ""
    
    
    func createNewContent(name: String, script: String){
        var script = ""
        if contents.count == 0{
            contents.append((name, "IMG_3136", hkScreen1, "HotKey = Command + Option + 1", script))
        }
        else if contents.count == 1{
            contents[0].2 = hkScreen1
            contents[0].3 = "HotKey = Command + Option + 1"
            contents.append((name, "slider-turtle", hkScreen2, "HotKey = Command + Option + 2", script))
        }
        else if contents.count == 2{
            contents[0].2 = hkScreen1
            contents[0].3 = "HotKey = Command + Option + 1"
            contents[1].2 = hkScreen2
            contents[1].3 = "HotKey = Command + Option + 2"
            contents.append((name, "slider-turtle", hkScreen3, "HotKey = Command + Option + 3", script))
        }
        else if contents.count == 3{
            contents[0].2 = hkScreen1
            contents[0].3 = "HotKey = Command + Option + 1"
            contents[1].2 = hkScreen2
            contents[1].3 = "HotKey = Command + Option + 2"
            contents[2].2 = hkScreen3
            contents[2].3 = "HotKey = Command + Option + 3"
            contents.append((name, "slider-turtle", hkScreen4, "HotKey = Command + Option + 4", script))
        }
        else if contents.count == 4{
            contents[0].2 = hkScreen1
            contents[0].3 = "HotKey = Command + Option + 1"
            contents[1].2 = hkScreen2
            contents[1].3 = "HotKey = Command + Option + 2"
            contents[2].2 = hkScreen3
            contents[2].3 = "HotKey = Command + Option + 3"
            contents[3].2 = hkScreen4
            contents[3].3 = "HotKey = Command + Option + 4"
            contents.append((name, "slider-turtle", hkScreen5, "HotKey = Command + Option + 5", script))
        }
    }
    
    

    @IBOutlet weak var removeButton: NSButtonCell!
    
    
    @IBOutlet weak var hotKeyText: NSTextFieldCell!
    
    
    override func viewDidLoad() {
        //if addedName != ""{
          //  contents.append((addedName, "IMG_3136", .d))
        //}
        //initContents()
        checkLength()
        enableWatchers()
        self.preferredContentSize = NSMakeSize(500, 300)
        self.tableView.reloadData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    weak var presentedPopupController: popUpViewController?
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let vc = segue.destinationController as? popUpViewController {
            vc.delegate = self
            self.presentedPopupController = vc
        }
    }
    
    @IBOutlet weak var addButton: NSButton!
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return contents.count
    }
    
    
    func enableWatchers(){
        let duh = self.contents.count
        hkScreen1.isPaused = true
        hkScreen2.isPaused = true
        hkScreen3.isPaused = true
        hkScreen4.isPaused = true
        hkScreen5.isPaused = true
        if duh >= 1{
            hkScreen1.isPaused = false
            hkScreen1.keyDownHandler = { print("did 1") }
        }
        if duh >= 2{
            hkScreen2.isPaused = false
            hkScreen2.keyDownHandler = { print("did 2") }
        }
        if duh >= 3{
            hkScreen3.isPaused = false
            hkScreen3.keyDownHandler = { print("did 3") }
        }
        if duh >= 4{
            hkScreen4.isPaused = false
            hkScreen4.keyDownHandler = { print("did 4", duh) }
        }
        if duh == 5{
            hkScreen5.isPaused = false
            hkScreen5.keyDownHandler = { print("did 5") }
        }
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44
    }
    @IBOutlet weak var screenNameInfo: NSTextField!
    
    
    
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if row > -1{
            screenNameInfo.stringValue = contents[row].0
            hotKeyText.stringValue = contents[row].3
        }
        return true
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let content = self.contents[row]
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "screenOne"), owner: self) as! NSTableCellView
        cell.imageView?.image = NSImage.init(named: NSImage.Name(rawValue: content.1))
        cell.textField?.stringValue = content.0
        return cell
    }


    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBAction func removeContent(_ sender: Any) {
        let remove = tableView.selectedRow
        if remove > -1{
            contents.remove(at: remove)
            reformatView()
        }
        checkLength()
        enableWatchers()
        self.tableView.reloadData()
    }
    
    func popupViewController(viewController: popUpViewController, didEnterName name: String, didRecieveImg: String) {
        createNewContent(name: name, script: didRecieveImg)
        checkLength()
        enableWatchers()
        self.tableView.reloadData()
        if let presented = self.presentedPopupController {
            self.dismissViewController(presented)
            self.presentedPopupController = nil
        }
    }
    
    
    func reformatView(){
        if contents.count >= 1{
            contents[0].2 = hkScreen1
            contents[0].3 = "HotKey = Command + Option + 1"
        }
        if contents.count >= 2{
            contents[1].2 = hkScreen2
            contents[1].3 = "HotKey = Command + Option + 2"
        }
        if contents.count >= 3{
            contents[2].2 = hkScreen3
            contents[2].3 = "HotKey = Command + Option + 3"
        }
        if contents.count >= 4{
            contents[3].2 = hkScreen4
            contents[3].3 = "HotKey = Command + Option + 4"
        }
        if contents.count >= 5{
            contents[4].2 = hkScreen5
            contents[4].3 = "HotKey = Command + Option + 5"
        }
    }
    
    func checkLength(){
        if self.contents.count == 5{
            self.addButton.isEnabled = false
        }
        else if self.contents.count == 0{
            removeButton.isEnabled = false
        }
        else{
            addButton.isEnabled = true
            removeButton.isEnabled = true
        }
    }
    
}

