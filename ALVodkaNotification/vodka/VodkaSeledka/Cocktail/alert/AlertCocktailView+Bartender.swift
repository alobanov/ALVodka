//
//  AlertCocktailView+Bartender.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 15.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public enum AlertContentType {
    case Success(title: String?, subtitle: String?)
    case Error(title: String?, subtitle: String?)
    case Info(title: String?, subtitle: String?)
}

struct AlertColor {
    var success: UIColor = UIColor(hexString: "CDFF8C")
    var failure: UIColor = UIColor(hexString: "F0756E")
    var info: UIColor = UIColor(hexString: "FCFFB3")
}

extension AlertCocktailView {
    class func alert(title: String, descr: String) -> AlertCocktailView {
        let v = AlertCocktailView.instance(AlertCocktailView.self)
        v.updateTitle(title)
        v.updateDescription(descr)
        return v
    }
    
    public static func makeAlcohol(contentType: NotifyContentType) -> Alcohol {
        switch contentType {
        case let .Success(title, subtitle):
            return AlertCocktailView.alert(title!, descr: subtitle!)
        case let .Error(title, subtitle):
            return AlertCocktailView.alert(title!, descr: subtitle!)
        case let .Info(title, subtitle):
            return AlertCocktailView.alert(title!, descr: subtitle!)
        }
    }
}
