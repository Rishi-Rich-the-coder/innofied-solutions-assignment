//
//  NetworkManagerType.swift
//  InnofiedSolutionAssignment
//
//  Created by Rishikesh Yadav on 3/15/21.
//

import Foundation

public typealias CompletionHander = ((UsersList?) -> Void)

fileprivate protocol NetworkManagerType {
    func fetchUserData(pageNumber: Int, with completion: @escaping CompletionHander)
}

fileprivate class NetworkManager: NetworkManagerType {
    
    func fetchUserData(pageNumber: Int, with completion: @escaping CompletionHander)  {
        guard let url = URL(string: "https://reqres.in/api/users?page=\(pageNumber)&per_page=8") else { return  }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let userData = data, error == nil else { return  }
            do {
                let decodedData = try JSONDecoder().decode(UsersList.self, from: userData)
                completion(decodedData)
            } catch {
                print(error)
            }
        }.resume()
    }
}


public protocol NetworkUsecaseType {
    func getUserData(pageNumber: Int, with completion: @escaping CompletionHander)
}

class NetworkUsecase: NetworkUsecaseType {
    
    private let networkManager: NetworkManagerType!
    
    init() {
        networkManager = NetworkManager()
    }
    
    func getUserData(pageNumber: Int, with completion: @escaping CompletionHander) {
         networkManager.fetchUserData(pageNumber: pageNumber, with: completion)
    }
}
