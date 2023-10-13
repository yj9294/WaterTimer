//
//  TabBarCommand.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation
import UIKit

class TabBarCommand: AppCommand {
    func execute(in store: Store) {
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "#464646")!]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.stackedLayoutAppearance = itemAppearance
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
