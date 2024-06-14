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
    func getTodos(createAt: String , completion: @escaping (NetworkResult<GetTodosDTO>) -> Void)
}

let keychain = KeychainSwift()
//let accessToken = keychain.get("accessToken")
let accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwNDIweXVuQGdtYWlsLmNvbSIsImF1dGgiOiJST0xFX1VTRVIiLCJpYXQiOjE3MTgzMzM0NzksImV4cCI6MTcxODMzNzA3OX0.mbLTJQCyFgJq57jJxyMBugVv3pexSswlXXFOutIyJouIsbQLroMkXiizogZSUE8hINdh3ntd2zj35YBMSVad8Q"

let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        // 헤더에 accessToken 추가
        request.addValue("Bearer \(accessToken ?? "accessToken 없음")", forHTTPHeaderField: "Authorization")
        // 수정된 요청을 완료 클로저에 전달
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

final class CategoryService: BaseService, CategoryServiceProtocol {
    let moyaProvider = MoyaProvider<CategoryTargetType>(requestClosure: requestClosure, plugins: [MoyaLoggingPlugin()])
    
    func getTodos(createAt: String , completion: @escaping (NetworkResult<GetTodosDTO>) -> Void) {
        moyaProvider.request(.getTodos(createAt: createAt)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data
                if statusCode == 401 {
                    print("인증 실패: \(String(data: data, encoding: .utf8) ?? "데이터 없음")")
                }
                let networkResult: NetworkResult<GetTodosDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
}

