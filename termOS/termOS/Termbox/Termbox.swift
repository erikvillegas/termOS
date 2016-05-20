//
//  Termbox.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

enum InputMode : Int32 {
    case Keyboard = 1
    case KeyboardAndMouse = 4
}

enum OutputMode : Int32 {
    case Colors8 = 1
    case Colors256 = 2
    case Colors216 = 3
    case Grayscale = 4
}

enum TextAttribute : Int {
    case None = 0
    case Bold = 256
    case Underlined = 512
    case BoldAndUnderlined = 768
}

// https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
enum Color : Int {
    case Black = 0
    case RedDimmed = 1
    case GreenDimmed = 2
    case YellowDimmed = 3
    case BlueDimmed = 4
    case MagentaDimmed = 5
    case CyanDimmed = 6
    case WhiteDimmed = 7
    case Gray = 8
    case Red = 9
    case Green = 10
    case Yellow = 11
    case Blue = 12
    case Magenta = 13
    case Cyan = 14
    case White = 15
    
    case Clear = 1000
}

struct Point : CustomStringConvertible {
    var x: Int
    var y: Int
    
    var description: String {
        return "(\(x), \(y))"
    }
}

struct Size : CustomStringConvertible {
    var width: Int
    var height: Int
    
    var description: String {
        return "(\(width), \(height))"
    }
}

struct Cell {
    var character: String
    var textColor: Color
    var backgroundColor: Color
    var textAttribute: TextAttribute
    
    static func emptyCell() -> Cell {
        return Cell(character: " ", textColor: .Black, backgroundColor: .Black, textAttribute: .Bold)
    }
}

class Termbox {
    enum Event {
        case WindowResize(width : Int, height : Int)
        case MouseClick(x : Int, y : Int)
        case CharacterPressed(character: String)
        case KeyPressed(key: Key)
        case Unknown
        
        enum Key : UInt16 {
            case Tab = 9
            case Enter = 13
            case Escape = 27
            case Space = 32
            case Backspace = 127
            case RightArrow = 65514
            case LeftArrow = 65515
            case DownArrow = 65516
            case UpArrow = 65517
        }
    }
    
    static let sharedInstance = Termbox()
    
    let cursor = Cursor()
    
    var width: Int {
        #if DEBUG
        return 80
        #else
        return Int(tb_width())
        #endif
    }
    
    var height: Int {
        #if DEBUG
            return 30
        #else
            return Int(tb_height())
        #endif
    }
    
    func start(inputMode:InputMode = .Keyboard, _ outputMode:OutputMode = .Colors256) {
        tb_init()
        tb_select_input_mode(inputMode.rawValue)
        tb_select_output_mode(outputMode.rawValue)
    }
    
    func stop() {
        tb_shutdown()
    }
    
    func waitForEvent() -> Event {
        var event:tb_event = tb_event()
        tb_poll_event(&event)
        
        #if DEBUG
            return .CharacterPressed(character: " ")
        #endif
        
        if Int32(event.type) == TB_EVENT_KEY {
            if event.ch != 0 {
                return .CharacterPressed(character: String(UnicodeScalar(event.ch)))
            }
            else {
                let key = Event.Key(rawValue: event.key)!
                if key == .Space { // convenience so spaces are treated as characters
                    return .CharacterPressed(character: " ")
                }
                else {
                    return .KeyPressed(key: key)
                }
            }
        }
        else if Int32(event.type) == TB_EVENT_MOUSE {
            log("mouse event!")
            return .MouseClick(x: Int(event.x), y: Int(event.y))
        }
        else if Int32(event.type) == TB_EVENT_RESIZE {
            return .WindowResize(width: Int(event.w), height: Int(event.h))
        }
        return .Unknown
    }
    
    func addCell(cell: Cell, at point : Point) {
        let x = Int32(point.x)
        let y = Int32(point.y)
        let ch = cell.character.unicodeScalars.first!.value
        let fg = UInt16(cell.textColor.rawValue) | UInt16(cell.textAttribute.rawValue)
        let bg = UInt16(cell.backgroundColor.rawValue)
        
        tb_change_cell(x, y, ch, fg, bg)
    }
    
    func displayCells() {
        tb_present()
    }
    
    func clearAllCells() {
        tb_clear()
    }
    
    func clearCellAt(point: Point) {
        let cell = Cell(character: " ", textColor: .Black, backgroundColor: .Black, textAttribute: .None)
        addCell(cell, at: point)
    }
    
    func addTextLine(line: TextLine) {
        for (index, character) in line.text.characters.enumerate() {
            let cell = Cell(character: String(character), textColor: line.textColor, backgroundColor: line.backgroundColor, textAttribute: line.textAttribute)
            addCell(cell, at: Point(x: index, y: line.rowIndex))
        }
    }
}

class Cursor {
    
    enum CursorMovement {
        case Left(by: Int)
        case Right(by: Int)
        case Up(by: Int)
        case Down(by: Int)
    }
    
    var position = Point(x: -1, y: -1) {
        didSet {
            tb_set_cursor(Int32(position.x), Int32(position.y))
        }
    }
    
    func moveTo(x: Int, _ y: Int) {
        position = Point(x: x, y: y)
    }
    
    func moveLeft(by amount: Int = 1) {
        moveRelative(.Left(by: amount))
    }
    
    func moveRight(by amount: Int = 1) {
        moveRelative(.Right(by: amount))
    }
    
    func moveUp(by amount: Int = 1) {
        moveRelative(.Up(by: amount))
    }
    
    func moveDown(by amount: Int = 1) {
        moveRelative(.Down(by: amount))
    }
    
    func moveRelative(movement : CursorMovement) {
        var x = position.x
        var y = position.y
        
        let maxX = Termbox.sharedInstance.width - 1
        let maxY = Termbox.sharedInstance.height - 1
        
        switch movement {
        case .Left(let amount):
            x = max(x - amount, 0)
        case .Right(let amount):
            x = min(x + amount, maxX)
        case .Up(let amount):
            y = max(y - amount, 0)
        case .Down(let amount):
            y = min(y + amount, maxY)
        }
        
        position = Point(x : max(x, 0), y : max(y, 0))
    }
}

struct TextLine {
    let text: String
    let rowIndex: Int
    let textColor: Color
    let backgroundColor: Color
    let textAttribute: TextAttribute
}
