//
//  AlertManager .swift
//  Virtual-Tourist
//
//  Created by Yazeedo on 22/05/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

public class AlertManager: NSObject {
    
    static let shared = AlertManager()
    
    override init() {}
    
    public func showFailureFromViewController(viewController: UIViewController, message: String) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
