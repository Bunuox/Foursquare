//
//  PlacesVC.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 28.10.2021.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var placesTableView: UITableView!

    var places = [PFObject]()
    var selectedPlace = PFObject.init(className: "Places")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlace))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOutButtonClicked))

        placesTableView.dataSource = self
        placesTableView.delegate = self
        
        PlaceModel.sharedInstance.getAllPlacesData { message, placeObjects in
            if message == "Success"{
                self.places = placeObjects
                self.placesTableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PlaceModel.sharedInstance.getAllPlacesData { message, placeObjects in
            if message == "Success"{
                self.places = placeObjects
                self.placesTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.places[indexPath.row].object(forKey: "placeName") as? String
        return cell
    }
    
    @objc func addPlace(){
        performSegue(withIdentifier: "toPlaceVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedPlace = places[indexPath.row]
        performSegue(withIdentifier: "toPlaceDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaceDetailsVC"{
            let destinationVC = segue.destination as! PlaceDetailsVC
            destinationVC.selectedPlace = self.selectedPlace
        }
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
