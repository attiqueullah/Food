//
//  APIManager.swift
//  Smart Elevator
//
//  Created by Attique Ullah on 14/12/2021.
//

import Foundation
import Moya
import UIKit
import IHProgressHUD
import Connectivity
protocol Networkable {
    var provider: MoyaProvider<API> { get }
}
class APIManager: Networkable {
    static let sharedInstance = APIManager()
    let connectivity: Connectivity = Connectivity()
    
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    func getFood(id : String , completion: @escaping (Result<Food, Error>) -> ()) {
        request(target: .getFoods(id: id), completion: completion)
    }
}
private extension APIManager {
    private func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        
        let connectivityChanged: (Connectivity) -> Void = { [weak self] connectivity in
            if connectivity.isConnected {
                IHProgressHUD.show(withStatus: "Please wait...")
                self?.provider.request(target) { result in
                    IHProgressHUD.dismiss()
                    switch result {
                    case let .success(response):
                        do {
                            let results = try JSONDecoder().decode(T.self, from: response.data)
                            completion(.success(results))
                        } catch let error {
                            IHProgressHUD.showError(withStatus: error.localizedDescription)
                            completion(.failure(error))
                        }
                    case let .failure(error):
                        IHProgressHUD.showError(withStatus: error.localizedDescription)
                        completion(.failure(error))
                    }
                }
            }
            else {
                IHProgressHUD.showError(withStatus: "Internet is unavailable")
            }
        }
        connectivity.whenConnected = connectivityChanged
        connectivity.whenDisconnected = connectivityChanged
        connectivity.startNotifier()
    }
    
}
