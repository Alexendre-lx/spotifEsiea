//
//  detailsViewController.swift
//  ProgMobile
//
//  Created by ALEXENDRE OBLI on 22/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit
import NotificationCenter




class detailsViewController: UIViewController {
    var titre : titre
    var imageView : UIImageView!
    var titleView : UITextView!
    var artistView : UITextView!
    var dateView : UITextView!
    var playbutton : UIButton!
    var singlesView : UITableView!
    
    
    init(details : titre) {
        titre = details
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        singlesView = UITableView(frame: self.view.frame)
        singlesView.dataSource = self
        singlesView.delegate = self
        singlesView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        singlesView.separatorStyle = .none
        self.view.addSubview(singlesView)
        self.singlesView.backgroundColor = .clear
        setdatas(title: titre)
    }
    
    func setdatas(title : titre){
        self.imageView = UIImageView()
        imageView.downloaded(from: self.titre.imageLink)
        self.artistView = UITextView()
        self.artistView.text = self.titre.artistName
        self.titleView = UITextView()
        titleView.textColor = UIColor.white
        self.titleView.text = self.titre.name
        self.playbutton = UIButton()
        playbutton.backgroundColor = UIColor.green
        playbutton.setTitle("Jouer le litre", for: .normal)
        playbutton.layer.cornerRadius = 20
        playbutton.addTarget(self, action: #selector(playTrack), for: .touchUpInside)
        self.dateView = UITextView()
    }
    
    @objc func playTrack() {
        if (self.titre.previewLink.count < 10) {
            
            let alert = UIAlertController(title: "Attention", message: "La musique va s'ouvrir si vous avez l'application spotify", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    guard let url = URL(string: self.titre.directLink) else { return }
                UIApplication.shared.open(url)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: ["link": self.titre.previewLink,"Artiste":self.titre.artistName,"Name": self.titre.name, "ImageLink": self.titre.imageLink ])
    }
    }
}
