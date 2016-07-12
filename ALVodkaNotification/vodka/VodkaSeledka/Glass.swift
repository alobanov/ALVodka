//
//  VodkaSeledka.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 10.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

class Glass: UIView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0.0, alpha:0.25)
        view.alpha = 0
        return view
    }()
    
    private var controllerTo: UIViewController?
    private var displayTimer = NSTimer()
    
    private var queue = GlassQueue<BaseHudView>()
    private var content: BaseHudView!
    
    convenience init() {
        self.init(frame: CGRectZero)
        self.backgroundColor = UIColor.clearColor()
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
    
    private func updateConten(content: BaseHudView) {
        self.content = content
        
        if (content.configuration.dimsBackground) {
            addSubview(backgroundView)
        }
        
        addSubview(content)
        
        clipsToBounds = true
        userInteractionEnabled = true
        
        self.setupPositionContentView(content)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Glass.orientationDidChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        setupFrames()
    }
    
    internal func pour(content: BaseHudView, inView: UIView) {
        // setup new content
        
        queue.enqueue(content)
        if (queue.count == 1) {
            self.checkNextRecipe()
        }
        
        if (self.superview == nil) {
            inView.addSubview(self)
        }
        
        if (queue.count > 1) {
            if !content.configuration.queueEnabled {
                if self.content != nil {
                    self.hide()
                }
            }
        }
    }
    
    private func checkNextRecipe() {
        guard let recipe = queue.peek() else {
            self.removeFromSuperview()
            return;
        }
        
        self.updateConten(recipe)
        self.show()
        
        self.performSelector(#selector(Glass.setupFrames), withObject: nil, afterDelay: 0.0)
    }
    
    private func show() {
        self.hidden = false
        
        if content.configuration.dimsBackground {
            UIView.animateWithDuration(0.5) {
                self.backgroundView.alpha = 1
            }
        }
        
        self.content?.show({ s in })
        self.content?.manualCloseEventBlock = ({[weak self] _ in
            self?.hide()
        })
        
        displayTimer.invalidate()
        displayTimer = NSTimer.scheduledTimerWithTimeInterval(3,
                                                              target: self,
                                                              selector: #selector(Glass.hide),
                                                              userInfo: nil,
                                                              repeats: false)
    }
    
    func hide() {
        queue.dequeue()
        displayTimer.invalidate()
        
        if (content.configuration.dimsBackground) {
            UIView.animateWithDuration(0.3, animations: { 
                self.backgroundView.alpha = 0;
            })
        }
        
        if let cont = self.content {
            cont.hide({[weak self] s in
                cont.removeFromSuperview()
                self?.backgroundView.removeFromSuperview()
                self?.hidden = true
                self?.checkNextRecipe()
            })
        }
    }
    
    // MARK: - Handling screen orientation
    func orientationDidChange() {
        setupFrames()
    }
    
    // MARK: - Setup
    internal func setupFrames() {
        self.frame.size = UIScreen.mainScreen().bounds.size
        backgroundView.frame = UIScreen.mainScreen().bounds
        self.backgroundView.frame.size = self.frame.size
        
        if content.configuration.userInterationEnabled {
            if let cont = self.content {
                cont.layoutIfNeeded()
                print(cont.bounds.size.height)
                self.frame.size = CGSizeMake(self.frame.size.width, cont.bounds.size.height + cont.frame.origin.y*2)
            }
        }
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
