//
//  Store.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation
import Combine
import UIKit

class Store: ObservableObject {
    @Published var state = AppState()
    var publishers = [AnyCancellable]()
    init() {
        dispatch(.launching)
        dispatch(.tabbar)
        dispatch(.reminderNotification)
        dispatch(.adRequestConfig)
    }
    
    func dispatch(_ action: AppAction) {
        debugPrint("[Action] \(action)")
        let result = Store.reduce(state, action: action)
        state = result.0
        let command = result.1
        command?.execute(in: self)
    }
}

extension Store {
    static func reduce(_ state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var command: AppCommand? = nil
        switch action {
        case .background(let isBackground):
            appState.root.enterbackground = isBackground
        case .tabbar:
            command = TabBarCommand()
        case .launch(let isLaunch):
            appState.root.item = isLaunch ? .launch : .home
        case .launching:
            appState.root.progress = 0.0
            command = LaunchCommand()
        case .progress(let progress):
            appState.root.progress = progress
            
        case .animationProgress(let progress):
            appState.record.progress = progress
        case .drinkMax(let max):
            appState.record.drinkMax = max
        case .animation:
            command = DashboardCommand()
        case .addDrink(let model):
            var list = appState.record.drinkList ?? []
            list.append(model)
            appState.record.drinkList = list
            
        case .chartSelect(let item):
            appState.charts.item = item
        case .addReminder(let item):
            var list = appState.reminder.list ??  appState.reminder.defauolt
            if let index = list.firstIndex(of: item) {
                list[index] = item
                list = list.sorted { m1, m2 in
                    return m1 < m2
                }
            } else {
                list.append(item)
                list = list.sorted { m1, m2 in
                    return m1 < m2
                }
            }
            appState.reminder.list = list
            NotificationUtil.shared.appendReminder(item)
            
        case .deleteReminder(let str):
            appState.reminder.list = appState.reminder.list?.filter({ it in
                return str != it
            })
            NotificationUtil.shared.deleteNotifications(str)
            
        case .reminderNotification:
            command = ReminderCommand()
            
        case .adRequestConfig:
            command = GADRemoteConfigCommand()
        case .adUpdateConfig(let config):
            appState.ad.config = config
        case .adUpdateLimit(let state):
            command = GADUpdateLimitCommand(state)
        case .adAppear(let position):
            command = GADAppearCommand(position)
        case .adDisappear(let position):
            command = GADDisappearCommand(position)
        case .adClean(let position):
            command = GADCleanCommand(position)
        
        case .adLoad(let position, let p):
            appState.ad.position = p
            command = GADLoadCommand(position, p)
        case .adShow(let position, let p, let completion):
            command = GADShowCommand(position, p, completion)
            
        case .adNativeImpressionDate(let p):
            appState.ad.impressionDate[p] = Date()
        case .adModel(let model):
            appState.root.adModel = model
            
        case .dismiss:
            command = DismissCommand()
        }
        return (appState, command)
    }
}

