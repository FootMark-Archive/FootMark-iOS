//
//  ReviewService.swift
//  FootMark
//
//  Created by 윤성은 on 6/13/24.
//

import Foundation
import Moya
import KeychainSwift

protocol ReviewServiceProtocol {
    func postReview(request: PostReviewRequestModel, completion: @escaping (NetworkResult<PostReviewDTO>) -> Void)
    func putReview(content: String ,request: PutReviewRequestModel, completion: @escaping (NetworkResult<PutReviewDTO>) -> Void)
}

//let keychain = KeychainSwift()
////let accessToken = keychain.get("accessToken")
//let accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwNDIweXVuQGdtYWlsLmNvbSIsImF1dGgiOiJST0xFX1VTRVIiLCJpYXQiOjE3MTgyODg5NDgsImV4cCI6MTcxODI5MjU0OH0.P5fKmFlx0uaR9XadDr3Ehvat6LOb7Y9crvh5MNubehRvnLP1aOOjRyTz9RnoY6ZKG4kzVMdbxzQd-M9ijTIj5Q"
//
//let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
//    do {
//        var request = try endpoint.urlRequest()
//        // 헤더에 accessToken 추가
//        request.addValue("Bearer \(accessToken ?? "accessToken 없음")", forHTTPHeaderField: "Authorization")
//        // 수정된 요청을 완료 클로저에 전달
//        done(.success(request))
//    } catch {
//        done(.failure(MoyaError.underlying(error, nil)))
//    }
//}

final class ReviewService: BaseService, ReviewServiceProtocol {
    let moyaProvider = MoyaProvider<ReviewTargetType>(requestClosure: requestClosure, plugins: [MoyaLoggingPlugin()])
    
    func postReview(request: PostReviewRequestModel, completion: @escaping (NetworkResult<PostReviewDTO>) -> Void) {
        moyaProvider.request(.addReview(request: request)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data
                
                let networkResult: NetworkResult<PostReviewDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func putReview(content: String ,request: PutReviewRequestModel, completion: @escaping (NetworkResult<PutReviewDTO>) -> Void) {
        moyaProvider.request(.editReview(content: content, request: request)) { result in
            switch result {
            case .success(let result):
                let statusCode = result.statusCode
                let data = result.data
                
                let networkResult: NetworkResult<PutReviewDTO> = self.judgeStatus(statusCode: statusCode, data: data)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
}

