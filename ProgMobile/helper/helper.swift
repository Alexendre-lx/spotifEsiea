//
//  helper.swift
//  ProgMobile
//
//  Created by Alexendre on 20/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import Foundation
import UIKit


struct newReleases {
    let artists : Array<NSDictionary>!
    let markets : Array<String>!
    let links : Array<NSDictionary>!
    let id : String!
    let images : Array<NSDictionary>!
    let name : String
    let releaseDate : String
    let type : String
    let directLink : String
}

struct newSearch {
    let artists : Array<NSDictionary>?
    let id : String!
    let name : String
    let directLink : String
    let previewUrl : String
}

struct recommendations {
    let artists : Array<NSDictionary>!
    let links : Array<NSDictionary>!
    let id : String!
    let images : Array<NSDictionary>!
    let name : String
    let releaseDate : String
    let type : String
    let directLink : String
    let previewUrl : String
}

struct playlist {
    let description : String!
    let id : String!
    let images : Array<NSDictionary>!
    let name : String
    let directLink : String
}

struct titre {
    let imageLink : String
    let name : String
    let artistName : String
    let type : String
    let releaseDate : String
    let id : String
    let directLink : String
    let previewLink : String
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        self.alpha = 0
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 1
                }
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

