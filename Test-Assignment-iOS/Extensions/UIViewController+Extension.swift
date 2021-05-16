//
//  UIViewController+Extension.swift
//  Test-Assignment-iOS
//
//  Created by cr3w on 16.05.2021.
//

import UIKit

extension UIViewController {
    
    var safeLayout: UILayoutGuide {
        return view.safeAreaLayoutGuide
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_) in
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

