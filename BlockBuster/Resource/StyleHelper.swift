//
//  StyleHelper.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 20/8/24.
//

import Foundation
import UIKit

class StyleHelper {
    static let shared = StyleHelper()
    
    let sharkGray = UIColor(red: 25/255, green: 27/255, blue: 31/255, alpha: 1)
    let outerSpaceGray = UIColor(red: 50/255, green: 55/255, blue: 57/255, alpha: 1)
    let abbeyGray = UIColor(red: 82/255, green: 85/255, blue: 91/255, alpha: 1)
    let osloGray = UIColor(red: 149/255, green: 153/255, blue: 157/255, alpha: 1)
    let ironGray = UIColor(red: 213/255, green: 216/255, blue: 220/255, alpha: 1)
}

enum ColorStyle {
    case mainBackground
    case tabBarBackground
    case textFieldBackground
    case textFieldBorder
    case textTextField
    case unselectedItem
    
    func color() -> UIColor {
        switch self {
        case .mainBackground:
            return StyleHelper.shared.sharkGray
        case .tabBarBackground:
            return StyleHelper.shared.outerSpaceGray
        case .textFieldBackground:
            return StyleHelper.shared.outerSpaceGray
        case .textFieldBorder:
            return StyleHelper.shared.osloGray
        case .textTextField:
            return StyleHelper.shared.ironGray
        case .unselectedItem:
            return StyleHelper.shared.ironGray
        }
    }
}

enum FontStyle {
    case title
    case description
    case subTitle
    
    func font() -> UIFont {
        switch self {
        case .title:
            UIFont.systemFont(ofSize: 22, weight: .bold)
        case .subTitle:
            UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .description:
            UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
}

