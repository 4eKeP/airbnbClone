//
//  ItemModel.swift
//  airbnbClone
//
//  Created by admin on 26.12.2021.
//

import Foundation
import UIKit
//MARK: - Модель для добовления в CoreData
class Item{
    let itemImage: UIImage
    let itemRatingAndCount: String
    let like: Bool
    let address: String
    let description: String
    let price: String
    let type: String
    let hostedBy: String
    
    init(itemImage: UIImage, itemRatingAndCount: String, like: Bool, address: String, description: String, price: String, type: String, hostedBy: String){
        self.itemImage = itemImage
        self.itemRatingAndCount = itemRatingAndCount
        self.like = like
        self.address = address
        self.description = description
        self.price = price
        self.type = type
        self.hostedBy = hostedBy
    }
}


