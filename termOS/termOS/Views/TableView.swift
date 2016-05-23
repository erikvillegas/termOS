//
//  TableView.swift
//  termOS
//
//  Created by Erik Villegas on 5/17/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class TableViewCell : View, Focusable {
    var index = 0
    private(set) var isFocused = false
    
    func gainFocus() {
        isFocused = true
        log("cell gained focus! index: " + String(index))
    }
    
    func loseFocus() {
        isFocused = false
        log("cell losed focus! index: " + String(index))
    }
}

protocol TableViewDataSource {
    func numberOfRows(tableView:TableView) -> Int
    func heightForRows(tableView:TableView) -> Int
    func rowSeparatorHeight(tableView:TableView) -> Int
    func cellForRow(row:Int, tableView:TableView) -> TableViewCell
}

protocol TableViewDelegate {
    func tableView(tableView:TableView, didSelectRow row:Int)
}


class TableView : ScrollView {
    var delegate: TableViewDelegate?
    var dataSource: TableViewDataSource?
    var highlightedIndex = -1
    
    func reloadData() {
        
        if let dataSource = dataSource {
            // remove all subviews
            for subview in subviews {
                subview.removeFromSuperview()
            }
            
            let numberOfRows = dataSource.numberOfRows(self)
            let rowHeight = dataSource.heightForRows(self)
            let rowSeparatorHeight = dataSource.rowSeparatorHeight(self)
            
            // add the views!
            for i in 0..<numberOfRows {
                let cell = dataSource.cellForRow(i, tableView: self)
                cell.index = i
                cell.frame = Frame(x: 0, y: i * rowHeight + (i * rowSeparatorHeight), width: frame.width, height:rowHeight)
                addSubview(cell)
            }
            
            // configure the scroll view
            if rowSeparatorHeight > 0 {
                contentSize = Size(width: frame.width, height: numberOfRows * rowHeight + ((numberOfRows - 1) * rowSeparatorHeight))
            }
            else {
                contentSize = Size(width: frame.width, height: numberOfRows * rowHeight)
            }
        }
    }
    
    override func updateInnerFocusWithKey(key: Termbox.Event.Key) {
        log("tableView: updateInnerFocusWithKey")
        
        if let dataSource = dataSource {
            let numberOfRows = dataSource.numberOfRows(self)
            let rowHeight = dataSource.heightForRows(self) + dataSource.rowSeparatorHeight(self)
            
            let visibleTableRows = frame.height - (hasBorder ? 2 : 0)
            
            if key == .DownArrow {
                highlightedIndex = min(highlightedIndex + 1, numberOfRows - 1)
                
                if ((highlightedIndex * rowHeight) - contentOffset.y) >= visibleTableRows {
                    contentOffset.y = min(contentOffset.y + rowHeight, contentSize.height - visibleTableRows)
                }
            }
            else if key == .UpArrow {
                highlightedIndex = max(highlightedIndex - 1, 0)

                if (highlightedIndex * rowHeight) < contentOffset.y {
                    contentOffset.y = max(contentOffset.y - rowHeight, 0)
                }
            }
            else if key == .LeftArrow {
                
            }
            else if key == .RightArrow {
                
            }
            else if key == .Enter {
                if highlightedIndex == -1 {
                    highlightedIndex = 0
                }
            }
            else if key == .Escape {
                highlightedIndex = -1
            }
            
            reloadData()
        }
    }
}