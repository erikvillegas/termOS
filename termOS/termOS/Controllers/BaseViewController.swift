//
//  BaseViewController.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class BaseController {
    let view = View()
    
    func handleEvent(event: Termbox.Event) {}
    
    func viewDidLoad() {}
}

// other controllers WIP

class SearchViewController : BaseController {
    
    override func handleEvent(event: Termbox.Event) {
        super.handleEvent(event)
    }
}

class ChatViewController : BaseController {
    
    override func handleEvent(event: Termbox.Event) {
        super.handleEvent(event)
    }
}

class MenuViewController : BaseController {
    
    struct MenuOption {
        let name: String
        let handler: (Void) -> (Void)
    }
    
    var menuOptions = [MenuOption]()
    
    override init() {
        super.init()
        
        
    }
    
    override func handleEvent(event: Termbox.Event) {
        super.handleEvent(event)
        
        // draw menu options
    }
}