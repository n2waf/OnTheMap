//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by nF ™ on 15/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var findLocationOutlet: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var link: UITextField!
    var Clocation: CLLocation? = nil
    let annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()

  
        findLocationOutlet.layer.cornerRadius = 7
    }
    

    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        self.activityView.startAnimating()
        if name.text != "" && link.text != "" {
            findLocation()
        } else {
            let alert = UIAlertController.ShowAlert("Some Thing wrong", "Be sure you are fill the name and link !")
            self.present(alert,animated: true)
        }
        DispatchQueue.main.async {
            self.activityView.stopAnimating()
        }
        
    }
    
    func findLocation() {
        self.activityView.startAnimating()
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(name.text!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    let alert = UIAlertController.ShowAlert("Wrong Location", "the location can't be found !")
                    self.present(alert,animated: true)
                    return
            }
            self.annotation.coordinate = location.coordinate
            self.Clocation = location
            self.activityView.stopAnimating()
            self.performSegue(withIdentifier: "findLocation", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? FindLocationViewController
        vc?.location = Clocation
        vc?.annotation = annotation
        vc?.address = name.text
        vc?.link = link.text
    }
}
