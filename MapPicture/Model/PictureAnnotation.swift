//
//  PictureAnnotation.swift
//  MapPicture
//
//  Created by 韩显钊 on 2023/8/1.
//

import MapKit
import Foundation

class PictureAnnotation: NSObject, MKAnnotation {
    let picture: Picture
    let coordinate: CLLocationCoordinate2D
    
    init(picture: Picture, coordinate: CLLocationCoordinate2D) {
        self.picture = picture
        self.coordinate = coordinate
    }
}
