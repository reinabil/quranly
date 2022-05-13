//
//  QuranManager.swift
//  Quranly
//
//  Created by Nabil Rei on 26/04/22.
//
import Foundation
import CoreLocation

protocol QuranManagerDelegate {
    func didUpdateQuran(_ quranManager: QuranManager, quran: QuranModel)
    func didFailWithError(error: Error)
}

struct QuranManager {
    var delegate: QuranManagerDelegate?
    var quranURL = "https://quran-api-id.vercel.app/random"

    func fetchAyah () -> String {
        let URLString = "\(quranURL)"
        performRequest(with: URLString)
        return URLString
    }
    
    func nextAyah (surah: Int, ayah: Int) -> String {
        let URLString = "https://quran-api-id.vercel.app/surahs/\(surah)/ayahs/\(ayah)"
        performRequest(with: URLString)
        return URLString
    }
    
    func prevAyah (surah: Int, ayah: Int) -> String {
        let URLString = "https://quran-api-id.vercel.app/surahs/\(surah)/ayahs/\(ayah)"
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
                    if let ayah = self.parseJSON(safeData) {
                        self.delegate?.didUpdateQuran(self, quran: ayah)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ quranData: Data) -> QuranModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(QuranData.self, from: quranData)

            let ayahInQuran = decodedData.number.inQuran
            let ayahInSurah = decodedData.number.inSurah
            let surahName = "Surah Test"
            let ayahArab = decodedData.arab
            let ayahTranslation = decodedData.translation
            let ayahTafsirLong = decodedData.tafsir.kemenag.long
            let ayahURLAudio = decodedData.audio.alafasy
            
            let ayah = QuranModel(ayahInQuran: ayahInQuran, ayahInSurah: ayahInSurah, surahName: surahName, ayahArab: ayahArab, ayahTranslation: ayahTranslation, ayahTafsirLong: ayahTafsirLong, ayahURLAudio: ayahURLAudio)
            return ayah
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

