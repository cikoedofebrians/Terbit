//
//  MyRoutineRouter.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import Foundation
import Observation
import SwiftUI


@Observable

class BaseRouter<T: Equatable> {
    var path: [T] = [] {
        didSet {
            if path.count == 0 && tabBarVisibility == .hidden {
                turnOnTabBar()
            }
        }
    }
    
    var tabBarVisibility: Visibility = .visible
    
    func turnOffTabBar() {
            tabBarVisibility = .hidden
    }
    
    func turnOnTabBar() {
            tabBarVisibility = .visible
    }
    
    func push(_ screen: T) {
        path.append(screen)
    }
    
    func pop(_ screen: T) {
        if (path.count > 1) {
            path.removeLast()
        }
    }
    
    func popUntil(_ screen: T) {
        while (path.last != screen) {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
}



class MyRoutineRouter: BaseRouter<MyRoutineViewEnum> {}

class HistoryRouter: BaseRouter<HistoryViewEnum> {}
