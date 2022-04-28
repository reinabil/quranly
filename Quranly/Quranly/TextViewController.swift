//
//  TextViewController.swift
//  Quranly
//
//  Created by Nabil Rei on 26/04/22.
//

import UIKit

var ayahArray: Array<String> = ["HAHAHAHA"]

class TextViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    var quranManager = QuranManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quranManager.delegate = self
        quranManager.fetchAyah()

    }


}



extension TextViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
    }
}

extension TextViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ayahArray[indexPath.row]
        
        return cell
    }
}

extension TextViewController: QuranManagerDelegate {
    func didUpdateQuran(_ quranManager: QuranManager, quran: QuranModel) {
        DispatchQueue.main.async {
//            ayahArray.append(quran.ayahArab)
//            ayahArray.append(quran.ayahTranslation)
//            ayahArray.append(quran.ayahTafsirLong)
        }
        
    }
    
    func didFailWithError(error: Error){
        print(error)
    }
}

