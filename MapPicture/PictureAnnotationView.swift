//
//  PictureAnnotationView.swift
//  MapPicture
//
//  Created by 韩显钊 on 2023/8/1.
//

import MapKit
import Foundation

class PictureAnnotationView: MKAnnotationView {
    
    func config(annotation: PictureAnnotation) {
        let picture = annotation.picture
        
        if let imageURL = picture.imageURL {
            self.image = UIImage(contentsOfFile: imageURL.path)?
                .preparingThumbnail(of: CGSize(width: 56, height: 56))
        } else {
            self.image = nil
        }
    }
    
}
