//
//  DashboardCommand.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

struct DashboardCommand: AppCommand {
    func execute(in store: Store) {
        let drinkMax = store.state.record.drinkMax ?? 2000
        let today = store.state.record.todayDrink
        
        let token = SubscriptionToken()
        var progress = 0.0
        let duration = 3.0
        if today == 0 {
            return
        }
        Timer.publish(every: 0.01, on: .main, in: .common).autoconnect().sink { _ in
            let radio = 0.01 / duration
            progress += radio
            if progress >= Double(today) / Double(drinkMax) || progress >= 1 {
                token.unseal()
                store.dispatch(.animationProgress(Int(progress * 1000)))
                return
            }
            store.dispatch(.animationProgress(Int(progress * 1000)))
        }.seal(in: token)
    }
}
