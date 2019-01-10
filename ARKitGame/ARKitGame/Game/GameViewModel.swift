//
//  GameViewModel.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 09/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import Foundation
import UIKit
//import SwiftIconFont

class FeedListViewModel {
    let score = Observable<Int>(value: 0)
    let isLoading = Observable<Bool>(value: false)
    let time = Observable<TimeInterval>(value: 30)
    let effectPaths = Observable<[String]>(value: [])
}
