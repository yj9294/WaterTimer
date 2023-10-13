//
//  RecordPage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/31.
//

import SwiftUI

struct RecordPage: View {
    
    @EnvironmentObject var store: Store
    
    @Environment(\.presentationMode) var presentModel
    
    let handler: ((DrinkModel)->Void)
    
    let coulum:[GridItem] = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]
    @State var item: AppState.Record.Index = .water
    @State var ml: String = "200"
    @State var title: String = "Water"
    var body: some View {
        VStack{
            HStack{
                Image("img")
                VStack(alignment: .leading, spacing: 17){
                    if item != .customization {
                        Text(title).font(.system(size: 13)).padding(.all, 10)
                    } else {
                        TextField("", text: $title).font(.system(size: 13)).padding(.all, 10).background(Color.white).frame(width: 120)
                    }
                    
                    HStack(spacing: 0){
                        TextField("", text: $ml).keyboardType(.numberPad).frame(width: 35).padding(.all, 3).background(Color.white.cornerRadius(4))
                        Text("ml")
                        Spacer()
                    }.font(.system(size: 13)).padding(.all, 10)
                }.foregroundColor(Color("#0F1034"))
            }.background(Image("record_bg")).padding(.horizontal, 15).padding(.top, 30)
            ScrollView {
                LazyVGrid(columns: coulum, spacing: 12) {
                    ForEach(AppState.Record.Index.allCases, id: \.self) { item in
                        Button(action: {
                            select(item)
                        }, label: {
                            VStack{
                                Image(item.icon)
                                Text(item.title + " 200ml").font(.system(size: 13))
                            }.background(Image("item_bg")).frame(width: 155, height: 131)
                        }).foregroundColor(Color("#333333"))
                    }
                }.padding(.top, 24)
            }
            Spacer()
            Button(action: storeage) {
                Text("OK")
            }.padding(.vertical, 12).padding(.horizontal, 80).background(Color("#17E3CE").cornerRadius(22)).foregroundColor(Color.black)
        }
    }
}

extension RecordPage {
    
    func select(_ item: AppState.Record.Index) {
        self.item = item
        title = item.title
        ml = "200"
        self.item = item
    }
    
    func storeage() {
        store.dispatch(.adLoad(.interstitial))
        store.dispatch(.adShow(.interstitial) { _ in
            let model = DrinkModel(id: UUID().uuidString,day: Date().day, time: Date().time, item: item, name: title, ml: Int(ml) ?? 200)
            handler(model)
            presentModel.wrappedValue.dismiss()
        })
    }
}

struct RecordPage_Previews: PreviewProvider {
    static var previews: some View {
        RecordPage { _ in
        }
    }
}
