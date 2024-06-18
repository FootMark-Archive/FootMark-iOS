//
//  CategoryTargetType.swift
//  FootMark
//
//  Created by 윤성은 on 6/14/24.
//

import Foundation
import Moya

enum CategoryTargetType {
    case getTodo(createAt: String)
}

extension CategoryTargetType: BaseTargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getTodo(_):
            return "/category/todos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTodo(_):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTodo(let createAt):
            // Ensure the createAt is sent as a parameter if needed
            return .requestParameters(parameters: ["createAt": createAt], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getTodo(_):
            return ["Content-Type": "application/json"]
        }
    }
}

