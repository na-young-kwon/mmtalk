//
//  mmtalk++Bundle.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/17.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "Secret", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY_mmtalk"] as? String
        else {
            fatalError("API키가 없습니다.")
        }
        return key
    }
}
