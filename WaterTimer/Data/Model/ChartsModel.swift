//
//  Charts.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

struct ChartModel: Codable, Hashable {
    var displayProgerss: CGFloat = 0.0
    var progress: CGFloat
    var totalML: Int
    var unit: String // 描述 类似 9:00 或者 Mon  或者03/01 或者 Jan
}
