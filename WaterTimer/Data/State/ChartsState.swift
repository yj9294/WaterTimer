//
//  ChartsState.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation
import UIKit

extension AppState {
    struct Charts {
        var item: Index = .day
        
        var barSource: [Int] {
            let array = [0, 1, 2, 3, 4, 5]
            return array.map { index in
                if item == .year {
                    return index * 800 * 30
                } else if item == .day {
                    return index * 200
                } else {
                    return index * 800
                }
            }.reversed()
        }
        
        var dataSource: [ChartModel] {
            let drinkList: [DrinkModel] = UserDefaults.standard.getObject([DrinkModel].self, forKey: "drink.list") ?? []
            
            switch item {
            case .day:
                return item.unit.map({ time in
                    let total = drinkList.filter { model in
                        let lastTime = model.time.components(separatedBy: "~").last ?? "00:00"
                        let modelTime = lastTime.components(separatedBy: ":").first ?? "00"
                        
                        let nowTimeLast = time.components(separatedBy: "~").last ?? "00"
                        let nowTime = nowTimeLast.components(separatedBy: ":").first ?? "00"
                        return Date().day == model.day && (Int(modelTime)! >= Int(nowTime)! - 6) && (Int(modelTime)! < Int(nowTime)!)
                    }.map({
                        $0.ml
                    }).reduce(0, +)
                    return ChartModel(progress: Double(total)  / 1000.0 , totalML: total, unit: time)
                })
            case .week:
                return item.unit.map { weeks in
                    // 当前搜索目的周几
                    let week = AppState.Charts.Index.allCases.filter {
                        $0 == .week
                    }.first?.unit.firstIndex(of: weeks) ?? 0
                    
                    // 当前日期 用于确定当前周
                    let weekDay = Calendar.current.component(.weekday, from: Date())
                    let firstCalendar = Calendar.current.date(byAdding: .day, value: 1-weekDay, to: Date()) ?? Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                            
                    // 目标日期
                    let target = Calendar.current.date(byAdding: .day, value: week, to: firstCalendar) ?? Date()
                    let targetString = dateFormatter.string(from: target)
                    
                    let total = drinkList.filter { model in
                        model.day == targetString
                    }.map({
                        $0.ml
                    }).reduce(0, +)
                    return ChartModel(progress: Double(total)  / 4000.0, totalML: total, unit: weeks)
                }
            case .month:
                return item.unit.map { date in
                    let year = Calendar.current.component(.year, from: Date())
                    
                    let month = date.components(separatedBy: "/").first ?? "01"
                    let day = date.components(separatedBy: "/").last ?? "01"
                    
                    let total = drinkList.filter { model in
                        return model.day == "\(year)-\(month)-\(day)"
                    }.map({
                        $0.ml
                    }).reduce(0, +)
                    
                    return ChartModel(progress: Double(total)  / 4000.0, totalML: total, unit: date)

                }
            case .year:
                return  item.unit.map { month in
                    
                    let total = drinkList.filter { model in
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let date = formatter.date(from: model.day)
                        formatter.dateFormat = "MMM"
                        let m = formatter.string(from: date!)
                        return m == month
                    }.map({
                        $0.ml
                    }).reduce(0, +)
                    
                    return ChartModel(progress: Double(total)  / 120000.0, totalML: total, unit: month)

                }
            }
        }
        
        enum Index: String, CaseIterable, Codable {
            case day, week, month, year
            
            var unit: [String] {
                switch self {
                case .day:
                    return ["0:00~6:00", "6:00~12:00", "12:00~18:00", "18:00~24:00"]
                case .week:
                    return ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                case .month:
                    var days: [String] = []
                    for index in 0..<30 {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM/dd"
                        let date = Date(timeIntervalSinceNow: TimeInterval(index * 24 * 60 * 60 * -1))
                        let day = formatter.string(from: date)
                        days.insert(day, at: 0)
                    }
                    return days
                case .year:
                    var months: [String] = []
                    for index in 0..<12 {
                        let d = Calendar.current.date(byAdding: .month, value: -index, to: Date()) ?? Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MMM"
                        let day = formatter.string(from: d)
                        months.insert(day, at: 0)
                    }
                    return months
                }
            }
        }
    }
}
