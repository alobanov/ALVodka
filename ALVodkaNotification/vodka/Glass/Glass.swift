//
//  Glass.swift
//  ALVodkaNotification
//
//  Created by Lobanov Aleksey on 02.04.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

let glass = Glass()

//public func Vodka(content: Alcohol, to: UIViewController, completion: (() -> ())? = {}) {
//    glass.pour(content, to: to, completion: completion)
//}

public class Glass: UIView {
    public private(set) lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()//Recipe.Colors.background
        view.clipsToBounds = false
        view.alpha = 0
        
        return view
    }()
    
    public private(set) lazy var tableGlass: UITableView = {
        let tableView = UITableView()
        tableView.registerNib(UINib(nibName: Alcohol.cellIdentifier, bundle: nil),
                                    forCellReuseIdentifier: Alcohol.cellIdentifier)
        
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
        
        return tableView
    }()
    
    private lazy var glassDataSource: GlassDataSource = {
        let ds = GlassDataSource()
        return ds
    }()
    
    public private(set) var announcement: Alcohol?
    public private(set) var displayTimer = NSTimer()
    public private(set) var shouldSilent = false
    public private(set) var completion: (() -> ())?
    
    private var queue = GlassQueue<Alcohol>()
    private var controllerTo: UIViewController?
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = false
        addSubview(backgroundView)
        backgroundView.addSubview(tableGlass)
        
        tableGlass.dataSource = glassDataSource
        confConstraint()
        
        clipsToBounds = true
        userInteractionEnabled = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Glass.orientationDidChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        UIView.animateWithDuration(0.3) { 
            self.backgroundView.alpha = 1
        }
    }
    
    private func confConstraint() {
        let variableBindings = ["table":tableGlass]
        tableGlass.translatesAutoresizingMaskIntoConstraints = false
        
        let cn1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[table(>=300)]-0-|", options:.AlignAllBaseline, metrics: nil, views: variableBindings)
        
        let cn2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[table]-0-|", options:.AlignAllBaseline, metrics: nil, views: variableBindings)
        
        self.backgroundView.addConstraints(cn1)
        self.backgroundView.addConstraints(cn2)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Vodka are dead!")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    // MARK: - Configuration
    
    public func pour(announcement: Alcohol, completion: (() -> ())?) {
        queue.enqueue(announcement)
        
        if (queue.count == 1) {
            self.checkNotify()
        }
    }
    
    public func checkNotify() {
        guard let aloc = queue.peek() else {
            return;
        }
        
        backgroundView.alpha = 1
        tableGlass.frame.size = CGSizeMake(1000, 1000)
        glassDataSource.items.append(aloc)
        
        let indexPath = NSIndexPath(forRow: glassDataSource.items.count-1, inSection: 0)
        tableGlass.beginUpdates()
        tableGlass.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
        tableGlass.endUpdates()
        
        shouldSilent = false
        configureView(aloc)
        
        shout(to: aloc.to!)
        self.completion = aloc.action
    }
    
    public func configureView(announcement: Alcohol) {
        self.announcement = announcement
        
        self.performSelector(#selector(Glass.displayTimerDidFire), withObject: announcement.destroyUid, afterDelay: announcement.duration)
    }
    
    public func shout(to controller: UIViewController) {
        guard let controller = controller.navigationController else { fatalError("The controller must contain a navigation bar") }
        
        if self.controllerTo == nil {
            self.controllerTo = controller;
            controller.view.addSubview(self)
        }
        
        setupFrames()
    }
    
    // MARK: - Setup
    
    public func setupFrames() {
        let totalWidth = UIScreen.mainScreen().bounds.width
        backgroundView.frame = CGRect(x: 0, y: 0, width: totalWidth, height: 1000)
        tableGlass.layoutIfNeeded()
        let height = self.tableGlass.contentSize.height
        self.backgroundView.frame.size = CGSize(width: totalWidth, height: height)
        self.frame.size = self.backgroundView.frame.size
    }
    
    // MARK: - Actions
    
    public func silent(identifier: String) {
        var index = 0
        for item: Alcohol in glassDataSource.items {
            if item.destroyUid == identifier {
                break
            }
            index += 1
        }
        
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        glassDataSource.items.removeAtIndex(index)
        tableGlass.beginUpdates()
        tableGlass.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
        tableGlass.endUpdates()
        
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(Glass.setupFrames), object: nil)
        self.performSelector(#selector(Glass.setupFrames), withObject: nil, afterDelay: 0.5)
    }
    
    // MARK: - Timer methods
    
    public func displayTimerDidFire(identifier: String) {
        shouldSilent = true
        silent(identifier)
        
        self.queue.dequeue()
        self.performSelector(#selector(Glass.checkNotify), withObject: nil, afterDelay: 0.5)
    }
    
    // MARK: - Handling screen orientation
    
    func orientationDidChange() {
        setupFrames()
    }
}

