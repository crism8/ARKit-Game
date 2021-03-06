//
//  UIView+PinEdges.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 31/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

extension UIView {
    func pinAllEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    func pinEdgesToLeft(to other: UIView) {
        leftAnchor.constraint(equalTo: other.leftAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    func pinEdgesToRight(to other: UIView) {
        rightAnchor.constraint(equalTo: other.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    func pinLeftRight(to other: UIView, offset: CGFloat) {
        rightAnchor.constraint(equalTo: other.rightAnchor, constant: -offset).isActive = true
        leftAnchor.constraint(equalTo: other.leftAnchor, constant: offset).isActive = true
    }
    func pinTopLeftRight(to other: UIView) {
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        rightAnchor.constraint(equalTo: other.rightAnchor).isActive = true
        leftAnchor.constraint(equalTo: other.leftAnchor).isActive = true
    }
    
    func pinBottomLeftRight(to other: UIView) {
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: other.rightAnchor).isActive = true
        leftAnchor.constraint(equalTo: other.leftAnchor).isActive = true
    }
    
    func pinTopBottom(to other: UIView) {
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    
    func centerXY(to other: UIView) {
        centerXAnchor.constraint(equalTo: other.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: other.centerYAnchor).isActive = true
    }
}
