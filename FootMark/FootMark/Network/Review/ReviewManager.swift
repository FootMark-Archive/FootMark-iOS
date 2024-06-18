//
//  ReviewManager.swift
//  FootMark
//
//  Created by 윤성은 on 6/18/24.
//

import UIKit

class ReviewManager {
    var postReviews: [PostReviewDTO] = []
    var putReviews: [PutReviewDTO] = []

    func createPostReviewDummyData() -> PostReviewDTO {
        return PostReviewDTO(
            statusCode: 200,
            message: "Success",
            data: PostReviewDataClass(
                reviewID: 1,
                memberID: 1,
                categoryID: 42,
                content: "This is a test review"
            )
        )
    }

    func createPutReviewDummyData() -> PutReviewDTO {
        return PutReviewDTO(
            statusCode: 200,
            message: "Success",
            data: PutReviewDataClass(
                reviewID: 1,
                memberID: 1,
                categoryID: 42,
                content: "This is an updated review"
            )
        )
    }

    // 더미 데이터 추가
    func addPostReviewDummyData(_ data: PostReviewDTO) {
        postReviews.append(data)
    }

    func addPutReviewDummyData(_ data: PutReviewDTO) {
        putReviews.append(data)
    }

    // 데이터 수정
    func updatePostReview(reviewID: Int, newContent: String) {
        if let index = postReviews.firstIndex(where: { $0.data.reviewID == reviewID }) {
            postReviews[index].data.content = newContent
        }
    }

    func updatePutReview(reviewID: Int, newContent: String) {
        if let index = putReviews.firstIndex(where: { $0.data.reviewID == reviewID }) {
            putReviews[index].data.content = newContent
        }
    }

    // 데이터 삭제
    func deletePostReview(reviewID: Int) {
        postReviews.removeAll { $0.data.reviewID == reviewID }
    }

    func deletePutReview(reviewID: Int) {
        putReviews.removeAll { $0.data.reviewID == reviewID }
    }
}
