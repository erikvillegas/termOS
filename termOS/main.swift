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
    let cells = view.draw()
    
    for (row, rowCells) in cells.enumerate() {
        for (column, cell) in rowCells.enumerate() {
            termbox.addCell(cell, at: Point(x: column, y: row))
        }
    }
}

func start() {

    
    let termbox = Termbox.sharedInstance
    
    termbox.start()
    
    // set up views and controllers
    let window = View()
    window.frame = Frame(x: 0, y: 0, width: termbox.width, height: termbox.height)
    window.bounds = window.frame
    
    let navigationController = NavigationController()
    navigationController.view.frame = window.frame
    navigationController.view.bounds = window.frame
    window.addSubview(navigationController.view)
    navigationController.viewDidLoad()
    
    let mainMenuViewController = MainMenuViewController()
    navigationController.pushViewController(mainMenuViewController)
    
    renderView(window, termbox: termbox)
    termbox.displayCells()
    
    var looping = true
    
    while looping {
        let event = termbox.waitForEvent()
        
        termbox.clearAllCells()
        
        if case .KeyPressed(let key) = event where key == .Escape {
            looping = false
        }
        else if case .WindowResize(let width, let height) = event {
            window.frame = Frame(x: 0, y: 0, width: width, height: height)
            window.bounds = window.frame
        }
        
        // send event to first responder
        if let firstResponder = findFirstResponder(window) {
            firstResponder.handleEvent(event)
        }
        
        navigationController.handleEvent(event)
        
        sendEvent(event, view: window)
        
        renderView(window, termbox: termbox)
        termbox.displayCells()
    }
    
    termbox.stop()
}

start()

