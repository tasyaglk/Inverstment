//
//  UISegmentedControlExtension.swift
//  Inverstment
//
//  Created by Тася Галкина on 05.05.2025.
//

import UIKit

extension UISegmentedControl {
    
    func removeBorder(){
        
        let backgroundImage = UIImage()
        
        
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        

        let divisorImage = UIImage()
        
        self.setDividerImage(divisorImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
}
