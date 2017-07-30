//
//  FileManagerVC+Constraints.swift
//  NoorMagazine
//
//  Created by Mahmoud Hamad on 7/13/17.
//  Copyright © 2017 yassin abdelmaguid. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
extension FileManagerVC {
    

    //Important
    func setCollectionViewConstraints() { //handle x , y, width and height
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    }

    
    func setButtonsContrainsts() {      //handle x , y, width and height
        backBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8).isActive = true
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 13).isActive = true

        deleteBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8).isActive = true
        deleteBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14).isActive = true
        
        markBTN.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8).isActive = true
        markBTN.rightAnchor.constraint(equalTo: deleteBtn.leftAnchor, constant: -17).isActive = true
    }

    func setHeaderViewConstraints(){      //handle x , y, width and height
        headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}

@available(iOS 9.0, *)
extension FileManagerVC {
    /////////////////////////////////////
    func getDirectoryPath() -> String {
        print("VC getDirectoryPath")
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func contentsOfDirectoryAtPath(path: String) -> [String]? {
        print("VC contentsOfDirectoryAtPath")
        
        guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path) else { return nil}
        return paths.map { aContent in (path as NSString).appendingPathComponent(aContent)}
    }
    
    func AlertDismiss(t: String, msg: String, yesCompletion: @escaping () -> ()) {
        let ac = UIAlertController(title: t, message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert: UIAlertAction) in
            //self.dismiss(animated: true, completion: nil)
            yesCompletion()
        }))
        self.present(ac, animated: true, completion: nil)
        
    }
}

func contentsOfDirectoryAtPath(path: String) -> [String]? {
    print("VC contentsOfDirectoryAtPath")
    
    guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path) else { return nil}
    
    return paths.map { aContent in (path as NSString).appendingPathComponent(aContent)}
}

@available(iOS 9.0, *)
public extension UIImage {
    static func make(name: String) -> UIImage? {
        let bundle = Bundle(for: FileManagerVC.self)
        
        print(contentsOfDirectoryAtPath(path: "\(Bundle(for: FileManagerVC.self).bundlePath)"))
        print("\(Bundle(for: FileManagerVC.self).bundlePath)/FileManager_Swift")
        
        print("FileManager_Swift/Assets/\(name).xcassets/\(name)")
        
        //return UIImage(named: "FileManager-Swift/Assets/\(name).xcassets/\(name).imageset/\(name)", in: bundle, compatibleWith: nil)
        
        //return UIImage(named: "/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/10B539AB-038D-482B-A6B8-476CD929B841/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/send_btn.png", in: bundle, compatibleWith: nil)
        
        let url = URL(fileURLWithPath: "/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/10B539AB-038D-482B-A6B8-476CD929B841/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/").appendingPathComponent(name)
        return UIImage(contentsOfFile: "\(url)")
    }
}


/*
["/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/976A33C2-21DA-4EAF-94B5-2652C9B23A15/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/_CodeSignature",
 "/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/976A33C2-21DA-4EAF-94B5-2652C9B23A15/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/FileManager_Swift",
 "/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/976A33C2-21DA-4EAF-94B5-2652C9B23A15/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/Info.plist"]

*/
/*
["/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/10B539AB-038D-482B-A6B8-476CD929B841/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/_CodeSignature",
 "/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/10B539AB-038D-482B-A6B8-476CD929B841/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/Assets.car",
 "/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/10B539AB-038D-482B-A6B8-476CD929B841/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/FileManager_Swift",
 "/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/10B539AB-038D-482B-A6B8-476CD929B841/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/Info.plist",
 "/Users/Mahmoud/Library/Developer/CoreSimulator/Devices/57E06727-662D-44F0-8A8D-83DA6B8776A9/data/Containers/Bundle/Application/10B539AB-038D-482B-A6B8-476CD929B841/FileManager-Swift_Example.app/Frameworks/FileManager_Swift.framework/send_btn.png"])
*/

