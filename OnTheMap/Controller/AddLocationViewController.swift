//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by nF ™ on 15/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var findLocationOutlet: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var link: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

  
        findLocationOutlet.layer.cornerRadius = 7
    }
    

    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        if name.text != "" && link.text != "" {
            self.performSegue(withIdentifier: "findLocation", sender: self)
        } else {
            let alert = UIAlertController.ShowAlert("Some Thing wrong", "Be sure you are fill the name and link !")
            self.present(alert,animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? findLocationViewController
        
        vc?.address = name.text
        vc?.link = link.text
    }
}
