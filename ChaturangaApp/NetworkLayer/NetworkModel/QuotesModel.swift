//
//  QuotesModel.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 07.12.2022.

import Foundation

// MARK: - Quote
struct Quote: Codable {
    let q, a, c, h: String?
}

typealias Quotes = [Quote]
