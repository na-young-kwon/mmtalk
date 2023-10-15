//
//  PaddingLabel.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/15.
//

import UIKit

final class TagLabel: UILabel {
    private var padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
