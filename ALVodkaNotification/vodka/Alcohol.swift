//
//  Alcohol.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 02.04.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public struct Alcohol {
    public static var cellIdentifier = "AlcoholViewCell"
    
    public var title: String
    public var subtitle: String?
    public var image: UIImage?
    public var duration: NSTimeInterval
    public var action: (() -> Void)?
    
    public var destroyUid: String
    
    public init(title: String, subtitle: String? = nil, image: UIImage? = nil, duration: NSTimeInterval = 2, action: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.duration = duration
        self.action = action
        destroyUid = String(format: "%f", NSDate().timeIntervalSince1970)
    }
}

