//
//  RecordModel.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

struct RecordModel: Codable {
    var date: String // "yyyy-MM-dd HH:ss"
    var items: [DrinkModel]
}
