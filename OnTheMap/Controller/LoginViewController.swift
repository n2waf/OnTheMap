//
//  ViewController.swift
//  OnTheMap
//
//  Created by nF ™ on 12/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logInButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        email.layer.borderWidth = 0.5
        password.layer.borderWidth = 0.5
        email.layer.borderColor = UIColor.systemGray2.cgColor
        password.layer.borderColor = UIColor.systemGray2.cgColor
        password.layer.cornerRadius = 7
        email.layer.cornerRadius = 7
        email.setLeftPaddingPoints(4)
        password.setLeftPaddingPoints(4)
        logInButtonOutlet.layer.cornerRadius = 7
        email.delegate = self
        password.delegate = self
        email.tag = 0
        password.tag = 1
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:]) { (success) in
        }
    }
    @IBAction func logIn(_ sender: Any) {
        
        if email.text != "" && password.text != "" {
            self.activityView.startAnimating()
             createSessionRequest(userName: email.text!, password: password.text!)
        } else {
         
            let alert = UIAlertController.ShowAlert("Some Thing wrong", "Be sure you are fill the email and password !")
            self.present(alert,animated: true)
        }
       
    } 
    
    func createSessionRequest(userName:String , password:String) {
        
        let userInfo = CreateSession(udacity: Udacity(username: userName, password: password))
        APIClient.createSession(UserInfo: userInfo) { (response, error) in
           DispatchQueue.main.async {
            if error != nil {
                let alert = UIAlertController.ShowAlert("Failure", error!.localizedDescription)
                    self.present(alert, animated: true)
            } else {
                    UIAlertController.ShowAlertWithSegue("Success", "", vc: self, segue: "main")
                }
            self.activityView.stopAnimating()
            }
            
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            logIn(self)
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
}
