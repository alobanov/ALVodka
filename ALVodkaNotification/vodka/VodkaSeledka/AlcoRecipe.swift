//
//  AlcoRecipe.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 11.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import Foundation

protocol ViewConfigurable {
    var constraintH: (String, UInt) { get }
    var constraintV: (String, UInt) { get }
    
    var manualCloseEventBlock: (() -> Void)? {set get}
    
    func show(block: (Bool)->())
    func hide(block: (Bool)->())
}