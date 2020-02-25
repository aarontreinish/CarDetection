//
//  Meta.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation

struct Meta: Codable {
    let classifier: Int?
    let md5: String?
    let parameters: Parameters?
    let time: Double?

    enum CodingKeys: String, CodingKey {

        case classifier = "classifier"
        case md5 = "md5"
        case parameters = "parameters"
        case time = "time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        classifier = try values.decodeIfPresent(Int.self, forKey: .classifier)
        md5 = try values.decodeIfPresent(String.self, forKey: .md5)
        parameters = try values.decodeIfPresent(Parameters.self, forKey: .parameters)
        time = try values.decodeIfPresent(Double.self, forKey: .time)
    }

}
