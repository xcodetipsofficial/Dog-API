//
//  DogImage.swift
//  FetchingDogImages
//
//  Created by Kyle Wilson on 2020-02-28.
//  Copyright © 2020 Xcode Tips. All rights reserved.
//

import Foundation

/* Our codable struct
 that helps decode the json */
 
struct DogImage: Codable {
    let message: String
    let status: String
}
