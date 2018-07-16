//
//  FileManagerVC.swift
//  NoorMagazine
//
//  Created by mac on 7/12/17.
//  Copyright © 2017 yassin abdelmaguid. All rights reserved.
//

import UIKit


//Controller - FileManagerVC
@available(iOS 9.0, *)
public class FileManagerVC: UIViewController {

    var filess = [File]()
    
    var ourDirectory: String? //our app my computer
    
    var ourPathSteps = [String]() //every time we go inside folder will append its path & when press back will remove last path from array and go to last path before deleted one
        //acts like a history for us
    
    var currentPath: String?
    //switches
    var markIs = false {
        didSet {
            markBTN.setTitleColor(markIs == true ? UIColor.white : UIColor.lightGray, for: .normal)
            markBTN.setImage(markIs == true ? UIImage(named: "messageindicatorchecked1") : UIImage(named: "messageindicator1"), for: .normal)
        }
    }
    
    var markedFiles = [File]() { //files we marked and will deleted them
        didSet {
            deleteBtn.setTitleColor(markedFiles.count > 0 ? UIColor.white : UIColor.lightGray, for: .normal)
        }
    }
    
    lazy var headerView: FancyView = self.configuerHeaderView()
    lazy var collectionView: UICollectionView = self.configuerCollectionView()
    lazy var markBTN: UIButton = self.configuerMarkBtn()
    lazy var deleteBtn: UIButton = self.configuerDeleteBtn()
    lazy var backBtn: UIButton = self.configuerBackBtn()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        collectionView.delegate = self; collectionView.dataSource = self
        view.addSubview(collectionView)
        view.addSubview(headerView)
        view.addSubview(markBTN)
        view.addSubview(backBtn)
        view.addSubview(deleteBtn)
        
        setHeaderViewConstraints()
        setCollectionViewConstraints()
        setButtonsContrainsts()
        
        //register our cell
        collectionView.register(FileCell.self, forCellWithReuseIdentifier: "FileCell")
        
        ourDirectory = getDirectoryPath()
        //ourPathSteps.append(ourDirectory!) dont need it but keep it 27teate
        
        debugFM("\(ourDirectory)")
        
        readFilesHere(path: ourDirectory!)
    }
    
    func readFilesHere(path: String) {  //dont add nil or a path again to our list we did one
        if currentPath != nil, !ourPathSteps.contains(currentPath!) {
            
        }
        
        //get the files inside this new path
        let filesNames = contentsOfDirectoryAtPath(path: path)
        
        
        currentPath = path                 //currentPath = the new path
        
        
        ourPathSteps.append(currentPath!) //add our currentPath to history
        
        printFM("currentPath \(currentPath)")
        
        var thisPathFiles = [File]()
        for file in filesNames! {

            let cleanedFileName = file.replacingOccurrences(of: "\(currentPath!)/", with: "") //remove first path
            
            var file: File?
            
            //let fileType = cleanedFileName.remove before the .
            if !cleanedFileName.contains(".") {
                file = File(fileName: cleanedFileName, fileType: "file", filePath: currentPath!)
                
            } else {
                let fileType = cleanedFileName.components(separatedBy: ".").last
                
                file = File(fileName: cleanedFileName, fileType: fileType!, filePath: currentPath!)

            }
            
            debugFM("fileName \(file?.fileName), filetype \(file?.fileType)")

            thisPathFiles.append(file!)
        }
        filess = thisPathFiles
        collectionView.reloadData()
    }
    
    @IBAction func markTapped(_ sender: Any) {
        markIs = markIs == false ? true : false
    }
    
    @IBAction func deleteFilesPressed(_ sender: Any){
        
        AlertDismiss(t: "Deleting Files", msg: "Are you sure you wanna delete this files") { [unowned self] _  in
            
            debugFM("User tapped yes delete")
            
            if self.markIs == true {
                if (self.collectionView.indexPathsForSelectedItems?.count)! > 0 {
                    //if markedFiles.count > 0 {
                    
                    
                    let selectedCellsIndex = self.collectionView.indexPathsForSelectedItems
                    
                    for index in selectedCellsIndex! {
                        let file = self.filess[index.row]
                        self.markedFiles.append(file)
                        
                    }
                    
                    
                    for markedFile in self.markedFiles {     //loop through markedFiles
                        
                        var fileName: String!
                        //get its name.type
                        if markedFile.fileType != "file" {
                            fileName = markedFile.fileName
                        } else {
                            fileName = markedFile.fileName
                        }
                        
                        //get its path mycomputer/name.type
                        let fullMarkedFilePath = "\(self.currentPath!)/\(fileName!)"
                        
                        
                        //start deleting operation
                        do {
                            let fileManager = FileManager.default
                            
                            // Check if file exists
                            if fileManager.fileExists(atPath: fullMarkedFilePath) {
                                
                                // Delete file
                                try fileManager.removeItem(atPath: fullMarkedFilePath)
                                printFM("File deleted")
                                
                            } else {
                                printFM("File does not exist at path \(fullMarkedFilePath)")
                                
                            }
                        }
                        catch let error as NSError {
                            printFM("error with deleting -- \(error)")
                        }
                    }
                    //after delete cV will select cell instead of the removed one
                    for cell in self.collectionView.visibleCells {
                        cell.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
                    }
                    self.readFilesHere(path: self.currentPath!)
                    self.collectionView.reloadData()
                    self.markIs = false
                }
            }
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        if ourPathSteps.count <= 1 { //we are in mycomputer cant go more back
            debugFM("backButton count \(ourPathSteps.count)")
            //AlertDismiss(t: "Leaving File Manager", msg: "Are you sure?")
            AlertDismiss(t: "Leaving File Manager", msg: "Are you sure?", yesCompletion: {
                self.dismiss(animated: true, completion: nil)

            })
            
            ;return
        }
        
        
        ourPathSteps.removeLast()               //remove the last(our current)
        debugFM("backButton ourPathSteps after last one removed \(ourPathSteps)")
        readFilesHere(path: ourPathSteps.last!)  //go to the one before our current
        debugFM("backButton ourPathSteps.last! \(ourPathSteps.last!)")
        markedFiles.removeAll()
        ourPathSteps.removeLast()               //remove again, had a bug that when we enter folder and back from it it will add the documents address, + 1, 2 , 3, 4 so have to do it twice, remove current, remove the new back(opened)
    }


}
@available(iOS 9.0, *)
extension FileManagerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FileCell", for: indexPath) as? FileCell {
            
            let fileName = filess[indexPath.row].fileName
            let fileType = filess[indexPath.row].fileType
            let filePath = filess[indexPath.row].filePath
            
            cell.configuerCell(fileName: fileName, fileType: fileType, filePath: filePath)
            
            //People Decide the images by code Version
            /*
            //New Edit
            //Set Image
            switch fileType {
            case "file" : cell.fileImageV.image = FileManagerVC._imagess["file"]
            case "zip"  : cell.fileImageV.image = FileManagerVC._imagess["zip"]
            case "3gp"  : cell.fileImageV.image = FileManagerVC._imagess["3gp"]
            case "jpg"  : cell.fileImageV.image = FileManagerVC._imagess["jpg"]
            case "json" : cell.fileImageV.image = FileManagerVC._imagess["json"]
            case "mp4"  : cell.fileImageV.image = FileManagerVC._imagess["mp4"]
            case "pdf"  : cell.fileImageV.image = FileManagerVC._imagess["pdf"]
            case "png"  : cell.fileImageV.image = FileManagerVC._imagess["png"]
            case "txt"  : cell.fileImageV.image = FileManagerVC._imagess["txt"]
            case "xml"  : cell.fileImageV.image = FileManagerVC._imagess["xml"]
            case "zip"  : cell.fileImageV.image = FileManagerVC._imagess["zip"]
            default:
                break;
            }*/
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filess.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFile = filess[indexPath.row]
        
        if markIs == false {
            
            if selectedFile.fileType == "file" {
                
                readFilesHere(path: "\(currentPath!)/\(selectedFile.fileName)")
                //currentPath + . + selectedFile type
                //go to this path, show whats inside it, update collectionV
            
            }
        } else {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = UIColor.darkGray

        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(white: 0.92, alpha: 1.0)

        
    }
   
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if customizations.cellType == .titleAndSize {
            return CGSize(width: 114, height: 130)
        } else {
            return CGSize(width: 114, height: 114)
        }
    }
     /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100.0
    }*/
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(14, 20, 14, 20)
    }
}

//Model - File
class File {
    private var _fileName: String?
    private var _fileType: String?
    private var _filePath: String?

    
    init(fileName: String, fileType: String,filePath: String) {
        _fileName = fileName
        _fileType = fileType
        _filePath = filePath
    }
    
    var fileName: String {
        get { if _fileName == nil { return "" }
            return _fileName!
        } set {
            _fileName = newValue
        }
    }
    
    var fileType: String {
        get { if _fileType == nil { return "" }
            return _fileType!
        } set {
            _fileType = newValue
        }
    }
    
    var filePath: String {
        get { if _filePath == nil { return "" }
            return _filePath!
        } set {
            _filePath = newValue
        }
    }
}

//View - FileCell
@available(iOS 9.0, *)
class FileCell: UICollectionViewCell {
    

    var fileImageV: UIImageView = {
        let piv = UIImageView()
        piv.translatesAutoresizingMaskIntoConstraints = false
        piv.clipsToBounds = true
        piv.contentMode = .scaleAspectFit
        return piv
    }()
    var fileNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Avenir", size: 18)
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    var fileSubTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Avenir", size: 12)
        lbl.textColor = .darkGray
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var cellTitle: CellType = customizations.cellType ?? .title
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(fileImageV)
        self.addSubview(fileNameLbl)
        
        self.contentMode = .center
        self.clipsToBounds = true
        
        if customizations.cellType == .titleAndSize {
            self.addSubview(fileSubTitleLbl)
            
            
            //fileSize label constraints
            fileSubTitleLbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            fileSubTitleLbl.topAnchor.constraint(equalTo: fileNameLbl.bottomAnchor).isActive = true
            fileSubTitleLbl.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -6).isActive = true
            fileSubTitleLbl.heightAnchor.constraint(greaterThanOrEqualTo: self.contentView.heightAnchor, multiplier: 0.20).isActive = true
            
            
            //fileName label constraints
            fileNameLbl.bottomAnchor.constraint(equalTo: fileSubTitleLbl.topAnchor, constant: 2).isActive = true
            fileNameLbl.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -6).isActive = true
            fileNameLbl.heightAnchor.constraint(greaterThanOrEqualTo: self.contentView.heightAnchor, multiplier: 0.18).isActive = true
            
            
            //Image constraints
            fileImageV.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
            fileImageV.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -6).isActive = true
            fileImageV.bottomAnchor.constraint(equalTo: fileNameLbl.topAnchor, constant: -5).isActive = true
            //fileImageV.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.67).isActive = true

            
        } else {
            //Image constraints
            fileImageV.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
            fileImageV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            fileImageV.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -6).isActive = true
            fileImageV.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75).isActive = true
            
            //fileName label constraints
            fileNameLbl.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
            fileNameLbl.topAnchor.constraint(equalTo: fileImageV.bottomAnchor).isActive = true
            fileNameLbl.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -6).isActive = true
            fileNameLbl.heightAnchor.constraint(greaterThanOrEqualTo: self.contentView.heightAnchor, multiplier: 0.25).isActive = true
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuerCell(fileName: String, fileType: String, filePath: String) {
        self.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
        
        switch cellTitle {
        case .title:
            fileNameLbl.text = fileName
        case .titleAndSize:
            //Get File Size
            //let filePath = "\(filePath)/\(fileName).\(fileType)"
            let filePath = "\(filePath)/\(fileName)"

            //Set Title
            switch fileType {
            case "file":
                fileNameLbl.text = fileName
                fileSubTitleLbl.text = "Directory"
            case "zip", "3gp", "jpg", "json", "mp4", "pdf", "txt", "xml", "zip", "png","jpg","jpeg":
                let size = fileSize(fromPath: filePath)
                fileNameLbl.text = fileName
                fileSubTitleLbl.text = size ?? String()
            default:
                fileNameLbl.text = fileName
                break;
            }
        }
        
        //Set Image Part
        switch fileType {
            case "file" : fileImageV.image = UIImage(named: "file")
            case "zip"  : fileImageV.image = UIImage(named: "zip")
            case "3gp"  : fileImageV.image = UIImage(named: "3gp")
            case "jpg"  : fileImageV.image = UIImage(named: "jpg")
            case "json" : fileImageV.image = UIImage(named: "json")
            case "mp4"  : fileImageV.image = UIImage(named: "mp4")
            case "pdf"  : fileImageV.image = UIImage(named: "pdf")
            case "txt"  : fileImageV.image = UIImage(named: "txt")
            case "xml"  : fileImageV.image = UIImage(named: "xml")
            case "zip"  : fileImageV.image = UIImage(named: "zip")
            case "png","jpg","jpeg":
                //debugFM("\(filePath)/\(fileName).\(fileType)")
                let url = URL(fileURLWithPath: "\(filePath)/\(fileName).\(fileType)")
                fileImageV.image = UIImage(contentsOfFile: url.path)
        default:
            break;
        }

    }
}

