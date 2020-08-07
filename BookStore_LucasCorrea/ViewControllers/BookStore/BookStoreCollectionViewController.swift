//
//  BookStoreCollectionViewController.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 06/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BookCollectionViewCell"

class BookStoreCollectionViewController: UICollectionViewController {
    
    //
    // MARK: - Oulets
    
    //
    // MARK: - Properties
    var viewModel: BookStoreViewModel
    
    /// Init
    /// - Parameters:
    ///   - coder: NSCoder
    ///   - viewModel: ViewModel
    init?(coder: NSCoder, viewModel: BookStoreViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    // MARK: - Private methods
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            return self.bookLayoutSection(isWide: isWideView)
        }
        return layout
    }
    
    private func bookLayoutSection(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let groupHeight = NSCollectionLayoutDimension.fractionalWidth(isWide ? 0.25 : 0.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWide ? 4 : 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
