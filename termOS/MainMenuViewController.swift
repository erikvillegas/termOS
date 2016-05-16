//
//  MainMenuViewController.swift
//  Termbox-Swift
//
//  Created by Erik Villegas on 5/15/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class MainMenuViewController : MenuViewController {
    
    var headerLabel: Label!
    var textFields = [TextField]()
    
    func updateHeaderLabelWithFirstName(firstName: String?, lastName: String?) {
        var string = "Hello"
        
        if let firstName = firstName where firstName.characters.count > 0 {
            string += " "
            string += firstName
        }
        
        if let lastName = lastName where lastName.characters.count > 0 {
            string += " "
            string += lastName
        }
        
        if string.characters.count > 0 {
            string += "!"
        }
        headerLabel.text = string
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel = Label(text: "")
        headerLabel.frame = Frame(x: 0, y: 0, width: view.frame.width, height: 1)
        headerLabel.backgroundColor = .CyanDimmed
        headerLabel.textAlignment = .Center
        
        updateHeaderLabelWithFirstName(nil, lastName: nil)
        
        view.addSubview(headerLabel)
        
        
        let contentView = View()
        contentView.frame = Frame(x: 0, y: 2, width: view.frame.width, height: 10)
        contentView.backgroundColor = .BlueDimmed
        
        let firstNameLabel = Label(text: "First Name:")
        firstNameLabel.frame = Frame(x: 1, y: 1, width: firstNameLabel.text.characters.count, height: 1)
        
        let lastNameLabel = Label(text: "Last Name:")
        lastNameLabel.frame = Frame(x: 1, y: firstNameLabel.frame.y + 2, width: lastNameLabel.text.characters.count, height: 1)
        
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        
        let firstNameField = TextField(text: "")
        let lastNameField = TextField(text: "")
        
        firstNameField.frame = Frame(x: firstNameLabel.frame.x + firstNameLabel.frame.width + 2, y: firstNameLabel.frame.y, width: 20, height: 1)
        firstNameField.backgroundColor = .Blue
        firstNameField.eventHandler = { event in
            if case .DidChange(_) = event {
                self.updateHeaderLabelWithFirstName(firstNameField.text, lastName: lastNameField.text)
            }
        }
        
        lastNameField.frame = Frame(x: lastNameLabel.frame.x + lastNameLabel.frame.width + 2, y: lastNameLabel.frame.y, width: 20, height: 1)
        lastNameField.backgroundColor = .Blue
        lastNameField.eventHandler = { event in
            if case .DidChange(_) = event {
                self.updateHeaderLabelWithFirstName(firstNameField.text, lastName: lastNameField.text)
            }
        }
        
        contentView.addSubview(firstNameField)
        contentView.addSubview(lastNameField)
        
        view.addSubview(contentView)
        
        firstNameField.becomeFirstResponder()
        
        textFields = [firstNameField, lastNameField]
    }
    
    override func handleEvent(event: Termbox.Event) {
        if case .KeyPressed(let key) = event where key == .Tab {
            var firstResponderIndex = 0
            
            for (index, textField) in textFields.enumerate() {
                if textField.isFirstResponder {
                    textField.resignFirstResponder()
                    firstResponderIndex = index
                    break
                }
            }
            
            //            log("\(firstResponderIndex)")
            let nextResponder = textFields[(firstResponderIndex + 1) % textFields.count]
            
            nextResponder.becomeFirstResponder()
        }
    }
}
