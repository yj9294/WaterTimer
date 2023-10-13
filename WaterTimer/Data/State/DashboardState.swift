//
//  DashboardState.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

extension AppState {
    struct Dashboard {
        enum Index: String {
            case record, total
            var title: String {
                switch self {
                case .record:
                    return "Record"
                case .total:
                    return "Daily Goal"
                }
            }
            var editImage: String {
                return "home_\(self.rawValue)_edit"
            }
            var backgroundImage: String {
                return "home_\(self.rawValue)_bg"
            }
        }
    }
}
