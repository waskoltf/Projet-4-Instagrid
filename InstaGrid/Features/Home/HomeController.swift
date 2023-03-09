//
//  ViewController.swift
//  InstaGrid
//
//  Created by wassime lotfi on 19/01/2023.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var swipeUpToShareStack: UIStackView!
    
    @IBOutlet weak var centerBlocView: UIView!
    @IBOutlet var centerBlocViews: [UIView]!
    @IBOutlet var centerBlocImageViews: [UIImageView]!
    @IBOutlet var centerBlocButtons: [UIButton]!
    @IBOutlet var selectedImageViews: [UIImageView]!
    
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    private var selectedImageViewIndex: Int = 0
    
    // MARK: - Find a way to detect UIDevice.current.orientation position at launch
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSwipeGestureDirection()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateSwipeGestureDirection()
    }
    
    // MARK: - IBActions
    
    @IBAction func changeLayoutButtonIsTapped(_ sender: UIButton) {
        let buttonTag = sender.tag
        let itsFirstButton = buttonTag == 0
        let itsSecondButton = buttonTag == 1
        
        // update selectedImageView
        
        selectedImageViews.forEach { $0.isHidden = true }
        selectedImageViews[buttonTag].isHidden = false
        
        // update grid layout of centerBloc
        
        centerBlocViews.forEach {
            $0.isHidden = false
        }
        
        if itsFirstButton {
            centerBlocViews[1].isHidden = true
        }
        
        if itsSecondButton {
            centerBlocViews[3].isHidden = true
        }
    }
    
    // MARK: - Swipe up
    
    @IBAction func swipeUpToShare(_ sender: UISwipeGestureRecognizer) {
        centerBlocButtons.forEach {
            $0.isEnabled = false
            $0.isUserInteractionEnabled = false
        }
        
        let centerBlocOrigin = centerBlocView.frame.origin
        let centerBlocHeight = centerBlocView.bounds.height
        let upStackViewDirection = -(swipeUpToShareStack.frame.origin.x + swipeUpToShareStack.bounds.height) * 1.7
        
        var upView = CGAffineTransform(translationX: 0, y: -(centerBlocOrigin.y + centerBlocHeight))
        var upStackView = CGAffineTransform(translationX: 0, y: upStackViewDirection)
        
        if swipeGesture.direction == .left {
            upView = CGAffineTransform(translationX: -(centerBlocOrigin.x + centerBlocHeight), y: 0)
            upStackView = CGAffineTransform(translationX: upStackViewDirection, y: 0)
        }
        
        UIView.animate(withDuration: 0.7, delay: 0, animations: {
            self.centerBlocView.transform = upView
            self.swipeUpToShareStack.transform = upStackView
        }, completion: { finished in
            if !finished { return }
            self.presentActivityController()
        })
    }
    
    @IBAction func imageViewButtonIsTapped(_ sender: UIButton) {
        selectedImageViewIndex = sender.tag
        print("sender.tag: \(sender.tag)")
        print("buttonIsTapped")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        self.present(imagePickerController,animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension HomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        centerBlocImageViews[selectedImageViewIndex].image = image
        picker.dismiss(animated: true)
    }
}

// MARK: - Convenience Methods

extension HomeController {
    
    private func updateSwipeGestureDirection() {
        let isLandscape = UIDevice.current.orientation.isLandscape
        swipeGesture.direction = isLandscape ? .left : .up
    }
    
    private func presentActivityController() {
        let image = getImageFromCenterBlocView()
        let shareSheetVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        self.present(shareSheetVC, animated: true) {
            // Définir le completion handler pour déclencher lorsque l'utilisateur a fini de partager ou de fermer le share sheet
            shareSheetVC.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
                // Vérifier si l'utilisateur a terminé l'action de partage ou a fermé la feuille de partage
                if completed || activityType == nil {
                    self.resetCenterBlocView()
                }
            }
        }
    }
    
    private func resetCenterBlocView() {
        UIView.animate(withDuration: 0.7, animations: {
            self.centerBlocView.transform = .identity
            self.swipeUpToShareStack.transform = .identity
        }, completion: { finished in
            self.centerBlocButtons.forEach {
                $0.isEnabled = true
                $0.isUserInteractionEnabled = true
            }
        })
    }
    
    // MARK: - Transformer le bloc CenterBlocView en image
    private func getImageFromCenterBlocView() -> UIImage {
        return UIImage(named : "Icon")!
    }
}
