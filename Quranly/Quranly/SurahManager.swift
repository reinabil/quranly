//
//  SurahManager.swift
//  Quranly
//
//  Created by Nabil Rei on 28/04/22.
//
import Foundation
import CoreLocation

protocol SurahManagerDelegate {
    func didUpdateSurah(_ surahManager: SurahManager, surah: SurahModel)
    func didFailWithError(error: Error)
}

struct SurahManager {
    
    var defaults = UserDefaults.standard
    var delegate: SurahManagerDelegate?
    var surahURL = "https://api.alquran.cloud/v1/ayah/"

    func fetchSurah (_ numberAyah: Int) -> String {
        let URLString = "\(surahURL)\(numberAyah)"
        performRequest(with: URLString)
        return URLString
    }
    
    func performRequest(with urlString: String) {
        // 1. create URL
        if let url = URL(string: urlString) {
            // 2. create URL session
            let session = URLSession(configuration: .default)
            
            // 3. give a session task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    if let surah = self.parseJSON(safeData) {
                        self.delegate?.didUpdateSurah(self, surah: surah)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ surahData: Data) -> SurahModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SurahData.self, from: surahData)
            
            let ayahInQuran = decodedData.data.number
            let surahName = decodedData.data.surah.englishName
            let numberOfAyah = decodedData.data.surah.numberOfAyahs
       
            print(surahName)
            print(numberOfAyah)
            
            let surah = SurahModel(ayahInQuranSurah: ayahInQuran, surahName: surahName, numberOfAyah: numberOfAyah)
            return surah
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
