//
//  NavigationController.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class NavigationController : BaseController {
    
    var viewControllers:[BaseController] = []
    
    override func handleEvent(event: Termbox.Event) {
        super.handleEvent(event)
        
        if let topViewController = viewControllers.last {
            topViewController.handleEvent(event)
        }
    }
    
    func pushViewController(controller: BaseController) {
        viewControllers.append(controller)
        controller.view.frame = view.frame
        controller.view.bounds = view.frame
        view.addSubview(controller.view)
        controller.viewDidLoad()
    }
    
    func popViewController() {
        viewControllers.removeLast()
    }
}
