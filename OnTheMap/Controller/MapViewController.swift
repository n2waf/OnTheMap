//
//  MapViewController.swift
//  OnTheMap
//
//  Created by nF ™ on 14/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController , MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        APIClient.getStudentLocations { (data, error) in
            guard let data = data?.results else {
                let alert = UIAlertController.ShowAlert("failure", "Faild to fetch data from server")
                self.present(alert,animated: true)
                return
            }
            self.handleMapData(data)
        }
    }
    
    @IBAction func add(_ sender: Any) {
    }
    @IBAction func Reload(_ sender: Any) {
        APIClient.getStudentLocations { (data, error) in
            self.handleMapData((data?.results)!)
        }
    }
    @IBAction func logOut(_ sender: Any) {
        APIClient.logOut()
        dismiss(animated: true, completion: nil)
    }
    func handleMapData(_ data:[Result]) {
        var desc = [MKPointAnnotation]()
        
        for i in data {
            let latitude = i.latitude
            let longitude = i.longitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(i.firstName) \(i.lastName)"
            annotation.coordinate = coordinate
            annotation.subtitle = i.mediaURL
            
            desc.append(annotation)
        }
        DispatchQueue.main.async {
            self.mapView.addAnnotations(desc)
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

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                UIApplication.shared.open(URL(string: toOpen)!, options: [:]) { (success) in
                    print(success)
                }
               
            }
        }
    }


}
