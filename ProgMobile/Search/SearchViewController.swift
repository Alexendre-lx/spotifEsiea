//
//  SearchViewController.swift
//  ProgMobile
//
//  Created by Alexendre on 13/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UITableViewController {
    var searchBar:UISearchBar!
    let api = apiLooker()
    let waitingView = UIView()
    let waitingLabel = UILabel()
    
    var tracks : [newSearch] = [newSearch]()
    let deposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        waitingView.frame = self.view.frame
        waitingView.backgroundColor = UIColor.green
        self.tableView.backgroundColor = .clear
        waitingLabel.text = "Veuillez entrer une recherche"
        waitingLabel.font = .boldSystemFont(ofSize: 24)
        waitingLabel.frame = self.waitingView.bounds
        waitingLabel.textAlignment = .center
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        searchBar.placeholder = "Your placeholder"
        searchBar.delegate = self
        tableView.register(searchTableViewcell.self, forCellReuseIdentifier: "myCell")
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        self.waitingView.addSubview(waitingLabel)
        self.view.addSubview(waitingView)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! searchTableViewcell
        cell.backgroundColor = .clear
        cell.detailTextLabel!.text = self.tracks[indexPath.row].name
        cell.detailTextLabel!.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Attention", message: "La musique va s'ouvrir si vous avez l'application spotify", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if (self.tracks[indexPath.row].previewUrl.count < 10){
                guard let url = URL(string: self.tracks[indexPath.row].directLink) else { return }
                UIApplication.shared.open(url)} else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: ["link": self.tracks[indexPath.row].previewUrl,"Artiste":self.tracks[indexPath.row].artists?.first?["name"],"Name": self.tracks[indexPath.row].name, "ImageLink": nil ])
            }
        }))
        self.present(alert, animated: true, completion: nil)
        

    }
    
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                  if(self.searchBar.text != ""){
                    UIView.animate(withDuration: 0.3) {
                        self.waitingView.alpha = 0
                    }
                    
              self.api.getSearch(text: self.searchBar.text!) { (response) in
                  print(response)
                self.tracks = response
                self.tableView.reloadData()
                    }} else {
                    UIView.animate(withDuration: 0.3) {
                        self.tracks.removeAll()
                        self.tableView.reloadData()
                        self.waitingView.alpha = 1
                    }
        }
    }
    
}

