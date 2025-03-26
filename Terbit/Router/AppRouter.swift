//
//  AppRouter.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import Foundation
import Observation
import SwiftUI

@Observable
class AppRouter {
    var path: [TerbitScreenEnum] = []
    
    func push(_ screen: TerbitScreenEnum) {
        path.append(screen)
    }
    
    func pop(_ screen: TerbitScreenEnum) {
        if (path.count > 1) {
            path.removeLast()
        }
    }
    
    func popUntil(_ screen: TerbitScreenEnum) {
        while (path.last != screen) {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
