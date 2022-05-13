//
//  QuranData.swift
//  Quranly
//
//  Created by Nabil Rei on 26/04/22.
//

import Foundation

struct QuranData: Codable {
    let number: Number
    let arab: String
    let translation: String
    let tafsir: Tafsir
    let audio: Audio
}

struct Number: Codable {
    let inQuran: Int
    let inSurah: Int
}

struct Tafsir: Codable {
    let kemenag: Kemenag
}

struct Kemenag: Codable {
    let long: String
}

struct Audio: Codable {
    let alafasy: URL
}
