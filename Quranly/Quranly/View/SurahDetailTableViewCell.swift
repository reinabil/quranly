//
//  SurahDetailTableViewCell.swift
//  Quranly
//
//  Created by Nabil Rei on 11/05/22.
//

import UIKit
import AVFoundation

class SurahDetailTableViewCell: UITableViewCell {

    var player:AVPlayer?
    
    @IBOutlet weak var ayahLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var isPaused = false
    
    @IBAction func playPressed(_ sender: UIButton) {
        
//        url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3")
//        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
//        player = AVPlayer(playerItem: playerItem)
//        
//        if !isPaused {
//            player?.play()
//        } else {
//            player?.pause()
//        }
//        
//        
//        let seconds : Float64 = CMTimeGetSeconds(playerItem.asset.duration)
//        print(seconds)
        
//        if !isPaused {
//            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//                self.player?.pause()
//                print("PAUSED")
//            }
//        } else {
//        }
        
        isPaused = !isPaused
    }
}
