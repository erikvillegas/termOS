//
//  Label.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class Label : View {
    
    enum Alignment {
        case Left
        case Center
        case Right
    }
    
    var text: String
    var textColor = Color.White
    var textAlignment = Alignment.Left
    
    init(text: String) {
        self.text = text
    }
    
//    override func draw() -> [[Cell]] {
//        var startX = frame.x
//        var startY = frame.y
//        
//        // frames are relative, so add the origin of the superview
//        if let superview = superview {
//            startX = superview.frame.x + frame.x
//            startY = superview.frame.y + frame.y
//        }
//        
//        // always center the label. This value is absolute, not relative to superview
//        let textRow = Int(round(Float(frame.height)/2.0) - 1.0) + startY
//        var textStartColumn = 0
//        
//        switch textAlignment {
//        case .Left:
//            textStartColumn = 0
//        case .Right:
//            textStartColumn = frame.width - text.characters.count + startX
//        case .Center:
//            textStartColumn = (frame.width/2) - (text.characters.count/2) + startX
//        }
//        
//        var drawLetterIndex = 0
//        
//        for y in startY..<(startY + frame.height) {
//            for x in startX..<(startX + frame.width) {
//                var characterToDisplay = " "
//                
//                if (y == textRow && x >= textStartColumn && drawLetterIndex < text.characters.count) {
//                    characterToDisplay = String(text[text.startIndex.advancedBy(drawLetterIndex)])
//                    drawLetterIndex += 1
//                }
//                
//                let cellBackgroundColor = self.backgroundColor == .Clear ? self.superview!.backgroundColor : self.backgroundColor
//                
//                let cell = Cell(character: characterToDisplay, textColor: textColor, backgroundColor: cellBackgroundColor, textAttribute: .None)
//                Termbox.sharedInstance.addCell(cell, at: Point(x: x, y: y))
//                
//                
//            }
//        }
//        
//        for subview in subviews {
//            subview.draw()
//        }
//        
//        return [[Cell]]()
//    }
    
    override func draw() -> [[Cell]] {
        // 1. rasterize myself
        var cells = Array(count: frame.height, repeatedValue: Array(count: frame.width, repeatedValue: Cell.emptyCell()))
        
        // always center the label. This value is absolute, not relative to superview
        let textRow = Int(round(Float(frame.height)/2.0) - 1.0)
        var textStartColumn = 0
        
        switch textAlignment {
        case .Left:
            textStartColumn = 0
        case .Right:
            textStartColumn = frame.width - text.characters.count
        case .Center:
            textStartColumn = (frame.width/2) - (text.characters.count/2)
        }
        
        var drawLetterIndex = 0
        
        for y in 0..<frame.height {
            for x in 0..<frame.width {
                
                var characterToDisplay = " "
                
                if (y == textRow && x >= textStartColumn && drawLetterIndex < text.characters.count) {
                    characterToDisplay = String(text[text.startIndex.advancedBy(drawLetterIndex)])
                    drawLetterIndex += 1
                }
                
                let cellBackgroundColor = self.backgroundColor == .Clear ? self.superview!.backgroundColor : self.backgroundColor
                
                cells[y][x].character = characterToDisplay
                cells[y][x].textColor = textColor
                cells[y][x].backgroundColor = cellBackgroundColor
            }
        }
        
        // 2. composite my rasterized subviews on top of me
        for subview in subviews {
            let subviewCells = subview.draw()
            
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
            
        }
        
        // 3. return my rasterized/composited cells
        return cells
    }
}
