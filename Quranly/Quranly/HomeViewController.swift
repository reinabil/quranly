//
//  HomeViewController.swift
//  Quranly
//
//  Created by Nabil Rei on 26/04/22.
//

import UIKit
import UserNotifications
import AVFoundation

var tafsirText = ""

class HomeViewController: UIViewController {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?

    @IBOutlet weak var surahAyah: UILabel!
    @IBOutlet weak var hijriDate: UILabel!
    @IBOutlet weak var verseTitle: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var ayah: UILabel!
    @IBOutlet weak var translation: UILabel!
    @IBOutlet weak var tafsir: UILabel!
    @IBOutlet weak var goToTafsir: UIButton!
    @IBOutlet weak var play: UIButton!
    
    var defaults = UserDefaults.standard
    
    var ayahInQuranHome: Int!
    var isPlayed = false
    
    var surahAyahString = "Al-Fatiha : 1"
    
    var quranManager = QuranManager()
    var surahManager = SurahManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        surahAyah.text = surahAyahString
        
        // Do any additional setup after loading the view.
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
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: {
            (error) in
            
        })
        
        quranManager.delegate = self
        quranManager.fetchAyah()
        
        surahAyah.text = defaults.string(forKey: "surahName")
        print("Surah name")
        print(defaults.string(forKey: "surahName"))
        
        let url = URL(string: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/6234.mp3")
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
    }
}

    @IBAction func playPressed(_ sender: UIButton) {
     
        if !isPlayed {
            player?.pause()
            isPlayed = true
            play.setImage(UIImage(systemName: "play.fill"), for: .normal)
            play.setTitle("Play", for: .normal)
            
            print(isPlayed)
            
        } else {
            player?.play()
            isPlayed = false
            play.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            play.setTitle("Pause", for: .normal)
            
            print(isPlayed)
        }
        
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
       
    }
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        quranManager.fetchAyah()
        isPlayed = false
        player?.pause()
        play.setImage(UIImage(systemName: "play.fill"), for: .normal)
        play.setTitle("Play", for: .normal)
    }
    @IBAction func goToTafsirPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tafsirModal", sender: self)
    }
    
}

extension HomeViewController: QuranManagerDelegate{
    func didUpdateQuran(_ quranManager: QuranManager, quran: QuranModel) {
        DispatchQueue.main.async {
            self.ayah.text = quran.ayahArab
            self.translation.text = quran.ayahTranslation
            tafsirText = quran.ayahTafsirLong
            self.ayahInQuranHome = quran.ayahInQuran
//            self.url = URL(string: "\(quran.ayahURLAudio)")
//            print(self.url!)
            self.surahManager.fetchSurah(self.ayahInQuranHome)
            print(self.ayahInQuranHome!)
           
        }
        
    }
    
    func didFailWithError(error: Error){
        print(error)
    }
    
}

extension HomeViewController: SurahManagerDelegate {
    
    func didUpdateSurah(_ surahManager: SurahManager, surah: SurahModel) {
        
        DispatchQueue.main.async {
            
        }
    }
    
}


