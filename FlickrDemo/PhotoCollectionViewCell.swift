//
//  PhotoCollectionViewCell.swift
//  FlickerTest
//
//  Created by clark on 2020/1/9.
//  Copyright © 2020 clark. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoimageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoimageView.contentMode = .scaleAspectFit
    }
    
    func configure(title: String, imageUrl: String) {
        titleLabel.text = title
        if let url = URL(string: imageUrl) {
            let request = URLRequest(url: url)
            APIManager.sharedInstance.getPhotoRequest(request) { [weak self] (result) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let data):
                    let photoImage = UIImage(data: data)
                    strongSelf.photoimageView.image = photoImage
                case .failure(let error):
                    print("getPhotoRequest:",error)
                }
            }
        }
    }
}
