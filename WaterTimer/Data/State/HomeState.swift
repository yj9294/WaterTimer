//
//  HomeState.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

extension AppState {
    struct Home {
        var item: Index = .dashboard
        enum Index {
            case dashboard, statistics, reminder
            
            var title: String {
                switch self {
                case .dashboard:
                    return "home"
                case .statistics:
                    return "statistics"
                case .reminder:
                    return "reminder"
                }
            }
            
            var image: String {
                return title
            }
        }
    }
}
