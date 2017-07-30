//
//  ViewController.swift
//  YVSplash
//
//  Created by Yevhenii Veretennikov on 7/30/17.
//  Copyright © 2017 CREATE COURAGE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = YVSplashView(image: #imageLiteral(resourceName: "genius").withRenderingMode(.alwaysTemplate), size: CGSize(width: 100, height: 100), color: .black)
        view.delay = 2
        view.duration = 1.5
        view.repeatCount = 3
        view.imageColor = .white
        
        view.animate({
            print("DONE")
        })
        
        self.view.addSubview(view)
    }
}

