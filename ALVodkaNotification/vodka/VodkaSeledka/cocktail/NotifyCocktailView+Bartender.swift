//
//  AlertHudView+Fabric.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 12.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public enum NotifyContentType {
    case Success(title: String?, subtitle: String?)
    case Error(title: String?, subtitle: String?)
    case Info(title: String?, subtitle: String?)
}

extension NotifyCocktailView {
    class func popupSuccess(title: String, descr: String) -> NotifyCocktailView {
        let v = NotifyCocktailView.instance(NotifyCocktailView.self)
        v.updateTitle(title)
        v.updateDescription(descr)
        v.bubleView.backgroundColor = UIColor.greenColor()
        
        return v
    }
    
    class func popupFailure(title: String, descr: String) -> NotifyCocktailView {
        let v = NotifyCocktailView.instance(NotifyCocktailView.self)
        v.updateTitle(title)
        v.updateDescription(descr)
        v.bubleView.backgroundColor = UIColor.redColor()
        
        return v
    }
    
    class func popupInfo(title: String, descr: String) -> NotifyCocktailView {
        let v = NotifyCocktailView.instance(NotifyCocktailView.self)
        v.updateTitle(title)
        v.updateDescription(descr)
        v.bubleView.backgroundColor = UIColor.orangeColor()
        
        return v
    }
    
    public static func makeAlcohol(contentType: NotifyContentType) -> Alcohol {
        switch contentType {
        case let .Success(title, subtitle):
            return NotifyCocktailView.popupSuccess(title!, descr: subtitle!)
        case let .Error(title, subtitle):
            return NotifyCocktailView.popupFailure(title!, descr: subtitle!)
        case let .Info(title, subtitle):
            return NotifyCocktailView.popupInfo(title!, descr: subtitle!)
        }
    }
}