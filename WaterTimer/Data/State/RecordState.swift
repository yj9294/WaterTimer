//
//  RecordState.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

extension AppState {
    struct Record {
        
        var progress: Int = 0
        
        var todayDrink: Int {
            (drinkList ?? []).filter { model in
                model.day == Date().day
            }.map({
                $0.ml
            }).reduce(0, +)
        }
        
        let drinkAll = 4000

        @UserDefault(key: "drink.max")
        var drinkMax: Int?
        
        @UserDefault(key: "drink.list")
        var drinkList: [DrinkModel]?
        
        
        var historyList: [[DrinkModel]] {
             return drinkList?.reduce([]) { (result, item) -> [[DrinkModel]] in
                 var result = result
                 if result.count == 0 {
                     result.append([item])
                 } else {
                     if var arr = result.last, let lasItem = arr.last, lasItem.day == item.day  {
                         arr.append(item)
                         result[result.count - 1] = arr
                     } else {
                         result.append([item])
                     }
                 }
                return result
             } ?? []
        }
        
        enum Index: String, Codable, CaseIterable {
            case water, drinks, milk, coffee, tea, customization
            
            var title: String {
                self.rawValue.capitalized
            }
            
            var icon: String {
                self.rawValue
            }
        }
    }
}
