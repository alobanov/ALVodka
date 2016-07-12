//
//  VodkaWindow.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 10.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

class VodkaWindow: UIWindow {
    internal let frameView: UIView
    internal init(frameView: UIView) {
        self.frameView = frameView
        super.init(frame: UIApplication.sharedApplication().delegate!.window!!.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        windowLevel = UIWindowLevelNormal + 500.0
        backgroundColor = UIColor.clearColor()
        
        addSubview(backgroundView)
        addSubview(frameView)
    }
    
    internal override func layoutSubviews() {
        super.layoutSubviews()
        
        frameView.center = center
        backgroundView.frame = bounds
    }
    
    internal func showFrameView() {
        layer.removeAllAnimations()
        makeKeyAndVisible()
        frameView.center = center
        frameView.alpha = 1.0
        hidden = false
    }
    
    private var willHide = false
    
    internal func hideFrameView(animated anim: Bool, completion: ((Bool) -> Void)? = nil) {
        let finalize: (finished: Bool) -> (Void) = { finished in
            self.hidden = true
            self.resignKeyWindow()
            self.willHide = false
            
            completion?(finished)
        }
        
        if hidden {
            return
        }
        
        willHide = true
        
        if anim {
            UIView.animateWithDuration(0.8, animations: {
                self.frameView.alpha = 0.0
                self.hideBackground(animated: false)
                }, completion: { bool in finalize(finished: true) } )
        } else {
            self.frameView.alpha = 0.0
            finalize(finished: true)
        }
    }
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0.0, alpha:0.25)
        view.alpha = 0.0
        return view
    }()
    
    internal func showBackground(animated anim: Bool) {
        if anim {
            UIView.animateWithDuration(0.175) {
                self.backgroundView.alpha = 1.0
            }
        } else {
            backgroundView.alpha = 1.0
        }
    }
    
    internal func hideBackground(animated anim: Bool) {
        if anim {
            UIView.animateWithDuration(0.65) {
                self.backgroundView.alpha = 0.0
            }
        } else {
            backgroundView.alpha = 0.0
        }
    }
}
