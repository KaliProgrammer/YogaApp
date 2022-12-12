//
//  NetworkLayer.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 07.12.2022.
//

import Foundation

protocol NetworkLayer {
    func getAllQuotes(callback: @escaping QuotesCallback)
    
}
