//
//  playerViewController.swift
//  ProgMobile
//
//  Created by ALEXENDRE OBLI on 23/12/2019.
//  Copyright © 2019 Alexendre. All rights reserved.
//

import UIKit
import AVFoundation
import NotificationCenter

class playerViewController: UIViewController {
    var player : AVPlayer?
    var imageView = UIImageView()
    var playPauseButton = UIButton()
    var titleView = UILabel()
    var artist = UILabel()
    

    
    func initNotif(){
        NotificationCenter.default.addObserver(self, selector: #selector(playMusic(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.playMusic(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        print("playerOk")
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height))
        imageView.contentMode = .scaleAspectFill
        playPauseButton.frame.size = CGSize(width: 40, height: 40)
        playPauseButton.backgroundColor = UIColor.green
        playPauseButton.layer.cornerRadius = 10
        playPauseButton.layer.masksToBounds = true
        playPauseButton.center = self.view.center
        playPauseButton.setTitle("Play", for: .normal)
        
        titleView.frame.size = CGSize(width: self.view.frame.width, height: 60)
        titleView.center.x = self.view.center.x
        titleView.frame.origin.y = 0
        titleView.text = "Titre"
        
        artist.frame.size = CGSize(width: self.view.frame.width, height: 60)
        artist.center.x = self.view.center.x
        artist.frame.origin.y = 70
        artist.text = "Artiste"
        
        imageView.backgroundColor = .green
        
        self.view.addSubview(imageView)
        self.imageView.addSubview(playPauseButton)
        self.imageView.addSubview(titleView)
        self.imageView.addSubview(artist)
        // handle notification
        // Do any additional setup after loading the view.
    }
    
    @objc func playMusic(_ notification: NSNotification){
        if (player != nil){
            player?.pause()
        }
        if let dict = notification.userInfo as NSDictionary? {
            print("playing \((dict["ImageLink"] as? String)!)")
            if ((dict[dict.allKeys.first!] as? String)!.count >= 10){ do {
                self.imageView.downloaded(from: (dict["ImageLink"] as? String)!)
                self.playPauseButton.setTitle("Pause", for: .normal)
                self.artist.text = (dict["Artiste"] as? String)!
                self.titleView.text = (dict["Name"] as? String)!
            let playerItem = AVPlayerItem(url: URL(string: ((dict["link"] as? String)!))!)
            
            self.player = AVPlayer(playerItem: playerItem)
            player!.volume = 1.0
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }}

        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
