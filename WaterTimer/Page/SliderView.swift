//
//  SliderView.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/31.
//

import Foundation
import SwiftUI

struct SliderView: UIViewRepresentable {
    @Binding var progress: Int?
    let total: Int
    func makeUIView(context: Context) -> some UIView {
        let view = UISlider()
        view.tintColor = UIColor(named: "#17E3CE")!
        view.setThumbImage(UIImage(named: "point"), for: .normal)
        view.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(sender:)), for: .valueChanged)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let view = uiView as? UISlider {
            view.value = Float(progress ?? 2000) / Float(total)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: SliderView
        
        init(_ parent: SliderView) {
            self.parent = parent
        }
        
        @objc func valueChanged(sender: UISlider) {
            parent.progress = Int(sender.value * Float(parent.total) / 100) * 100
            if parent.progress == 0 {
                parent.progress = 100
            }
        }
    }
}
