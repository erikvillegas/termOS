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
    var textAttribute = TextAttribute.None
    
    init(text: String) {
        self.text = text
    }
    
    override func draw() {
        super.draw()
        
        var cells = self.contents!
        
        let drawFrame = hasBorder ? Frame(x: 1, y: 1, width: frame.width - 2, height: frame.height - 2) : frame
        let originStart = hasBorder ? Point(x: 1, y: 1) : Point(x: 0, y: 0)
        
        // always center the label vertically. This value is absolute, not relative to superview
        let textRow = Int(round(Float(drawFrame.height)/2.0) - 1.0) + originStart.y
        var textStartColumn = originStart.x
        
        if drawFrame.width > text.characters.count { // only align if we have more space than characters
            switch textAlignment {
            case .Left:
                textStartColumn = 0 + originStart.x
            case .Right:
                textStartColumn = drawFrame.width - text.characters.count + originStart.x
            case .Center:
                textStartColumn = (drawFrame.width/2) - (text.characters.count/2) + originStart.x
            }
        }
        
        var drawLetterIndex = 0
        
        for y in originStart.y..<(drawFrame.height + originStart.y) {
            for x in originStart.x..<(drawFrame.width + originStart.x) {
                
                var characterToDisplay: String?
                var drawingLabelCharacter = false
                
                if y == textRow && x >= textStartColumn && drawLetterIndex < text.characters.count {
                    characterToDisplay = String(text[text.startIndex.advancedBy(drawLetterIndex)])
                    drawLetterIndex += 1
                    drawingLabelCharacter = true
                }
                
                if let character = characterToDisplay {
                    cells[y][x].character = character
                }
                
                cells[y][x].textColor = textColor
                
                if backgroundColor != .Clear {
                    cells[y][x].backgroundColor = backgroundColor
                }
                else {
                    cells[y][x].backgroundColor = superview?.backgroundColor ?? .Black
                }
                
                if drawingLabelCharacter {
                    cells[y][x].textAttribute = textAttribute
                }
                else if textAttribute.rawValue & TextAttribute.Reversed.rawValue == TextAttribute.Reversed.rawValue {
                    cells[y][x].textAttribute = .Reversed
                }
            }
        }
        
        self.contents = cells
    }
}
