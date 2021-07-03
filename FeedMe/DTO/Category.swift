//
//  Category.swift
//  FeedMe
//
//  Created by Ayman Omara on 03/07/2021.
//

import Foundation
struct Category: Codable {
    let categories: [CategoryElement]
}

// MARK: - CategoryElement
struct CategoryElement: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
