//
//  ViewController.swift
//  FileManager-Swift
//
//  Created by Mahmoud333 on 07/16/2017.
//  Copyright (c) 2017 Mahmoud333. All rights reserved.
//

import UIKit
import FileManager_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func presentFileManager(_ sender: Any) {
        
        //customizations.cellType = CellType.titleAndSize And CellType.title
        //customizations.headerViewColor = UIColor.green
        
        let fileManager = FileManagerVC()
        
        /*//Old Code to pass the Images
        fileManager.passImages = [
            "file" : UIImage(named: "file")!,
            "zip"  : UIImage(named: "zip")!,
            "3gp"  : UIImage(named: "3gp")!,
            "jpg"  : UIImage(named: "jpg")!,
            "json" : UIImage(named: "json")!,
            "mp4"  : UIImage(named: "mp4")!,
            "pdf"  : UIImage(named: "pdf")!,
            "png"  : UIImage(named: "png")!,
            "txt"  : UIImage(named: "txt")!,
            "xml"  : UIImage(named: "xml")!,
            
            "trash"  : UIImage(named: "trash")!,
            "mark"  : UIImage(named: "messageindicator1")!,
            "markChecked"  : UIImage(named: "messageindicatorchecked1")!,
            "back"  : UIImage(named: "send_btn")!
        ]*/
        
        
        present(fileManager, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

