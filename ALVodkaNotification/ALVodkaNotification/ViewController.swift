//
//  ViewController.swift
//  ALVodkaNotification
//
//  Created by Lobanov on 01.04.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let container = UIView()
//        container.backgroundColor = UIColor.blueColor()
//        container.frame = CGRectMake(0.0, 90.0, 400.0, 100.0)
//        
//        let fView = UIView()
//        fView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(container)
//        container.addSubview(fView)
//        fView.backgroundColor = UIColor.redColor()
//        
//        let variableBindings = ["headerView":fView]
//        
//        let cn1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[headerView(>=300)]-20-|", options:.AlignAllBaseline, metrics: nil, views: variableBindings)
//        
//        let cn2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[headerView(>=50)]-20-|", options:.AlignAllBaseline, metrics: nil, views: variableBindings)
//        
//        container.addConstraints(cn1)
//        container.addConstraints(cn2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showNotify(sender: AnyObject) {
        let announcement = Alcohol(title: self.randomStringWithLength(self.rand(14)),
                                   subtitle: self.randomStringWithLength(self.rand(500)),
                                   image: UIImage(named: "avatar"),
                                   duration: 3,
                                   to: self)
        
        glass.pour(announcement) { 
            print("completed")
        }
    }
    
    func rand(i: UInt32)-> Int {
        return Int(arc4random_uniform(i) + 1)
    }
    
    func randomStringWithLength (len : Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString as String
    }
}

