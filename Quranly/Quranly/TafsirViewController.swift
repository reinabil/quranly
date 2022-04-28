//
//  TafsirViewController.swift
//  Quranly
//
//  Created by Nabil Rei on 27/04/22.
//

import UIKit

class TafsirViewController: UIViewController {

    @IBOutlet weak var tafsirText: UILabel!
    var tafsir = ""
    @IBOutlet weak var tafsirTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
