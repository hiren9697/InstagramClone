//
//  CommonFunctions.swift
//  ListStructure
//
//  Created by Hiren Faldu Solution on 21/05/22.
//

import UIKit

// MARK: - Debug print
func debugprint(_ items: Any...) {
    #if DEBUG
        for item in items {
            print(item)
        }
    #endif
}
