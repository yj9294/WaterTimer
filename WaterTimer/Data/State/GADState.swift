//
//  GADState.swift
//  WaterTimer
//
//  Created by yangjian on 2023/9/5.
//

import Foundation


extension AppState {
    struct GADState {
        
        var position: GADPosition.Position = .home
        
        @UserDefault(key: "state.ad.config")
        var config: GADConfig?
       
        @UserDefault(key: "state.ad.limit")
        var limit: GADLimit?
        
        var impressionDate:[GADPosition.Position: Date] = [:]
        
        let ads:[GADLoadModel] = GADPosition.allCases.map { p in
            GADLoadModel(position: p)
        }
        
        func isLoaded(_ position: GADPosition) -> Bool {
            return self.ads.filter {
                $0.position == position
            }.first?.isLoaded == true
        }

        func isLimited(in store: Store) -> Bool {
            if limit?.date.isToday == true {
                if (store.state.ad.limit?.showTimes ?? 0) >= (store.state.ad.config?.showTimes ?? 0) || (store.state.ad.limit?.clickTimes ?? 0) >= (store.state.ad.config?.clickTimes ?? 0) {
                    return true
                }
            }
            return false
        }
    }
}
