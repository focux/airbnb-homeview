//
//  Extension.swift
//  AnimateHeader
//
//  Created by Leonardo Dominguez on 8/26/17.
//  Copyright © 2017 Leonardo Dominguez. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, left: NSLayoutXAxisAnchor?, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, leftConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        _ = anchors.map { $0.isActive = true }
        
        return anchors
        
    }
    
    func centerInView() -> [NSLayoutConstraint] {
        var centerAnchors = [NSLayoutConstraint]()
        translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = centerXAnchor.constraint(equalTo: (superview?.centerXAnchor)!)
        centerAnchors.append(centerX)
        
        let centerY = centerYAnchor.constraint(equalTo: (superview?.centerYAnchor)!)
        centerAnchors.append(centerY)
        
        _ = centerAnchors.map({ $0.isActive = true })
        
        return centerAnchors
    }
}
