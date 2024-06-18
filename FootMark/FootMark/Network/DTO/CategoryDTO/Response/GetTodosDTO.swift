//
//  GetCategoryDTO.swift
//  FootMark
//
//  Created by 윤성은 on 6/14/24.
//

// Category에 포함된 TodosDTO
import Foundation

// MARK: - Welcome
struct GetTodosDTO: Codable {
    let statusCode: Int
    let message: String
    let data: GetTodosDataClass
}

// MARK: - DataClass
struct GetTodosDataClass: Codable {
    let todoDateResDtos: [TodoDateResDto]
    let completionRate: Int
    let diaryExists: Bool
    let todayEmoji: String?
}

// MARK: - TodoDateResDto
struct TodoDateResDto: Codable {
    let categoryID: Int
    let categoryName: String
    let content: [String]
    let isCompleted: [Bool]
    let todoID: [Int]

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName, content, isCompleted
        case todoID = "todoId"
    }
}
