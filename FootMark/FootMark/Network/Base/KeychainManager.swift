//
//  KeychainManager.swift
//  FootMark
//
//  Created by 윤성은 on 6/14/24.
//

import Foundation
import Moya
import KeychainSwift

class KeychainManager {
    static let shared = KeychainManager()
    private let keychain = KeychainSwift()
    
    // accessToken을 static으로 선언할 필요가 없으므로 인스턴스 메서드를 통해 접근
    var accessToken: String? {
        return keychain.get("accessToken")
    }
    
    // requestClosure를 클래스 메서드로 변경
    static var requestClosure: (Endpoint, @escaping MoyaProvider.RequestResultClosure) -> Void = { endpoint, done in
        // KeychainManager의 인스턴스를 통해 accessToken 가져오기
        let accessToken = KeychainManager.shared.accessToken ?? ""
        do {
            var request = try endpoint.urlRequest()
            // 헤더에 accessToken 추가
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            // 수정된 요청을 완료 클로저에 전달
            done(.success(request))
        } catch {
            done(.failure(MoyaError.underlying(error, nil)))
        }
    }
}
