//
//  TabBarPage.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import Foundation

enum TabBarPage: CaseIterable {
    case productList, myPage
    
    init?(index: Int) {
        switch index {
            case 0: self = .productList
            case 1: self = .myPage
            default: return nil
        }
    }
    
    var pageNumber: Int {
        switch self {
            case .productList: return 0
            case .myPage: return 1
        }
    }
    
    var imageName: String {
        switch self {
        case .productList:
            return "Home"
        case .myPage:
            return "MyPage"
        }
    }
    
    var stringValue: String {
        switch self {
        case .productList:
            return "쇼핑몰"
        case .myPage:
            return "내정보"
        }
    }
}
