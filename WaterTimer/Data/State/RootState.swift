//
//  RootState.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

extension AppState {
    struct Root {
        var item: Index = .launch
        var progress: Double = 0.0
        var adModel: GADNativeViewModel = .None
        var enterbackground = false
        enum Index {
            case launch, home
        }
    }
}
