//
//  AlertHudView.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public class AlertHudView: BaseHudView {
    @IBOutlet weak var iconView: UIImageView!
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
        
        iconView.image = Vodka.imageOfCanvas1
    }
    
    class func alertSuccess() -> AlertHudView {
        let v = AlertHudView.instance(AlertHudView.self)
        v.updateTitle("")
        v.updateDescription("")
        
        return v
    }
    
    class func alertSuccess(title: String, descr: String) -> AlertHudView {
        let v = AlertHudView.instance(AlertHudView.self)
        v.updateTitle(title)
        v.updateDescription(descr)
        
        return v
    }
}
