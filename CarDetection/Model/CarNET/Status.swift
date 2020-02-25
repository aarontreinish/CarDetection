//
//  Status.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation

struct Status: Codable {
    let code: Int?
    let message: String?
    let selected: Bool?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case selected = "selected"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        selected = try values.decodeIfPresent(Bool.self, forKey: .selected)
    }

}
