//
//  PlaceVC.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 1.11.2021.
//

import UIKit

class PlaceVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    

    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var placeTypePickerView: UIPickerView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var selectImageView: UIImageView!
    
    var placeTypesList: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeTypePickerView.delegate = self
        self.placeTypePickerView.dataSource = self
        
        self.selectImageView.isUserInteractionEnabled = true
        let gestureRecognizerForImagePick = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        self.selectImageView.addGestureRecognizer(gestureRecognizerForImagePick)
        
        let gestureRecognizerEndEdit = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        self.view.addGestureRecognizer(gestureRecognizerEndEdit)
        
        placeTypesList = ["pub","café","resteurant"]
        
        let placeModelInstance = PlaceModel.sharedInstance
        placeModelInstance.placeType = placeTypesList[0]
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
    
    @IBAction func NextButtonClicked(_ sender: Any) {
        let placeModelInstance = PlaceModel.sharedInstance
        placeModelInstance.placeName = placeNameTextField.text!
        placeModelInstance.placeComment = commentTextField.text!
        placeModelInstance.placeImage = selectImageView.image!
        
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let placeModelInstance = PlaceModel.sharedInstance
        placeModelInstance.placeType = placeTypesList[row] as String
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(picker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.selectImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func endEdit(){
        self.view.endEditing(true)
    }
}
