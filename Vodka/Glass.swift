//
//  VodkaSeledka.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 10.07.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

public class Glass: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0.0, alpha:0.25)
        view.alpha = 0
        return view
    }()
    
    private var controllerTo: UIViewController?
    private var displayTimer = NSTimer()
    private var queue = GlassQueue<Alcohol>()
    private var content: Alcohol!
    
    convenience init() {
        self.init(frame: CGRectZero)
        
        backgroundColor = UIColor.clearColor()
        clipsToBounds = true
        userInteractionEnabled = true
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Vodka are dead!")
        NSNotificationCenter
            .defaultCenter()
            .removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    private func updateConten(content: Alcohol) {
        self.content = content
        
        if (content.configuration().dimsBackground) {
            addSubview(backgroundView)
        }
        addSubview(content)
        
        setupPositionContentView(content)
        NSNotificationCenter
            .defaultCenter()
            .addObserver(self, selector: #selector(Glass.orientationDidChange),
                                                         name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        setupFrames()
    }
    
    internal func pour(content: Alcohol, inView: UIView) {
        queue.enqueue(content)
        if queue.count == 1 {
            self.checkNextRecipe()
        }
        
        if self.superview == nil {
            inView.addSubview(self)
        }
        
        if queue.count > 1 {
            if !content.configuration().queueEnabled {
                if self.content != nil {
                    self.breatheOut()
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
        self.drink()
        
        self.performSelector(#selector(Glass.setupFrames), withObject: nil, afterDelay: 0.0)
    }
    
    // MARK: - Show
    private func drink() {
        self.hidden = false
        
        if content.configuration().dimsBackground {
            UIView.animateWithDuration(0.5) {
                self.backgroundView.alpha = 1
            }
        }
        
        self.content.show({ s in })
        self.content.manualCloseEventBlock = ({[weak self] _ in
            self?.breatheOut()
        })
        
        if self.content.configuration().autoHide {
            displayTimer.invalidate()
            displayTimer = NSTimer.scheduledTimerWithTimeInterval(self.content.configuration().delay,
                                                                  target: self,
                                                                  selector: #selector(Glass.breatheOut),
                                                                  userInfo: nil,
                                                                  repeats: false)
        }
    }
    
    // MARK: - Hide
    public func breatheOut() {
        queue.dequeue()
        displayTimer.invalidate()
        
        if (content.configuration().dimsBackground) {
            UIView.animateWithDuration(0.3, animations: { 
                self.backgroundView.alpha = 0;
            })
        }
        
        content.hide({[weak self] s in
            self?.backgroundView.removeFromSuperview()
            self?.hidden = true
            self?.content.removeFromSuperview()
            self?.checkNextRecipe()
        })
    }
    
    // MARK: - Handling screen orientation
    internal func orientationDidChange() {
        setupFrames()
    }
    
    // MARK: - Frame and position setup
    internal func setupFrames() {
        self.frame.size = UIScreen.mainScreen().bounds.size
        backgroundView.frame = UIScreen.mainScreen().bounds
        self.backgroundView.frame.size = self.frame.size
        
        switch content.configuration().style {
        case .FullScreen:
            break
        case .Notification:
            content.layoutIfNeeded()
            self.frame.size = CGSizeMake(self.frame.size.width, content.bounds.size.height + content.frame.origin.y*2)
        }
    }
    
    private func setupPositionContentView(view: Alcohol) {
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
