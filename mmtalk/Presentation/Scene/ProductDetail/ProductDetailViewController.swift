//
//  ProductDetailViewController.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/15.
//

import UIKit
import RxSwift

final class ProductDetailViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = "제목"
        return label
    }()
    
    var viewModel: ProductDetailViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUpNavigationBar()
        bindViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(120)
        }
    }
    
    private func setUpNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "상품 상세보기"
        backButton.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(
            #selector(UIViewController.viewWillAppear(_:))
        ).map { _ in }
        let input = ProductDetailViewModel.Input(viewWillAppear: viewWillAppear)
        let output = viewModel.transform(input: input)
        
        output.product
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { product in
                self.titleLabel.text = product.title
            })
            .disposed(by: disposeBag)
    }
}
