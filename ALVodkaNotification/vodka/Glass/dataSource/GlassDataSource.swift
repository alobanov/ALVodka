//
//  GlassDataSource.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 02.04.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

class GlassDataSource: NSObject, UITableViewDataSource {
    
    var items:[Alcohol] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let alco = items[indexPath.row] as Alcohol
        let cell: AlcoholViewCell = tableView.dequeueReusableCellWithIdentifier(Alcohol.cellIdentifier) as! AlcoholViewCell
        cell.reloadCell(alco)
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        cell.tintColor = UIColor.whiteColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
}
