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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "搜尋結果 \(searchTitle)"
        setCollectionView()

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
    }
    
    
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        //print(viewModel.photo[indexPath.item].title)
        cell.configure(title: viewModel.photo[indexPath.item].title, imageUrl: viewModel.photo[indexPath.item].urlString)
        return cell
    }
    
    
}
