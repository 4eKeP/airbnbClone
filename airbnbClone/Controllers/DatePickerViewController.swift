//
//  DatePickerViewController.swift
//  airbnbClone
//
//  Created by admin on 09.01.2022.
//

import UIKit
import CoreData
// самая сырая часть:(
class DatePickerViewController: UIViewController{
    //создаем "контекст" по образу класса AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //экземпляры свойств объекта CoreDataModel (Entity: Dates)
    var chekInDate = Date()
    var chekOutDate = Date()
    // переменная для загрузки сохраненных в базу данных объектов
    var loadedDates = [Dates]()
    
    @IBOutlet weak var chekInLable: UILabel!
    @IBOutlet weak var chekOutLable: UILabel!
    @IBOutlet weak var chekInDatePicker: UIDatePicker!
    @IBOutlet weak var chekOutDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        //функция для загрузки объектов из базы данных
        loadDate()
        // проверка отображения и загрузки данных из базы
        // задаю экземплярам свойств выгружанные из базы значения
        updateDateLable()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        // определяю соответствие данных выбраных на DatePicker и объектами
        chekInDate = chekInDatePicker.date
        chekOutDate = chekOutDatePicker.date
        // задаю условие при котором нельзя выбрать дату заселения болше даты выселения. Еще надо доделать невозможность выбора даты из прошлого
        if chekInDate > chekOutDate{
            // создание AlertController для увидомления пользователя о необходимости смены даты. Здесь выбераеться заголовок и сообщение и стиль уведомления
            let alert = UIAlertController(title: "Alert", message: "Chek-in date is greater then chek-out date", preferredStyle: UIAlertController.Style.alert)
            // добавление кнопки в уведомление для ее закрытия
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // функция для выведения уведомления на экран
            self.present(alert, animated: true, completion: nil)
        }else{
            //определяем "контекст" где будет существовать добавляемый объект
            let contextDate = Dates(context: context)
            //добавляем данные в контекст
            contextDate.chekInDate = chekInDate
            contextDate.chekOutDate = chekOutDate
            // функция для сохранения контекста
            saveDate()
            //функция для загрузки данных из базы
            loadDate()
            //функция для обнавления Lable с данными о дате
            updateDateLable()
        }
    }
    @IBAction func chekInDatePickerChanged(_ sender: UIDatePicker) {
    }
    @IBAction func chekOutDatePickerChanged(_ sender: UIDatePicker) {
    }
    //функция для сохранения контекста в базе
    func saveDate(){
        //попытка сохранения данных из контекста
        do{
            try context.save()
        }catch{
            print("Error saving contex \(error)")
        }
    }
    //функция для загрузки и базы данных
    func loadDate(){
        //создаем "запрос" который "принесет" данные обозначенного типа "Dates"
        let request: NSFetchRequest<Dates> = Dates.fetchRequest()
        // попытка вытащить данные в "контекст"
        do{
            loadedDates = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
    }
    //функция для обнавления Lable с данными о дате
    func updateDateLable() {
        //база не до конца настроена и каждый раз добавляет новые значения в конец массива, так что здесь я беру последние значения из него. что бы не происходило вылета при отсутствие данных добавил значение по умолчанию
        chekInDate = loadedDates.last?.chekInDate ?? Date.now
        chekOutDate = loadedDates.last?.chekOutDate ?? Date.now
        // задаю соответствие данных и Lable форматирую дату под нужный вид
        chekInLable.text = "Chek in: \(chekInDate.formatted(date: .long, time:.omitted))"
        chekOutLable.text = "Chek out: \(chekOutDate.formatted(date: .long, time:.omitted))"
    }
}
