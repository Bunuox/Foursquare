//
//  PlaceVC.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 1.11.2021.
//

import UIKit

class PlaceVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var placeTypePickerView: UIPickerView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var selectImageView: UIImageView!
    
    var placeTypesList: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeTypePickerView.delegate = self
        self.placeTypePickerView.dataSource = self

        placeTypesList = ["test","test1","test2"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return placeTypesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return placeTypesList[row]
    }
    
}
