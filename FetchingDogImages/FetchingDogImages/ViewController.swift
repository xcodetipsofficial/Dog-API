//
//  ViewController.swift
//  FetchingDogImages
//
//  Created by Kyle Wilson on 2020-02-28.
//  Copyright © 2020 Xcode Tips. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var randomDogButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomDogButton.layer.cornerRadius = 10
    }
    
    //MARK: Random Image Response
    
    func handleRandomImageResponse(imageData: DogImage?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    //MARK: Handle Image File Response

    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async { //put on main thread
            self.dogImageView.image = image //add image
        }
    }
    
    //MARK: Button Tapped
    
    @IBAction func randomDogTapped(_ sender: Any) {
        
        DogAPI.requestRandomImage { (imageData, success, error)  in
            
            if error != nil {
                DispatchQueue.main.async { //put on main thread
                    let alert = UIAlertController(title: "Error", message: "There was an error: \(error?.localizedDescription ?? "")", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true) //present alerts
                }
                return
            }
            
            guard imageData != nil else {
                DispatchQueue.main.async { //put on main thread
                    let alert = UIAlertController(title: "No Image", message: "Could not load image", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                return
            }
            
            if success { //if it succeeds getting the request
                self.handleRandomImageResponse(imageData: imageData)
            }
        }
    }
    
    
}

