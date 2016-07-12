//
//  AlcoRecipe.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import Foundation

protocol ViewConfigurable {
    var config: Themeble {get set}
    var constraintH: (String, UInt) { get }
    var constraintV: (String, UInt) { get }
}

enum Position: Int {
    case Center = 0, CenterRright, CenterLeft, CenterWithScreenWidth,
    Top, TopRight, TopLeft, TopWithScreenWidth,
    Bottom, BottomRight, BottomLeft, BottomWithScreenWidth
}

protocol Themeble {
    //Alerts
    var position: Position { get }
}

struct BaseConfiguration: Themeble {
    var position = Position.Top
}

struct TopConfiguration: Themeble {
    var position = Position.Center
}
