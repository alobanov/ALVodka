//
//  AlertCocktailView.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 15.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

struct AlertConf: Configurable {
    var dimsBackground: Bool = true
    var style: VodkaStyle = VodkaStyle.FullScreen
    var position = VodkaPosition.Center
    var queueEnabled = true
    var autoHide: Bool = false
    var delay: NSTimeInterval = 0
}

public class AlertCocktailView: Alcohol {

    override func configuration() -> Configurable {
        return AlertConf()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    
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
