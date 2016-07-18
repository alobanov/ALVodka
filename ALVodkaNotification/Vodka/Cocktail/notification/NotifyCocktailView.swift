//
//  AlertHudView.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

struct NotificationConf: Configurable {
    var dimsBackground: Bool = false
    var style: VodkaStyle = VodkaStyle.Notification
    var position = VodkaPosition.Top
    var queueEnabled = false
    var autoHide: Bool = true
    var delay: NSTimeInterval = 5
    
}

public class NotifyCocktailView: Alcohol {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var bubleView: UIView!
    
    override func configuration() -> Configurable {
        return NotificationConf()
    }
    
    func updateTitle(title: String) {
        self.titleLabel.text = title
    }
    
    func updateDescription(descr: String) {
        self.descrLabel.text = descr
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath.init(rect: self.bounds)
        self.layer.masksToBounds = false;
        self.layer.shadowColor = UIColor.blackColor().CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1.1);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowPath = shadowPath.CGPath;
    }
    
    @IBAction func tapOnAlert(sender: AnyObject) {
        print("Hellow tap")
        if let b = self.manualCloseEventBlock {
            b()
        }
    }

}
