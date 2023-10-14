//
//  ViewController.swift
//  mmtalk
//
//  Created by 권나영 on 2023/10/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ProductListViewController: UIViewController {
    var viewModel: ProductListViewModel!
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        bindViewModel()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titlePositionAdjustment = UIOffset(horizontal: -(view.frame.width / 2), vertical: 5)
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "쇼핑몰"
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(70)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(150)
            ),
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(CGFloat(10))
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).map { _ in }
        let input = ProductListViewModel.Input(viewWillAppear: viewWillAppear)
        let output = viewModel.transform(input: input)
        
        output.products
            .bind(
                to: collectionView.rx.items(
                    cellIdentifier: ProductCell.reuseID, cellType: ProductCell.self)
            ) { index, item, cell  in
                cell.bindViewModel(with: item)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Product.self)
            .subscribe(onNext: { product in
//                print(product)
            })
            .disposed(by: disposeBag)
    }
}
