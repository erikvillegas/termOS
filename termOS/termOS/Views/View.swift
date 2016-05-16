//
//  View.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class View {
    var frame = Frame(x: 0, y: 0, width: 0, height: 0)
    var backgroundColor = Color.Clear
    var subviews = [View]()
    var superview: View?
    
    func draw() {
        
        var startX = frame.x
        var startY = frame.y
        
        // frames are relative, so add the origin of the superview
        if let superview = superview {
            startX = superview.frame.x + frame.x
            startY = superview.frame.y + frame.y
        }
        
        for y in startY..<(startY + frame.height) {
            for x in startX..<(startX + frame.width) {
                let cell = Cell(character: " ", textColor: .Black, backgroundColor: backgroundColor, textAttribute: .None)
                Termbox.sharedInstance.addCell(cell, at: Point(x: x, y: y))
            }
        }
        
        for subview in subviews {
            subview.draw()
        }
    }
    
    func addSubview(view: View) {
        subviews.append(view)
        view.superview = self
    }
}

extension View : CustomStringConvertible {
    var description: String {
        return "(\(frame.x), \(frame.y), \(frame.width), \(frame.height))"
    }
}