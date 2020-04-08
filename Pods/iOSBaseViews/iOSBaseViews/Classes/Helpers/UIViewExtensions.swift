//
//  UIViewExtension.swift
//  iOSBaseViews
//
//  Created by Nik on 07/01/2020.
//

import Foundation

public extension UIView {
    class func clearView() -> UIView {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
