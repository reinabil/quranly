//
//  HomeViewController.swift
//  Quranly
//
//  Created by Nabil Rei on 26/04/22.
//

import UIKit
import UserNotifications
import AVFoundation
import Lottie
import AVKit

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
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var stackViewHome: UIStackView!
    @IBOutlet weak var playButtonNavBar: UIBarButtonItem!
    
    @IBOutlet weak var ayahNew: UITextView!
    var isFinishedLoading =  false
    
    var ayahInQuranHome: Int!
    var isPlayed = false
    
    var surahAyahString = "Al-Fatiha : 1"
    
    
    var quranManager = QuranManager()
    var surahManager = SurahManager()
    
    let ayahView = UIView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
//            let animationView = AnimationView(name: "quran-lottie")
//        animationView.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
//        animationView.contentMode = .scaleAspectFit
//        animationView.center = self.stackViewHome.center
            animationView.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
            stackViewHome.addSubview(animationView)
            animationView.play()
            animationView.loopMode = .loop
        
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
        
        let content = UNMutableNotificationContent()
        content.title = "Quranly"
        content.body = notifText[randomInt]
        content.sound = .default
        
        var date = DateComponents()
        date.hour = 6
        date.minute = 0
        
        ayahNew.text = "بِسْــــــــــــــــــمِ اللهِ الرَّحْمَنِ الرَّحِيْمِ "
        
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
        
//        ayah.topAnchor.constraint(equalTo: siborderygijo.topAnchor, constant: sekian)
//
//        let wrappingView = UIView(frame: UIScreen.main.bounds)
//        wrappingView.layer.borderColor = UIColor.yellow.cgColor
//        wrappingView.layer.borderWidth = 2.0;
//        wrappingView.addSubview(ayah)
        
        url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/\(ayahNumberInQuran).mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
       
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
        print("shared button")
        //Set the default sharing message.
               let message = "\(surahAyahTitle)\n\n\(surahArabGlobal)\n\n\(surahArtiGlobal)\n\nAyo awali hari dengan membaca Al-Quran di Quranify App 😊"
               //Set the link to share.
               if let link = NSURL(string: "")
               {
                   let objectsToShare = [message,link] as [Any]
                   let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                   activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                   self.present(activityVC, animated: true, completion: nil)
               }
    }
    
    @IBAction func playPressedNavBar(_ sender: UIBarButtonItem) {
        url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/\(ayahNumberInQuran).mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        if !isPlayed {
            player?.pause()
            isPlayed = true
            playButtonNavBar.image = UIImage(systemName: "play.fill")
    
            
            print(isPlayed)
            
        } else {
            player?.play()
            isPlayed = false
            playButtonNavBar.image = UIImage(systemName: "stop.fill")
            
            print(isPlayed)
        }
        
    }
    @IBAction func playPressed(_ sender: UIButton) {
        url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/\(ayahNumberInQuran).mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        if !isPlayed {
            player?.pause()
            isPlayed = true
            play.setImage(UIImage(systemName: "play.fill"), for: .normal)
            play.setTitle("Play", for: .normal)
            
            print(isPlayed)
            
        } else {
            player?.play()
            isPlayed = false
            play.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            play.setTitle("Stop", for: .normal)
            
            print(isPlayed)
        }
        
    }
    

    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
       
    }
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        
        showSpinner(onView: self.view)
        quranManager.fetchAyah()
        player?.pause()
        play.setImage(UIImage(systemName: "play.fill"), for: .normal)
        play.setTitle("Play", for: .normal)
    }
    @IBAction func goToTafsirPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tafsirModal", sender: self)
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
    
    func didUpdateQuran(_ quranManager: QuranManager, quran: QuranModel) {
        
        var defaults = UserDefaults.standard
        
        DispatchQueue.main.async {
            self.removeSpinner()
            self.ayah.text = quran.ayahArab
            self.ayahNew.text = quran.ayahArab
            self.translation.text = quran.ayahTranslation
            tafsirText = quran.ayahTafsirLong
            surahArabGlobal = quran.ayahArab
            surahArtiGlobal = quran.ayahTranslation
            ayahNumberInQuran = quran.ayahInQuran
            
            print(quran.ayahInQuran)
            surahAyahTitle = "\(self.surahNameGenerator(quran.ayahInQuran))" + " : " + "\(quran.ayahInSurah)"
            self.title = "\(self.surahNameGenerator(quran.ayahInQuran))" + " : " + "\(quran.ayahInSurah)"
            
            
//            self.url = URL(string: "\(quran.ayahURLAudio)")
//            print(self.url!)
//            self.surahManager.fetchSurah(self.ayahInQuranHome)
//            print(self.ayahInQuranHome!)
            
           
        }
        
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
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
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
}
