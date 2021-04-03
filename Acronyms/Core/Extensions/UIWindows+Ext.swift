//
//  UIWindows+Ext.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import UIKit

extension UIWindow {
    func changeWindows(viewController: UIViewController) {
        if let snapshot: UIView = (snapshotView(afterScreenUpdates: true)) {
            viewController.view.addSubview(snapshot)
            rootViewController = viewController
            UIView.animate(withDuration: 0.3, animations: {() in
                snapshot.layer.opacity = 0
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            }, completion: { (finished: Bool) in
                if finished {
                    snapshot.removeFromSuperview()
                }
            })
        }
    }
}
