//
//  ReminderState.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

extension AppState {
    struct Reminder{
        
        let defauolt: [String] = ["08:00", "10:00", "12:00", "14:00", "16:00", "18:00", "20:00"]
        
        @UserDefault(key: "reminder.list")
        var list: [String]?
    }
}
