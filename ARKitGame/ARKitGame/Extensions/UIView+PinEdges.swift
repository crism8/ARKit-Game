//
//  UIView+PinEdges.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 31/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}
