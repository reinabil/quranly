//
//  TafsirViewController.swift
//  Quranly
//
//  Created by Nabil Rei on 27/04/22.
//

import UIKit

class TafsirViewController: UIViewController {

    
    @IBOutlet weak var tafsirText: UITextView!
    var tafsir = ""
    var surahAyah = ""
    @IBOutlet weak var tafsirTitle: UILabel!
    @IBOutlet weak var surahAyahTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tafsirText.layer.borderWidth = 0
        tafsirText.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        tafsirText.layer.cornerRadius = 12
        tafsirText.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20);
        
        title = surahAyah
        surahAyahTitle.text = surahAyah
        tafsirTitle.text = "TAFSIR"
        tafsirText.text = tafsir
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true)
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
