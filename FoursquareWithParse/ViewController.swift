//
//  ViewController.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 23.10.2021.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        
        if usernameTextField.text != "" && passwordTextField.text != ""{
            
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { user, err in
                
                if err != nil {
                    self.makeAlert(message: err?.localizedDescription ?? "error", title: "Error")
                } else{
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
                    
            }
            
        }else{
            makeAlert(message: "Please fill in mandatory fields.", title: "Error")
        }

    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if usernameTextField.text != "" && passwordTextField.text != ""{
            
            let user = PFUser()
            user.username = usernameTextField.text!
            user.password = passwordTextField.text!
            
            user.signUpInBackground { success, err in
                if err != nil{
                    self.makeAlert(message: err?.localizedDescription ?? "", title: "Error")
                } else{
                    //segue
                    print("User created")
                }
            }
            
        }else{
            makeAlert(message: "Please fill in mandatory fields.", title: "Error")
        }
    }
    
    func makeAlert(message: String, title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

