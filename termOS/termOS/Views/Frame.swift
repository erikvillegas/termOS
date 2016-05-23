//
//  Frame.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

struct Frame {
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    
    init(x x: Int, y: Int, width: Int, height: Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

extension Frame : CustomStringConvertible {
    var description: String {
        return "(x: \(x), y: \(y), width: \(width), height: \(height))"
    }
}