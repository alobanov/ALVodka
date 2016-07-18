//
//  AlcoRecipe.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import Foundation

protocol AlcoholConfigurable {
    
    // Constraint setting use text format
    var constraintH: (String, UInt) { get }
    var constraintV: (String, UInt) { get }
    
    // Common close block
    var manualCloseEventBlock: (() -> Void)? {set get}
    
    // animation in this methods
    func show(block: (Bool)->())
    func hide(block: (Bool)->())
    
    func configuration() -> Configurable
}

enum VodkaPosition: Int {
    case Center, Top, Bottom
}

enum VodkaStyle: Int {
    case FullScreen, Notification
}

protocol Configurable {
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