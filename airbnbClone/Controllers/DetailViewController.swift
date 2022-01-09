//
//  DetailViewController.swift
//  airbnbClone
//
//  Created by admin on 07.01.2022.
//

import UIKit

class DetailViewController: UIViewController{
    //объект в который передаем данные по "segue" из "ExplorerViewController"
    var selectedItem: CoreDataItem?
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var ratingAndCountLable: UILabel!
    @IBOutlet weak var hostedByLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var communicationDescriptionLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // указываю какие значения должны отображаться в окне конкретной ячейки
        if let safeImage = selectedItem?.itemImage{
            itemImage.image = UIImage(data: safeImage)
        }else{
            print("Error, Image not found")
        }
        typeLable.text = selectedItem?.type
        ratingAndCountLable.text = selectedItem?.itemRatingAndCount
        // задаю значение по умолчанию для "hostedBy", вроде не обязательно но ворнинг писал что можно(хотя не обязательно)
        hostedByLable.text = "Cottage hosted by \(selectedItem?.hostedBy ?? "Noname")"
        descriptionLable.text = selectedItem?.itemDescription
        priceLable.text = selectedItem?.price
        communicationDescriptionLable.text = "100% of recent guests rated \(selectedItem?.hostedBy ?? "Noname") a 5-star in communication"
    }
    
    @IBAction func changeDatesPressed(_ sender: UIButton) {
    }
    @IBAction func likeBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func shareBarButtonPressed(_ sender: UIBarButtonItem) {
        presentShareSheet()
    }
    //функция вызывающая окно Share для отправки картинки и типа
    func presentShareSheet(){
        if let safeImage = selectedItem?.itemImage{
            let safeType = selectedItem?.type ?? "type not found"
            // создаю ViewConntroller окна share и обозначаю какие данные отправлять при нажатии. Вроде как безопасно распаковал но ворнинг остался, проблема в том что принимаемый тип Any? надо будет поискать
            let shareSheetVC = UIActivityViewController(activityItems: [UIImage(data: safeImage), safeType], applicationActivities: nil)
            // команда для появления контроллера на экране
            present(shareSheetVC, animated: true)
        }else{
            print("Picture not found")
        }
    }
}

