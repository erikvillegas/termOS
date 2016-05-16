//
//  main.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/14/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation


// Helper methods

// recursively find the first responder text field in the given view
func findFirstResponder(view: View) -> TextField? {
    if view.subviews.count == 0 {
        if let textField = view as? TextField where textField.isFirstResponder {
            return textField
        }
        else {
            return nil
        }
    }
    
    for subview in view.subviews {
        if let activeTextField = findFirstResponder(subview) {
            return activeTextField
        }
    }
    
    return nil
}


func start() {
    
    let termbox = Termbox.sharedInstance
    
    termbox.start()
    
    // set up views and controllers
    let window = View()
    window.frame = Frame(x: 0, y: 0, width: termbox.width, height: termbox.height)
    
    let navigationController = NavigationController()
    navigationController.view.frame = window.frame
    window.addSubview(navigationController.view)
    navigationController.viewDidLoad()
    
    let mainMenuViewController = MainMenuViewController()
    navigationController.pushViewController(mainMenuViewController)
    
    window.draw()
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
        }
        
        // send event to first responder
        if let firstResponder = findFirstResponder(window) {
            firstResponder.handleEvent(event)
        }
        
        navigationController.handleEvent(event)
        
        window.draw()
        termbox.displayCells()
    }
    
    termbox.stop()
}

start()
