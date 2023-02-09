//
//  ViewController.swift
//  InstaGrid
//
//  Created by wassime lotfi on 19/01/2023.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet var selectedImageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeLayoutButtonIsTapped(_ sender: UIButton) {
        selectedImageViews.forEach { $0.isHidden = true }
        selectedImageViews[sender.tag].isHidden = false
    }
}

