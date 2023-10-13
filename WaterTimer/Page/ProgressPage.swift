//
//  ProgressPage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation
import SwiftUI

struct ProgressPage: UIViewRepresentable {
    let progress: Int
    
    func makeUIView(context: Context) -> some UIView {
        return CircleProgressView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let view = uiView as? CircleProgressView {
            view.setProgress(progress)
        }
    }
}

class CircleProgressView: UIView {
    // 灰色静态圆环
    var staticLayer: CAShapeLayer!
    // 进度可变圆环
    var arcLayer: CAShapeLayer!
    
    // 为了显示更精细，进度范围设置为 0 ~ 1000
    var progress = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(_ progress: Int) {
        self.progress = progress
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        if staticLayer == nil {
            staticLayer = createLayer(1000, UIColor.white)
        }
        self.layer.addSublayer(staticLayer)
        if arcLayer != nil {
            arcLayer.removeFromSuperlayer()
        }
        arcLayer = createLayer(self.progress, UIColor(named: "#18CEFB")!)
        self.layer.addSublayer(arcLayer)
    }
    
    private func createLayer(_ progress: Int, _ color: UIColor) -> CAShapeLayer {
        let endAngle = -CGFloat.pi / 2 + (CGFloat.pi * 2) * CGFloat(progress) / 1000
        let layer = CAShapeLayer()
        layer.lineWidth = 12
        layer.strokeColor = color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        let radius = self.bounds.width / 2 - layer.lineWidth
        let path = UIBezierPath.init(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: radius, startAngle: -CGFloat.pi / 2, endAngle: endAngle, clockwise: true)
        layer.path = path.cgPath
        return layer
    }

}
