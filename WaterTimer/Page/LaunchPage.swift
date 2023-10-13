//
//  LaunchPage.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import SwiftUI

struct LaunchPage: View {
    let progress: Double
    var body: some View {
        VStack{
            Image("icon").padding(.top, 83)
            Spacer()
            VStack(spacing: 41){
                Image("Water Timer")
                ProgressView(value: progress, total: 1.0).tint(Color("#17E3CE"))
            }.padding(.bottom, 49+13).padding(.horizontal, 88)
        }.background(Image("bg"))
    }
}

struct LaunchPage_Previews: PreviewProvider {
    static var previews: some View {
        LaunchPage(progress: 0.5)
    }
}
