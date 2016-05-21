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
    
    override func draw() {
        super.draw()
        
        var cells = self.contents!
        
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
                
                if y == textRow && x >= textStartColumn && drawLetterIndex < text.characters.count {
                    characterToDisplay = String(text[text.startIndex.advancedBy(drawLetterIndex)])
                    drawLetterIndex += 1
                }
                
                cells[y][x].character = characterToDisplay
                cells[y][x].textColor = textColor
                
                if backgroundColor != .Clear {
                    cells[y][x].backgroundColor = backgroundColor
                }
                else {
                    cells[y][x].backgroundColor = superview?.backgroundColor ?? .Black
                }
            }
        }
        
        self.contents = cells
    }
}
