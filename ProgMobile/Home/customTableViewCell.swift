//
//  customTableViewCell.swift
//  ProgMobile
//
//  Created by Alexendre on 20/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var collection : FlowViewController!
    var controller : UIViewController!
    var data : NSArray!
    var numberOfRow = 0
    let api = apiLooker()
    var type = ""
    var newReleaseData : [newReleases]!
    var newRecommendations : [recommendations]!
    var newPlaylists : [playlist]!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionView(type : String){
        self.type = type
                switch type {
                case "Recommandations":
                    api.getRecommendations { (response) in
                        print(response)
                        self.newRecommendations = response
                        self.numberOfRow = response.count
                        self.collection = FlowViewController(frame: self.bounds, inputType: "newReleases")
                        self.collection.collectionView.delegate = self
                        self.collection.collectionView.dataSource = self
                        self.addSubview(self.collection.view)
                        self.collection.collectionView.reloadData()
        //                self.dataDict = response
                    }
                    break
                case "newReleases":
                    api.getNewReleases { (response) in
                        print(response)
                        self.newReleaseData = response
                        self.numberOfRow = response.count
                        self.collection = FlowViewController(frame: self.bounds, inputType: "newReleases")
                        self.collection.collectionView.delegate = self
                        self.collection.collectionView.dataSource = self
                        self.addSubview(self.collection.view)
                        self.collection.collectionView.reloadData()
        //                self.dataDict = response
                    }
                        break
                case "playlists":
                                api.getNewPlaylist { (response) in
                                print(response)
                                self.newPlaylists = response
                                self.numberOfRow = response.count
                                self.collection = FlowViewController(frame: self.bounds, inputType: "playlists")
                                self.collection.collectionView.delegate = self
                                self.collection.collectionView.dataSource = self
                                self.addSubview(self.collection.view)
                                self.collection.collectionView.reloadData()
                //                self.dataDict = response
                            }
                    break
                default:
                    break
                }
    }
    
    func getControllet(_ mainController : UIViewController){
        self.controller = mainController
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case "Recommandations":
            let detailView = detailsViewController(details: randToTitle(recommandation: newRecommendations[indexPath.row]))
            collectionView.inputViewController?.navigationController?.pushViewController(detailView, animated: true)
            self.controller.navigationController?.pushViewController(detailView, animated: true)
                break
        case "newReleases":
            let detailView = detailsViewController(details: randToTitle(release: newReleaseData[indexPath.row]))
            self.controller.navigationController?.pushViewController(detailView, animated: true)
                    break
        case "playlists":
            let alert = UIAlertController(title: "Attention", message: "La musique va s'ouvrir si vous avez l'application spotify", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                guard let url = URL(string: self.newPlaylists[indexPath.row].directLink) else { return }
                  UIApplication.shared.open(url)
            }))
            self.controller.present(alert, animated: true, completion: nil)
                break
            default:
                break
            }
    }
    
    func randToTitle (recommandation : recommendations) -> titre {
        let title = titre(imageLink: recommandation.images.first!["url"] as! String, name: recommandation.name, artistName: recommandation.artists.first?["name"] as? String ?? "null", type: recommandation.type, releaseDate: recommandation.releaseDate, id: recommandation.id, directLink: recommandation.directLink, previewLink: recommandation.previewUrl)
        
        return title
    }
    
    func randToTitle (release : newReleases) -> titre {
        let title = titre(imageLink: release.images.first!["url"] as! String, name: release.name, artistName: release.artists.first?["name"] as? String ?? "null", type: release.type, releaseDate: release.releaseDate, id: release.id, directLink: release.directLink, previewLink: "<null>")
        return title
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfRow
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! customCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        print(indexPath)
       
        cell.backgroundColor = UIColor.green
        
                switch type {
                case "Recommandations":
                    cell.setData(Image: ((newRecommendations[indexPath.row].images.first)!.value(forKey: "url"))! as! String, name: newRecommendations[indexPath.row].name)
                    break
                case "newReleases":
                     cell.setData(Image: ((newReleaseData[indexPath.row].images.first)!.value(forKey: "url"))! as! String, name: newReleaseData[indexPath.row].name)
                        
                        break
                case "playlists":
                    cell.setData(Image: ((newPlaylists[indexPath.row].images.first)!.value(forKey: "url"))! as! String, name: newPlaylists[indexPath.row].name)
                    break
                default:
                    break
                }
        return cell
    }

}
