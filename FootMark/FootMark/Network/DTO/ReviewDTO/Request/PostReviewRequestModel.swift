//
//  PostReviewRequestModel.swift
//  FootMark
//
//  Created by 윤성은 on 6/18/24.
//

import Foundation

// MARK: - PostReviewRequestModel
struct PostReviewRequestModel: Codable {
    let createAt: String
    let categoryId: Int
    let content: String
}
