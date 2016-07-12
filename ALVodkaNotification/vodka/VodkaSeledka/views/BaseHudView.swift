//
//  BaseHudView.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public class BaseHudView: UIView, ViewConfigurable {
    var config: Themeble = BaseConfiguration()
    
    var constraintH: (String, UInt) {
        switch config.position {
        case .Bottom, .Top:
            return ("H:|-10-[content]-10-|", 0)
        default:
            return ("H:[container]-(<=0)-[content(>=100)]", NSLayoutFormatOptions.AlignAllCenterY.rawValue)
        }
    }
    
    var constraintV: (String, UInt) {
        switch config.position {
        case .Top:
            return ("V:|-20-[content(>=100)]", 0)
        case .Bottom:
            return ("V:[content(>=100)]-20-|", 0)
        default:
            return ("V:[container]-(<=0)-[content(>=100)]", NSLayoutFormatOptions.AlignAllCenterX.rawValue)
        }
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instance<T>(type: T.Type) -> T {
        let name: String = NSStringFromClass(T.self as! AnyObject.Type)
        let view = NSBundle.mainBundle().loadNibNamed(name.componentsSeparatedByString(".").last, owner: nil, options: nil).first as! T
        return view
    }
}
