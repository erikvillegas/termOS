//
//  TextField.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class TextField : View {
    
    enum Event {
        case DidChange(TextField)
        case DidReturn(TextField)
    }
    
    var text: String
    var textColor = Color.White
    var eventHandler: ((Event) -> (Void))?
    
    init(text: String) {
        self.text = text
    }
    
    override func draw() {
        super.draw()
        
        var startX = frame.x
        var startY = frame.y
        
        // frames are relative, so add the origin of the superview
        if let superview = superview {
            startX = superview.frame.x + frame.x
            startY = superview.frame.y + frame.y
        }
        
        // always center the label. This value is absolute, not relative to superview
        let textRow = Int(round(Float(frame.height)/2.0) - 1.0) + startY
        
        var lastLetterPositionX = 0
        var drawLetterIndex = 0
        
        for y in startY..<(startY + frame.height) {
            for x in startX..<(startX + frame.width) {
                var characterToDisplay = " "
                
                if (y == textRow && drawLetterIndex < text.characters.count) {
                    characterToDisplay = String(text[text.startIndex.advancedBy(drawLetterIndex)])
                    drawLetterIndex += 1
                    lastLetterPositionX = x
                }
                
                let cellBackgroundColor = self.backgroundColor == .Clear ? self.superview!.backgroundColor : self.backgroundColor
                
                let cell = Cell(character: characterToDisplay, textColor: textColor, backgroundColor: cellBackgroundColor, textAttribute: .None)
                Termbox.sharedInstance.addCell(cell, at: Point(x: x, y: y))
            }
        }
        
        if isFirstResponder {
            var newCursorPosition = Point(x: 0, y: textRow)
            
            if text.characters.count == 0 {
                newCursorPosition.x = startX
            }
            else if text.characters.count == frame.width {
                newCursorPosition.x = min(lastLetterPositionX, startX + frame.width)
            }
            else {
                newCursorPosition.x = min(lastLetterPositionX + 1, startX + frame.width)
            }
            
            Termbox.sharedInstance.cursor.position = newCursorPosition
        }
        
        self.contents = cells
    }
    
    override func becomeFirstResponder() {
        isFirstResponder = true
    }
    
    override func resignFirstResponder() {
        isFirstResponder = false
    }
    
    override func handleEvent(event: Termbox.Event) {
        if case .CharacterPressed(let character) = event {
            if text.characters.count < frame.width {
                text += character
                eventHandler?(.DidChange(self))
            }
        }
        else if case .KeyPressed(let key) = event where key == .Backspace {
            if text.characters.count > 0 {
                text = String(text.characters.dropLast())
                eventHandler?(.DidChange(self))
            }
        }
    }
}