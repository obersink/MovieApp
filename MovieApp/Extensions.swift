//
//  Extensions.swift
//  MovieApp
//
//  Created by Simon Zhen on 5/2/17.
//  Copyright © 2017 Simon Zhen. All rights reserved.
//

import UIKit

@IBDesignable class PaddedLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}

@IBDesignable extension UIView {
    
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
}

//@IBDesignable class BorderedView: UIView {
//    
//    @IBInspectable var borderWidth: CGFloat = 0
//    
//    override func draw(_ layer: CALayer, in ctx: CGContext) {
//        <#code#>
//    }
//    
//    override var layer: CALayer {
//        get {
//            
//            
//            var clayer = super.layer
//            clayer.borderColor = UIColor.darkGray.cgColor
//            clayer.borderWidth = borderWidth
//            return clayer
//        }
//    }
//}
