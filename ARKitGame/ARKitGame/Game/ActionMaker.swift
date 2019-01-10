//
//  ActionMaker.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 10/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit
import SceneKit

class ActionMaker: NSObject {

    var actions = [SCNAction]()
    let animationDuration = 2.0

         func moveAlong(path: UIBezierPath) -> SCNAction {
            
            let points = path.elements
            
            for point in points {
                self.makeActionsForPoint(point: point)
            }

            /*for point in (points).reversed() {
                self.makeActionsForPoint(point: point)
            }*/
            return SCNAction.sequence(self.actions)
        }
        
        func makeActionsForPoint(point: PathElement) {
            switch point {
            case .moveToPoint(let a):
                let moveAction = SCNAction.move(to: SCNVector3(a.x, a.y, 0), duration: animationDuration)
                self.actions.append(moveAction)
                break
                
            case .addCurveToPoint(let a, let b, let c):
                let moveAction1 = SCNAction.move(to: SCNVector3(a.x, a.y, 0), duration: animationDuration)
                let moveAction2 = SCNAction.move(to: SCNVector3(b.x, b.y, 0), duration: animationDuration)
                let moveAction3 = SCNAction.move(to: SCNVector3(c.x, c.y, 0), duration: animationDuration)
                self.actions.append(moveAction1)
                self.actions.append(moveAction2)
                self.actions.append(moveAction3)
                break
                
            case .addLineToPoint(let a):
                let moveAction = SCNAction.move(to: SCNVector3(a.x, a.y, 0), duration: animationDuration)
                self.actions.append(moveAction)
                break
                
            case .addQuadCurveToPoint(let a, let b):
                let moveAction1 = SCNAction.move(to: SCNVector3(a.x, a.y, 0), duration: animationDuration)
                let moveAction2 = SCNAction.move(to: SCNVector3(b.x, b.y, 0), duration: animationDuration)
                self.actions.append(moveAction1)
                self.actions.append(moveAction2)
                break
                
            default:
                let moveAction = SCNAction.move(to: SCNVector3(0, 0, 0), duration: animationDuration)
                self.actions.append(moveAction)
                break
            }
        }
}

public extension UIBezierPath {
    
    var elements: [PathElement] {
        var pathElements = [PathElement]()
        withUnsafeMutablePointer(to: &pathElements) { elementsPointer in
            cgPath.apply(info: elementsPointer) { (userInfo, nextElementPointer) in
                let nextElement = PathElement(element: nextElementPointer.pointee)
                let elementsPointer = userInfo!.assumingMemoryBound(to: [PathElement].self)
                elementsPointer.pointee.append(nextElement)
            }
        }
        return pathElements
    }
}

public enum PathElement {
    
    case moveToPoint(CGPoint)
    case addLineToPoint(CGPoint)
    case addQuadCurveToPoint(CGPoint, CGPoint)
    case addCurveToPoint(CGPoint, CGPoint, CGPoint)
    case closeSubpath
    
    init(element: CGPathElement) {
        switch element.type {
        case .moveToPoint: self = .moveToPoint(element.points[0])
        case .addLineToPoint: self = .addLineToPoint(element.points[0])
        case .addQuadCurveToPoint: self = .addQuadCurveToPoint(element.points[0], element.points[1])
        case .addCurveToPoint: self = .addCurveToPoint(element.points[0], element.points[1], element.points[2])
        case .closeSubpath: self = .closeSubpath
        }
    }
}
