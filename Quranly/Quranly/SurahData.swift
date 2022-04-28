//
//  SurahData.swift
//  Quranly
//
//  Created by Nabil Rei on 28/04/22.
//

import Foundation

struct SurahData: Codable {
    let data: data
}

struct data: Codable {
    let number: Int
    let surah: Surah
}

struct Surah: Codable {
    let englishName: String
    let numberOfAyahs: Int
}
