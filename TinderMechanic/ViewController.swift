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
    
    
    // enumeration of states
    
    enum CardSelectionState {
        
        case NoSelection
        case SwipingLeft
        case SwipedLeft
        case SwipingRight
        case SwipedRight

    }
    

    var xFromCenter:CGFloat = 0
//    var label:UILabel!
     @IBOutlet weak var imageView:UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    var frame: CGRect!
    
    @IBOutlet weak var cardBackgroundView: UIView!
    var cardSelectionState:CardSelectionState = .NoSelection
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frame = CGRectZero
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
        
        
        
//        imageView = UIImageView(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 100, 200, 200))
//        // default image for our user
        imageView.image = UIImage(named: "mario.jpg")
//
//        // giving the image a circle style
//        // add a corner radius to our image
//        imageView.layer.cornerRadius = imageView.frame.size.width / 2
//        imageView.clipsToBounds = true
////        self.view.addSubview(imageView)
//        
//        // add the gesture recognizer code
//        // add a gesture recogniser that pans the object
////        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
//        
//        // add the gesture to the imageView
////        imageView.addGestureRecognizer(gesture)
//        imageView.userInteractionEnabled = true
        
    }
    
    // add a viewDidAppear function for each time the viewDidAppear
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        styleMyViews()
        
    }
    
    // add a function to style the views
    func styleMyViews() {
        // round the corner on the card
        cardBackgroundView.layer.cornerRadius = 5
        
    }
    
    
    @IBAction func cardWasDragged(sender: UIPanGestureRecognizer) {
        println("The card was dragged")
        
        
        let translation = sender.translationInView(self.view)
        // get what has been dragged
        var profile = sender.view!
        xFromCenter += translation.x
        var scale = min(100 / abs(xFromCenter), 1)
        
        
        // remove the translation along the Y access so it only moves left and right
        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y)
        //        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y + translation.y)
        
        // reset translation
        sender.setTranslation(CGPointZero, inView: self.view)
        
        // rotate the label/image
        var rotation:CGAffineTransform = CGAffineTransformMakeRotation(translation.x / 200)
        // stretch the view
        var stretch:CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
        // stretch the label/image
        //        imageView.transform = stretch
        // check whether or not someone is chosen
        if profile.center.x < 100 {
            println("not chosen")
            cardSelectionState = .SwipingLeft
            // do nothing
            if profile.center.x < 20 {
                cardSelectionState = .SwipedLeft
            }
        } else {
            println("chosen")
            cardSelectionState = .SwipingRight
            // we could add the chosen user to parse
            if profile.center.x > 300 {
                cardSelectionState = .SwipedRight
            }
        }
        // when the gesture state has ended
        if sender.state == UIGestureRecognizerState.Ended {
    
            switch cardSelectionState {
                
            case .NoSelection:
                println("No Selecdtion")

            case .SwipingLeft:
                println("Left swping")

            case .SwipedLeft:
                println("Left swiped")
 
            case .SwipingRight:
                println("Right swiping")
                
            case .SwipedRight:
                println("Right swiped")
    
            }
//            // set the label/image back
//            profile.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
//            
//            // undo the scale
//            scale = max(abs(xFromCenter) / 100, 1)
//            // undo any rotations
//            rotation = CGAffineTransformMakeRotation(0)
//            
//            // stretch the current view back to normal
//            stretch = CGAffineTransformScale(rotation, scale, scale)
//            
//            
            // set the label or image to the original size after scaling
            UIView.animateWithDuration( 0.3, animations: { () -> Void in
                profile.frame = CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 140, 200, 200)
                }, completion: { (sucess) -> Void in
                    // once the animation is done, the state of the card is back to .NoSelection
                    self.cardSelectionState = .NoSelection
            })
        }
        
        // TODO: load next image
        
    }


    // creating the function for wasDragged that passes in a UIPanGestureRecogniszer
//    func wasDragged(gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translationInView(self.view)
//        // get what has been dragged
//        var profile = gesture.view!
//        xFromCenter += translation.x
//        var scale = min(100 / abs(xFromCenter), 1)
//        
//        
//        // remove the translation along the Y access so it only moves left and right
//        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y)
////        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y + translation.y)
//        
//        // reset translation
//        gesture.setTranslation(CGPointZero, inView: self.view)
//        
//        // rotate the label/image
//        var rotation:CGAffineTransform = CGAffineTransformMakeRotation(translation.x / 200)
//        // stretch the view
//        var stretch:CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
//        // stretch the label/image
////        imageView.transform = stretch
//        // check whether or not someone is chosen
//        if profile.center.x < 100 {
//            println("not chosen")
//            // do nothing
//        } else {
//            println("chosen")
//            // we could add the chosen user to parse
//        }
//        // when the gesture state has ended
//        if gesture.state == UIGestureRecognizerState.Ended {
//            // set the label/image back
//            profile.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
//            
//            // undo the scale
//            scale = max(abs(xFromCenter) / 100, 1)
//            // undo any rotations
//            rotation = CGAffineTransformMakeRotation(0)
//            
//            // stretch the current view back to normal
//            stretch = CGAffineTransformScale(rotation, scale, scale)
//            
//            
//            // set the label or image to the original size after scaling
//            UIView.animateWithDuration( 0.3, animations: { () -> Void in
//                self.imageView.frame = CGRectMake(self.view.bounds.width / 2, self.view.bounds.height / 2 - 40, profile.frame.size.width, profile.frame.size.height)
//            }, completion: { (sucess) -> Void in
//                
//            })
//        }
//        
//    }

}

