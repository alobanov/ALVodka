//
//  ViewController.swift
//  ALVodkaNotification
//
//  Created by Lobanov on 01.04.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let glass = Glass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    deinit {
        print("Destroy: \(#file.componentsSeparatedByString("/").last!) : \(#function)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showNotify(sender: AnyObject) {
        if let view = self.navigationController?.view {
            let reciept = NotifyCocktailView
                .makeAlcohol(.Success(title: "What about VODKA", subtitle:"Vodka is a distilled beverage composed primarily of water and ethanol, sometimes with traces of impurities and flavorings. Traditionally, vodka is made by the distillation of fermented cereal grains or potatoes, though some modern brands use other substances, such as fruits or sugar."))
            reciept.configuration = NotificationConf()
            glass.pour(reciept, inView: view)
        }
    }
    
    @IBAction func showAlert(sender: AnyObject) {
        if let view = self.navigationController?.view {
            let reciept = NotifyCocktailView.makeAlcohol(.Error(title: "Как на счет водки?",
                subtitle:"Во́дка — крепкий алкогольный напиток, бесцветный водно-спиртовой раствор с характерным вкусом и спиртовым запахом."))
            glass.pour(reciept, inView: view)
        }
    }
    
    @IBAction func closeSelf(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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

