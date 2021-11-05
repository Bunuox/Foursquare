//
//  PlaceDetailsVC.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 4.11.2021.
//

import UIKit
import MapKit
import Parse

class PlaceDetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var placeTypeTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeCommentTextField: UITextField!
    
    var selectedPlace = PFObject.init(className: "Places")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.placeNameTextField.text = selectedPlace.object(forKey: "placeName") as? String
        self.placeTypeTextField.text = selectedPlace.object(forKey: "placeType") as? String
        self.placeCommentTextField.text = selectedPlace.object(forKey: "placeComment") as? String
        
        if let imageData = selectedPlace.object(forKey: "placeImage") as? PFFileObject{
            imageData.getDataInBackground { data, err in
                if err == nil {
                    self.imageView.image = UIImage(data: data!)

                }
            }
        }

        
        let coordinates = CLLocationCoordinate2D(latitude: selectedPlace.object(forKey: "placeLatitude") as? Double ?? 0, longitude: selectedPlace.object(forKey: "placeLongitude" ) as? Double ?? 0)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = self.selectedPlace.object(forKey: "placeName") as? String
        annotation.subtitle = self.selectedPlace.object(forKey: "placeType") as? String
        
        self.mapView.region = MKCoordinateRegion(center: coordinates, span: span)
        self.mapView.addAnnotation(annotation)
    }

}
