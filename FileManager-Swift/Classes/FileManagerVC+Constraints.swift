//
//  FileManagerVC+Constraints.swift
//  NoorMagazine
//
//  Created by Mahmoud Hamad on 7/13/17.
//  Copyright © 2017 yassin abdelmaguid. All rights reserved.
//

import UIKit

//Configuer Our views
@available(iOS 9.0, *)
extension FileManagerVC {
    
    func configuerHeaderView() -> FancyView {
        let view = FancyView()
        view.backgroundColor = customizations.headerViewColor ?? UIColor.purple
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow = true
        return view
    }
    
    func configuerCollectionView() -> UICollectionView {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(14, 20, 14, 20)
        //let width = UIScreen.main.bounds.size.width
        //flow?.itemSize = CGSize(width: width/3, height: width/3)
        flow.itemSize = CGSize(width: 140, height: 140)
        flow.minimumLineSpacing = 14
        flow.minimumInteritemSpacing = 14
        flow.scrollDirection = .vertical
        let cV = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flow)
        cV.allowsMultipleSelection = true
        cV.translatesAutoresizingMaskIntoConstraints = false
        cV.backgroundColor = UIColor.clear
        
        return cV
    }
    
    func configuerMarkBtn() -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(" Mark", for: .normal)
        btn.setTitleColor( UIColor.lightGray, for: .normal)
        btn.frame.size = CGSize(width: 48, height: 38)
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.titleLabel?.font = UIFont(name: "Avenir", size: 18)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        btn.setImage( UIImage(named: "messageindicator1.png"), for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(markTapped), for: .touchUpInside)
        btn.tintColor = UIColor.gray
        return btn
    }
    
    func configuerDeleteBtn() -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle("Delete", for: .normal)
        btn.setTitleColor( UIColor.lightGray, for: .normal)
        btn.frame.size = CGSize(width: 48, height: 38)
        btn.setImage( UIImage(named: "trash"), for: .normal)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.titleLabel?.font = UIFont(name: "Avenir", size: 18)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(deleteFilesPressed), for: .touchUpInside)
        btn.tintColor = UIColor.gray
        return btn
    }
    
    func configuerBackBtn() -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(" Back", for: .normal)
        btn.setTitleColor( UIColor.lightGray, for: .normal)
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        //btn.setImage(UIImage.make(name: "send_btn"), for: .normal)
        btn.setImage(UIImage(named: "send_btn"), for: .normal)
        //btn.setImage(FileManagerVC._imagess["back"], for: .normal)
        
        btn.frame.size = CGSize(width: 48, height: 38)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.titleLabel?.font = UIFont(name: "Avenir", size: 18)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        btn.tintColor = UIColor.gray
        return btn
    }
}

//Constraints
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

@available(iOS 9.0, *)
public extension UIImage {
    static func make(name: String) -> UIImage? {
        let bundle = Bundle(for: FileManagerVC.self)
        
        debugFM("\(contentsOfDirectoryAtPath(path: "\(Bundle(for: FileManagerVC.self).bundlePath)"))")
        debugFM("\(Bundle(for: FileManagerVC.self).bundlePath)/FileManager_Swift")
        debugFM("FileManager_Swift/Assets/\(name).xcassets/\(name)")

        
        
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

