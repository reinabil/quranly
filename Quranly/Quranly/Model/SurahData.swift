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
    let text: String
    let surah: Surah
}

struct Surah: Codable {
    let englishName: String
    let numberOfAyah: Int
}
