//
//  ScrollView.swift
//  termOS
//
//  Created by Erik Villegas on 5/17/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

protocol FocusableArea : Focusable {
    func updateInnerFocusWithKey(key: Termbox.Event.Key)
//    func didUpdateFocusInArea(direction: Direction)
    
    func gainInnerFocus()
    func loseInnerFocus()
}


class ScrollView : View, FocusableArea {
    var contentSize = Size(width: 0, height: 0)
    var contentOffset = Point(x: 0, y: 0) {
        didSet {
            bounds = Frame(x: contentOffset.x, y: contentOffset.y, width: bounds.width, height: bounds.height)
        }
    }
    
    private(set) var isFocused = false
    
    func gainFocus() {
        log("scroll view gained focus!")
        isFocused = true
        borderColor = .White
    }
    
    func gainInnerFocus() {
        log("scroll view gained inner focus!")
        isFocused = true
        borderColor = .Gray
    }
    
    func loseFocus() {
        log("scroll view lost focus!")
        isFocused = false
        borderColor = .Gray
    }
    
    func loseInnerFocus() {
        log("scroll view lost inner focus!")
        isFocused = false
        borderColor = .White
    }
    
    func updateInnerFocusWithKey(key: Termbox.Event.Key) {
        log("updateInnerFocusWithKey")
        
        if key == .DownArrow {
            contentOffset.y = min(contentOffset.y + 1, contentSize.height - frame.height + (hasBorder ? 2 : 0))
        }
        else if key == .UpArrow {
            contentOffset.y = max(contentOffset.y - 1, 0)
        }
        else if key == .LeftArrow {
            
        }
        else if key == .RightArrow {
            
        }
    }
}