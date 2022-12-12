//
//  Errors.swift
//  ChaturangaApp
//
//  Created by MacBook Air on 07.12.2022.
//

import Foundation

public enum NetworkError: Error {
    case custom(String)
    case emptyData
    case wrongJson(String)
}
