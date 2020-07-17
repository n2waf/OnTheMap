//
//  ListViewController.swift
//  OnTheMap
//
//  Created by nF ™ on 14/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import UIKit

class ListViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{


    var LocationsData = [Result]()
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        APIClient.getStudentLocations { (data, error) in
            self.LocationsData = (data?.results)!
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
        }
    }
    
    @IBAction func add(_ sender: Any) {
    }
    @IBAction func Reload(_ sender: Any) {
        APIClient.getStudentLocations { (data, error) in
            if error != nil {
                let alert = UIAlertController.ShowAlert("Faild to fetch data", "Try again later or reload")
                self.present(alert,animated: true)
            } else {
                self.LocationsData = (data?.results)!
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
            
            
        }
    }
    @IBAction func logOut(_ sender: Any) {
        APIClient.logOut()
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LocationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let locationInfo = LocationsData[indexPath.row]
        cell.textLabel?.text = locationInfo.firstName + locationInfo.lastName
        cell.detailTextLabel?.text = locationInfo.mediaURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: LocationsData[indexPath.row].mediaURL)
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:]) { (success) in
            }
        }

    }


}
