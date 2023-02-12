//
//  String+Extension.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 23/06/22.
//

import Foundation

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
