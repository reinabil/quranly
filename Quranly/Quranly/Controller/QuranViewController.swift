//
//  QuranViewController.swift
//  Quranly
//
//  Created by Nabil Rei on 09/05/22.
//

import UIKit

let surahArray = [
    "Al-Fatihah",
    "Al-Baqarah",
    "Ali 'Imran",
    "An-Nisa'",
    "Al-Ma'idah",
    "Al-An'am",
    "Al-A’raf",
    "Al-Anfal",
    "At-Taubah",
    "Yunus",
    "Hud",
    "Yusuf",
    "Ar-Ra’d",
    "Ibrahim",
    "Al-Hijr",
    "An-Nahl",
    "Al-Isra'",
    "Al-Kahf",
    "Maryam",
    "Ta Ha",
    "Al-Anbiya",
    "Al-Hajj",
    "Al-Mu’minun",
    "An-Nur",
    "Al-Furqan",
    "Asy-Syu'ara'",
    "An-Naml",
    "Al-Qasas",
    "Al-'Ankabut",
    "Ar-Rum",
    "Luqman",
    "As-Sajdah",
    "Al-Ahzab",
    "Saba’",
    "Fatir",
    "Ya Sin",
    "As-Saffat",
    "Sad",
    "Az-Zumar",
    "Ghafir",
    "Fussilat",
    "Asy-Syura",
    "Az-Zukhruf",
    "Ad-Dukhan",
    "Al-Jasiyah",
    "Al-Ahqaf",
    "Muhammad",
    "Al-Fath",
    "Al-Hujurat",
    "Qaf",
    "Az-Zariyat",
    "At-Tur",
    "An-Najm",
    "Al-Qamar",
    "Ar-Rahman",
    "Al-Waqi’ah",
    "Al-Hadid",
    "Al-Mujadilah",
    "Al-Hasyr",
    "Al-Mumtahanah",
    "As-Saff",
    "Al-Jumu’ah",
    "Al-Munafiqun",
    "At-Tagabun",
    "At-Talaq",
    "At-Tahrim",
    "Al-Mulk",
    "Al-Qalam",
    "Al-Haqqah",
    "Al-Ma’arij",
    "Nuh",
    "Al-Jinn",
    "Al-Muzzammil",
    "Al-Muddassir",
    "Al-Qiyamah",
    "Al-Insan",
    "Al-Mursalat",
    "An-Naba’",
    "An-Nazi’at",
    "'Abasa",
    "At-Takwir",
    "Al-Infitar",
    "Al-Mutaffifin",
    "Al-Insyiqaq",
    "Al-Buruj",
    "At-Tariq",
    "Al-A’la",
    "Al-Gasyiyah",
    "Al-Fajr",
    "Al-Balad",
    "Asy-Syams",
    "Al-Lail",
    "Ad-Duha",
    "Al-Insyirah",
    "At-Tin",
    "Al-'Alaq",
    "Al-Qadr",
    "Al-Bayyinah",
    "Az-Zalzalah",
    "Al-'Adiyat",
    "Al-Qari'ah",
    "At-Takasur",
    "Al-'Asr",
    "Al-Humazah",
    "Al-Fil",
    "Quraisy",
    "Al-Ma’un",
    "Al-Kausar",
    "Al-Kafirun",
    "An-Nasr",
    "Al-Lahab",
    "Al-Ikhlas",
    "Al-Falaq",
    "An-Nas"
    ]
let surahNumber = [
    "Al-Fatihah" : 1,
    "Al-Baqarah" : 2,
    "Ali 'Imran" : 3,
    "An-Nisa'" : 4,
    "Al-Ma'idah" : 5,
    "Al-An'am" : 6,
    "Al-A’raf" : 7,
    "Al-Anfal" : 8,
    "At-Taubah" : 9,
    "Yunus" : 10,
    "Hud" : 11,
    "Yusuf" : 12,
    "Ar-Ra’d" : 13,
    "Ibrahim" : 14,
    "Al-Hijr" : 15,
    "An-Nahl" : 16,
    "Al-Isra'" : 17,
    "Al-Kahf" : 18,
    "Maryam" : 19,
    "Ta Ha" : 20,
    "Al-Anbiya" : 21,
    "Al-Hajj" : 22,
    "Al-Mu’minun" : 23,
    "An-Nur" : 24,
    "Al-Furqan" : 25,
    "Asy-Syu'ara'" : 26,
    "An-Naml" : 27,
    "Al-Qasas" : 28,
    "Al-'Ankabut" : 29,
    "Ar-Rum" : 30,
    "Luqman" : 31,
    "As-Sajdah" : 32,
    "Al-Ahzab" : 33,
    "Saba’" : 34,
    "Fatir" : 35,
    "Ya Sin" : 36,
    "As-Saffat" : 37,
    "Sad" : 38,
    "Az-Zumar" : 39,
    "Ghafir" : 40,
    "Fussilat" : 41,
    "Asy-Syura" : 42,
    "Az-Zukhruf" : 43,
    "Ad-Dukhan" : 44,
    "Al-Jasiyah" : 45,
    "Al-Ahqaf" : 46,
    "Muhammad" : 47,
    "Al-Fath" : 48,
    "Al-Hujurat" : 49,
    "Qaf" : 50,
    "Az-Zariyat" : 51,
    "At-Tur" : 52,
    "An-Najm" : 53,
    "Al-Qamar" : 54,
    "Ar-Rahman" : 55,
    "Al-Waqi’ah" : 56,
    "Al-Hadid" : 57,
    "Al-Mujadilah" : 58,
    "Al-Hasyr" : 59,
    "Al-Mumtahanah" : 60,
    "As-Saff" : 61,
    "Al-Jumu’ah" : 62,
    "Al-Munafiqun" : 63,
    "At-Tagabun" : 64,
    "At-Talaq" : 65,
    "At-Tahrim" : 66,
    "Al-Mulk" : 67,
    "Al-Qalam" : 68,
    "Al-Haqqah" : 69,
    "Al-Ma’arij" : 70,
    "Nuh" : 71,
    "Al-Jinn" : 72,
    "Al-Muzzammil" : 73,
    "Al-Muddassir" : 74,
    "Al-Qiyamah" : 75,
    "Al-Insan" : 76,
    "Al-Mursalat" : 77,
    "An-Naba’" : 78,
    "An-Nazi’at" : 79,
    "'Abasa" : 80,
    "At-Takwir" : 81,
    "Al-Infitar" : 82,
    "Al-Mutaffifin" : 83,
    "Al-Insyiqaq" : 84,
    "Al-Buruj" : 85,
    "At-Tariq" : 86,
    "Al-A’la" : 87,
    "Al-Gasyiyah" : 88,
    "Al-Fajr" : 89,
    "Al-Balad" : 90,
    "Asy-Syams" : 91,
    "Al-Lail" : 92,
    "Ad-Duha" : 93,
    "Al-Insyirah" : 94,
    "At-Tin" : 95,
    "Al-'Alaq" : 96,
    "Al-Qadr" : 97,
    "Al-Bayyinah" : 98,
    "Az-Zalzalah" : 99,
    "Al-'Adiyat" : 100,
    "Al-Qari'ah" : 101,
    "At-Takasur" : 102,
    "Al-'Asr" : 103,
    "Al-Humazah" : 104,
    "Al-Fil" : 105,
    "Quraisy" : 106,
    "Al-Ma’un" : 107,
    "Al-Kausar" : 108,
    "Al-Kafirun" : 109,
    "An-Nasr" : 110,
    "Al-Lahab" : 111,
    "Al-Ikhlas" : 112,
    "Al-Falaq" : 113,
    "An-Nas" : 114,
]

class QuranViewController: UIViewController {


    @IBOutlet weak var surahTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching = false
    var searchedSurah = [String]()
    
    var selectedSurah = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let directionalMargins = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        searchBar.directionalLayoutMargins = directionalMargins
        
//        navigationItem.titleView = searchBar
        
        surahTableView.delegate = self
        surahTableView.dataSource = self
        
        searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

//MARK: - EXTENSION TABLE VIEW
extension QuranViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedSurah.count
        } else {
            return surahArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "surahCell", for: indexPath) as! SurahTableViewCell
        
        if isSearching {
            cell.labelText?.text = "\(surahNumber[searchedSurah[indexPath.row]]!).  \(searchedSurah[indexPath.row])"
            cell.arabLabel?.text = getSurahTitleArab(numberOfSurah: "\(surahNumber[searchedSurah[indexPath.row]]!)")
        } else {
            cell.labelText?.text = "\(surahNumber[surahArray[indexPath.row]]!). \(surahArray[indexPath.row])"
            cell.arabLabel?.text = getSurahTitleArab(numberOfSurah: "\(surahNumber[surahArray[indexPath.row]]!)")
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching {
            selectedSurah = searchedSurah[indexPath.row]
        } else {
            selectedSurah = surahArray[indexPath.row]
        }
        
        print(selectedSurah)
        print(surahNumber[selectedSurah])
        performSegue(withIdentifier: "surah", sender: self)
    }
}



//MARK: - EXTENSION SEARCH BAR
extension QuranViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
            let array = (surahArray as NSArray).filtered(using: searchPredicate)
            searchedSurah = array as! [String]
        } else {
            searchedSurah = surahArray
        }
        
        isSearching = true
        surahTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        isSearching = false
        searchBar.text = ""
        surahTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

//MARK: - EXTENSION VIEW CONTROLLER
extension QuranViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if  segue.identifier  ==   "surah"   {
           guard let  vc  =  segue.destination  as? SurahDetailViewController else { return }
           vc.numberOfSurah = surahNumber[selectedSurah]
          
       }
    }
}
