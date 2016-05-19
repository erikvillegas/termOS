//
//  View.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class Responder {
    var isFirstResponder = false
    
    func becomeFirstResponder() {
        
    }
    
    func resignFirstResponder() {
        
    }
    
    func handleEvent(event: Termbox.Event) {
        
    }
}

class View : Responder {
    var frame = Frame(x: 0, y: 0, width: 0, height: 0)
    var bounds = Frame(x: 0, y: 0, width: 0, height: 0)
    var backgroundColor = Color.Clear
    var subviews = [View]()
    var superview: View?
    
    func draw() -> [[Cell]] {
        
        // 1. rasterize myself
        var cells = Array(count: frame.height, repeatedValue: Array(count: frame.width, repeatedValue: Cell.emptyCell()))
        
        for y in 0..<frame.height {
            for x in 0..<frame.width {
                cells[y][x].character = " "
                cells[y][x].backgroundColor = backgroundColor
            }
        }
        
        // 2. composite my rasterized subviews on top of me
        for subview in subviews {
            
            let subviewCells = subview.draw()
            
            // composite the cells on top of mine given the frame.
            
            for y in 0..<subview.frame.height {
                for x in 0..<subview.frame.width {
                    
                    // calculate the position the cell should be placed at
                    let positionX = x + subview.frame.x - bounds.x
                    let positionY = y + subview.frame.y - bounds.y
                    
                    // only display the cell if it's within our bounds. Otherwise it'll be clipped
                    if positionY >= 0 && positionY < cells.count && positionX >= 0 && positionX < cells[positionY].count {
//                        if self is ScrollView {
//                            log("setting cell at position (\(positionX), \(positionY))")
//                        }
                        
                        cells[positionY][positionX] = subviewCells[y][x]
                        
                    }
                }
            }
            
            
        }
        
        // 3. return my rasterized/composited cells
        return cells
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