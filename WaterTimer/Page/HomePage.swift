//
//  HomePage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var store: Store
        
    var body: some View {
        NavigationView {
            VStack{
                TabView(selection: $store.state.home.item) {
                    ItemView(.dashboard, isSelected: isSelect(.dashboard))
                    ItemView(.statistics, isSelected: isSelect(.statistics))
                    ItemView(.reminder, isSelected: isSelect(.reminder))
                }.onChange(of: store.state.home.item) { newValue in
                    store.dispatch(.adDisappear(.native))
                    switch newValue {
                    case .dashboard:
                        store.dispatch(.adLoad(.native, .home))
                    case .statistics:
                        store.dispatch(.adLoad(.native, .chats))
                    case .reminder:
                        store.dispatch(.adLoad(.native, .reminder))
                    }
                }
            }
        }
    }
    
    struct ItemView: View {
        init(_ item: AppState.Home.Index, isSelected: Bool) {
            self.item = item
            self.isSelected = isSelected
        }
        let item: AppState.Home.Index
        let isSelected: Bool
        var body: some View {
            VStack{
                if item == .dashboard {
                    DashboardPage()
                } else if item == .statistics {
                    StatisticsPage()
                } else {
                    ReminderPage()
                }
            }.tabItem {
                VStack{
                    Image( !isSelected ? item.image : item.image + " 1")
                    Text(item.title.capitalized)
                }
            }.tag(item)
        }
    }
    
    func isSelect(_ item: AppState.Home.Index) -> Bool {
        return store.state.home.item == item
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(Store())
    }
}
