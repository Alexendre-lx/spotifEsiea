//
//  ViewController.swift
//  ProgMobile
//
//  Created by Alexendre on 13/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var newReleasesData = Array<newReleases>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.tableView.register(customTableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.isEditing = false
        
        self.tableView.sectionHeaderHeight = 40
        self.tableView.estimatedSectionHeaderHeight = 40
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let categorieName = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: tableView.estimatedSectionHeaderHeight))
        categorieName.textAlignment = .justified
        categorieName.font = .boldSystemFont(ofSize: 24)
        categorieName.textColor = .white
        switch section {
        case 0:
            categorieName.text = "Les dernières nouveautés"
            break
        case 1:
            categorieName.text = "Les suggestions (electro)"
            break
        case 2:
            categorieName.text = "Les playlists populaires"
            break
        default:
            break
        }
        view.backgroundColor = UIColor.clear
        view.addSubview(categorieName)
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! customTableViewCell
        cell.getControllet(self)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        switch indexPath.section {
            case 0:
                cell.setCollectionView(type : "newReleases")
            break
            case 1:
                cell.setCollectionView(type : "Recommandations")
                break
            case 2:
                cell.setCollectionView(type : "playlists")
                break
            default:
                 cell.backgroundColor = themeColor
                 break
            }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.view.frame.height / 5
        case 1:
            return self.view.frame.height / 3
        case 2:
            return self.view.frame.height / 3
        default:
             return self.view.frame.height
        }
    }
}

