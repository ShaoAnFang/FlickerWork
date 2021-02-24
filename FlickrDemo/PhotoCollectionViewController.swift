//
//  PhotoCollectionViewController.swift
//  FlickerTest
//
//  Created by clark on 2020/1/9.
//  Copyright © 2020 clark. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    let viewModel = PhotoCollectionViewModel()
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photoCollectionViewFlowLayout: UICollectionViewFlowLayout!
    var searchTitle = ""
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(needRefreshData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "搜尋結果 \(searchTitle)"
        viewModel.delegate = self
        setCollectionView()
    }
    
    @objc func needRefreshData() {
        viewModel.currentPage = 1
        viewModel.fetchPhotoData(text: searchTitle, pages: "\(viewModel.currentPage)", prePage: "\(viewModel.currentPrePage)")
    }
    
    func setCollectionView() {
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        photoCollectionViewFlowLayout.scrollDirection = .vertical
        photoCollectionViewFlowLayout.minimumInteritemSpacing = 5
        photoCollectionViewFlowLayout.minimumLineSpacing = 5
        photoCollectionViewFlowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 10, height: (UIScreen.main.bounds.width / 2) + 15)
        photoCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        photoCollectionView.refreshControl = refreshControl
    }
    
}

extension PhotoCollectionViewController: PhotoCollectionViewModelDelegate {
    
    func didFinishedFetchData() {
        self.refreshControl.endRefreshing()
        self.photoCollectionView.reloadData()
    }
    
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.item + 1 == viewModel.photo.count {
            viewModel.currentPage += 1
            viewModel.fetchPhotoData(text: searchTitle, pages: "\(viewModel.currentPage)", prePage: "\(viewModel.currentPrePage)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        //print(viewModel.photo[indexPath.item].title)
        cell.configure(title: viewModel.photo[indexPath.item].title, imageUrl: viewModel.photo[indexPath.item].urlString)
        return cell
    }
    
}
