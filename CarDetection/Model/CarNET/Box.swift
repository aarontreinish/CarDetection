//
//  Box.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation

struct Box: Codable {
    let br_x: Double?
    let br_y: Double?
    let tl_x: Double?
    let tl_y: Double?

    enum CodingKeys: String, CodingKey {

        case br_x = "br_x"
        case br_y = "br_y"
        case tl_x = "tl_x"
        case tl_y = "tl_y"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        br_x = try values.decodeIfPresent(Double.self, forKey: .br_x)
        br_y = try values.decodeIfPresent(Double.self, forKey: .br_y)
        tl_x = try values.decodeIfPresent(Double.self, forKey: .tl_x)
        tl_y = try values.decodeIfPresent(Double.self, forKey: .tl_y)
    }

}
