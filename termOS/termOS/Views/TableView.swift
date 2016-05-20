//
//  TableView.swift
//  termOS
//
//  Created by Erik Villegas on 5/17/16.
//  Copyright © 2016 Erik Villegas. All rights reserved.
//

import Foundation

class TableViewCell : View {
    
}

protocol TableViewDataSource {
    func numberOfRows(tableView:TableView) -> Int
    func heightForRows(tableView:TableView) -> Int
    func rowSeparatorHeight(tableView:TableView) -> Int
    func cellForRow(row:Int, tableView:TableView) -> TableViewCell
}

class TableView : ScrollView {
    var dataSource: TableViewDataSource?
    
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
}