//
//  CategoryTargetType.swift
//  FootMark
//
//  Created by 윤성은 on 6/14/24.
//

import Foundation
import Moya

enum CategoryTargetType {
    case getTodos(createAt: String)
}

extension CategoryTargetType: BaseTargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getTodos(let createAt):
            return "/category/todos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTodos(let createAt):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTodos(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getTodos(let createAt):
            return ["Content-Type": "application/json", "createAt": createAt]
        }
    }
}

