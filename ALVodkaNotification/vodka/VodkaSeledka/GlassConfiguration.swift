//
//  GlassConfiguration.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 12.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import Foundation

enum Position: Int {
    case Center = 0, CenterRright, CenterLeft, CenterWithScreenWidth,
    Top, TopRight, TopLeft, TopWithScreenWidth,
    Bottom, BottomRight, BottomLeft, BottomWithScreenWidth
}

protocol Configurable {
    //Alerts
    var dimsBackground: Bool { get }
    var userInterationEnabled: Bool { get }
    var position: Position { get }
}

struct NotificationConf: Configurable {
    var dimsBackground: Bool = false
    var userInterationEnabled: Bool = true
    var position = Position.Top
}

struct AlertConf: Configurable {
    var dimsBackground: Bool = true
    var userInterationEnabled: Bool = false
    var position = Position.Center
}