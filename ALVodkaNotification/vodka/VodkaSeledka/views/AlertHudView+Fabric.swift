//
//  AlertHudView+Fabric.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 12.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

extension AlertHudView {
    class func popupSuccess(title: String, descr: String) -> AlertHudView {
        let v = AlertHudView.instance(AlertHudView.self)
        v.updateTitle(title)
        v.updateDescription(descr)
        v.bubleView.backgroundColor = UIColor.greenColor()
        
        return v
    }
    
    class func popupFailure(title: String, descr: String) -> AlertHudView {
        let v = AlertHudView.instance(AlertHudView.self)
        v.updateTitle(title)
        v.updateDescription(descr)
        v.bubleView.backgroundColor = UIColor.redColor()
        
        return v
    }
    
    class func popupInfo(title: String, descr: String) -> AlertHudView {
        let v = AlertHudView.instance(AlertHudView.self)
        v.updateTitle(title)
        v.updateDescription(descr)
        v.bubleView.backgroundColor = UIColor.orangeColor()
        
        return v
    }
}