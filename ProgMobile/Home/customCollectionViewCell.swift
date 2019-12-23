//
//  customCollectionViewCell.swift
//  ProgMobile
//
//  Created by Alexendre on 20/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit

class customCollectionViewCell: UICollectionViewCell {
    let imgaeView = UIImageView()
    let nom = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setData(Image: String, name: String){
        self.imgaeView.frame = self.bounds
        self.imgaeView.downloaded(from: Image, contentMode: .scaleAspectFill)
        self.addSubview(imgaeView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
