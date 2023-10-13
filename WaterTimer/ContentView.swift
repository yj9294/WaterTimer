//
//  ContentView.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    
    var progress: Double {
        store.state.root.progress
    }
    
    var body: some View {
        VStack {
            if store.state.root.item == .launch {
                LaunchPage(progress: progress)
            } else {
                HomePage()
            }
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            willEnterForeground()
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            didEnterBackground()
        }.onReceive(NotificationCenter.default.publisher(for: .nativeAdLoadCompletion)) { noti in
            loadCompletion(noti)
        }
    }
}

extension ContentView {
    
    func willEnterForeground() {
        store.dispatch(.dismiss)
        store.dispatch(.launching)
        store.dispatch(.launch(true))
    }
    
    func didEnterBackground() {
        store.dispatch(.launch(true))
    }
    
    
    func loadCompletion(_ noti: Notification) {
        if let ad = noti.object as? GADNativeViewModel {
            DispatchQueue.main.async {
                store.dispatch(.adModel(ad))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
