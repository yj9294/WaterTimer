//
//  LaunchCommand.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation
import AppTrackingTransparency

struct LaunchCommand: AppCommand {
    func execute(in store: Store) {
        var progress = 0.0
        var duration = 12.5
        let subscription = SubscriptionToken()
        Timer.publish(every: 0.01, on: .main, in: .common).autoconnect().sink { _ in
            if store.state.root.enterbackground {
                subscription.unseal()
                return
            }
            progress += 0.01 / duration
            if progress >= 1.0 {
                subscription.unseal()
                store.dispatch(.adShow(.interstitial) { _ in
                    if store.state.root.progress >= 0.9 {
                        store.dispatch(.launch(false))
                    }
                })
                return
            }
            
            if progress > 0.3, store.state.ad.isLoaded(.interstitial) {
                duration = 0.1
            }
            
            store.dispatch(.progress(progress))
        }.seal(in: subscription)
        
        ATTrackingManager.requestTrackingAuthorization { _ in
        }
        
        store.dispatch(.adLoad(.interstitial))
        store.dispatch(.adLoad(.native))
    }
}
