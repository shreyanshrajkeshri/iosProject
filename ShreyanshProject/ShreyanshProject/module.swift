//
//  module.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 02/04/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import Foundation

enum CellMode {
    case Country
    case Language
    case None
}

struct Country {
    let countryName: String
    let countryCode: String
}


public protocol LanguageProtocol {
    
    func getSelectedLanguage(languageName: String)
}
