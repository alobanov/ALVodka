//
//  BaseHudView.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public class BaseHudView: UIView, ViewConfigurable {
    
    var configuration: Configurable!
    var manualCloseEventBlock: (() -> Void)?
    
    var constraintH: (String, UInt) {
        switch configuration.position {
        case .Bottom, .Top:
            return ("H:|-10-[content]-10-|", 0)
        default:
            return ("H:[container]-(<=0)-[content(<=240,>=150)]", NSLayoutFormatOptions.AlignAllCenterY.rawValue)
        }
    }
    
    var constraintV: (String, UInt) {
        switch configuration.position {
        case .Top:
            return ("V:|-24-[content(>=10)]", 0)
        case .Bottom:
            return ("V:[content(>=10)]-20-|", 0)
        default:
            return ("V:[container]-(<=0)-[content(>=30)]", NSLayoutFormatOptions.AlignAllCenterX.rawValue)
        }
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instance<T>(type: T.Type) -> T {
        let name: String = NSStringFromClass(T.self as! AnyObject.Type)
        let view = NSBundle.mainBundle().loadNibNamed(name.componentsSeparatedByString(".").last, owner: nil, options: nil).first as! T
        return view
    }
    
    public func show(block: (Bool)->()) {
        alpha = 0
        transform = CGAffineTransformMakeScale(0.95, 0.95)
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.transform = CGAffineTransformMakeScale(1, 1)
            self.alpha = 1
            }, completion:block)
    }
    
    public func hide(block: (Bool)->()) {
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.transform = CGAffineTransformMakeScale(0.95, 0.95)
            self.alpha = 0
            }, completion: block)
    }
}
