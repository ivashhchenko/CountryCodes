//
//  Network.swift
//  CountryCodes
//
//  Created by artem on 23.01.2023.
//

import Foundation


class Network {
        
    static let singleton = Network()
    
    func readLocalFile(forName name: String, ofType type: String) -> Data? {
        
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: type), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func parse(jsonData: Data) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let decodedData: [CountryCode] = try decoder.decode([CountryCode].self, from: jsonData)
            print(decodedData)
        } catch {
            print("decode error")
        }
        
    }
    
    func loadJson(fromStringURL url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: url) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                
                if let data = data {
                    completion(.success(data))
                }
                
                if let error = error {
                    completion(.failure(error))
                }
                
            }
            
            urlSession.resume()
        }
    }
    
    private init(){}
    
}
