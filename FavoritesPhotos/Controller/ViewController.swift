//
//  ViewController.swift
//  FavoritesPhotos
//
//  Created by Raman Kozar on 27/04/2023.
//

import UIKit
import Photos

class ViewController: UIViewController {

    var autorizationIsOK: Bool = false
    
    @IBOutlet weak var mainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openFavoutites(_ sender: Any) {
        
        autorizationIsOK = photoAuthorization()
        
        if autorizationIsOK {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
            self.present(next, animated: true, completion: nil)
        }
        
    }
    
    private func photoAuthorization() -> Bool {
        
        var finalAutorizationStatus: Bool = false
        let autorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch autorizationStatus {
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (currentStatus) in
                
                switch currentStatus {
                case .authorized:
                    finalAutorizationStatus = true
                case .notDetermined, .restricted, .denied, .limited:
                    finalAutorizationStatus = false
                @unknown default:
                    finalAutorizationStatus = false
                }
                
            }
            
        case .authorized:
            finalAutorizationStatus = true
        case .restricted, .denied, .limited:
            finalAutorizationStatus = false
        @unknown default:
            finalAutorizationStatus = false
        }
        
        return finalAutorizationStatus
        
    }
    
}

