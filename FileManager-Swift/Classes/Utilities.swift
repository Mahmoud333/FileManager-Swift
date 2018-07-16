//
//  Utilities.swift
//  FileManager-Swift
//
//  Created by Algorithm on 7/16/18.
//

import Foundation

internal func printFM(_ msg: String) {
    print("FileManager: \(msg)")
}

internal func debugFM(_ msg: String) {
    print("FM Debug: \(msg)")
    //NSLog("FM Debug: %@", msg)
}

//Get File Size
func fileSize(fromPath path: String) -> String? {
    var size: Any?
    do {
        size = try FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size]
    } catch (let error) {
        printFM("File size error: \(error)")
        return nil
    }
    guard let fileSize = size as? UInt64 else {
        return nil
    }
    
    // bytes
    if fileSize < 1023 {
        return String(format: "%lu bytes", CUnsignedLong(fileSize))
    }
    // KB
    var floatSize = Float(fileSize / 1024)
    if floatSize < 1023 {
        return String(format: "%.1f KB", floatSize)
    }
    // MB
    floatSize = floatSize / 1024
    if floatSize < 1023 {
        return String(format: "%.1f MB", floatSize)
    }
    // GB
    floatSize = floatSize / 1024
    return String(format: "%.1f GB", floatSize)
}

//getDirectoryPath
func getDirectoryPath() -> String {
    debugFM("VC getDirectoryPath")
    
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

//get the contents of the file at path
func contentsOfDirectoryAtPath(path: String) -> [String]? {
    debugFM("VC contentsOfDirectoryAtPath")
    
    
    guard let paths = try? FileManager.default.contentsOfDirectory(atPath: path) else { return nil}
    return paths.map { aContent in (path as NSString).appendingPathComponent(aContent)}
}

