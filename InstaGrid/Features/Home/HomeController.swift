//
//  ViewController.swift
//  InstaGrid
//
//  Created by wassime lotfi on 19/01/2023.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var centerBlocView: UIView!
    @IBOutlet var selectedOrHiddenViews: [UIView]!
    
    @IBOutlet var selectedImageViews: [UIImageView]!
    
    @IBOutlet var imageViewsButton: [UIButton]!
    
    @IBOutlet var constraintsToDisable: [NSLayoutConstraint]!
    

    @IBOutlet weak var swipeUpToShareStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeLayoutButtonIsTapped(_ sender: UIButton) {
        constraintsToDisable.forEach {
            $0.isActive = true
        }
        
        let buttonTag = sender.tag
        let itsFirstButton = buttonTag == 0
        let itsSecondButton = buttonTag == 1
        
        // update selectedImageView
        
        selectedImageViews.forEach { $0.isHidden = true }
        selectedImageViews[buttonTag].isHidden = false
        
        // update grid layout of centerBloc
        
        selectedOrHiddenViews.forEach {
            $0.isHidden = false
        }
        
        if itsFirstButton {
            selectedOrHiddenViews[1].isHidden = true
        }
        
        if itsSecondButton {
            selectedOrHiddenViews[3].isHidden = true
        }
    }
    
    // MARK: - Swipe up
    
    // TO CHECK: Why swipe doesn't work when we swipe from buttons
    
    @IBAction func swipeUpToShare(_ sender: UISwipeGestureRecognizer) {
        imageViewsButton.forEach {
            $0.isEnabled = false
        }
        imageViewsButton.forEach {
            $0.isUserInteractionEnabled = false
        }
        if UIDevice.current.orientation == .portrait{
            sender.direction = .up
            if sender.direction == .up {
                let upView = CGAffineTransform(translationX: 0, y: -(self.centerBlocView.frame.origin.y + self.centerBlocView.bounds.height))
                let upStackView = CGAffineTransform(translationX: 0, y: -(self.swipeUpToShareStack.frame.origin.y + self.swipeUpToShareStack.bounds.height)*1.7)
                
                print("commence")
                UIView.animate(withDuration: 0.7, delay: 0, animations: {
                    self.centerBlocView.transform = upView
                    self.swipeUpToShareStack.transform = upStackView
                }, completion: { finished in
                    if finished {
                        self.centerBlocView.transform = CGAffineTransform.identity
                        self.swipeUpToShareStack.transform = CGAffineTransform.identity
                        self.imageViewsButton.forEach {
                            $0.isEnabled = true
                        }
                        self.imageViewsButton.forEach {
                            $0.isUserInteractionEnabled = true
                        }
                    }
                    print("fini")
                })
            }
        }
        
    }
    
    @IBAction func swipeLeftToShare(_ sender: UISwipeGestureRecognizer) {
            if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            sender.direction = .left
            if sender.direction == .left{
                let leftView = CGAffineTransform(translationX: -(self.centerBlocView.frame.origin.x + self.centerBlocView.bounds.height), y:0)
                let leftStackView = CGAffineTransform(translationX: -(self.swipeUpToShareStack.frame.origin.x + self.swipeUpToShareStack.bounds.height)*1.7, y: 0)
    
                UIView.animate(withDuration: 0.7, delay: 0, animations: {
                    self.centerBlocView.transform = leftView
                    self.swipeUpToShareStack.transform = leftStackView
                }, completion: { finisher in
                    if finisher {
                        self.centerBlocView.transform = CGAffineTransform.identity
                        self.swipeUpToShareStack.transform = CGAffineTransform.identity
                        self.imageViewsButton.forEach {
                            $0.isEnabled = true
                        }
                        self.imageViewsButton.forEach {
                            $0.isUserInteractionEnabled = true
                        }
                    }
                })
            }
    
    
        }
    }
   
    
    
    @IBAction func imageViewButtonIsTapped(_ sender: Any) {
        print("buttonIsTapped")
    }
}


