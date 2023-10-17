//
//  LoadingFooterView.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/16.
//

import UIKit
import SnapKit

final class LoadingFooterView: UICollectionReusableView {
    private let spinner = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        spinner.startAnimating()
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
