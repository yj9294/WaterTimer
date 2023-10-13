//
//  GADViewModel.swift
//  WaterTimer
//
//  Created by yangjian on 2023/9/5.
//

import Foundation
import SwiftUI
import GoogleMobileAds

class GADNativeViewModel: NSObject {
    let ad: GADBaseModel.GADNativeModel?
    let view: UINativeAdView
    init(ad: GADBaseModel.GADNativeModel? = nil, view: UINativeAdView) {
        self.ad = ad
        self.view = view
        self.view.refreshUI(ad: ad?.nativeAd)
    }
    
    static var None: GADNativeViewModel {
        GADNativeViewModel(view: UINativeAdView())
    }
}
