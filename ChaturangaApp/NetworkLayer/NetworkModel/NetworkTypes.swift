//
//  NetworkModel.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 07.12.2022.
//

import Foundation

typealias QuotesResult = Result<Array<Quote>, NetworkError>
typealias QuotesCallback = (QuotesResult) -> Void
