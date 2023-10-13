//
//  StatisticsPage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import SwiftUI

struct StatisticsPage: View {
    
    @EnvironmentObject var store: Store
    
    var item: AppState.Charts.Index {
        store.state.charts.item
    }
    
    var bar: [Int] {
        store.state.charts.barSource
    }
    
    var dataSource: [ChartModel] {
        store.state.charts.dataSource
    }
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Text("Statistics").font(.system(size: 20)).fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: {
                        HistoryRecordPage()
                    }, label: {
                        Image("history")
                    })
                }
            }.padding(.horizontal, 20)
            VStack{
                HStack{
                    ForEach(AppState.Charts.Index.allCases, id: \.self) { item in
                        Button(action: {
                            select(item)
                        }, label: {
                            Text(item.rawValue).padding(.horizontal, 15).padding(.vertical, 8).background(item == self.item ? Color("#01ECC4") : Color.clear).foregroundColor(item == self.item ? Color.black : Color("#88A2B5")).cornerRadius(18)
                        })
                    }
                }.padding(.top, 7)
                HStack(alignment: .bottom){
                    VStack(alignment: .trailing, spacing: 28) {
                        ForEach(bar, id: \.self) { index in
                            Text("\(index)").font(.system(size: 12)).foregroundColor(Color("#888996"))
                        }
                    }.frame(width: 50).padding(.leading, 20).padding(.bottom, 30)
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHGrid(rows: [GridItem(.flexible())]) {
                            ForEach(dataSource, id: \.self) { item in
                                VStack(spacing: 16){
                                    GeometryReader { proxy in
                                        VStack(spacing: 0){
                                            Color.white
                                            let height = proxy.size.height * item.progress
                                            Color("#18CEFB").cornerRadius(13).frame(height: height > proxy.size.height ? proxy.size.height : height)
                                        }
                                    }
                                    Text(item.unit).foregroundColor(Color("#888996")).font(.system(size: 12))
                                    
                                }.padding(.leading)
                            }
                        }.padding(.leading, 4)
                    }
                    Spacer()
                }.padding(.top, 25)
                Spacer()
            }.background(Color.white.cornerRadius(6)).frame(height: 340).padding(.top, 24).padding(.horizontal, 20)
            Spacer()
            if store.state.ad.position == .chats {
                HStack{
                    NativeView(model: store.state.root.adModel)
                }.padding(.horizontal, 20).frame(height: 116)
            }
            Spacer()
        }.background(Image("bg").ignoresSafeArea())
    }
}

extension StatisticsPage {
    func select(_ item: AppState.Charts.Index) {
        store.dispatch(.chartSelect(item))
    }
}

struct StatisticsPage_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsPage().environmentObject(Store())
    }
}
