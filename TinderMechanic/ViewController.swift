//
//  ViewController.swift
//  TinderMechanic
//
//  Created by Yung Dai on 2015-05-25.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // global variable declarations
    var xFromCenter:CGFloat = 0
//    var label:UILabel!
    var imageView:UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //draw the label on the ViewController
        /*
        label = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100))
        label.text = "Drag Me"
        label.textAlignment = NSTextAlignment.Center
        // add the label as a subView onto the viewcontroller
        self.view.addSubview(label)
        
        // add a gesture recogniser that pans the object
        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        
        // add the gesture to the label
        label.addGestureRecognizer(gesture)
        label.userInteractionEnabled = true
        */
        
        imageView = UIImageView(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 100, 200, 200))
        // default image for our user
        imageView.image = UIImage(named: "mario.jpg")
        
        // giving the image a circle style
        // add a corner radius to our image
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        // add the gesture recognizer code
        // add a gesture recogniser that pans the object
        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        
        // add the gesture to the imageView
        imageView.addGestureRecognizer(gesture)
        imageView.userInteractionEnabled = true
        
    }


    // creating the function for wasDragged that passes in a UIPanGestureRecogniszer
    func wasDragged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translationInView(self.view)
        // get what has been dragged
        var profile = gesture.view!
        xFromCenter += translation.x
        var scale = min(100 / abs(xFromCenter), 1)
        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y + translation.y)
        
        // reset translation
        gesture.setTranslation(CGPointZero, inView: self.view)
        
        // rotate the label/image
        var rotation:CGAffineTransform = CGAffineTransformMakeRotation(translation.x / 200)
        // stretch the view
        var stretch:CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
        // stretch the label/image
//        imageView.transform = stretch
        // check whether or not someone is chosen
        if profile.center.x < 100 {
            println("not chosen")
            // do nothing
        } else {
            println("chosen")
            // we could add the chosen user to parse
        }
        // when the gesture state has ended
        if gesture.state == UIGestureRecognizerState.Ended {
            // set the label/image back
            profile.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
            
            // undo the scale
            scale = max(abs(xFromCenter) / 100, 1)
            // undo any rotations
            rotation = CGAffineTransformMakeRotation(0)
            
            // stretch the current view back to normal
//            stretch = CGAffineTransformScale(rotation, scale, scale)
            
            // set the label or image to the original size after scaling
            imageView.frame = CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 100, 200, 200)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

