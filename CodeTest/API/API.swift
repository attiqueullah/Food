//
//  API.swift
//  Smart Elevator
//
//  Created by Attique Ullah on 14/12/2021.
//

import Foundation
import Moya
import UIKit


enum API {
    case getFoods(id: String)
}
extension API: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.lifesum.com/v2/foodipedia")!
    }
    
    public var path: String {
        switch self {
        case .getFoods: return "/codetest"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getFoods: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getFoods(let foodId): return .requestParameters(parameters: ["foodid": foodId], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
