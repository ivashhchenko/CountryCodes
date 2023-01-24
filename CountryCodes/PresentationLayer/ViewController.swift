//
//  ViewController.swift
//  CountryCodes
//
//  Created by Apex Bank
//

import UIKit

final class CountryListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        }
    
        
    private func updateLocalData() {
        if let localData = Network.singleton.readLocalFile(forName: "countryCodes", ofType: "json") {
            Network.singleton.parse(jsonData: localData)
        }
    }
    
    private func updateData() {
        let urlString = "some url"
        Network.singleton.loadJson(fromStringURL: urlString) { (result) in
            switch result {
            case .success(let data):
                Network.singleton.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

