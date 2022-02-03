// FilmsModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Struct Films
struct Films: Decodable {
    let title: String?
    let overview: String?
    let posterPath: String?
    let id: Int
}

/// Struct Category
struct Category: Decodable {
    let results: [Films]
}

