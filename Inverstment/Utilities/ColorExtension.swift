//
//  ColorExtension.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

extension UIColor {
    static let blackColor = UIKit.UIColor.init(netHex: 0x1A1A1A)
    static let redColor = UIKit.UIColor.init(netHex: 0xB22424)
    static let greenColor = UIKit.UIColor.init(netHex: 0x24B25D)
    static let grayColor = UIKit.UIColor.init(netHex: 0xF1F4F7)
    static let grayTextColor = UIKit.UIColor.init(netHex: 0xBABABA)
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

