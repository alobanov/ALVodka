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

struct NotificationColor {
    var success: UIColor = UIColor(hexString: "CDFF8C")
    var failure: UIColor = UIColor(hexString: "F0756E")
    var info: UIColor = UIColor(hexString: "FCFFB3")
}

extension NotifyCocktailView {
    class func notification(title: String, descr: String, color: UIColor) -> NotifyCocktailView {
        let v = NotifyCocktailView.instance(NotifyCocktailView.self)
        v.bubleView.backgroundColor = color
        v.updateTitle(title)
        v.updateDescription(descr)
        return v
    }
    
    public static func makeAlcohol(contentType: NotifyContentType) -> Alcohol {
        switch contentType {
        case let .Success(title, subtitle):
            return NotifyCocktailView.notification(title!, descr: subtitle!, color: NotificationColor().success)
        case let .Error(title, subtitle):
            return NotifyCocktailView.notification(title!, descr: subtitle!, color: NotificationColor().failure)
        case let .Info(title, subtitle):
            return NotifyCocktailView.notification(title!, descr: subtitle!, color: NotificationColor().info)
        }
    }
}