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
    var contents:[[Cell]]?
    
    func draw() {
        var cells = Array(count: frame.height, repeatedValue: Array(count: frame.width, repeatedValue: Cell.emptyCell()))
        
        // draw myself
        for y in 0..<frame.height {
            for x in 0..<frame.width {
                cells[y][x].character = " "
                cells[y][x].backgroundColor = backgroundColor
            }
        }

        contents = cells
        
        // make subviews draw themselves
        for subview in subviews {
            subview.draw()
        }
    }
    
    func composite() {
        for subview in subviews {
            
            subview.composite()
            
            var cells = self.contents ?? [[Cell]]()
            var subviewCells = subview.contents ?? [[Cell]]()
            
            for y in 0..<subview.frame.height {
                for x in 0..<subview.frame.width {
                    
                    // calculate the position the cell should be placed at
                    let positionX = x + subview.frame.x - bounds.x
                    let positionY = y + subview.frame.y - bounds.y
                    
                    // only display the cell if it's within our bounds. Otherwise it'll be clipped
                    if positionY >= 0 && positionY < cells.count && positionX >= 0 && positionX < cells[positionY].count {
                        cells[positionY][positionX] = subviewCells[y][x]
                    }
                }
            }
            
            self.contents = cells
        }
    }
    
    func addSubview(view: View) {
        subviews.append(view)
        view.superview = self
    }
    
    func removeFromSuperview() {
        if let superview = superview {
            if let subviewIndex = superview.subviews.indexOf(self) {
                superview.subviews.removeAtIndex(subviewIndex)
                self.superview = nil
                return
            }
        }
    }
}

extension View : CustomStringConvertible {
    var description: String {
        return "(\(frame.x), \(frame.y), \(frame.width), \(frame.height))"
    }
}

extension View : Equatable {}

func ==(lhs: View, rhs: View) -> Bool {
    return lhs === rhs
}
