//
//  VodkaSeledka.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 10.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

class VodkaSeledka: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0.0, alpha:0.25)
        view.alpha = 0
        return view
    }()
    
    private var controllerTo: UIViewController?
    private var displayTimer = NSTimer()
    
    convenience init(content: BaseHudView) {
        self.init(frame: CGRectZero)
        self.updateConten(content)
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Vodka are dead!")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    internal func updateConten(content: BaseHudView) {
        addSubview(backgroundView)
        addSubview(content)
        
        clipsToBounds = true
        userInteractionEnabled = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Glass.orientationDidChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        self.setupPositionContentView(content)
    }
    
    internal func shout(to controller: UIViewController) {
        guard let controller = controller.navigationController else { fatalError("The controller must contain a navigation bar") }
        
        if self.controllerTo == nil {
            self.controllerTo = controller;
            controller.view.addSubview(self)
        }
        
        displayTimer.invalidate()
        displayTimer = NSTimer.scheduledTimerWithTimeInterval(3,
                               target: self,
                               selector: #selector(VodkaSeledka.hide),
                               userInfo: nil,
                               repeats: false)
        
        UIView.animateWithDuration(0.5) { 
            self.backgroundView.alpha = 1
        }
        
        setupFrames()
    }
    
    func hide() {
        UIView.animateWithDuration(0.5, animations: { 
            self.backgroundView.alpha = 0
            }) { (state) in
                self.removeFromSuperview()
        }
        
    }
    
    // MARK: - Handling screen orientation
    func orientationDidChange() {
        setupFrames()
    }
    
    // MARK: - Setup
    internal func setupFrames() {
        backgroundView.frame = UIScreen.mainScreen().bounds
        self.backgroundView.frame.size = UIScreen.mainScreen().bounds.size
        self.frame.size = self.backgroundView.frame.size
    }
    
    func setupPositionContentView(view: BaseHudView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let views = ["content": view, "container": self]
        
        let (formatH, optionH) = view.constraintH
        let (formatV, optionV) = view.constraintV
        
        let horizontalConstraints =
            NSLayoutConstraint.constraintsWithVisualFormat(formatH,
                                                           options: NSLayoutFormatOptions(rawValue: optionH),
                                                           metrics: nil, views: views)
        let verticalConstraints =
            NSLayoutConstraint.constraintsWithVisualFormat(formatV,
                                                           options: NSLayoutFormatOptions(rawValue: optionV),
                                                           metrics: nil, views: views)
        
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstraints)
    }
}
