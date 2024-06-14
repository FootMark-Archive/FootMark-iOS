//
//  PostReviewRequestModel.swift
//  FootMark
//
//  Created by 윤성은 on 6/13/24.
//

import Foundation

// MARK: - PostReviewRequestModel
struct PostReviewRequestModel: Codable {
    let createAt: String
    let categoryId: Int
    let content: String
}

func createPostReviewRequestModel(createAt: String, categoryId: Int, content: String) -> PostReviewRequestModel {

    return PostReviewRequestModel(createAt: createAt, categoryId: categoryId, content: content)
}
