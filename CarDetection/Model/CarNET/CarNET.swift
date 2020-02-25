//
//  CarNET.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation

struct CarNET: Codable {
    let detections: [Detections]?
    let is_success: Bool?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {

        case detections = "detections"
        case is_success = "is_success"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        detections = try values.decodeIfPresent([Detections].self, forKey: .detections)
        is_success = try values.decodeIfPresent(Bool.self, forKey: .is_success)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}
