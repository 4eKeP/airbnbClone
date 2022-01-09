//
//  ExplorerTableViewCell.swift
//  airbnbClone
//
//  Created by admin on 26.12.2021.
//

import UIKit
import CoreData
// класс ячейки
class ExplorerItemTableViewCell: UITableViewCell{
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var ratingAndCountItemLable: UILabel!
    @IBOutlet weak var likeItemButton: UIButton!
    @IBOutlet weak var addressItemLable: UILabel!
    @IBOutlet weak var descriptionItemLable: UILabel!
    @IBOutlet weak var priceItemLable: UILabel!
    
    // указываю какие значения должны отображаться в окне конкретной ячейки
    func setItem(item: CoreDataItem){
        // безопасное извлечение опционального объекта
        if let safeImage = item.itemImage{
            // перевод из формата Data в UIImage
            itemImage.image = UIImage(data: safeImage)
        }else{
            print("Error, Image not found")
        }
        ratingAndCountItemLable.text = item.itemRatingAndCount
        addressItemLable.text = item.address
        descriptionItemLable.text = item.itemDescription
        priceItemLable.text = item.price
        
    }
    // Недоделанная функция постановки "лайка" при нажатии на соответствующую кнопку
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
    }
    
}
