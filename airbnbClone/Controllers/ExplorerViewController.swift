//
//  ViewController.swift
//  airbnbClone
//
//  Created by admin on 09.12.2021.
//

import UIKit
import CoreData

class ExplorerViewController: UITableViewController {
    
    @IBOutlet weak var dateBarButton: UIBarButtonItem!
    // массив созданных в CoreData объектов по ItemModel
    var items: [CoreDataItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // инициальизация массива с помощю функции
        items = createArrey()
        tableView.delegate = self
        tableView.dataSource = self
    }
    //MARK: - Создание массива объектов
    func createArrey() -> [CoreDataItem] {
        // объекты созданные по ItemModel
        let itemOne = Item(itemImage: UIImage(imageLiteralResourceName: "moskow_1bedroom"), itemRatingAndCount: "5.0(3 reviews)", like: false, address: "Moskva, Russia", description: "2 guests · 1 bedroom · 1 bed · 1 bath", price: "₽ 4000/night", type: "Apartament", hostedBy: "Tanya")
        let itemTwo = Item(itemImage: UIImage(imageLiteralResourceName: "moskow_ 2bedroom"), itemRatingAndCount: "4.92(284 reviews)", like: true, address: "Moskva, Russia", description: "4 guests · Studio · 2 beds · 1.5 baths", price: "₽ 5000/night", type: "Apartament", hostedBy: "Denis")
        let itemThree = Item(itemImage: UIImage(imageLiteralResourceName: "moskow_1bedroom_2"), itemRatingAndCount: "4.95(165 reviews)", like: true, address: "Moskva, Russia", description: "2 guests · 1 bedroom · 2 beds · 1 bath", price: "₽ 4500/night", type: "Apartament", hostedBy: "Nadya")
        let itemFour = Item(itemImage: UIImage(imageLiteralResourceName: "moskow_ 2bedroom_2"), itemRatingAndCount: "4.89(45 reviews)", like: true, address: "Moskva, Russia", description: "2 guests · Studio · 2 beds · 1 bath", price: "₽ 4700/night", type: "Apartament", hostedBy: "Georgy")
        
        var tempItems: [CoreDataItem] = []
        // объекты созданные с помощю функции addItem по CoreDataModel(Entity: CoreDataItem)
        let item1 = addItem(item: itemOne)
        let item2 = addItem(item: itemTwo)
        let item3 = addItem(item: itemThree)
        let item4 = addItem(item: itemFour)
        // добавление объектов в массив
        tempItems.append(item1)
        tempItems.append(item2)
        tempItems.append(item3)
        tempItems.append(item4)
        // возвращение временного массива
        return tempItems
    }
    //переопределение функции для отмены выбора анимации выделения ячейки
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    //MARK: - TableView Data Source
    //функция определяющая количество секций в TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //функция определяющая ячейку с которой взаимодействуют и контент в ней
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // объект в ячейке
        let item = items[indexPath.row]
        // определение образа ячейки
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExplorerItemCell") as! ExplorerItemTableViewCell
        // заполнение ячейки данными из выбранного объекта
        cell.setItem(item: item)
        return cell
    }
    //MARK: - TableView Delegate Methods
    // "segue" на следующий контроллер
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //определяю конкретный контроллер к которому обращаюсь
        let destinationVC = segue.destination as! DetailViewController
        // определяю какие данные должны быть переданны на следующий контроллер. В данном случае это данные объекта выбранной ячейки
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedItem = items[indexPath.row]
        }
    }
    // функция добавляющая объект в CoreData из ItemModel
    func addItem(item: Item) -> CoreDataItem{
        //создаю "контекст" по образу класса AppDelegate
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //определяю "контекст" где будет существовать добавляемый объект
        let contextItem = CoreDataItem(context: context)
        // перевожу изображение из формата UIImage в формат Data так как в CoreData нельзя хронить UIImage
        let itemImageData1 = item.itemImage.pngData()
        //задаю соотвестствие между объектами ItemModel и CoreDataModel
        contextItem.itemImage = itemImageData1
        contextItem.itemRatingAndCount = item.itemRatingAndCount
        contextItem.liked = item.like
        contextItem.address = item.address
        contextItem.itemDescription = item.description
        contextItem.type = item.type
        contextItem.price = item.price
        contextItem.hostedBy = item.hostedBy
        // возвращаю созданный объект
        return contextItem
    }
}


