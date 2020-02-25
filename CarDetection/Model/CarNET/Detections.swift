//
//  Detections.swift
//  CarDetection
//
//  Created by Aaron Treinish on 2/24/20.
//  Copyright © 2020 Aaron Treinish. All rights reserved.
//

import Foundation

struct Detections: Codable {
    let box: Box?
    let `class`: Class?
    let color: [String]?
    let mm: [String]?
    let mmg: [Mmg]?
    let status: Status?
    let subclass: [Subclass]?

    enum CodingKeys: String, CodingKey {

        case box = "box"
        case `class` = "class"
        case color = "color"
        case mm = "mm"
        case mmg = "mmg"
        case status = "status"
        case subclass = "subclass"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        box = try values.decodeIfPresent(Box.self, forKey: .box)
        `class` = try values.decodeIfPresent(Class.self, forKey: .class)
        color = try values.decodeIfPresent([String].self, forKey: .color)
        mm = try values.decodeIfPresent([String].self, forKey: .mm)
        mmg = try values.decodeIfPresent([Mmg].self, forKey: .mmg)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        subclass = try values.decodeIfPresent([Subclass].self, forKey: .subclass)
    }

}
