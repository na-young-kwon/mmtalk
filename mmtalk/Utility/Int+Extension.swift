//
//  Int+Extension.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/15.
//

import Foundation

extension Int {
    var decimalFormat: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
