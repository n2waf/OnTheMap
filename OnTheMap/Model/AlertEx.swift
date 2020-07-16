//
//  AlertController.swift
//  OnTheMap
//
//  Created by nF ™ on 15/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import Foundation
import UIKit
extension UIAlertController {
     
    class func ShowAlert(_ title : String ,_ messaeg: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: messaeg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        }))
        
        return alert
    }
    class func ShowAlertWithSegue(_ title : String ,_ messaeg: String , vc:UIViewController , segue:String) {
        
        let alert = UIAlertController(title: title, message: messaeg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            vc.performSegue(withIdentifier: segue, sender: vc)
        }))
        
        vc.present(alert,animated: true)
    }
}
