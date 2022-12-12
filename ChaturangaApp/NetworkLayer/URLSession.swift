//
//  URLSession.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 07.12.2022.
//

import Foundation

 class URLSessionLayer: NetworkLayer {
  
    private let baseAddressForQuotes = "https://zenquotes.io/api/quotes"
    
    init() {}
    
     func getAllQuotes(callback: @escaping QuotesCallback) {
        let url = URL(string: baseAddressForQuotes)
        let urlRequest = URLRequest(url: url!)
       
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                callback(Result.failure(.custom(error?.localizedDescription ?? "")))
                return
            }
            if data == nil {
                callback(.failure(.emptyData))
                return
            }
            do {
                let quotes = try JSONDecoder().decode(Quotes.self, from: data!)
                callback(Result.success(quotes))
                } catch {
                callback(Result.failure(.wrongJson("Wrong format")))
            }
        }.resume()
    }
    
    
}
