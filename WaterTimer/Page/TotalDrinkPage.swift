//
//  TotalDrinkPage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import SwiftUI

struct TotalDrinkPage: View {
    @EnvironmentObject var store: Store
    var total: Int {
        store.state.record.drinkAll
    }
    
    var drinkMax: Int {
        store.state.record.drinkMax ?? 2000
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack{
                VStack{
                    ZStack {
                        Image("total_drink")
                        Text("\(drinkMax)ml").padding(.leading, 30)
                    }.padding(.top, 40)
                    Text("Your daily water goal：" + "\(drinkMax)ml").font(.system(size: 12)).foregroundColor(Color("#88A2B5")).padding(.top, 35)
                }
                HStack{
                    Button(action: decrease) {
                        Image("decrease").frame(width: 18)
                    }
                    SliderView(progress: $store.state.record.drinkMax, total: total).frame(height: 12).padding(.horizontal, 12)
                    Button(action: reduce) {
                        Image("reduce").frame(width: 18)
                    }
                }.padding(.horizontal, 16).padding(.vertical, 24).background(Color("#E0F1F1").cornerRadius(24))
                Spacer()
            }.padding(.horizontal, 16)
        }.background(Image("bg").ignoresSafeArea())
    }
}

extension TotalDrinkPage {
    func decrease() {
        let max = (drinkMax - 100 < 0) ? 100 : (drinkMax - 100)
        store.dispatch(.drinkMax(max))
    }
    
    func reduce() {
        let max = (drinkMax + 100 > total) ? total : (drinkMax + 100)
        store.dispatch(.drinkMax(max))
    }
}

struct TotalDrinkPage_Previews: PreviewProvider {
    static var previews: some View {
        TotalDrinkPage().environmentObject(Store())
    }
}
