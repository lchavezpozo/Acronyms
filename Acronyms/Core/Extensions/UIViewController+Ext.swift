//
//  UIViewController+Ext.swift
//  Acronyms
//
//  Created by Luis Chavez pozo on 3/04/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, titleButton: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: titleButton, style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

