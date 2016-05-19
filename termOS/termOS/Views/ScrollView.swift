//
//  ScrollView.swift
//  termOS
//
//  Created by Erik Villegas on 5/17/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class ScrollView : View {
    var contentSize = Size(width: 0, height: 0)
    var contentOffset = Point(x: 0, y: 0) {
        didSet {
            bounds = Frame(x: contentOffset.x, y: contentOffset.y, width: bounds.width, height: bounds.height)
        }
    }
    
    override func handleEvent(event: Termbox.Event) {
        if case .KeyPressed(let key) = event {
            if key == .DownArrow {
                contentOffset.y = min(contentOffset.y + 1, contentSize.height - frame.height)
            }
            else if key == .UpArrow {
                contentOffset.y = max(contentOffset.y - 1, 0)
            }
            else if key == .LeftArrow {
                
            }
            else if key == .RightArrow {
                
            }
            
            log("content offset: " + String(contentOffset))
        }
    }
}