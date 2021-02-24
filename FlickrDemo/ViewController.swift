//
//  ViewController.swift
//  FlickerTest
//
//  Created by clark on 2020/1/9.
//  Copyright © 2020 clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var pageTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "搜尋輸入頁"
        viewModel.delegate = self
        contentTextField.delegate = self
        pageTextField.delegate = self
        contentTextField.placeholder = "欲搜尋內容"
        pageTextField.placeholder = "每頁呈現數量"
        pageTextField.keyboardType = .numberPad
        searchButton.isEnabled = false
        searchButton.backgroundColor = .lightGray
        searchButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let searchTitle = contentTextField.text, let prePage = pageTextField.text else { return }
        viewModel.fetchData(text: searchTitle, pages: "1", prePage: prePage)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if !contentTextField.text!.isEmpty, !pageTextField.text!.isEmpty {
            searchButton.isEnabled = true
            searchButton.backgroundColor = .blue
        } else {
            searchButton.isEnabled = false
            searchButton.backgroundColor = .lightGray
        }
    }
    
    
}

//MARK: ViewModelDelegate
extension ViewController: ViewModelDelegate {
    
    func didFinishedFetchData() {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoCollectionViewController") as? PhotoCollectionViewController {
            vc.searchTitle = contentTextField.text!
            if let photo = viewModel.photoResponseData?.photos?.photo, let prePage = Int(pageTextField.text!) {
                vc.viewModel.photo = photo
                vc.viewModel.currentPrePage = prePage
            }

            navigationController?.navigationBar.topItem!.title = "搜尋輸入頁"
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
