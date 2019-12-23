//
//  api.swift
//  ProgMobile
//
//  Created by Alexendre on 13/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import Foundation
import Alamofire

var appKey : String!

class apiLooker {
    
    func getNewReleases (completion: @escaping (Array<newReleases>)->()) {
        let headers: HTTPHeaders = [
          "Authorization":"Bearer \(appKey!)"
        ]
        AF.request("https://api.spotify.com/v1/browse/new-releases", headers: headers)
            .responseJSON { response in
                
                switch response.result {

                case .success(let json):
                    let JSON = json as? NSDictionary
                    let id = (JSON!["albums"] as? NSDictionary)?.value(forKey: "items") as? Array<NSDictionary>
                    var element = Array<newReleases>()
                    for elements in id! {
                        element.append(newReleases(artists: (elements.value(forKey: "artists") as! Array<NSDictionary>), markets: (elements.value(forKey: "available_markets") as! Array<String>), links: elements.value(forKey: "external_urls") as? Array<NSDictionary>, id: (elements.value(forKey: "id") as! String), images: (elements.value(forKey: "images") as! Array<NSDictionary>), name: elements.value(forKey: "name") as! String, releaseDate: elements.value(forKey: "release_date") as! String, type: elements.value(forKey: "type") as! String, directLink: (elements.value(forKey: "uri") as! String)))
                    }
                        completion(element)
                case .failure(let error):
                    print(error)
                }
                }
    }
    
    func getSearch (text: String,completion: @escaping (Array<newSearch>)->()) {
        let headers: HTTPHeaders = [
          "Authorization":"Bearer \(appKey!)"
        ]
        AF.request("https://api.spotify.com/v1/search?q=\(text.replacingOccurrences(of: " ", with: "%20"))&type=track", headers: headers)
            .responseJSON { response in
                
                switch response.result {

                case .success(let json):
                    let JSON = json as? NSDictionary
                    let id = (JSON!["tracks"] as? NSDictionary)?.value(forKey: "items") as? Array<NSDictionary>
                    var element = Array<newSearch>()
                    for elements in id! {
                        
                        element.append(newSearch(artists: (elements.value(forKey: "artists") as? Array<NSDictionary>), id: (elements.value(forKey: "id") as! String), name: (elements.value(forKey: "name") as! String), directLink: (elements.value(forKey: "uri") as! String), previewUrl: (elements.value(forKey: "preview_url") as? String ?? "<null>")))
                    }
                        completion(element)
                case .failure(let error):
                    print(error)
                }
                }
    }
    
    func getNewPlaylist (completion: @escaping (Array<playlist>)->()) {
        let headers: HTTPHeaders = [
          "Authorization":"Bearer \(appKey!)"
        ]
        AF.request("https://api.spotify.com/v1/browse/featured-playlists", headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    let JSON = json as? NSDictionary
                    let id = (JSON!["playlists"] as? NSDictionary)?.value(forKey: "items") as? Array<NSDictionary>
                    var element = Array<playlist>()
                    for elements in id! {
                        element.append(playlist(description: (elements.value(forKey: "description") as! String), id: (elements.value(forKey: "id") as! String), images: (elements.value(forKey: "images") as! Array<NSDictionary>), name: elements.value(forKey: "name") as! String, directLink: (elements.value(forKey: "uri") as! String)))
                    }
                        completion(element)
                case .failure(let error):
                    print(error)
                }
                }
        
    }
    
    func getRecommendations (completion: @escaping (Array<recommendations>)->()) {
        let headers: HTTPHeaders = [
          "Authorization":"Bearer \(appKey!)"
        ]
        AF.request("https://api.spotify.com/v1/recommendations?seed_genres=electro", headers: headers)
            .responseJSON { response in
                
                switch response.result {

                case .success(let json):
                    let JSON = json as? NSDictionary
                    print(JSON!)
                    let id = JSON!["tracks"] as? Array<NSDictionary>
                    var element = Array<recommendations>()
                    for elements in id! {
                        if elements["album"] != nil {
                            element.append(recommendations(artists: (elements.value(forKey: "artists") as? Array<NSDictionary>), links: elements.value(forKey: "external_urls") as? Array<NSDictionary>, id: (elements.value(forKey: "id") as? String), images: ((elements.value(forKey: "album") as? NSDictionary)?.value(forKey: "images") as! Array<NSDictionary>), name: elements.value(forKey: "name") as? String ?? "null", releaseDate: elements.value(forKey: "releaseDate") as? String ?? "null", type: elements.value(forKey: "type") as? String ?? "null", directLink: (elements.value(forKey: "uri") as! String), previewUrl : (elements.value(forKey: "preview_url") as? String ?? "<null>")))
                            
                        } else {
                            element.append(recommendations(artists: (elements.value(forKey: "artists") as? Array<NSDictionary>), links: elements.value(forKey: "external_urls") as? Array<NSDictionary>, id: (elements.value(forKey: "id") as? String), images: (elements.value(forKey: "images") as? Array<NSDictionary>), name: elements.value(forKey: "name") as? String ?? "null", releaseDate: elements.value(forKey: "releaseDate") as? String ?? "null", type: elements.value(forKey: "type") as? String ?? "null", directLink: (elements.value(forKey: "uri") as! String), previewUrl : (elements.value(forKey: "preview_url") as? String ?? "<null>")))
                        }

                    }
                        completion(element)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getToken (completion: @escaping (Bool)->()) {
        let headers: HTTPHeaders = [
          "Authorization":"Basic NmY4YzJlODczM2RkNDYxMzlkNDk1NTU2OWM1ZTM4YjY6NDAxNDhkN2M2NDkwNDNlNTlhOTM0MmZhZTEzMDRjMjY="
        ]
        AF.request("https://accounts.spotify.com/api/token", method: .post, parameters: ["grant_type": "client_credentials"], headers: headers)
            .responseJSON { response in
            
            switch response.result {

            case .success(let json):
                let JSON = json as? NSDictionary
                appKey = (JSON!["access_token"] as! String)
                print(appKey!)
                    completion(true)
                
            case .failure(let error):
                print(error)
            }
            }
    }
}
