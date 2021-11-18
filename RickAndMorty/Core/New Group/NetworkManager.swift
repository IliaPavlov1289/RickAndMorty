//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 01.11.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }

    func getCaracters(name: String?, status: String?, species: String?, gender: String?, completion: @escaping ([Character]) -> Void) {
        let host = "https://rickandmortyapi.com/api"
        let path = "/character"
        
        let params: Parameters = [
            "name": name ?? "",
            "status": status ?? "",
            "species": species ?? "",
            "gender": gender ?? "",
                ]
        
        AF.request(host + path, parameters: params).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.value,
                      let characters = try? JSONDecoder().decode(CharacterList.self, from: data).results
                else { return }
                completion(characters)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func getImage(fromUrl url: URLConvertible, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success:
                guard let imageData = response.value,
                      let image = UIImage(data: imageData, scale: 1.0)
                else { return }
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
