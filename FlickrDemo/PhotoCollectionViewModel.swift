//
//  PhotoCollectionViewModel.swift
//  FlickerTest
//
//  Created by clark on 2020/1/9.
//  Copyright © 2020 clark. All rights reserved.
//

import Foundation

protocol PhotoCollectionViewModelDelegate: AnyObject {
    func didFinishedFetchData()
}

class PhotoCollectionViewModel {
    
    var delegate: PhotoCollectionViewModelDelegate?
    var photoResponseData: PhotoResponseData?
    var photo : [PhotoDetailData] = []
    var currentPage: Int = 1
    var currentPrePage: Int = 0
    
    func fetchPhotoData(text: String, pages: String, prePage: String) {
        APIManager.sharedInstance.searchRequest(HttpRequest(text: text, perPage: prePage, page: pages)) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode(PhotoResponseData.self, from: data)
                    strongSelf.photoResponseData = responseData
                    
                    if let photoArray = responseData.photos?.photo, let page = responseData.photos?.page {
                        print("API response currentPage: \(page)")
                        if strongSelf.currentPage == 1 {
                            strongSelf.photo = photoArray
                        } else {
                            strongSelf.photo += photoArray
                        }
                    }
                    strongSelf.delegate?.didFinishedFetchData()
                } catch let error {
                    print("JSONDecod error:",error)
                }
            case .failure(let error):
                print("api error:",error)
            }
        }
    }
    
}
