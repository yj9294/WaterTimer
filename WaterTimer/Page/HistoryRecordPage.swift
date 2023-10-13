//
//  HistoryRecordPage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/31.
//

import SwiftUI

struct HistoryRecordPage: View {
    
    @EnvironmentObject var store: Store
    
    var dataSource: [[DrinkModel]] {
        store.state.record.historyList
    }
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    ForEach(dataSource, id: \.self) { items in
                        VStack(alignment: .leading){
                            Text(items.first?.day ?? "").font(.system(size: 13)).foregroundColor(Color("#0F1034"))
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(items, id: \.self) { item in
                                    HStack{
                                        Image(item.item.icon).resizable().frame(width: 35, height: 35)
                                        VStack(alignment:.leading, spacing: 4){
                                            Text(item.name)
                                            Text("\(item.ml)ml")
                                        }.font(.system(size: 10)).foregroundColor(Color("#7C868C"))
                                    }.padding(.horizontal, 8).padding(.vertical, 14).background(Color.white.cornerRadius(8))
                                }
                            }
                        }.padding(.all, 12).background(RoundedRectangle(cornerRadius: 16).strokeBorder(Color("#18CEFB"), lineWidth: 2.0).background(Color("#E0F1F1"))).padding(.all)
                    }
                }
                Spacer()
            }
        }.background(Image("bg").resizable().ignoresSafeArea())
    }
}

struct HistoryRecordPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRecordPage().environmentObject(Store())
    }
}
