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
    var bounds = Frame(x: 0, y: 0, width: 0, height: 0)
    var backgroundColor = Color.Clear
    var subviews = [View]()
    var superview: View?
    
    func draw() -> [[Cell]] {
        

        
//        for subview in subviews {
//            subview.draw()
//        }
        

        return self.rasterize()
    }
    
    func rasterize() -> [[Cell]] {
        
        // 1. rasterize myself
        var cells = Array(count: frame.width, repeatedValue: Array(count: frame.height, repeatedValue: Cell.emptyCell()))
        
        for y in 0..<frame.height {
            for x in 0..<frame.width {
                log("adding at (\(x), \(y))")
                
                cells[x][y].character = " "
                cells[x][y].backgroundColor = backgroundColor
            }
        }
        
        // 2. composite my rasterized subviews on top of me
        if let firstSubview = subviews.first {
            
            let subviewCells = firstSubview.rasterize()
            
            // composite the cells on top of mine given the frame.
            
            for y in 0..<firstSubview.frame.height {
                for x in 0..<firstSubview.frame.width {
                    
                    let positionX = x + firstSubview.frame.x
                    let positionY = y + firstSubview.frame.y
                    
                    log("(2) adding at (\(positionX), \(positionY))")
                    
                    cells[positionX][positionY] = subviewCells[x][y]
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