//
//  main.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/14/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation


// Helper methods

// recursively find the first responder view in the given view
func findFirstResponder(view: View) -> View? {
    if view.subviews.count == 0 && view.isFirstResponder {
        return view
    }
    
    for subview in view.subviews {
        if let firstResponderView = findFirstResponder(subview) {
            return firstResponderView
        }
    }
    
    return nil
}


func sendEvent(event: Termbox.Event, view: View) {
    if view.subviews.count == 0 {
        view.handleEvent(event)
    }
    else {
        for subview in view.subviews {
            subview.handleEvent(event)
            sendEvent(event, view: subview)
        }
    }
}

func renderView(view:View, termbox:Termbox) {
    view.draw()
    view.composite()
    
    for (row, rowCells) in view.contents!.enumerate() {
        for (column, cell) in rowCells.enumerate() {
            termbox.addCell(cell, at: Point(x: column, y: row))
        }
    }
}

let window = View()
var focusedElement: Focusable?

func start() {
    
    let termbox = Termbox.sharedInstance
    
    termbox.start()
    
    // set up views and controllers
    window.frame = Frame(x: 0, y: 0, width: termbox.width, height: termbox.height)
    window.bounds = window.frame
    window.backgroundColor = .Red
    
//    let view = Label(text: "Hey!")
//    view.frame = Frame(x: 2, y: 2, width: window.frame.width - 4, height: window.frame.height - 4)
//    view.backgroundColor = .RedDimmed
//    view.textAlignment = .Center
//    
//    window.addSubview(view)
    
    let navigationController = NavigationController()
    navigationController.view.frame = window.frame
    navigationController.view.bounds = window.frame
    window.addSubview(navigationController.view)
    navigationController.viewDidLoad()
    
    let mainMenuViewController = MainMenuViewController()
    navigationController.pushViewController(mainMenuViewController)
    
    updateFocus(.DownArrow, inWindow: window)
    
    renderView(window, termbox: termbox)
    termbox.displayCells()
    
    var looping = true
    
    while looping {
        let event = termbox.waitForEvent()
        
        termbox.clearAllCells()
        
        if case .KeyPressed(let key) = event where key == .Escape {
            looping = false
        }
        else if case .WindowResized(let width, let height) = event {
            window.frame = Frame(x: 0, y: 0, width: width, height: height)
            window.bounds = window.frame
        }
        
        // send event to first responder
        if let firstResponder = findFirstResponder(window) {
            firstResponder.handleEvent(event)
        }

        navigationController.handleEvent(event)
        
        // update focus
        if case .KeyPressed(let key) = event {
            updateFocus(key, inWindow: window)
        }
        
        sendEvent(event, view: window)
        
        renderView(window, termbox: termbox)
        termbox.displayCells()
    }
    
    termbox.stop()
}

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

func updateFocus(key: Termbox.Event.Key, inWindow window: View) {
    if let element = focusedElement {
        let elementRelativeFrame = frameRelativeToWindow(element)
        
        var checkFocusFrame: Frame?
        var direction: Direction?
        
        if key == .RightArrow {
            let checkFocusX = elementRelativeFrame.x + elementRelativeFrame.width
            checkFocusFrame = Frame(x: checkFocusX, y: elementRelativeFrame.y, width: window.frame.width - checkFocusX, height: elementRelativeFrame.height)
            direction = .Right
        }
        else if key == .LeftArrow {
            checkFocusFrame = Frame(x: 0, y: elementRelativeFrame.y, width: elementRelativeFrame.x, height: elementRelativeFrame.height)
            direction = .Left
        }
        else if key == .DownArrow {
            let checkFocusY = elementRelativeFrame.y + elementRelativeFrame.height
            checkFocusFrame = Frame(x: elementRelativeFrame.x, y: checkFocusY, width: elementRelativeFrame.width, height: window.frame.height - checkFocusY)
            direction = .Down
        }
        else if key == .UpArrow {
            checkFocusFrame = Frame(x: elementRelativeFrame.x, y: 0, width: elementRelativeFrame.width, height: elementRelativeFrame.y)
            direction = .Up
        }
        
        if let checkFocusFrame = checkFocusFrame, direction = direction, focusableElement = firstFocusableInFrame(checkFocusFrame, inView: window, direction: direction) {
            element.loseFocus()
            focusedElement = focusableElement
            focusedElement?.gainFocus()
        }
    }
    else {
        if let element = setInitialFocusInWindow(window) {
            focusedElement = element
            focusedElement?.gainFocus()
        }
    }
}

func firstFocusableInFrame(focusFrame: Frame, inView view: View, direction: Direction) -> Focusable? {
//    log("firstFocusableInFrame: " + focusFrame.description)
    if view.subviews.count == 0 && view is Focusable {
        let viewRelativeFrame = frameRelativeToWindow(view as! Focusable)
        
        if viewRelativeFrame.x >= focusFrame.x && viewRelativeFrame.x <= (focusFrame.x + focusFrame.width) &&
            viewRelativeFrame.y >= focusFrame.y && viewRelativeFrame.y <= (focusFrame.y + focusFrame.height) &&
            (viewRelativeFrame.x + viewRelativeFrame.width) >= focusFrame.x && (viewRelativeFrame.x + viewRelativeFrame.width) <= (focusFrame.x + focusFrame.width) &&
            (viewRelativeFrame.y + viewRelativeFrame.height) >= focusFrame.y && (viewRelativeFrame.y + viewRelativeFrame.height) <= (focusFrame.y + focusFrame.height) {
            
            return view as? Focusable
        }
    }
    
    var focusableElements = [Focusable]()
    
    for subview in view.subviews {
        if let focusableElement = firstFocusableInFrame(focusFrame, inView: subview, direction: direction) {
            focusableElements.append(focusableElement)
        }
    }
    
    if focusableElements.count > 0 {
        
        focusableElements.sortInPlace({ (f1, f2) -> Bool in
            let f1RelativeFrame = frameRelativeToWindow(f1)
            let f2RelativeFrame = frameRelativeToWindow(f2)
            
            switch direction {
            case .Right:
                // return the leftmost view
                return f1RelativeFrame.x < f2RelativeFrame.x
            case .Left:
                // return the rightmost view
                return f1RelativeFrame.x > f2RelativeFrame.x
            case .Up:
                // return the lowermost view
                return f1RelativeFrame.y > f2RelativeFrame.y
            case .Down:
                // return the topmost view
                return f1RelativeFrame.y < f2RelativeFrame.y
            }
        })
        
        return focusableElements.first
    }
    else {
        return nil
    }
}

func setInitialFocusInWindow(window: View) -> Focusable? {
    return findFirstFocusableElementInView(window)
}

func findFirstFocusableElementInView(view: View) -> Focusable? {
    if view.subviews.count == 0 && view is Focusable {
        return view as? Focusable
    }
    
    for subview in view.subviews {
        if let focusableElement = findFirstFocusableElementInView(subview) {
            return focusableElement
        }
    }
    
    return nil
}

func frameRelativeToWindow(focusable:Focusable) -> Frame {
    var x = focusable.frame.x
    var y = focusable.frame.y
    
    var currentView = focusable.superview
    
    while currentView != nil {
        x += currentView!.frame.x
        y += currentView!.frame.y
        currentView = currentView?.superview
    }
    
    return Frame(x: x, y: y, width: focusable.frame.width, height: focusable.frame.height)
}

start()

