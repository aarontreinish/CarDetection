//
//  Parameters.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation

struct Parameters: Codable {
    let box_max_ratio: Double?
    let box_min_height: Int?
    let box_min_ratio: Double?
    let box_min_width: Int?
    let box_select: String?
    let features: [String]?
    let region: [String]?

    enum CodingKeys: String, CodingKey {

        case box_max_ratio = "box_max_ratio"
        case box_min_height = "box_min_height"
        case box_min_ratio = "box_min_ratio"
        case box_min_width = "box_min_width"
        case box_select = "box_select"
        case features = "features"
        case region = "region"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        box_max_ratio = try values.decodeIfPresent(Double.self, forKey: .box_max_ratio)
        box_min_height = try values.decodeIfPresent(Int.self, forKey: .box_min_height)
        box_min_ratio = try values.decodeIfPresent(Double.self, forKey: .box_min_ratio)
        box_min_width = try values.decodeIfPresent(Int.self, forKey: .box_min_width)
        box_select = try values.decodeIfPresent(String.self, forKey: .box_select)
        features = try values.decodeIfPresent([String].self, forKey: .features)
        region = try values.decodeIfPresent([String].self, forKey: .region)
    }

}
