//
//  Picture.swift
//  MapPicture
//
//  Created by 韩显钊 on 2023/7/25.
//

import Foundation

struct Picture: Codable {

    static func loadData(from url: URL) -> [Picture] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let data = try Data(contentsOf: url)
            let pictures = try decoder.decode([Picture].self, from: data)
            return pictures
        } catch {
            debugPrint("load data occur error: \(error)")
            return []
        }
    }
    
    let imageName: String
    let latitude: Double
    let longitude: Double
    
    var imageURL: URL? {
        Bundle.main.url(forResource: imageName, withExtension: nil)
    }
    
}
