//
//  Bottle.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public enum NotifyContentType {
    case Success(title: String?, subtitle: String?)
    case Error(title: String?, subtitle: String?)
    case Info(title: String?, subtitle: String?)
}

public class NotifyCocktail {
    public static func makeAlcohol(contentType: NotifyContentType) -> BaseHudView {
        switch contentType {
        case let .Success(title, subtitle):
            return AlertHudView.popupSuccess(title!, descr: subtitle!)
        case let .Error(title, subtitle):
            return AlertHudView.popupFailure(title!, descr: subtitle!)
        case let .Info(title, subtitle):
            return AlertHudView.popupInfo(title!, descr: subtitle!)
        }
    }
}
