//
//  GlassQueue.swift
//  ALVodkaNotification
//
//  Created by Lobanov on 20.04.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import Foundation

public struct GlassQueue<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public func peek() -> T? {
        return array.first
    }
}
