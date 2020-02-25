//
//  Subclass.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation

struct Subclass: Codable {
    let name: String?
    let probability: Double?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case probability = "probability"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        probability = try values.decodeIfPresent(Double.self, forKey: .probability)
    }

}
