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
        
        constraintsToDisable.forEach {
            $0.isActive = false
        }
        
        imageViewsButton.forEach {
            $0.isUserInteractionEnabled = false
        }
        
        if sender.direction == .up {
            UIView.animate(withDuration: 1, delay: 0, animations: {
                self.centerBlocView.frame.origin.y -= (self.centerBlocView.frame.origin.y + self.centerBlocView.bounds.height)
            }, completion: { isFinished in
                if isFinished {
                    self.imageViewsButton.forEach {
                        $0.isUserInteractionEnabled = true
                    }
                }
            })
        }
    }
    
    @IBAction func imageViewButtonIsTapped(_ sender: Any) {
        print("buttonIsTapped")
    }
}

