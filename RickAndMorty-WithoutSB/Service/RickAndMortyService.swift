//
//  RickAndMortyService.swift
//  RickAndMorty-WithoutSB
//
//  Created by Kadir Yılmaz on 18.05.2023.
//

import Alamofire

enum RickAndMortyServiceEndPoint: String {
    case baseURL = "https://rickandmortyapi.com/api"
    case path = "/character"
    
    static func characterPath() -> String {
        return baseURL.rawValue + path.rawValue
    }
}

protocol IRickAndMortyService {
    func fetchAllData(response: @escaping ([Result]?) -> Void)
}

struct RickAndMortyService: IRickAndMortyService {
    
    func fetchAllData(response: @escaping ([Result]?) -> Void) {
        AF.request(RickAndMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }
    }
    
    
}
