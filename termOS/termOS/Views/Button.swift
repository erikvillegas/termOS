//
//  Button.swift
//  termOS
//
//  Created by Erik Villegas on 5/21/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

protocol Focusable {
    var frame: Frame { get }
    var superview: View? { get }
    
    var isFocused: Bool { get }
    func gainFocus()
    func loseFocus()
}

class Button : Label, Focusable {
    var unfocusedTextAttribute = TextAttribute.None
    private(set) var isFocused = false
    
    func gainFocus() {
        isFocused = true
        self.textAttribute = .Focused
    }
    
    func loseFocus() {
        isFocused = false
        self.textAttribute = unfocusedTextAttribute
    }
}
