//
//  DashboardPage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import SwiftUI

struct DashboardPage: View {
    @EnvironmentObject var store: Store
    
    var animationProgress: Int {
        store.state.record.progress
    }
    
    var drinkMax: Int {
        store.state.record.drinkMax ?? 2000
    }
    
    @State var isShowTotalPage  = false;
    
    var body: some View {
        VStack{
            HStack{
                Text("Drink").font(.system(size: 20)).fontWeight(.bold).padding(.leading, 20)
                Spacer()
            }
            Spacer()
            if store.state.ad.position == .home {
                HStack{
                    NativeView(model: store.state.root.adModel)
                }.padding(.horizontal, 20).frame(height: 116)
            }
            Spacer()
            ZStack{
                Image("home_progress").resizable().scaledToFit().frame(width: 233, height: 233)
                ProgressPage(progress: animationProgress).frame(width: 216, height: 216)
                Text("\(animationProgress / 10)%").font(.system(size: 48)).fontWeight(.semibold)
            }
            Image("home_title").padding(.top,46)
            Spacer()
            HStack{
                NavigationLink {
                    RecordPage { model in
                        store.dispatch(.addDrink(model))
                    }
                } label: {
                    ItemView(item: .record, text: "Add new one!")
                }
                Spacer()
                Button {
                    store.dispatch(.adLoad(.interstitial))
                    store.dispatch(.adShow(.interstitial) { _ in
                        isShowTotalPage = true
                    })
                } label: {
                    ItemView(item: .total, text: "\(drinkMax)ml")

                }
                NavigationLink(destination: TotalDrinkPage(), isActive: $isShowTotalPage) {
                    EmptyView()
                }
            }.padding(.horizontal, 30)
            Spacer()
        }.background(Image("bg").ignoresSafeArea()).onAppear{
            store.dispatch(.animation)
        }
    }
    
    struct ItemView: View {
        let item: AppState.Dashboard.Index
        let text: String
        var body: some View {
            VStack{
                HStack(spacing: 12){
                    Image(item.editImage)
                    Text(item.title).foregroundColor(Color.black)
                }
                Text(text).font(.system(size: 14)).foregroundColor(Color("#464646").opacity(0.5))
            }.padding(.vertical, 16).padding(.horizontal, 20).background(Image(item.backgroundImage))
        }
    }
}

struct DashboardPage_Previews: PreviewProvider {
    static var previews: some View {
        DashboardPage().environmentObject(Store())
    }
}
