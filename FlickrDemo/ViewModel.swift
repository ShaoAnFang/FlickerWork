//
//  ViewModel.swift
//  FlickerTest
//
//  Created by clark on 2020/1/9.
//  Copyright © 2020 clark. All rights reserved.
//

protocol ViewModelDelegate: AnyObject {
    func didFinishedFetchData()
}


import Foundation

class ViewModel {
    
    weak var delegate: ViewModelDelegate?
    var photoResponseData: PhotoResponseData?
            
    
    func fetchData(text: String, pages: String) {
        APIManager.sharedInstance.searchRequest(HttpRequest(text: text, perPage: pages)) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode(PhotoResponseData.self, from: data)
                    strongSelf.photoResponseData = responseData
                    //print(strongSelf.photoResponseData)
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
