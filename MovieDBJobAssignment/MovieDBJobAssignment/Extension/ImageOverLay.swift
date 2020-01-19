//
//  ImageOverLay.swift
//  MovieDBJobAssignment
//
//  Created by Zin Min on 19/01/2020.
//  Copyright © 2020 Zin Min. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    func addOverlay() {
      
        let mGradient = CAGradientLayer()
        mGradient.frame = self.frame
        var colors = [CGColor]()
        colors.append(UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor)
        colors.append(UIColor(red: 255, green: 255, blue: 255, alpha: 0.98).cgColor)
        mGradient.startPoint = CGPoint(x: 0.3, y: 0.3)
        mGradient.endPoint = CGPoint(x: 0.3, y: 0.7)
        mGradient.colors = colors

        if self.viewWithTag(1) == nil {
            self.layer.addSublayer(mGradient)
        }
    }
    
}
