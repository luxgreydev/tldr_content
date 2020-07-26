//
//  ItemModel.swift
//  tldr_content
//
//  Created by Nicholas on 7/25/20.
//  Copyright © 2020 Lux Grey. All rights reserved.
//

import UIKit
import CardSlider

struct ItemModel: CardSliderItem {
    var image: UIImage
    var rating: Int?
    var title: String
    var subtitle: String?
    var description: String?
}
