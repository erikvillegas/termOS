//
//  Logger.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/14/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
let fileURL = NSURL(fileURLWithPath: "\(documentsPath)/termOS-log.txt")

extension String {
    func appendLineToURL(fileURL: NSURL) throws {
        try self.stringByAppendingString("\n").appendToURL(fileURL)
    }
    
    func appendToURL(fileURL: NSURL) throws {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        try data.appendToURL(fileURL)
    }
}

extension NSData {
    func appendToURL(fileURL: NSURL) throws {
        if let fileHandle = try? NSFileHandle(forWritingToURL: fileURL) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.writeData(self)
        }
        else {
            try writeToURL(fileURL, options: .DataWritingAtomic)
        }
    }
}

func log(text:String) {
    #if DEBUG
    print(text)
    #else
    try! text.appendLineToURL(fileURL)
    #endif
}
