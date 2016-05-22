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
    
    func gainFocus()
    func loseFocus()
}

class Button : Label, Focusable {
    var unfocusedTextAttribute = TextAttribute.None
    
    func gainFocus() {
        
        self.textAttribute = .Focused
    }
    
    func loseFocus() {
        self.textAttribute = unfocusedTextAttribute
    }
}
