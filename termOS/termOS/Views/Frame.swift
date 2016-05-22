//
//  Frame.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

struct Frame {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
}

extension Frame : CustomStringConvertible {
    var description: String {
        return "(x: \(x), y: \(y), width: \(width), height: \(height))"
    }
}