//
//  ReminderCommand.swift
//  WaterTimer
//
//  Created by yangjian on 2023/9/1.
//

import Foundation

struct ReminderCommand: AppCommand {
    func execute(in store: Store) {
        
        NotificationUtil.shared.register { granted in
            if granted {
                store.state.reminder.list?.forEach({ item in
                    NotificationUtil.shared.appendReminder(item)
                })
            }
        }
    }
}
