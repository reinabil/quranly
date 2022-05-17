//
//  HomeViewController.swift
//  Quranly
//
//  Created by Nabil Rei on 26/04/22.
//

import UIKit
import UserNotifications
import AVFoundation
import AVKit
import Toaster


var tafsirText = ""
var surahAyahTitle = "Quranly"
var surahArabGlobal = "بِسْــــــــــــــــــمِ اللهِ الرَّحْمَنِ الرَّحِيْمِ "
var surahArtiGlobal = "Dengan menyebut nama Allah Yang Maha Pengasih lagi Maha Penyayang"
var ayahNumberInQuran = 1
var url: URL?


class HomeViewController: UIViewController {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?

    @IBOutlet weak var surahAyah: UILabel!
    @IBOutlet weak var hijriDate: UILabel!
    @IBOutlet weak var verseTitle: UILabel!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var ayah: UILabel!
    @IBOutlet weak var translation: UILabel!
    @IBOutlet weak var tafsir: UILabel!
    @IBOutlet weak var goToTafsir: UIButton!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var stackViewHome: UIStackView!
    @IBOutlet weak var playButtonNavBar: UIBarButtonItem!
    
    @IBOutlet weak var ayahNew: UITextView!
    var isFinishedLoading =  false
    static var ayahInSurahGlobal = 1
    
    static var ayahInQuranHome = 1
    var isPlayed = false
    var isMuted = false
    
    
    var surahAyahString = "Al-Fatiha : 1"
    
    
    var quranManager = QuranManager()
    var surahManager = SurahManager()
    
    let ayahView = UIView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        translation.textColor = UIColor(named: "black-white")
        try! AVAudioSession.sharedInstance().setCategory(.playback)
        navigationController?.navigationBar.prefersLargeTitles = true
        
////            let animationView = AnimationView(name: "quran-lottie")
////        animationView.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
////        animationView.contentMode = .scaleAspectFit
////        animationView.center = self.stackViewHome.center
//            animationView.frame = CGRect(x: 0, y: 0, width: 50, height: 100)
//            stackViewHome.addSubview(animationView)
//            animationView.play()
//            animationView.loopMode = .loop
        
        tafsirText = """
Jar majrur (بِسْمِ) di awal ayat berkaitan dengan kata kerja yang tersembunyi setelahnya sesuai dengan jenis aktifitas yang sedang dikerjakan. Misalnya anda membaca basmalah ketika hendak makan, maka takdir kalimatnya adalah : “Dengan menyebut nama Allah aku makan”.\n\nKita katakan (dalam kaidah bahasa Arab) bahwa jar majrur harus memiliki kaitan dengan kata yang tersembunyi setelahnya, karena keduanya adalah ma’mul. Sedang setiap ma’mul harus memiliki ‘amil.\n\nAda dua fungsi mengapa kita letakkan kata kerja yang tersembunyi itu di belakang.\n\nPertama : Tabarruk (mengharap berkah) dengan mendahulukan asma Allah Azza wa Jalla.\n\nKedua : Pembatasan maksud, karena meletakkan ‘amil dibelakang berfungsi membatasi makna. Seolah engkau berkata : “Aku tidak makan dengan menyebut nama siapapun untuk mengharap berkah dengannya dan untuk meminta pertolongan darinya selain nama Allah Azza wa Jalla”.\n\nKata tersembunyi itu kita ambil dari kata kerja ‘amal (dalam istilah nahwu) itu pada asalnya adalah kata kerja. Ahli nahwu tentu sudah mengetahui masalah ini. Oleh karena itulah kata benda tidak bisa menjadi ‘ami’l kecuali apabila telah memenuhi syarat-syarat tertentu.\n\nLalu mengapa kita katakan : “Kata kerja setelahnya disesuaikan dengan jenis pekerjaan yang sedang dikerjakan”, karena lebih tepat kepada yang dimaksud. Oleh sebab itu, Rasulullah Shallallahu ‘alaihi wa sallam bersabda.\n\nيَذْبَحْ بِاسْمِ اللَّهِ\n\n“Barangsiapa yang belum menyembelih, maka jika menyembelih hendaklah ia menyembelih dengan menyebut nama Allah"\n\nAtau : “Hendaklah ia menyembelih atas nama Allah”\n\nKata kerja, yakni ‘menyembelih’, disebutkan secara khusus disitu.\n\nLafzhul Jalalah (Allah). Merupakan nama bagi Allah Rabbul Alamin, selain Allah tidak boleh diberi nama denganNya. Nama ‘Allah’ merupakan asal, adapun nama-nama Allah selainnya adalah tabi’ (cabang darinya).\n\nAr-Rahmaan Yakni yang memiliki kasih sayang yang maha luas. Oleh sebab itu, disebutkan dalam wazan fa’laan, yang menunjukkan keluasannya.\n\nAr-Rahiim Yakni yang mencurahkan kasih sayang kepada hamba-hamba yang dikehendakiNya. Oleh sebab itu, disebutkan dalam wazan fa’iil, yang menunjukkan telah terlaksananya curahan kasih saying tersebut. Di sini ada dua penunjukan kasih sayang, yaitu kasih sayang merupakan sifat Allah, seperti yang terkandung dalam nama ‘Ar-Rahmaan’ dan kasih sayang yang merupakan perbuatan Allah, yakni mencurahkan kasih sayang kepada orang-orang yang disayangiNya, seperti yang terkandung dalam nama ‘Ar-Rahiim’. Jadi, Ar-Rahmaan dan Ar-Rahiiim adalah dua Asma’ Allah yang menunjukkan Dzat, sifat kasih sayang dan pengaruhnya, yaitu hikmah yang merupakan konsekuensi dari sifat ini.\n\nKasih sayang yang Allah tetapkan bagi diriNya bersifat hakiki berdasarkan dalil wahyu dan akal sehat. Adapun dalil wahyu, seperti yang telah ditetapkan dalam Al-Qur’an dan As-Sunnah tentang penetapan sifat Ar-Rahmah (kasih sayang) bagi Allah, dan itu banyak sekali. Adapun dalil akal sehat, seluruh nikmat yang kita terima dan musibah yang terhindar dari kita merupakan salah satu bukti curahan kasih sayang Allah kepada kita.
"""
        
        var notifText = [
        "Biar hari ini jadi berkah, mulai hari dengan ngaji yuk ah 😇",
        "Jadikan Al-Quran sebagai penyemangat harimu 😀",
        "Minyak wangi dari wangi kayu~ Baca 1 ayat dulu yu 😅",
        "Temuin ketenangan dari 1 ayat Al-Quran di sini 😌",
        "Gak usah galau, Al-Quran selalu bisa jadi penenang hatimu 😎",
        "Allah selalu ada di hatimu, yuk baca 1 ayat Quran dulu 😊",
        "1 ayat berjuta manfaat, ngaji dulu yuk sobat 🤩"
        ]
        
        
        
        let randomInt = Int.random(in: 0..<6)
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound], completionHandler: {
            (granted, error) in
            
        })
        
        let notif = notifText[randomInt]
        
        let content = UNMutableNotificationContent()
        content.title = "Quranly"
        content.body = notif
        content.sound = .default
        
        var date = DateComponents()
        date.hour = 7
        date.minute = 0
        
        func getRangeOfSubString(subString: String, fromString: String) -> NSRange {
            let sampleLinkRange = fromString.range(of: subString)!
            let startPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.lowerBound)
            let endPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.upperBound)
            let linkRange = NSMakeRange(startPos, endPos - startPos)
            return linkRange
        }
        
            
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: {
            (error) in
            
        })
        
        quranManager.delegate = self
        showSpinner(onView: self.view)
        
        quranManager.fetchAyah()
        
        
        
//        view.addSubview(ayahView)
//        ayahView.addSubview(ayah)
//        ayahView.layer.borderWidth = 1
//        ayahView.layer.borderColor = UIColor.black.cgColor
//
//
//        NSLayoutConstraint.activate([
//            ayahView.heightAnchor.constraint(equalTo: ayah.heightAnchor, constant: 10),
//            ayahView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
//            ayahView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//
//            ayah.centerXAnchor.constraint(equalTo: ayahView.centerXAnchor),
//            ayah.centerYAnchor.constraint(equalTo: ayahView.centerYAnchor)
//
//        ])
        
        ayah.layer.borderWidth = 0
        ayah.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        ayah.layer.cornerRadius = 12
        
        ayahNew.layer.borderWidth = 0
        ayahNew.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        ayahNew.layer.cornerRadius = 12
        ayahNew.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20);

        url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/\(ayahNumberInQuran).mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        isMuted = false
        playButtonNavBar.image = UIImage(systemName: "speaker.slash.fill")
       
        isPlayed = true
        play.setImage(UIImage(systemName: "play.fill"), for: .normal)
        play.setTitle("Play", for: .normal)
        
        
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tafsirModal" {
            let detailVC = segue.destination as? TafsirViewController
            // since we already subscribe the delegate from second page, we need to connect it to here
            detailVC?.tafsir = tafsirText
            print(surahAyahTitle)
            detailVC?.surahAyah = surahAyahTitle ?? "-"
    }
}

    @IBAction func sharePressed(_ sender: UIBarButtonItem) {
//        print("shared button")
//        //Set the default sharing message.
//               let message = "\(surahAyahTitle)\n\n\(surahArabGlobal)\n\n\(surahArtiGlobal)\n\nAyo awali hari dengan membaca Al-Quran di Quranify App 😊"
//               //Set the link to share.
//               if let link = NSURL(string: "")
//               {
//                   let objectsToShare = [message,link] as [Any]
//                   let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//                   activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
//                   self.present(activityVC, animated: true, completion: nil)
//               }
        self.performSegue(withIdentifier: "tafsirModal", sender: self)
    }
    
    @IBAction func playPressedNavBar(_ sender: UIBarButtonItem) {
        url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/\(ayahNumberInQuran).mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
//
//        if !isPlayed {
//            player?.pause()
//            isPlayed = true
//            playButtonNavBar.image = UIImage(systemName: "play.fill")
//
//
//            print(isPlayed)
//
//        } else {
//            player?.play()
//            isPlayed = false
//            playButtonNavBar.image = UIImage(systemName: "stop.fill")
//
//            print(isPlayed)
//        }
        if isMuted {
            player?.play()
            isMuted = false
            playButtonNavBar.image = UIImage(systemName: "speaker.slash.fill")
        } else {
            player?.pause()
            isMuted = true
            playButtonNavBar.image = UIImage(systemName: "speaker.wave.2.fill")
        }
        
    }
    @IBAction func playPressed(_ sender: UIButton) {
//        url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/\(ayahNumberInQuran).mp3")
//        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
//        player = AVPlayer(playerItem: playerItem)
//
//        if !isPlayed {
//            player?.pause()
//            isPlayed = true
//            play.setImage(UIImage(systemName: "play.fill"), for: .normal)
//            play.setTitle("Play", for: .normal)
//
//            print(isPlayed)
//
//        } else {
//            player?.play()
//            isPlayed = false
//            play.setImage(UIImage(systemName: "stop.fill"), for: .normal)
//            play.setTitle("Stop", for: .normal)
//
//            print(isPlayed)
//        }
        
        if !isMuted {
            isMuted = true
            play.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        } else {
            isMuted = false
            play.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        }
        
    }
    

    @IBAction func belajarPressed(_ sender: UIButton) {
        if let url = URL(string: "https://apps.apple.com/id/app/qiroah-latihan-baca-al-quran/id1491441336") {
              if #available(iOS 10, *){
                  UIApplication.shared.open(url)
              }else{
                  UIApplication.shared.openURL(url)
              }

          }
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
       
    }
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        showSpinner(onView: self.view)
        quranManager.fetchAyah()
        print("Ayah in Surah Global")
        print(HomeViewController.ayahInSurahGlobal)

        
    }
    @IBAction func goToTafsirPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "tafsirModal", sender: self)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        showSpinner(onView: self.view)
        quranManager.nextAyah(surah: surahNumberGenerator(HomeViewController.ayahInQuranHome+1), ayah: ayahInSurahGeneratorNext(HomeViewController.ayahInQuranHome))
        print("Ayah in Global")
        print(HomeViewController.ayahInQuranHome)
        print("Ayah in Surah")
        print(HomeViewController.ayahInSurahGlobal+1)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        showSpinner(onView: self.view)
        
        quranManager.prevAyah(surah: surahNumberGenerator(HomeViewController.ayahInQuranHome-1), ayah: ayahInSurahGeneratorPrev(HomeViewController.ayahInQuranHome))
    }
    
}

extension HomeViewController: SurahManagerDelegate {
    
    func didUpdateSurah(_ surahManager: SurahManager, surah: SurahModel) {
        
        DispatchQueue.main.async {
            print("halloe")
        }
    }
    
}

extension HomeViewController: QuranManagerDelegate{
    
    func getNumerals(num: Int) -> String {
        
            let number = NSNumber(value: num)
            let format = NumberFormatter()
            format.locale = Locale(identifier: "ar") // You can set locale of your language
            let formatedNumber = format.string(from: number)
            return formatedNumber!
        
        }
    
    func didUpdateQuran(_ quranManager: QuranManager, quran: QuranModel) {
        
        var defaults = UserDefaults.standard
        
        DispatchQueue.main.async {
            
            self.ayah.text = quran.ayahArab
            self.ayahNew.text = "\(quran.ayahArab)"
            self.translation.text = quran.ayahTranslation
            tafsirText = quran.ayahTafsirLong
            surahArabGlobal = quran.ayahArab
            surahArtiGlobal = quran.ayahTranslation
            ayahNumberInQuran = quran.ayahInQuran
            
            print(quran.ayahInQuran)
            surahAyahTitle = "\(self.surahNameGenerator(quran.ayahInQuran))" + " : " + "\(quran.ayahInSurah)"
            
            
            
            self.title = "\(self.surahNameGenerator(quran.ayahInQuran))" + " : " + "\(quran.ayahInSurah)"
            
            
            url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/\(ayahNumberInQuran).mp3")
            let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
            self.player = AVPlayer(playerItem: playerItem)
            
            if !self.isMuted {
                self.player?.play()
            }
            
            self.removeSpinner()
            ToastCenter.default.cancelAll()
            
//            self.url = URL(string: "\(quran.ayahURLAudio)")
//            print(self.url!)
//            self.surahManager.fetchSurah(self.ayahInQuranHome)
//            print(self.ayahInQuranHome!)
            
           
        }
        
        HomeViewController.ayahInQuranHome = quran.ayahInQuran
        HomeViewController.ayahInSurahGlobal = quran.ayahInSurah
        
    }
    
    func didFailWithError(error: Error){
        print(error)
    }
    
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)

        
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.6)
        
        let ai = UIActivityIndicatorView.init(style: .white)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        
        let toast = Toast(text: "Pastikan internet kamu lancar ya 😉")
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            toast.view.bottomOffsetPortrait = 160
            toast.show()
            
        
            UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                self.view.addSubview(spinnerView)
            }, completion: nil)
            
            NSLayoutConstraint.activate([
                ai.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor),
                ai.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor),
            ])
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    func surahNameGenerator(_ i: Int) -> String {
        if i > 0 && i <= 7{ return "Al-Fatihah"}
        if i > 7 && i <= 293{ return "Al-Baqarah"}
        if i > 293 && i <= 493{ return "Ali 'Imran"}
        if i > 493 && i <= 669{ return "An-Nisa'"}
        if i > 669 && i <= 789{ return "Al-Ma'idah"}
        if i > 789 && i <= 954{ return "Al-An'am"}
        if i > 954 && i <= 1160{ return "Al-A’raf"}
        if i > 1160 && i <= 1235{ return "Al-Anfal"}
        if i > 1235 && i <= 1364{ return "At-Taubah"}
        if i > 1364 && i <= 1473{ return "Yunus"}
        if i > 1473 && i <= 1596{ return "Hud"}
        if i > 1596 && i <= 1707{ return "Yusuf"}
        if i > 1707 && i <= 1750{ return "Ar-Ra’d"}
        if i > 1750 && i <= 1802{ return "Ibrahim"}
        if i > 1802 && i <= 1901{ return "Al-Hijr"}
        if i > 1901 && i <= 2029{ return "An-Nahl"}
        if i > 2029 && i <= 2140{ return "Al-Isra'"}
        if i > 2140 && i <= 2250{ return "Al-Kahf"}
        if i > 2250 && i <= 2348{ return "Maryam"}
        if i > 2348 && i <= 2483{ return "Ta Ha"}
        if i > 2483 && i <= 2595{ return "Al-Anbiya"}
        if i > 2595 && i <= 2673{ return "Al-Hajj"}
        if i > 2673 && i <= 2791{ return "Al-Mu’minun"}
        if i > 2791 && i <= 2855{ return "An-Nur"}
        if i > 2855 && i <= 2932{ return "Al-Furqan"}
        if i > 2932 && i <= 3159{ return "Asy-Syu'ara'"}
        if i > 3159 && i <= 3252{ return "An-Naml"}
        if i > 3252 && i <= 3340{ return "Al-Qasas"}
        if i > 3340 && i <= 3409{ return "Al-'Ankabut"}
        if i > 3409 && i <= 3469{ return "Ar-Rum"}
        if i > 3469 && i <= 3503{ return "Luqman"}
        if i > 3503 && i <= 3533{ return "As-Sajdah"}
        if i > 3533 && i <= 3606{ return "Al-Ahzab"}
        if i > 3606 && i <= 3660{ return "Saba’"}
        if i > 3660 && i <= 3705{ return "Fatir"}
        if i > 3705 && i <= 3788{ return "Ya Sin"}
        if i > 3788 && i <= 3970{ return "As-Saffat"}
        if i > 3970 && i <= 4058{ return "Sad"}
        if i > 4058 && i <= 4133{ return "Az-Zumar"}
        if i > 4133 && i <= 4218{ return "Ghafir"}
        if i > 4218 && i <= 4272{ return "Fussilat"}
        if i > 4272 && i <= 4325{ return "Asy-Syura"}
        if i > 4325 && i <= 4414{ return "Az-Zukhruf"}
        if i > 4414 && i <= 4473{ return "Ad-Dukhan"}
        if i > 4473 && i <= 4510{ return "Al-Jasiyah"}
        if i > 4510 && i <= 4545{ return "Al-Ahqaf"}
        if i > 4545 && i <= 4583{ return "Muhammad"}
        if i > 4583 && i <= 4612{ return "Al-Fath"}
        if i > 4612 && i <= 4630{ return "Al-Hujurat"}
        if i > 4630 && i <= 4675{ return "Qaf"}
        if i > 4675 && i <= 4735{ return "Az-Zariyat"}
        if i > 4735 && i <= 4784{ return "At-Tur"}
        if i > 4784 && i <= 4846{ return "An-Najm"}
        if i > 4846 && i <= 4901{ return "Al-Qamar"}
        if i > 4901 && i <= 4979{ return "Ar-Rahman"}
        if i > 4979 && i <= 5075{ return "Al-Waqi’ah"}
        if i > 5075 && i <= 5104{ return "Al-Hadid"}
        if i > 5104 && i <= 5126{ return "Al-Mujadilah"}
        if i > 5126 && i <= 5150{ return "Al-Hasyr"}
        if i > 5150 && i <= 5163{ return "Al-Mumtahanah"}
        if i > 5163 && i <= 5177{ return "As-Saff"}
        if i > 5177 && i <= 5188{ return "Al-Jumu’ah"}
        if i > 5188 && i <= 5199{ return "Al-Munafiqun"}
        if i > 5199 && i <= 5217{ return "At-Tagabun"}
        if i > 5217 && i <= 5229{ return "At-Talaq"}
        if i > 5229 && i <= 5241{ return "At-Tahrim"}
        if i > 5241 && i <= 5271{ return "Al-Mulk"}
        if i > 5271 && i <= 5323{ return "Al-Qalam"}
        if i > 5323 && i <= 5375{ return "Al-Haqqah"}
        if i > 5375 && i <= 5419{ return "Al-Ma’arij"}
        if i > 5419 && i <= 5447{ return "Nuh"}
        if i > 5447 && i <= 5475{ return "Al-Jinn"}
        if i > 5475 && i <= 5495{ return "Al-Muzzammil"}
        if i > 5495 && i <= 5551{ return "Al-Muddassir"}
        if i > 5551 && i <= 5591{ return "Al-Qiyamah"}
        if i > 5591 && i <= 5622{ return "Al-Insan"}
        if i > 5622 && i <= 5672{ return "Al-Mursalat"}
        if i > 5672 && i <= 5712{ return "An-Naba’"}
        if i > 5712 && i <= 5758{ return "An-Nazi’at"}
        if i > 5758 && i <= 5800{ return "'Abasa"}
        if i > 5800 && i <= 5829{ return "At-Takwir"}
        if i > 5829 && i <= 5848{ return "Al-Infitar"}
        if i > 5848 && i <= 5884{ return "Al-Mutaffifin"}
        if i > 5884 && i <= 5909{ return "Al-Insyiqaq"}
        if i > 5909 && i <= 5931{ return "Al-Buruj"}
        if i > 5931 && i <= 5948{ return "At-Tariq"}
        if i > 5948 && i <= 5967{ return "Al-A’la"}
        if i > 5967 && i <= 5993{ return "Al-Gasyiyah"}
        if i > 5993 && i <= 6023{ return "Al-Fajr"}
        if i > 6023 && i <= 6043{ return "Al-Balad"}
        if i > 6043 && i <= 6058{ return "Asy-Syams"}
        if i > 6058 && i <= 6079{ return "Al-Lail"}
        if i > 6079 && i <= 6090{ return "Ad-Duha"}
        if i > 6090 && i <= 6098{ return "Al-Insyirah"}
        if i > 6098 && i <= 6106{ return "At-Tin"}
        if i > 6106 && i <= 6125{ return "Al-'Alaq"}
        if i > 6125 && i <= 6130{ return "Al-Qadr"}
        if i > 6130 && i <= 6138{ return "Al-Bayyinah"}
        if i > 6138 && i <= 6146{ return "Az-Zalzalah"}
        if i > 6146 && i <= 6157{ return "Al-'Adiyat"}
        if i > 6157 && i <= 6168{ return "Al-Qari'ah"}
        if i > 6168 && i <= 6176{ return "At-Takasur"}
        if i > 6176 && i <= 6179{ return "Al-'Asr"}
        if i > 6179 && i <= 6188{ return "Al-Humazah"}
        if i > 6188 && i <= 6193{ return "Al-Fil"}
        if i > 6193 && i <= 6197{ return "Quraisy"}
        if i > 6197 && i <= 6204{ return "Al-Ma’un"}
        if i > 6204 && i <= 6207{ return "Al-Kausar"}
        if i > 6207 && i <= 6213{ return "Al-Kafirun"}
        if i > 6213 && i <= 6216{ return "An-Nasr"}
        if i > 6216 && i <= 6221{ return "Al-Lahab"}
        if i > 6221 && i <= 6225{ return "Al-Ikhlas"}
        if i > 6225 && i <= 6230{ return "Al-Falaq"}
        if i > 6230 && i <= 6236{ return "An-Nas"}
        else { return "-"}
    }
    
    func surahNumberGenerator(_ i: Int) -> Int {
        if i > 0 && i <= 7 {
return 1 }
        if i > 7 && i <= 293 { return 2 }
        if i > 293 && i <= 493 { return 3 }
        if i > 493 && i <= 669 { return 4 }
        if i > 669 && i <= 789 { return 5 }
        if i > 789 && i <= 954 { return 6 }
        if i > 954 && i <= 1160 { return 7 }
        if i > 1160 && i <= 1235 { return 8 }
        if i > 1235 && i <= 1364 { return 9 }
        if i > 1364 && i <= 1473 { return 10 }
        if i > 1473 && i <= 1596 { return 11 }
        if i > 1596 && i <= 1707 { return 12 }
        if i > 1707 && i <= 1750 { return 13 }
        if i > 1750 && i <= 1802 { return 14 }
        if i > 1802 && i <= 1901 { return 15 }
        if i > 1901 && i <= 2029 { return 16 }
        if i > 2029 && i <= 2140 { return 17 }
        if i > 2140 && i <= 2250 { return 18 }
        if i > 2250 && i <= 2348 { return 19 }
        if i > 2348 && i <= 2483 { return 20 }
        if i > 2483 && i <= 2595 { return 21 }
        if i > 2595 && i <= 2673 { return 22 }
        if i > 2673 && i <= 2791 { return 23 }
        if i > 2791 && i <= 2855 { return 24 }
        if i > 2855 && i <= 2932 { return 25 }
        if i > 2932 && i <= 3159 { return 26 }
        if i > 3159 && i <= 3252 { return 27 }
        if i > 3252 && i <= 3340 { return 28 }
        if i > 3340 && i <= 3409 { return 29 }
        if i > 3409 && i <= 3469 { return 30 }
        if i > 3469 && i <= 3503 { return 31 }
        if i > 3503 && i <= 3533 { return 32 }
        if i > 3533 && i <= 3606 { return 33 }
        if i > 3606 && i <= 3660 { return 34 }
        if i > 3660 && i <= 3705 { return 35 }
        if i > 3705 && i <= 3788 { return 36 }
        if i > 3788 && i <= 3970 { return 37 }
        if i > 3970 && i <= 4058 { return 38 }
        if i > 4058 && i <= 4133 { return 39 }
        if i > 4133 && i <= 4218 { return 40 }
        if i > 4218 && i <= 4272 { return 41 }
        if i > 4272 && i <= 4325 { return 42 }
        if i > 4325 && i <= 4414 { return 43 }
        if i > 4414 && i <= 4473 { return 44 }
        if i > 4473 && i <= 4510 { return 45 }
        if i > 4510 && i <= 4545 { return 46 }
        if i > 4545 && i <= 4583 { return 47 }
        if i > 4583 && i <= 4612 { return 48 }
        if i > 4612 && i <= 4630 { return 49 }
        if i > 4630 && i <= 4675 { return 50 }
        if i > 4675 && i <= 4735 { return 51 }
        if i > 4735 && i <= 4784 { return 52 }
        if i > 4784 && i <= 4846 { return 53 }
        if i > 4846 && i <= 4901 { return 54 }
        if i > 4901 && i <= 4979 { return 55 }
        if i > 4979 && i <= 5075 { return 56 }
        if i > 5075 && i <= 5104 { return 57 }
        if i > 5104 && i <= 5126 { return 58 }
        if i > 5126 && i <= 5150 { return 59 }
        if i > 5150 && i <= 5163 { return 60 }
        if i > 5163 && i <= 5177 { return 61 }
        if i > 5177 && i <= 5188 { return 62 }
        if i > 5188 && i <= 5199 { return 63 }
        if i > 5199 && i <= 5217 { return 64 }
        if i > 5217 && i <= 5229 { return 65 }
        if i > 5229 && i <= 5241 { return 66 }
        if i > 5241 && i <= 5271 { return 67 }
        if i > 5271 && i <= 5323 { return 68 }
        if i > 5323 && i <= 5375 { return 69 }
        if i > 5375 && i <= 5419 { return 70 }
        if i > 5419 && i <= 5447 { return 71 }
        if i > 5447 && i <= 5475 { return 72 }
        if i > 5475 && i <= 5495 { return 73 }
        if i > 5495 && i <= 5551 { return 74 }
        if i > 5551 && i <= 5591 { return 75 }
        if i > 5591 && i <= 5622 { return 76 }
        if i > 5622 && i <= 5672 { return 77 }
        if i > 5672 && i <= 5712 { return 78 }
        if i > 5712 && i <= 5758 { return 79 }
        if i > 5758 && i <= 5800 { return 80 }
        if i > 5800 && i <= 5829 { return 81 }
        if i > 5829 && i <= 5848 { return 82 }
        if i > 5848 && i <= 5884 { return 83 }
        if i > 5884 && i <= 5909 { return 84 }
        if i > 5909 && i <= 5931 { return 85 }
        if i > 5931 && i <= 5948 { return 86 }
        if i > 5948 && i <= 5967 { return 87 }
        if i > 5967 && i <= 5993 { return 88 }
        if i > 5993 && i <= 6023 { return 89 }
        if i > 6023 && i <= 6043 { return 90 }
        if i > 6043 && i <= 6058 { return 91 }
        if i > 6058 && i <= 6079 { return 92 }
        if i > 6079 && i <= 6090 { return 93 }
        if i > 6090 && i <= 6098 { return 94 }
        if i > 6098 && i <= 6106 { return 95 }
        if i > 6106 && i <= 6125 { return 96 }
        if i > 6125 && i <= 6130 { return 97 }
        if i > 6130 && i <= 6138 { return 98 }
        if i > 6138 && i <= 6146 { return 99 }
        if i > 6146 && i <= 6157 { return 100 }
        if i > 6157 && i <= 6168 { return 101 }
        if i > 6168 && i <= 6176 { return 102 }
        if i > 6176 && i <= 6179 { return 103 }
        if i > 6179 && i <= 6188 { return 104 }
        if i > 6188 && i <= 6193 { return 105 }
        if i > 6193 && i <= 6197 { return 106 }
        if i > 6197 && i <= 6204 { return 107 }
        if i > 6204 && i <= 6207 { return 108 }
        if i > 6207 && i <= 6213 { return 109 }
        if i > 6213 && i <= 6216 { return 110 }
        if i > 6216 && i <= 6221 { return 111 }
        if i > 6221 && i <= 6225 { return 112 }
        if i > 6225 && i <= 6230 { return 113 }
        if i > 6230 && i <= 6236 { return 114 }
        else { return 1}
    }
    
    func ayahInSurahGeneratorNext( _ i : Int) -> Int {
        if i == 7 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 293 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 493 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 669 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 789 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 954 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1160 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1235 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1364 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1473 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1596 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1707 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1750 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1802 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 1901 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2029 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2140 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2250 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2348 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2483 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2595 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2673 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2791 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2855 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 2932 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3159 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3252 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3340 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3409 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3469 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3503 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3533 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3606 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3660 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3705 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3788 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 3970 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4058 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4133 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4218 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4272 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4325 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4414 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4473 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4510 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4545 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4583 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4612 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4630 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4675 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4735 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4784 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4846 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4901 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 4979 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5075 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5104 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5126 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5150 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5163 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5177 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5188 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5199 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5217 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5229 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5241 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5271 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5323 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5375 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5419 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5447 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5475 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5495 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5551 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5591 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5622 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5672 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5712 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5758 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5800 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5829 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5848 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5884 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5909 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5931 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5948 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5967 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 5993 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6023 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6043 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6058 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6079 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6090 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6098 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6106 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6125 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6130 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6138 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6146 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6157 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6168 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6176 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6179 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6188 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6193 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6197 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6204 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6207 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6213 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6216 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6221 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6225 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6230 { HomeViewController.ayahInQuranHome += 1
return 1 }
        if i == 6236 { HomeViewController.ayahInQuranHome = 1
return 1 }
        else {
            HomeViewController.ayahInSurahGlobal += 1
            print("PPPPP : \(HomeViewController.ayahInQuranHome)" )
            return HomeViewController.ayahInSurahGlobal }
    }
    
    func ayahInSurahGeneratorPrev( _ i : Int) -> Int {
        if i == 1 { return 1 }
        if i == 8 { HomeViewController.ayahInQuranHome -= 1
    return 7 }
        if i == 294 { HomeViewController.ayahInQuranHome -= 1
    return 286 }
        if i == 494 { HomeViewController.ayahInQuranHome -= 1
    return 200 }
        if i == 670 { HomeViewController.ayahInQuranHome -= 1
    return 176 }
        if i == 790 { HomeViewController.ayahInQuranHome -= 1
    return 120 }
        if i == 955 { HomeViewController.ayahInQuranHome -= 1
    return 165 }
        if i == 1161 { HomeViewController.ayahInQuranHome -= 1
    return 206 }
        if i == 1236 { HomeViewController.ayahInQuranHome -= 1
    return 75 }
        if i == 1365 { HomeViewController.ayahInQuranHome -= 1
    return 129 }
        if i == 1474 { HomeViewController.ayahInQuranHome -= 1
    return 109 }
        if i == 1597 { HomeViewController.ayahInQuranHome -= 1
    return 123 }
        if i == 1708 { HomeViewController.ayahInQuranHome -= 1
    return 111 }
        if i == 1751 { HomeViewController.ayahInQuranHome -= 1
    return 43 }
        if i == 1803 { HomeViewController.ayahInQuranHome -= 1
    return 52 }
        if i == 1902 { HomeViewController.ayahInQuranHome -= 1
    return 99 }
        if i == 2030 { HomeViewController.ayahInQuranHome -= 1
    return 128 }
        if i == 2141 { HomeViewController.ayahInQuranHome -= 1
    return 111 }
        if i == 2251 { HomeViewController.ayahInQuranHome -= 1
    return 110 }
        if i == 2349 { HomeViewController.ayahInQuranHome -= 1
    return 98 }
        if i == 2484 { HomeViewController.ayahInQuranHome -= 1
    return 135 }
        if i == 2596 { HomeViewController.ayahInQuranHome -= 1
    return 112 }
        if i == 2674 { HomeViewController.ayahInQuranHome -= 1
    return 78 }
        if i == 2792 { HomeViewController.ayahInQuranHome -= 1
    return 118 }
        if i == 2856 { HomeViewController.ayahInQuranHome -= 1
    return 64 }
        if i == 2933 { HomeViewController.ayahInQuranHome -= 1
    return 77 }
        if i == 3160 { HomeViewController.ayahInQuranHome -= 1
    return 227 }
        if i == 3253 { HomeViewController.ayahInQuranHome -= 1
    return 93 }
        if i == 3341 { HomeViewController.ayahInQuranHome -= 1
    return 88 }
        if i == 3410 { HomeViewController.ayahInQuranHome -= 1
    return 69 }
        if i == 3470 { HomeViewController.ayahInQuranHome -= 1
    return 60 }
        if i == 3504 { HomeViewController.ayahInQuranHome -= 1
    return 34 }
        if i == 3534 { HomeViewController.ayahInQuranHome -= 1
    return 30 }
        if i == 3607 { HomeViewController.ayahInQuranHome -= 1
    return 73 }
        if i == 3661 { HomeViewController.ayahInQuranHome -= 1
    return 54 }
        if i == 3706 { HomeViewController.ayahInQuranHome -= 1
    return 45 }
        if i == 3789 { HomeViewController.ayahInQuranHome -= 1
    return 83 }
        if i == 3971 { HomeViewController.ayahInQuranHome -= 1
    return 182 }
        if i == 4059 { HomeViewController.ayahInQuranHome -= 1
    return 88 }
        if i == 4134 { HomeViewController.ayahInQuranHome -= 1
    return 75 }
        if i == 4219 { HomeViewController.ayahInQuranHome -= 1
    return 85 }
        if i == 4273 { HomeViewController.ayahInQuranHome -= 1
    return 54 }
        if i == 4326 { HomeViewController.ayahInQuranHome -= 1
    return 53 }
        if i == 4415 { HomeViewController.ayahInQuranHome -= 1
    return 89 }
        if i == 4474 { HomeViewController.ayahInQuranHome -= 1
    return 59 }
        if i == 4511 { HomeViewController.ayahInQuranHome -= 1
    return 37 }
        if i == 4546 { HomeViewController.ayahInQuranHome -= 1
    return 35 }
        if i == 4584 { HomeViewController.ayahInQuranHome -= 1
    return 38 }
        if i == 4613 { HomeViewController.ayahInQuranHome -= 1
    return 29 }
        if i == 4631 { HomeViewController.ayahInQuranHome -= 1
    return 18 }
        if i == 4676 { HomeViewController.ayahInQuranHome -= 1
    return 45 }
        if i == 4736 { HomeViewController.ayahInQuranHome -= 1
    return 60 }
        if i == 4785 { HomeViewController.ayahInQuranHome -= 1
    return 49 }
        if i == 4847 { HomeViewController.ayahInQuranHome -= 1
    return 62 }
        if i == 4902 { HomeViewController.ayahInQuranHome -= 1
    return 55 }
        if i == 4980 { HomeViewController.ayahInQuranHome -= 1
    return 78 }
        if i == 5076 { HomeViewController.ayahInQuranHome -= 1
    return 96 }
        if i == 5105 { HomeViewController.ayahInQuranHome -= 1
    return 29 }
        if i == 5127 { HomeViewController.ayahInQuranHome -= 1
    return 22 }
        if i == 5151 { HomeViewController.ayahInQuranHome -= 1
    return 24 }
        if i == 5164 { HomeViewController.ayahInQuranHome -= 1
    return 13 }
        if i == 5178 { HomeViewController.ayahInQuranHome -= 1
    return 14 }
        if i == 5189 { HomeViewController.ayahInQuranHome -= 1
    return 11 }
        if i == 5200 { HomeViewController.ayahInQuranHome -= 1
    return 11 }
        if i == 5218 { HomeViewController.ayahInQuranHome -= 1
    return 18 }
        if i == 5230 { HomeViewController.ayahInQuranHome -= 1
    return 12 }
        if i == 5242 { HomeViewController.ayahInQuranHome -= 1
    return 12 }
        if i == 5272 { HomeViewController.ayahInQuranHome -= 1
    return 30 }
        if i == 5324 { HomeViewController.ayahInQuranHome -= 1
    return 52 }
        if i == 5376 { HomeViewController.ayahInQuranHome -= 1
    return 52 }
        if i == 5420 { HomeViewController.ayahInQuranHome -= 1
    return 44 }
        if i == 5448 { HomeViewController.ayahInQuranHome -= 1
    return 28 }
        if i == 5476 { HomeViewController.ayahInQuranHome -= 1
    return 28 }
        if i == 5496 { HomeViewController.ayahInQuranHome -= 1
    return 20 }
        if i == 5552 { HomeViewController.ayahInQuranHome -= 1
    return 56 }
        if i == 5592 { HomeViewController.ayahInQuranHome -= 1
    return 40 }
        if i == 5623 { HomeViewController.ayahInQuranHome -= 1
    return 31 }
        if i == 5673 { HomeViewController.ayahInQuranHome -= 1
    return 50 }
        if i == 5713 { HomeViewController.ayahInQuranHome -= 1
    return 40 }
        if i == 5759 { HomeViewController.ayahInQuranHome -= 1
    return 46 }
        if i == 5801 { HomeViewController.ayahInQuranHome -= 1
    return 42 }
        if i == 5830 { HomeViewController.ayahInQuranHome -= 1
    return 29 }
        if i == 5849 { HomeViewController.ayahInQuranHome -= 1
    return 19 }
        if i == 5885 { HomeViewController.ayahInQuranHome -= 1
    return 36 }
        if i == 5910 { HomeViewController.ayahInQuranHome -= 1
    return 25 }
        if i == 5932 { HomeViewController.ayahInQuranHome -= 1
    return 22 }
        if i == 5949 { HomeViewController.ayahInQuranHome -= 1
    return 17 }
        if i == 5968 { HomeViewController.ayahInQuranHome -= 1
    return 19 }
        if i == 5994 { HomeViewController.ayahInQuranHome -= 1
    return 26 }
        if i == 6024 { HomeViewController.ayahInQuranHome -= 1
    return 30 }
        if i == 6044 { HomeViewController.ayahInQuranHome -= 1
    return 20 }
        if i == 6059 { HomeViewController.ayahInQuranHome -= 1
    return 15 }
        if i == 6080 { HomeViewController.ayahInQuranHome -= 1
    return 21 }
        if i == 6091 { HomeViewController.ayahInQuranHome -= 1
    return 11 }
        if i == 6099 { HomeViewController.ayahInQuranHome -= 1
    return 8 }
        if i == 6107 { HomeViewController.ayahInQuranHome -= 1
    return 8 }
        if i == 6126 { HomeViewController.ayahInQuranHome -= 1
    return 19 }
        if i == 6131 { HomeViewController.ayahInQuranHome -= 1
    return 5 }
        if i == 6139 { HomeViewController.ayahInQuranHome -= 1
    return 8 }
        if i == 6147 { HomeViewController.ayahInQuranHome -= 1
    return 8 }
        if i == 6158 { HomeViewController.ayahInQuranHome -= 1
    return 11 }
        if i == 6169 { HomeViewController.ayahInQuranHome -= 1
    return 11 }
        if i == 6177 { HomeViewController.ayahInQuranHome -= 1
    return 8 }
        if i == 6180 { HomeViewController.ayahInQuranHome -= 1
    return 3 }
        if i == 6189 { HomeViewController.ayahInQuranHome -= 1
    return 9 }
        if i == 6194 { HomeViewController.ayahInQuranHome -= 1
    return 5 }
        if i == 6198 { HomeViewController.ayahInQuranHome -= 1
    return 4 }
        if i == 6205 { HomeViewController.ayahInQuranHome -= 1
    return 7 }
        if i == 6208 { HomeViewController.ayahInQuranHome -= 1
    return 3 }
        if i == 6214 { HomeViewController.ayahInQuranHome -= 1
    return 6 }
        if i == 6217 { HomeViewController.ayahInQuranHome -= 1
    return 3 }
        if i == 6222 { HomeViewController.ayahInQuranHome -= 1
    return 5 }
        if i == 6226 { HomeViewController.ayahInQuranHome -= 1
    return 4 }
        if i == 6231 { HomeViewController.ayahInQuranHome -= 1
    return 5 }
        else {
            HomeViewController.ayahInSurahGlobal -= 1
            print("PPPPP : \(HomeViewController.ayahInQuranHome)" )
            return HomeViewController.ayahInSurahGlobal }
    }



}
