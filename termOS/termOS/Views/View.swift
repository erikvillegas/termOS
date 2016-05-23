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
    var backgroundColor = Color.Black
    var borderColor: Color?
    var hasBorder: Bool {
        return borderColor != nil
    }
    
    var subviews = [View]()
    var superview: View?
    var contents:[[Cell]]?
    
    func draw() {
        var cells = Array(count: frame.height, repeatedValue: Array(count: frame.width, repeatedValue: Cell.emptyCell()))
        
        let drawFrame = hasBorder ? Frame(x: frame.x + 1, y: frame.y + 1, width: frame.width - 2, height: frame.height - 2) : frame
        let originStart = hasBorder ? Point(x: 1, y: 1) : Point(x: 0, y: 0)
        
        // draw myself
        for y in originStart.y..<(drawFrame.height + originStart.y) {
            for x in originStart.x..<(drawFrame.width + originStart.x) {
                var character = " "
                var backgroundColorToUse = backgroundColor
                var foregroundColorToUse: Color?
                
                cells[y][x].character = character
                
                if backgroundColorToUse != .Clear {
                    cells[y][x].backgroundColor = backgroundColorToUse
                }
                else {
                    cells[y][x].backgroundColor = superview?.backgroundColor ?? .Black
                }
                
                if let foregroundColorToUse = foregroundColorToUse {
                    cells[y][x].textColor = foregroundColorToUse
                }
            }
        }
        
        if hasBorder {

            func drawCell(x:Int, _ y:Int, _ character:String) {
                cells[y][x].character = character
                cells[y][x].textColor = borderColor!
            }
            
            for x in 0..<frame.width {
                drawCell(x, 0, "─") // draw top border
                drawCell(x, frame.height - 1, "─") // draw bottom border
            }
            
            for y in 0..<frame.height {
                drawCell(0, y, "│") // draw left border
                drawCell(frame.width - 1, y, "│") // draw right border
            }
            
            // draw top left corner
            drawCell(0, 0, "┌")
            
            // draw top right corner
            drawCell(frame.width - 1, 0, "┐")
            
            // draw bottom left corner
            drawCell(0, frame.height - 1, "└")
            
            // draw bottom right corner
            drawCell(frame.width - 1, frame.height - 1, "┘")
        }

        contents = cells
        
        // make subviews draw themselves
        for subview in subviews {
            subview.draw()
        }
    }
    
//    func composite() {
//        for subview in subviews {
//            
//            subview.composite()
//            
//            var cells = self.contents ?? [[Cell]]()
//            var subviewCells = subview.contents ?? [[Cell]]()
//            
//            for y in 0..<subview.frame.height {
//                for x in 0..<subview.frame.width {
//                    
//                    // calculate the position the cell should be placed at
//                    let positionX = x + subview.frame.x - bounds.x
//                    let positionY = y + subview.frame.y - bounds.y
//                    
//                    // only display the cell if it's within our bounds. Otherwise it'll be clipped
//                    if positionY >= 0 && positionY < cells.count && positionX >= 0 && positionX < cells[positionY].count {
//                        cells[positionY][positionX] = subviewCells[y][x]
//                    }
//                }
//            }
//            
//            self.contents = cells
//        }
//    }
    
    func composite() {
        for subview in subviews {
            
            subview.composite()
            
            // if the difference between subview and superview is >= 2, then no clipping is required
            // however if the difference is 0 or 1, we need to clip a little bit (either 1 or 2):
            // difference -> clip amount
            // 0 -> 2
            // 1 -> 1
            // 2 -> 0
            // 3 -> 0
            // 4 -> 0
            let widthClippingAmount = (frame.width - subview.frame.width) >= 2 ? 0 : 2 - (frame.width - subview.frame.width)
            let heightClippingAmount = (frame.height - subview.frame.height) >= 2 ? 0 : 2 - (frame.height - subview.frame.height)
            
            let drawFrame = hasBorder ? Frame(x: subview.frame.x + 1, y: subview.frame.y + 1, width: subview.frame.width - widthClippingAmount, height: subview.frame.height - heightClippingAmount) : subview.frame
            
            var cells = self.contents ?? [[Cell]]()
            var subviewCells = subview.contents ?? [[Cell]]()
            
            for y in 0..<(drawFrame.height) {
                for x in 0..<(drawFrame.width) {
                    
                    // calculate the position the cell should be placed at
                    let positionX = x + drawFrame.x - bounds.x
                    let positionY = y + drawFrame.y - bounds.y
                    
                    // only display the cell if it's within our bounds. Otherwise it'll be clipped
                    let topBounds = (hasBorder ? 1 : 0)
                    let bottomBounds = cells.count - (hasBorder ? 1 : 0)
                    let leftBounds = (hasBorder ? 1 : 0)
                    
                    if positionY >= topBounds && positionY < bottomBounds && positionX >= leftBounds && positionX < cells[positionY].count {
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
            }
        }
    }
    
//    func isVisibleInSuperview() -> Bool {
//        return frame(self.frame, isContainedInFrame: superview!.bounds)
//    }
}

extension View : CustomStringConvertible {
    var description: String {
        return "class: \(self.dynamicType), frame: \(frame.description))"
    }
}

extension View : Equatable {}

func ==(lhs: View, rhs: View) -> Bool {
    return lhs === rhs
}
