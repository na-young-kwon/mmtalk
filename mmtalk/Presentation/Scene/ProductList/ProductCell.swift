//
//  ProductCell.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/15.
//

import UIKit
import SnapKit

final class ProductCell: UICollectionViewCell {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let discountRateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .systemGray4
        return label
    }()
    
    private let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray4
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.systemGray6.cgColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let priceStackView = UIStackView(arrangedSubviews: [discountRateLabel, priceLabel])
        priceStackView.spacing = 8
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(productImageView)
        stackView.addArrangedSubview(brandLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceStackView)
        stackView.addArrangedSubview(tagLabel)
        stackView.addArrangedSubview(reviewCountLabel)
    }
    
    private func configureConstraint() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        productImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(productImageView.snp.width).multipliedBy(1.0 / 1.0)
        }
    }
    
    func bindViewModel(with product: Product) {
        brandLabel.text = product.brand
        titleLabel.text = product.name
        priceLabel.text = product.sellPrice
        tagLabel.text = product.tags.first?.rawValue ?? nil
        discountRateLabel.text = product.discountRate + "%"
        reviewCountLabel.text = product.reviewCount == "0" ? nil : product.reviewCount
        // url로 이미지 로드
//        productImageView.image = product.imageURL
    }
}
