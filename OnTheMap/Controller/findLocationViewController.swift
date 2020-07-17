//
//  findLocationViewController.swift
//  OnTheMap
//
//  Created by nF ™ on 15/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import UIKit
import MapKit

class FindLocationViewController: UIViewController , MKMapViewDelegate{

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    var address : String? = ""
    var link : String? = ""
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishOutlet: UIButton!
    var location: CLLocation!
    var annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishOutlet.layer.cornerRadius = 7
       
        DispatchQueue.main.async {
            self.mapView.addAnnotation(self.annotation)
            self.mapView.setCenter(self.location.coordinate, animated: true)
        }
        
   
    }
    
    @IBAction func Finish(_ sender: Any) {
        self.activityView.startAnimating()
        let Student = PostRequest(uniqueKey: "123", firstName: "Yazed", lastName: "omari", mapString: address!, mediaURL: link!, latitude: Double(location!.coordinate.latitude), longitude: Double(location!.coordinate.longitude))
       
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
