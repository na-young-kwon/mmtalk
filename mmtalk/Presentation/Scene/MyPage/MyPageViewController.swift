//
//  MyPageViewController.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit
import SnapKit

final class MyPageViewController: UIViewController {
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "No content"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemGray2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewHierarchy()
        configureConstraint()
        configureNavigationBar()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureViewHierarchy() {
        view.addSubview(contentLabel)
    }
    
    private func configureConstraint() {
        contentLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.configureWithTransparentBackground()
        appearance.titlePositionAdjustment = UIOffset(horizontal: -(view.frame.width / 2), vertical: 5)
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "내정보"
    }
}
