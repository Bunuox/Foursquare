//
//  PlacesVC.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 28.10.2021.
//

import UIKit

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var placesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlace))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOutButtonClicked))

        placesTableView.dataSource = self
        placesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
    @objc func addPlace(){
        performSegue(withIdentifier: "toPlaceVC", sender: nil)
    }
    
    @objc func logOutButtonClicked(){
        let user = User()
        user.userLogOut { message in
            if message == "Success"{
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            }else{
                print(message)
            }
        }
    }
    
}
