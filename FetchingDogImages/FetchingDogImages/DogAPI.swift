//
//  DogAPI.swift
//  FetchingDogImages
//
//  Created by Kyle Wilson on 2020-02-28.
//  Copyright © 2020 Xcode Tips. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    
    enum Endpoint {
        
        case randomImageFromAllDogsCollection
        
        var url: URL {
            return URL(string: self.stringValue)! //for our case to take string and convert into URL
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random" //random dog picture generator, if you put this in the web you will get the response values of message and status which we decode
            }
        }
    }
    
    //MARK: GET IMAGE DATA
    
    class func requestRandomImage(completion: @escaping (DogImage?, Bool, Error?) -> Void) {
        let request = URLRequest(url: Endpoint.randomImageFromAllDogsCollection.url) //our url
        let session = URLSession.shared
        print(request)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in //perform data task with url request
            
            if error != nil { //check for error
                completion(nil, false, error) //completion has 3 params, data, response, error
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let imageData = try decoder.decode(DogImage.self, from: data) //decode our struct
                completion(imageData, true, nil) //pass the values and success
            } catch let error {
                print(error.localizedDescription)
                completion(nil, false, error) //error and false
            }
        })
        task.resume() //resume task because the task starts in suspended state
    }
    
    //MARK: Request Image File
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) { //will convert our data into data our UIImage can read
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in //pass url
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data) //get data for UIImage
            completionHandler(downloadedImage, nil) //pass the image
        })
        task.resume() //resume task because the task starts in suspended state
    }
    
}







