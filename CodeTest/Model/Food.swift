//
//  Food.swift
//  CodeTest
//
//  Created by Attique Ullah on 02/07/2022.
//

import Foundation
// MARK: - Food
struct Food: Codable {
    let meta: Meta
    let response: Response
}
// MARK: - Meta
struct Meta: Codable {
    let code: Int
}
// MARK: - Response
struct Response: Codable {
    let title: String
    let calories: Int
    let carbs, protein, fat, saturatedfat: Double
    let unsaturatedfat: Double
    let fiber: Int
    let cholesterol, sugar, sodium, potassium: Double
    let gramsperserving: Int
    let pcstext: String
}
