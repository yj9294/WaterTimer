//
//  AppCommand.swift
//  WaterTimer
//
//  Created by yangjian on 2023/8/30.
//

import Foundation
import Combine

protocol AppCommand {
    func execute(in store: Store)
}

class SubscriptionToken {
    var cancelable: AnyCancellable?
    func unseal() { cancelable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancelable = self
    }
}
