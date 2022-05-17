//
//  SurahDetailViewController.swift
//  Quranly
//
//  Created by Nabil Rei on 10/05/22.
//

import UIKit
import SwiftyJSON
import AVFoundation

class SurahDetailViewController: UIViewController {
    
    var numberOfSurah: Int?
    var numberOfAyah: Int?
    
    var player:AVPlayer?
    var isPaused = false
    
    @IBOutlet weak var ayahTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        ayahTableView.delegate = self
        ayahTableView.dataSource = self
        
        print(numberOfSurah!)
        
        print("title")
        print(getSurahTitle(numberOfSurah: "\(numberOfSurah!)"))
        title = getSurahTitle(numberOfSurah: "\(numberOfSurah!)")
        print("surah ayah")
        print(getSurahAyah(numberOfSurah: "\(numberOfSurah!)", ayah: "1"))
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func infoPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Help", message:
                "· Sentuh ayat untuk memutar audio\n\n· Tekan dan tahan ayat untuk membagikan ayat & melihat tafsir\n\n· Pastikan kamu terhubung dengan internet agar dapat mendengar audio ayat", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Close", style: .default))

            self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var ayahIndexPath = 1
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "tafsirAyah" {
            let detailVC = segue.destination as? TafsirViewController
            // since we already subscribe the delegate from second page, we need to connect it to here
            
            detailVC?.tafsir = getTafsirAyah(numberOfSurah: "\(numberOfSurah!)", ayah: "\(ayahIndexPath)")
            print(surahAyahTitle)
            detailVC?.surahAyah = "\(getSurahTitle(numberOfSurah: "\(numberOfSurah!)")) : \(ayahIndexPath)" ?? "-"
    }
    }

}

extension UIViewController {
    // SWIFTY JSON
    func getSurahTitle(numberOfSurah: String) -> String {
        if let path = Bundle.main.path(forResource: "Surah-JSON/\(numberOfSurah)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return "\(jsonObj["\(numberOfSurah)"]["name_latin"])"
            } catch let error {
                return "parse error: \(error.localizedDescription)"
            }
        } else {
            return "Invalid filename/path."
        }
    }
    
    func getSurahTitleArab(numberOfSurah: String) -> String {
        if let path = Bundle.main.path(forResource: "Surah-JSON/\(numberOfSurah)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return "\(jsonObj["\(numberOfSurah)"]["name"])"
            } catch let error {
                return "parse error: \(error.localizedDescription)"
            }
        } else {
            return "Invalid filename/path."
        }
    }
    
    func getSurahNumberOfAyah(numberOfSurah: String) -> String {
        if let path = Bundle.main.path(forResource: "Surah-JSON/\(numberOfSurah)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return "\(jsonObj["\(numberOfSurah)"]["number_of_ayah"])"
            } catch let error {
                return "parse error: \(error.localizedDescription)"
            }
        } else {
            return "Invalid filename/path."
        }
    }
    
    func getSurahAyah(numberOfSurah: String, ayah: String) -> String {
        if let path = Bundle.main.path(forResource: "Surah-JSON/\(numberOfSurah)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return "\(jsonObj["\(numberOfSurah)"]["text"][ayah])"
            } catch let error {
                return "parse error: \(error.localizedDescription)"
            }
        } else {
            return "Invalid filename/path."
        }
    }
    
    func getAyahTranslation(numberOfSurah: String, ayah: String) -> String {
        if let path = Bundle.main.path(forResource: "Surah-JSON/\(numberOfSurah)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return "\(jsonObj["\(numberOfSurah)"]["translations"]["id"]["text"][ayah])"
            } catch let error {
                return "parse error: \(error.localizedDescription)"
            }
        } else {
            return "Invalid filename/path."
        }
    }
    
    func getFirstAyahOfSurah(numberOfSurah i: Int) -> Int {
        if i == 1 { return 1 }
        if i == 2 { return 8 }
        if i == 3 { return 294 }
        if i == 4 { return 494 }
        if i == 5 { return 670 }
        if i == 6 { return 790 }
        if i == 7 { return 955 }
        if i == 8 { return 1161 }
        if i == 9 { return 1236 }
        if i == 10 { return 1365 }
        if i == 11 { return 1474 }
        if i == 12 { return 1597 }
        if i == 13 { return 1708 }
        if i == 14 { return 1751 }
        if i == 15 { return 1803 }
        if i == 16 { return 1902 }
        if i == 17 { return 2030 }
        if i == 18 { return 2141 }
        if i == 19 { return 2251 }
        if i == 20 { return 2349 }
        if i == 21 { return 2484 }
        if i == 22 { return 2596 }
        if i == 23 { return 2674 }
        if i == 24 { return 2792 }
        if i == 25 { return 2856 }
        if i == 26 { return 2933 }
        if i == 27 { return 3160 }
        if i == 28 { return 3253 }
        if i == 29 { return 3341 }
        if i == 30 { return 3410 }
        if i == 31 { return 3470 }
        if i == 32 { return 3504 }
        if i == 33 { return 3534 }
        if i == 34 { return 3607 }
        if i == 35 { return 3661 }
        if i == 36 { return 3706 }
        if i == 37 { return 3789 }
        if i == 38 { return 3971 }
        if i == 39 { return 4059 }
        if i == 40 { return 4134 }
        if i == 41 { return 4219 }
        if i == 42 { return 4273 }
        if i == 43 { return 4326 }
        if i == 44 { return 4415 }
        if i == 45 { return 4474 }
        if i == 46 { return 4511 }
        if i == 47 { return 4546 }
        if i == 48 { return 4584 }
        if i == 49 { return 4613 }
        if i == 50 { return 4631 }
        if i == 51 { return 4676 }
        if i == 52 { return 4736 }
        if i == 53 { return 4785 }
        if i == 54 { return 4847 }
        if i == 55 { return 4902 }
        if i == 56 { return 4980 }
        if i == 57 { return 5076 }
        if i == 58 { return 5105 }
        if i == 59 { return 5127 }
        if i == 60 { return 5151 }
        if i == 61 { return 5164 }
        if i == 62 { return 5178 }
        if i == 63 { return 5189 }
        if i == 64 { return 5200 }
        if i == 65 { return 5218 }
        if i == 66 { return 5230 }
        if i == 67 { return 5242 }
        if i == 68 { return 5272 }
        if i == 69 { return 5324 }
        if i == 70 { return 5376 }
        if i == 71 { return 5420 }
        if i == 72 { return 5448 }
        if i == 73 { return 5476 }
        if i == 74 { return 5496 }
        if i == 75 { return 5552 }
        if i == 76 { return 5592 }
        if i == 77 { return 5623 }
        if i == 78 { return 5673 }
        if i == 79 { return 5713 }
        if i == 80 { return 5759 }
        if i == 81 { return 5801 }
        if i == 82 { return 5830 }
        if i == 83 { return 5849 }
        if i == 84 { return 5885 }
        if i == 85 { return 5910 }
        if i == 86 { return 5932 }
        if i == 87 { return 5949 }
        if i == 88 { return 5968 }
        if i == 89 { return 5994 }
        if i == 90 { return 6024 }
        if i == 91 { return 6044 }
        if i == 92 { return 6059 }
        if i == 93 { return 6080 }
        if i == 94 { return 6091 }
        if i == 95 { return 6099 }
        if i == 96 { return 6107 }
        if i == 97 { return 6126 }
        if i == 98 { return 6131 }
        if i == 99 { return 6139 }
        if i == 100 { return 6147 }
        if i == 101 { return 6158 }
        if i == 102 { return 6169 }
        if i == 103 { return 6177 }
        if i == 104 { return 6180 }
        if i == 105 { return 6189 }
        if i == 106 { return 6194 }
        if i == 107 { return 6198 }
        if i == 108 { return 6205 }
        if i == 109 { return 6208 }
        if i == 110 { return 6214 }
        if i == 111 { return 6217 }
        if i == 112 { return 6222 }
        if i == 113 { return 6226 }
        if i == 114 { return 6231 }
        else { return 1 }
    }
    
    func getTafsirAyah(numberOfSurah: String, ayah: String) -> String {
        if let path = Bundle.main.path(forResource: "Surah-JSON/\(numberOfSurah)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return "\(jsonObj["\(numberOfSurah)"]["tafsir"]["id"]["kemenag"]["text"][ayah])"
            } catch let error {
                return "parse error: \(error.localizedDescription)"
            }
        } else {
            return "Invalid filename/path."
        }
    }
    
}

//MARK: - TABLE VIEW FOR SURAH
extension SurahDetailViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func getNumerals(num: Int) -> String {
        
            let number = NSNumber(value: num)
            let format = NumberFormatter()
            format.locale = Locale(identifier: "ar") // You can set locale of your language
            let formatedNumber = format.string(from: number)
            return formatedNumber!
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(getSurahNumberOfAyah(numberOfSurah: "\(self.numberOfSurah!)")) ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ayahCell", for: indexPath) as! SurahDetailTableViewCell
        
        let ayahArab = getNumerals(num: indexPath.row + 1)
        
        cell.ayahLabel?.text = "\(self.getSurahAyah(numberOfSurah: "\(self.numberOfSurah!)", ayah: "\(indexPath.row + 1)"))"
        cell.translateLabel?.text = "\(indexPath.row + 1). \(self.getAyahTranslation(numberOfSurah: "\(self.numberOfSurah!)", ayah: "\(indexPath.row + 1)"))"

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        var ayahInQuran = getFirstAyahOfSurah(numberOfSurah: numberOfSurah!)+(indexPath.row)
        
        url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/\(ayahInQuran).mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        if !isPaused {
            player?.play()
        } else {
            player?.pause()
        }
        
        print("Number of Ayah in Quran : \(getFirstAyahOfSurah(numberOfSurah: numberOfSurah!)+(indexPath.row))")
        let seconds : Float64 = CMTimeGetSeconds(playerItem.asset.duration)
        print(seconds)

    }
    
    func tableView(_ tableView: UITableView,
      contextMenuConfigurationForRowAt indexPath: IndexPath,
      point: CGPoint) -> UIContextMenuConfiguration? {
        
        ayahIndexPath = indexPath.row + 1

        let share = UIAction(title: "Share ayat", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                print("shared button")
                //Set the default sharing message.
            let message = """
\(self.getSurahTitle(numberOfSurah: "\(self.numberOfSurah!)")) : \(self.getSurahNumberOfAyah(numberOfSurah: "\(self.numberOfSurah!)"))\n\n\(self.getSurahAyah(numberOfSurah: "\(self.numberOfSurah!)", ayah: "\(indexPath.row + 1)"))\n\n\(self.getAyahTranslation(numberOfSurah: "\(self.numberOfSurah!)", ayah: "\(indexPath.row + 1)"))\n\nYuk awali hari dengan membaca Al-Quran di Qurany App 😊
"""
                       //Set the link to share.
                       if let link = NSURL(string: "")
                       {
                           let objectsToShare = [message,link] as [Any]
                           let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                           activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                           self.present(activityVC, animated: true, completion: nil)
                       }
            
        }
        
        let tafsir = UIAction(title: "Tafsir", image: UIImage(systemName: "text.book.closed.fill")) {
            _ in
            self.performSegue(withIdentifier: "tafsirAyah", sender: self)
            
        }

      return UIContextMenuConfiguration(identifier: nil,
        previewProvider: nil) { _ in
        UIMenu(children: [share, tafsir])
      }
    }
}


//MARK: - STRING EXTENSION
extension String {
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = locale

        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            let digit = Self.formatter.number(from: original)!
            let localized = Self.formatter.string(from: digit)!
            return (original, localized)
        }

        return maps.reduce(self) { converted, map in
            converted.replacingOccurrences(of: map.original, with: map.converted)
        }
    }
}

