//
//  detailsViewController.swift
//  ProgMobile
//
//  Created by ALEXENDRE OBLI on 22/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit
import NotificationCenter


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
        singlesView.delegate = self
        singlesView.dataSource = self
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
            guard let url = URL(string: self.titre.directLink) else { return }
        UIApplication.shared.open(url)
            
        }
        else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: ["link": self.titre.previewLink,"Artiste":self.titre.artistName,"Name": self.titre.name, "ImageLink": self.titre.imageLink ])
    }
    }
}

extension detailsViewController : UITableViewDelegate {
    
    
    
}

extension detailsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        if indexPath.section == 0 {
        switch indexPath.row {
        case 0:
            self.imageView.frame = cell.bounds
            cell.addSubview(self.imageView)
            break
        case 1:
            self.titleView.frame = cell.bounds
            self.titleView.textColor = .white
            self.titleView.backgroundColor = UIColor.clear
            self.titleView.text = self.titre.name
            self.titleView.isEditable = false
            cell.addSubview(self.titleView)
            break
        case 2:
            self.artistView.frame = cell.bounds
            self.artistView.textColor = .white
            self.artistView.backgroundColor = UIColor.clear
            self.artistView.text = "Par : \(self.titre.artistName)"
            self.artistView.isEditable = false
            cell.addSubview(self.artistView)
            break
        case 3:
            break
        case 4:
            self.playbutton.frame = CGRect(x: 0, y: 0, width: cell.bounds.width / 2, height: cell.bounds.height)
            playbutton.center.x = self.view.center.x
            cell.addSubview(self.playbutton)
            break
        case 5:
            self.dateView.frame = cell.bounds
            self.dateView.backgroundColor = .clear
            self.dateView.textColor = .white
            self.dateView.text = "Date de sortie : \(self.titre.releaseDate)"
            cell.addSubview(self.dateView)
            break
        default:
            break
        }
        } else {
            let tileView = UITextView(frame: cell.bounds)
            cell.addSubview(tileView)
            tileView.backgroundColor = .clear
            tileView.textColor = .white
            tileView.font = .boldSystemFont(ofSize: 22)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 60
        } else {
            switch indexPath.row {
            case 0:
                return self.view.frame.height / 2
            case 1:
                return 60
            case 2:
                return 60

            case 3:
                return 30

            case 4:
                return 60
            case 5:
                return 60
            default:
                return 0
            }
        }
    }
    
    
    
    
    
}
