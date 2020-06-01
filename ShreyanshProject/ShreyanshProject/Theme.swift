//
//  Theme.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 01/06/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class HexToUIColor {
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


class Theme {
    
    enum Colours {
        case backgroundColor
        
    }
    
    static func color(type: Colours) -> UIColor {
        
        
        guard let hexStringBackGroundColor: String = UserDefaults.standard.object(forKey: "backgroundColour") as? String else { return UIColor(red: 100, green: 255, blue: 255, alpha: 1) }
        
        let backgroundColour: UIColor = HexToUIColor.hexStringToUIColor(hex: hexStringBackGroundColor)
        
        
        switch type {
        case .backgroundColor:
            return backgroundColour
        }
    }
}

