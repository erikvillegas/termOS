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
//    var textFields = [TextField]()
    
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
        
//        headerLabel = Label(text: "")
//        headerLabel.frame = Frame(x: 0, y: 0, width: view.frame.width, height: 1)
//        headerLabel.backgroundColor = .CyanDimmed
//        headerLabel.textAlignment = .Center
//        
//        updateHeaderLabelWithFirstName("Erik", lastName: "V")
//        
//        view.addSubview(headerLabel)
//
//        
//        let contentView = View()
//        contentView.frame = Frame(x: 0, y: 2, width: view.frame.width, height: 10)
//        contentView.backgroundColor = .BlueDimmed
//        
//        let firstNameLabel = Label(text: "First Name:")
//        firstNameLabel.frame = Frame(x: 1, y: 1, width: firstNameLabel.text.characters.count, height: 1)
//        
//        let lastNameLabel = Label(text: "Last Name:")
//        lastNameLabel.frame = Frame(x: 1, y: firstNameLabel.frame.y + 2, width: lastNameLabel.text.characters.count, height: 1)
//        
//        contentView.addSubview(firstNameLabel)
//        contentView.addSubview(lastNameLabel)
//        
//        let firstNameField = TextField(text: "")
//        let lastNameField = TextField(text: "")
//        
//        firstNameField.frame = Frame(x: firstNameLabel.frame.x + firstNameLabel.frame.width + 2, y: firstNameLabel.frame.y, width: 20, height: 1)
//        firstNameField.backgroundColor = .Blue
//        firstNameField.eventHandler = { event in
//            if case .DidChange(_) = event {
//                self.updateHeaderLabelWithFirstName(firstNameField.text, lastName: lastNameField.text)
//            }
//        }
//        
//        lastNameField.frame = Frame(x: lastNameLabel.frame.x + lastNameLabel.frame.width + 2, y: lastNameLabel.frame.y, width: 20, height: 1)
//        lastNameField.backgroundColor = .Blue
//        lastNameField.eventHandler = { event in
//            if case .DidChange(_) = event {
//                self.updateHeaderLabelWithFirstName(firstNameField.text, lastName: lastNameField.text)
//            }
//        }
//        
//        contentView.addSubview(firstNameField)
//        contentView.addSubview(lastNameField)
//        
//        view.addSubview(contentView)
//        
//        firstNameField.becomeFirstResponder()
//        
//        textFields = [firstNameField, lastNameField]
        
        
//        let view1 = View()
//        view1.frame = Frame(x: 1, y: 1, width: view.frame.width - 2, height: view.frame.height - 2)
//        view1.backgroundColor = .Blue
//        
//        let view2 = View()
//        view2.frame = Frame(x: 1, y: 1, width: view1.frame.width - 2, height: view1.frame.height - 2)
//        view2.backgroundColor = .Red
//        
//        let view3 = View()
//        view3.frame = Frame(x: 1, y: 1, width: view2.frame.width - 2, height: view2.frame.height - 2)
//        view3.backgroundColor = .Yellow
//        
//        let view4 = View()
//        view4.frame = Frame(x: 1, y: 1, width: view3.frame.width - 2, height: view3.frame.height - 2)
//        view4.backgroundColor = .Magenta
//        
//        let view5 = View()
//        view5.frame = Frame(x: 1, y: 1, width: view4.frame.width - 2, height: view4.frame.height - 2)
//        view5.backgroundColor = .Cyan
//        
//        let view6 = View()
//        view6.frame = Frame(x: 1, y: 1, width: view5.frame.width - 2, height: view5.frame.height - 2)
//        view6.backgroundColor = .Green
//        
//        let view7 = View()
//        view7.frame = Frame(x: 1, y: 1, width: view6.frame.width - 2, height: view6.frame.height - 2)
//        view7.backgroundColor = .White
//        
//        view6.addSubview(view7)
//        view5.addSubview(view6)
//        view4.addSubview(view5)
//        view3.addSubview(view4)
//        view2.addSubview(view3)
//        view1.addSubview(view2)
//        view.addSubview(view1)
        
//        var currentView = view
//        
//        for i in 0..<Int(view.frame.height/2) {
//            let view = View()
//            view.frame = Frame(x: 1, y: 1, width: currentView.frame.width - 2, height: currentView.frame.height - 2)
//            view.backgroundColor = Color(rawValue: 8 + (i % 8))!
//            
//            currentView.addSubview(view)
//            currentView = view
//        }


//        let tableView = TableView()
//        tableView.frame = Frame(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        tableView.backgroundColor = .CyanDimmed
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.reloadData()
//
//        view.addSubview(tableView)
        
//        for i in 0..<tableView.contentSize.height {
//            let innerView = View()
//            innerView.frame = Frame(x: 1, y: i, width: tableView.frame.width - 2, height: 1)
//            innerView.backgroundColor = Color(rawValue: 8 + (i % 8))!
//            
//            tableView.addSubview(innerView)
//        }

        
        
//        let label = Label(text: "Hello!")
//        label.frame = Frame(x: 0, y: 0, width: view.frame.width - 0, height: view.frame.height - 0)
//        label.backgroundColor = .White
//        label.textColor = .Red
//        
//        view.addSubview(label)

        
        /* BUTTONS */
        
//        let b1 = Button(text: "Button 1")
//        b1.frame = Frame(x: 5, y: 2, width: b1.text.characters.count + 4, height: 3)
//        b1.backgroundColor = .BlueDimmed
//        b1.textColor = .White
//        b1.textAlignment = .Center
//
//        view.addSubview(b1)
//
//        let b2 = Button(text: "Button 2")
//        b2.frame = Frame(x: b1.frame.x + b1.frame.width + 5, y: 2, width: b2.text.characters.count + 4, height: 3)
//        b2.backgroundColor = .MagentaDimmed
//        b2.textColor = .White
//        b2.textAlignment = .Center
//        b2.borderColor = .Green
//        
//        view.addSubview(b2)

//        let b3 = Button(text: "Button 3")
//        b3.frame = Frame(x: b2.frame.x + b2.frame.width + 5, y: 2, width: b3.text.characters.count + 4, height: 3)
//        b3.backgroundColor = .RedDimmed
//        b3.textColor = .White
//        b3.textAlignment = .Center
//        
//        view.addSubview(b3)
//        
//        let b4View = View()
//        b4View.frame = Frame(x: b3.frame.x + b3.frame.width + 4, y: 1, width: b3.text.characters.count + 6, height: 5)
//        b4View.backgroundColor = .Cyan
//        
//        view.addSubview(b4View)
//        
//        let b4 = Button(text: "Button 4")
//        b4.frame = Frame(x: 1, y: 1, width: b4.text.characters.count + 4, height: 3)
//        b4.backgroundColor = .CyanDimmed
//        b4.textColor = .White
//        b4.textAlignment = .Center
//        
//        b4View.addSubview(b4)
//        
//        let b5 = Button(text: "Button 5")
//        b5.frame = Frame(x: b1.frame.x, y: b1.frame.y + b1.frame.height + 2, width: b5.text.characters.count + 4, height: 3)
//        b5.backgroundColor = .YellowDimmed
//        b5.textColor = .White
//        b5.textAlignment = .Center
//        
//        view.addSubview(b5)
//        
//        let b6 = Button(text: "Button 6")
//        b6.frame = Frame(x: b5.frame.x + b3.frame.width + 5, y: b5.frame.y, width: b6.text.characters.count + 4, height: 3)
//        b6.backgroundColor = .GreenDimmed
//        b6.textColor = .White
//        b6.textAlignment = .Center
//        
//        view.addSubview(b6)
        
//        let paddingLeft = 7
//        let paddingTop = 9
        
//        let v1 = Label(text: "Wassssup!")
//        v1.frame = Frame(x: 5, y: 5, width: v1.text.characters.count + 2, height: 5)
//        v1.textColor = .White
//        v1.textAlignment = .Center
//        v1.backgroundColor = .BlueDimmed
//        v1.borderColor = .White
//
//        view.addSubview(v1)

        /* DUAL SCROLL VIEWS */
//        
//        let scrollView1 = ScrollView()
//        scrollView1.frame = Frame(x: 0, y: 0, width: view.frame.width/2 - 1, height: view.frame.height)
//        scrollView1.contentSize = Size(width: scrollView1.frame.width, height: scrollView1.frame.height + 15)
//        scrollView1.backgroundColor = .BlueDimmed
//        scrollView1.borderColor = .Gray
//        
//        for i in 0..<scrollView1.contentSize.height {
//            let view = View()
//            view.frame = Frame(x: 0, y: i, width: scrollView1.frame.width, height: 1)
//            view.backgroundColor = Color(rawValue: 8 + (i % 8))!
//            
//            scrollView1.addSubview(view)
//        }
//        
//        let scrollView2 = ScrollView()
//        let scrollView2X = scrollView1.frame.width + 1
//        scrollView2.frame = Frame(x: scrollView2X, y: 0, width: view.frame.width - scrollView2X, height: view.frame.height)
//        scrollView2.contentSize = Size(width: scrollView2.frame.width, height: scrollView2.frame.height + 15)
//        scrollView2.backgroundColor = .RedDimmed
//        scrollView2.borderColor = .Gray
//
//        for i in 0..<scrollView1.contentSize.height {
//            let view = View()
//            view.frame = Frame(x: 0, y: i, width: scrollView2.frame.width, height: 1)
//            view.backgroundColor = Color(rawValue: 8 + (i % 8))!
//            
//            scrollView2.addSubview(view)
//        }
//        
//        view.addSubview(scrollView1)
//        view.addSubview(scrollView2)

        
        /* OVERLAPPING SUBVIEW WITH BORDER */
        
//        let view1 = View()
//        view1.frame = Frame(x: 0, y: 0, width: 20, height: 8)
//        view1.backgroundColor = .RedDimmed
//        view1.borderColor = .White
//        
//        let view2 = View()
//        view2.frame = Frame(x: 0, y: 0, width: 20, height: 8)
//        view2.backgroundColor = .BlueDimmed
//        view1.addSubview(view2)
//        
//        view.addSubview(view1)
        
        /* QUADRUPLE TABLE VIEWS */
        
        let tableView1 = TableView()
        tableView1.frame = Frame(x: 0, y: 0, width: view.frame.width/2 - 1, height: view.frame.height/2 - 1)
        tableView1.bounds = Frame(x: 0, y: 0, width: tableView1.frame.width, height: tableView1.frame.height)
        tableView1.backgroundColor = .BlueDimmed
        tableView1.borderColor = .Gray
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.reloadData()
        
        let tableView2 = TableView()
        let tableView2X = tableView1.frame.width + 1
        tableView2.frame = Frame(x: tableView2X, y: 0, width: view.frame.width - tableView2X, height: view.frame.height/2 - 1)
        tableView2.bounds = Frame(x: 0, y: 0, width: tableView2.frame.width, height: tableView2.frame.height)
        tableView2.backgroundColor = .RedDimmed
        tableView2.borderColor = .Gray
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.reloadData()
        
        let tableView3 = TableView()
        let tableView3Y = tableView1.frame.height + 1
        tableView3.frame = Frame(x: 0, y: tableView3Y, width: view.frame.width/2 - 1, height: view.frame.height - tableView3Y)
        tableView3.bounds = Frame(x: 0, y: 0, width: tableView3.frame.width, height: tableView3.frame.height)
        tableView3.backgroundColor = .BlueDimmed
        tableView3.borderColor = .Gray
        tableView3.delegate = self
        tableView3.dataSource = self
        tableView3.reloadData()
        
        let tableView4 = TableView()
        let tableView4X = tableView1.frame.width + 1
        let tableView4Y = tableView1.frame.height + 1
        tableView4.frame = Frame(x: tableView4X, y: tableView4Y, width: view.frame.width - tableView4X, height: view.frame.height - tableView4Y)
        tableView4.bounds = Frame(x: 0, y: 0, width: tableView4.frame.width, height: tableView4.frame.height)
        tableView4.backgroundColor = .BlueDimmed
        tableView4.borderColor = .Gray
        tableView4.delegate = self
        tableView4.dataSource = self
        tableView4.reloadData()
        
        view.addSubview(tableView1)
        view.addSubview(tableView2)
        view.addSubview(tableView3)
        view.addSubview(tableView4)
    }
    
    override func handleEvent(event: Termbox.Event) {
//        if case .KeyPressed(let key) = event where key == .Tab {
//            var firstResponderIndex = 0
//            
//            for (index, textField) in textFields.enumerate() {
//                if textField.isFirstResponder {
//                    textField.resignFirstResponder()
//                    firstResponderIndex = index
//                    break
//                }
//            }
//            
//            //            log("\(firstResponderIndex)")
//            let nextResponder = textFields[(firstResponderIndex + 1) % textFields.count]
//            
//            nextResponder.becomeFirstResponder()
//        }
    }
}

extension MainMenuViewController : TableViewDataSource {
    func numberOfRows(tableView: TableView) -> Int {
        return 30
    }
    
    func heightForRows(tableView: TableView) -> Int {
        return 1
    }
    
    func cellForRow(row: Int, tableView: TableView) -> TableViewCell {
        let isHighlighted = (tableView.highlightedIndex == row)
        
        let cell = TableViewCell()
        cell.backgroundColor = isHighlighted ? .Gray : .BlueDimmed
        
        let label = Label(text: "Hello! Row \(row)")
        label.frame = Frame(x: 0, y: 0, width: tableView.frame.width, height: heightForRows(tableView))
        label.backgroundColor = .Clear
        label.textColor = isHighlighted ? .BlueDimmed : .White
        
        cell.addSubview(label)
        
        return cell
    }
    
    func rowSeparatorHeight(tableView: TableView) -> Int {
        return 0
    }
}

extension MainMenuViewController : TableViewDelegate {
    func tableView(tableView: TableView, didSelectRow row: Int) {
        log("selected row \(row)")
    }
}
