//
//  CategoryService.swift
//  FootMark
//
//  Created by 윤성은 on 6/14/24.
//

import Foundation
import Moya
import KeychainSwift

protocol CategoryServiceProtocol {
    func getTodo(createAt: String , completion: @escaping (NetworkResult<GetTodosDTO>) -> Void)
}

final class CategoryService: BaseService, CategoryServiceProtocol {
    let moyaProvider: MoyaProvider<CategoryTargetType>
    
    override init() {
        self.moyaProvider = MoyaProvider<CategoryTargetType>(
            requestClosure: KeychainManager.shared.createRequestClosure(),
            plugins: [MoyaLoggingPlugin()]
        )
    }
    
    func getTodo(createAt: String , completion: @escaping (NetworkResult<GetTodosDTO>) -> Void) {
        moyaProvider.request(.getTodo(createAt: createAt)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data

                let networkResult: NetworkResult<GetTodosDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
