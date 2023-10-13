//
//  DrinkModel.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

struct DrinkModel: Codable, Hashable {
    var id: String = UUID().uuidString
    var day: String // yyyy-MM-dd
    var time: String // HH:mm
    var item: AppState.Record.Index // 列别
    var name: String
    var ml: Int // 毫升
}

struct DrinkTotalModel: Codable {
    var day: String // yyyy-MM-dd
    var ml: Int // 毫升
    static let `default` = DrinkTotalModel(day: Date().day, ml: 0)
}

extension Date {
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
}
