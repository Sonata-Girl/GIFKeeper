//
//  SearchViewController.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 12.10.2023.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - UIElements
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController()
        return search
    }()
    
    private lazy var gifsCollectionView: UICollectionView = {
        let layout = createLayout()
        let groups = UICollectionView(frame: .zero, collectionViewLayout: layout)
        groups.register(GifCoverCell.self, forCellWithReuseIdentifier: .groupCell)
        groups.showsVerticalScrollIndicator = false
        groups.dataSource = self
        groups.delegate = self
        return groups
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupNavigationBar()
        setupLayout()
    }
}

// MARK: - CollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {}

// MARK: - CollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        35
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: .groupCell, for: indexPath)
    }
}

// MARK: - Configuration view

private extension SearchViewController {
    func setupHierarchy() {
        view.addSubview(gifsCollectionView)
    }
    
    func setupLayout() {
        gifsCollectionView.snp.makeConstraints { make in make.edges.equalTo(view) }
    }
    
    func setupNavigationBar() {
        navigationItem.title = Constants.navigationTitle
        navigationItem.searchController = searchController
    }
}

// MARK: - Composition layout methods

private extension SearchViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layoutSection = CustomLayoutSection.shared.create(
            with: SectionSettings(
                columnAmount: 3,
                isGroup: false
            )
        )
        return UICollectionViewCompositionalLayout(section: layoutSection)
    }
}

// MARK: - Constants

private extension SearchViewController {
    enum Constants {
        static let navigationTitle = "Searching Gif"
        
        static let absoluteViewWidth: CGFloat = 1
        static let absoluteViewHeight: CGFloat = 1
        static let countItemInWidth: CGFloat = 3
        static let countItemInHeight: CGFloat = 3
        static let itemHeightOffset: CGFloat = 2
        
        static let countGroupInHeight: CGFloat = 5
        static let groupInterItemSpacing: CGFloat = 3
        
        static let sectionInterGroupSpacing: CGFloat = -40
    }
}
