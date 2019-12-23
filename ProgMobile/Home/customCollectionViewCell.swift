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
