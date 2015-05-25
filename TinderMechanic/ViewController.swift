//
//  ViewController.swift
//  TinderMechanic
//
//  Created by Yung Dai on 2015-05-25.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //draw the label on the ViewController
        var label:UILabel = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100))
        label.text = "Drag Me"
        label.textAlignment = NSTextAlignment.Center
        // add the label as a subView onto the viewcontroller
        self.view.addSubview(label)
        
        // add a gesture recogniser that pans the object
        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged"))
        
        // add the gesture to the label
        label.addGestureRecognizer(gesture)
        label.userInteractionEnabled = true
    }


    // creating the function for wasDragged
    
    func wasDragged() {
        println("dragged")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

