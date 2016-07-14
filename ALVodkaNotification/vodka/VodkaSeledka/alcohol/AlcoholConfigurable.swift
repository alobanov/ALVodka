//
//  AlcoRecipe.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import Foundation

protocol AlcoholConfigurable {
    // configuration
    var configuration: Configurable { set get }
    
    // Constraint setting use text format
    var constraintH: (String, UInt) { get }
    var constraintV: (String, UInt) { get }
    
    // Common close block
    var manualCloseEventBlock: (() -> Void)? {set get}
    
    // anumation in this methods
    func show(block: (Bool)->())
    func hide(block: (Bool)->())
}

enum VodkaPosition: Int {
    case Center, Top, Bottom
}

enum VodkaStyle: Int {
    case FullScreen, Notification
}

protocol Configurable {
    //Alerts
    var dimsBackground: Bool { get }
    var style: VodkaStyle { get }
    var position: VodkaPosition { get }
    var queueEnabled: Bool { get }
    var autoHide: Bool { get }
    var delay: NSTimeInterval { get }
}

struct VodkaConf: Configurable {
    var dimsBackground: Bool = true
    var style: VodkaStyle = VodkaStyle.FullScreen
    var position = VodkaPosition.Center
    var queueEnabled = true
    var autoHide: Bool = true
    var delay: NSTimeInterval = 4
    
}