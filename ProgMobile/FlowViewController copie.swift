//
//  FlowViewController.swift
//  ProgMobile
//
//  Created by Alexendre on 13/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit

class FlowViewController: UIViewController {
    
    var collectionView : UICollectionView!
    var frameSize = CGRect()
    var type : String!
    var dataDict = Array<NSDictionary>()
    
    init(frame: CGRect, inputType : String) {
        frameSize = frame
        let myLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        myLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myLayout.scrollDirection = .horizontal
        myLayout.itemSize = CGSize(width: frame.height - 10, height: frame.height - 10)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: myLayout)
        type = inputType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = frameSize
        collectionView.register(customCollectionViewCell.self, forCellWithReuseIdentifier: "myCollectionViewCell")
        collectionView.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView)
    }
}
