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
    enum Section {
        case list
    }
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var viewModel: ProductListViewModel!
    private let disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureUI()
        configureDataSource()
        bindViewModel()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titlePositionAdjustment = UIOffset(
            horizontal: -(view.frame.width / 2),
            vertical: 5
        )
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)
        ]
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
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil,
            top: .fixed(20),
            trailing: nil,
            bottom: nil
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(150)
            ),
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(CGFloat(20))
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        let productCellRegistration = UICollectionView.CellRegistration<ProductCell, Product> { (cell, indexPath, data) in
            cell.bindViewModel(with: data)
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Product>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Product) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: productCellRegistration, for: indexPath, item: item)
        }
    }
    
    private func applySnapshot(with products: [Product]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapShot.appendSections([.list])
        snapShot.appendItems(products)
        dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    private func bindViewModel() {
        let selectedLocation = PublishSubject<Product>()
        let fetchMoreProduct = PublishSubject<Void>()
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).map { _ in }
        
        let input = ProductListViewModel.Input(
            viewWillAppear: viewWillAppear,
            fetchMoreProduct: fetchMoreProduct.asObserver(),
            itemSelected: selectedLocation.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.products
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] products in
                self?.applySnapshot(with: products)
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Product.self)
            .subscribe(onNext: { product in
                selectedLocation.onNext(product)
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.didScroll
            .skip(1)
            .throttle(.seconds(3), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                let offsetY = self.collectionView.contentOffset.y
                let contentHeight = self.collectionView.contentSize.height
                let height = self.collectionView.frame.height
                
                if offsetY > (contentHeight - height) {
                    fetchMoreProduct.onNext(())
                }
            })
            .disposed(by: disposeBag)
    }
}
