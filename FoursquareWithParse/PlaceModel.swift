//
//  PlaceModel.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 4.11.2021.
//

import Foundation
import UIKit
import Parse

class PlaceModel{
    
    static let sharedInstance = PlaceModel()
    
    var placeId = ""
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    var placeLatitude = Double()
    var placeLongitude = Double()
    
    
    func savePlace(completion: @escaping (_ message:String) -> () ){
        let object = PFObject(className: "Places")
        object["placeName"] = self.placeName
        object["placeType"] = self.placeType
        object["placeComment"] = self.placeComment
        object["placeLatitude"] = self.placeLatitude
        object["placeLongitude"] = self.placeLongitude
        
        if let imageData = self.placeImage.jpegData(compressionQuality: 0.5){
            object["placeImage"] = PFFileObject(data: imageData)
        }
        
        object.saveInBackground { success, err in
            
            if err != nil {
                completion("Error")
            }
            
            else{
                completion("Success")
            }
            
        }
    }
    
    func getAllPlacesData(completion: @escaping (_ message:String,_ placeObjects:[PFObject]) -> ()){
        
        let query = PFQuery(className: "Places")
        var placeObjects = [PFObject]()
        
        query.findObjectsInBackground { objects, err in
            if err == nil{
                if objects != nil{
                    for object in objects!{
                        if let placeId = object.objectId as? String{
                            placeObjects.append(object)
                        }
                    }
                    completion("Success",placeObjects)
                }
            }else{
                completion("Error",[])
            }
        }
    }
    
    private init(){}
}
