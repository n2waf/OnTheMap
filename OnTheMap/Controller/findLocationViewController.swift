//
//  findLocationViewController.swift
//  OnTheMap
//
//  Created by nF ™ on 15/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import UIKit
import MapKit

class findLocationViewController: UIViewController , MKMapViewDelegate{

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    var address : String? = ""
    var link : String? = ""
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishOutlet: UIButton!
    var location: CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishOutlet.layer.cornerRadius = 7
        finishOutlet.isEnabled = false
        findLocation()
    }
    
    @IBAction func Finish(_ sender: Any) {
        self.activityView.startAnimating()
        let Student = PostRequest(uniqueKey: "123", firstName: "Yazed", lastName: "omari", mapString: address!, mediaURL: link!, latitude: Double(location!.latitude), longitude: Double(location!.longitude))
       
        APIClient.postStudentLocations(Student: Student) { (response, error) in
            DispatchQueue.main.async {
            if let response = response {
                
                self.dismiss(animated: true, completion: nil)
                
            } else {
                let alert = UIAlertController.ShowAlert("Post fails", "try again later")
                self.present(alert,animated: true)
            }
            self.activityView.stopAnimating()
            }
        }
        
        
    }
    
    func findLocation() {
        self.activityView.startAnimating()
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    let alert = UIAlertController.ShowAlert("Wrong Location", "the location can't be found !")
                    self.present(alert,animated: true)
                    return
            }
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            self.location = location.coordinate
            DispatchQueue.main.async {
                self.finishOutlet.isEnabled = true
                self.mapView.addAnnotation(annotation)
                self.mapView.setCenter(location.coordinate, animated: true)
                self.activityView.stopAnimating()
            }
            
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoLight)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }


}
