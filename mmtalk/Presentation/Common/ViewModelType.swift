//
//  ViewModelType.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
