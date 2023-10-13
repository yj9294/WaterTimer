//
//  Action.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation

enum AppAction {
    case launch(Bool)
    case launching
    case tabbar
    case background(Bool)
    case progress(Double)
    
    case animationProgress(Int)
    case animation
    case drinkMax(Int)
    
    case addDrink(DrinkModel)
    
    case chartSelect(AppState.Charts.Index)
    
    case addReminder(String)
    case deleteReminder(String)
    
    case reminderNotification
    
    case adRequestConfig
    case adUpdateConfig(GADConfig)
    case adUpdateLimit(GADLimit.Status)
    
    case adAppear(GADPosition)
    case adDisappear(GADPosition)
    
    case adClean(GADPosition)
    
    case adLoad(GADPosition, GADPosition.Position = .home)
    case adShow(GADPosition, GADPosition.Position = .home, ((GADNativeViewModel)->Void)? = nil)
    
    case adNativeImpressionDate(GADPosition.Position = .home)
    
    case adModel(GADNativeViewModel)
    
    case dismiss
}
