//
//  YVSplashView.swift
//  YVSplashView
//
//  Created by Yevhenii Veretennikov on 7/30/17.
//  Copyright © 2017 CREATE COURAGE. All rights reserved.
//

import Foundation
import UIKit

public typealias YVSplashCompletion = () -> Void

protocol YVSplashAnimatable: class {
    var imageView: UIImageView? { get set }
    var duration: CGFloat { get set }
    var delay: CGFloat { get set }
    var repeatCount: Float { get set }
    func animate(_ completion: YVSplashCompletion?)
}

class YVSplashView: UIView, YVSplashAnimatable {
    
    open var delay: CGFloat = 0
    open var duration: CGFloat = 1.3
    open var repeatCount: Float = 2
    open var imageView: UIImageView?
    open var splashImge: UIImage? {
        didSet {
            guard let imageView = imageView else { return }
            guard let image = splashImge else { return }
            imageView.image = image
        }
    }
    open var imageColor: UIColor = .black {
        didSet {
            guard let imageView = imageView else { return }
            imageView.tintColor = imageColor
        }
    }
    
    var splashImageView: UIImageView?
    
    public init(image: UIImage, size: CGSize, color: UIColor) {
        
        super.init(frame: UIScreen.main.bounds)
        
        imageView = UIImageView()
        imageView?.image = image
        imageView?.frame = CGRect(origin: .zero, size: size)
        imageView?.contentMode = .scaleAspectFit
        imageView?.center = center
        imageView?.tintColor = imageColor
        
        addSubview(imageView!)
        
        backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YVSplashView {
    func animate(_ completion: YVSplashCompletion? = nil) {
        
        CATransaction.begin()
        
        if let completion = completion {
            CATransaction.setCompletionBlock({
                self.zoomOutAnimation { completion() }
            })
        }
        animation()
        CATransaction.commit()
        
    }
    
    fileprivate func zoomOutAnimation(_ completion: YVSplashCompletion? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.imageView!.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }) { (isFinished) in
            self.removeFromSuperview()
            completion?()
        }
    }
    
    func animation() {
        let popForce = 0.5
        
        guard let imageView = imageView else { return }
        
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [0, 0.1 * popForce, 0.015 * popForce, 0.2 * popForce, 0]
        animation.keyTimes = [0, 0.25, 0.35, 0.55, 1]
        animation.duration = CFTimeInterval(duration/2)
        animation.isAdditive = true
        animation.repeatCount = repeatCount
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay/3)
        imageView.layer.add(animation, forKey: "scale")
    }
}
