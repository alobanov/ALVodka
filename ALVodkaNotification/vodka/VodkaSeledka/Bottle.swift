//
//  Bottle.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public enum HUDContentType {
    case Success
    case Error
    case Progress
    case Image(UIImage?)
    
    case LabeledSuccess(title: String?, subtitle: String?)
    case LabeledError(title: String?, subtitle: String?)
    case LabeledProgress(title: String?, subtitle: String?)
    case LabeledImage(image: UIImage?, title: String?, subtitle: String?)
    
    case Label(String?)
    case SystemActivity
}

public final class Bottle {
    public static func pour(content: HUDContentType, inController: UIViewController) {
        let selekda = VodkaSeledka(content: contentView(content) )
        selekda.shout(to: inController)
    }
    
    // MARK: Private methods
    private static func contentView(content: HUDContentType) -> BaseHudView {
        switch content {
        case .Success:
            return AlertHudView.alertSuccess()
        case let .LabeledSuccess(title, subtitle):
            return AlertHudView.alertSuccess(title!, descr: subtitle!)
        default:
            return BaseHudView()
        }
    }
}
