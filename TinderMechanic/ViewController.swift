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
    
    enum CardSelectionState:String {
        
        case NoSelection = "No Selection"
        case SwipingLeft = "Swiping Left"
        case SwipedLeft = "Swiped Left"
        case SwipingRight = "Swiping Right"
        case SwipedRight = "Swiped Right"

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
        





//        imageView = UIImageView(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 100, 200, 200))
//        // default image for our user
        imageView.image = UIImage(named: "mario.jpg")
//
//        // giving the image a circle style
//        // add a corner radius to our image
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
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
        styleMyViewsForNewUsers()
        
    }
    
    // add a function to style the views
    func styleMyViewsForNewUsers() {
        // round the corner on the card
        cardBackgroundView.layer.cornerRadius = 5
        setupViewForUser()
        
    }
    
    func setupViewForUser() {
            userName.text = "Hawt Guy"
    }
    
    
    @IBAction func cardWasDragged(sender: UIPanGestureRecognizer) {
        println("The card was dragged")
        
        if sender.state == UIGestureRecognizerState.Began {
            frame = sender.view?.frame
        }
        let translation = sender.translationInView(self.view)
        // get what has been dragged
        var profile = sender.view!
        xFromCenter += translation.x
//        var scale = min(100 / abs(xFromCenter), 1)
        
        
        // remove the translation along the Y access so it only moves left and right
        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y)
        //        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y + translation.y)
        
        // reset translation
        sender.setTranslation(CGPointZero, inView: self.view)
        
        // rotate the label/image
        var rotation:CGAffineTransform = CGAffineTransformMakeRotation(translation.x / 200)
        // stretch the view
//        var stretch:CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
        // stretch the label/image
//                imageView.transform = stretch
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
                println("No Selection")

            case .SwipingLeft:
                println("Left swiping gesture")

            case .SwipedLeft:
                println("Left swiped gesture")
 
            case .SwipingRight:
                println("Right swiping gesture")
                
            case .SwipedRight:
                println("Right swiped gesture")
    
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
                profile.frame = self.frame
                }, completion: { (completed) -> Void in
                    if (completed) {
                        switch self.cardSelectionState {
                        case .NoSelection:
                            println("No selection, something went wrong!")
                        case .SwipedRight:
                            println("I liked the person")
                            self.personIsSelected()
                        case .SwipedLeft:
                            println("I didn't like the person")
                            self.personIsNotSelected()
                        default:
                            println("default state of the switch")
                            
                        }
                        
               
                    }
                    // once the animation is done, the state of the card is back to .NoSelection
                    self.cardSelectionState = .NoSelection
            })
        }
        
        // TODO: load next image
        
    }
    
    func personIsSelected() {
        println("You've been selected")
        let popup = UIAlertController(title: "You've been selected", message: "Please selecte me back", preferredStyle: UIAlertControllerStyle.ActionSheet)
    
        
    }
    
    func personIsNotSelected() {
        println("You have not been selected")
    }
    
    func resetCards() {
        
    }

}

