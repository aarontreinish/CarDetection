//
//  Mmg.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation

struct Mmg: Codable {
    let generation_id: Int?
    let generation_name: String?
    let make_id: Int?
    let make_name: String?
    let model_id: Int?
    let model_name: String?
    let probability: Double?
    let years: String?

    enum CodingKeys: String, CodingKey {

        case generation_id = "generation_id"
        case generation_name = "generation_name"
        case make_id = "make_id"
        case make_name = "make_name"
        case model_id = "model_id"
        case model_name = "model_name"
        case probability = "probability"
        case years = "years"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        generation_id = try values.decodeIfPresent(Int.self, forKey: .generation_id)
        generation_name = try values.decodeIfPresent(String.self, forKey: .generation_name)
        make_id = try values.decodeIfPresent(Int.self, forKey: .make_id)
        make_name = try values.decodeIfPresent(String.self, forKey: .make_name)
        model_id = try values.decodeIfPresent(Int.self, forKey: .model_id)
        model_name = try values.decodeIfPresent(String.self, forKey: .model_name)
        probability = try values.decodeIfPresent(Double.self, forKey: .probability)
        years = try values.decodeIfPresent(String.self, forKey: .years)
    }

}
