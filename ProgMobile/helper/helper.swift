//
//  helper.swift
//  ProgMobile
//
//  Created by Alexendre on 20/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SystemConfiguration

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

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}
