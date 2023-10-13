//
//  DismissCommand.swift
//  WaterTimer
//
//  Created by yangjian on 2023/9/6.
//

import Foundation
import UIKit

struct DismissCommand: AppCommand {
    func execute(in store: Store) {
        let vc = GetRootVC()
        if let presentedVC = vc.presentedViewController {
            if let p = presentedVC.presentedViewController {
                p.dismiss(animated: true) {
                    presentedVC.dismiss(animated: true)
                }
            } else {
                presentedVC.dismiss(animated: true)
            }
        }
    }
    
    func GetRootVC() -> UIViewController {
        if let scene = UIApplication.shared.connectedScenes.filter({$0 is UIWindowScene}).first as? UIWindowScene, let keyWindow = scene.keyWindow,  let rootVC = keyWindow.rootViewController {
                return rootVC
        }
        return UIViewController()
    }
}
