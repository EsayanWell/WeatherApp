//
//  ViewController+alertController.swift
//  Sunny
//
//  Created by Ivan Akulov on 25/02/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit

// MARK: - Extension for ViewController

extension ViewController {
    
    // creating alercController
    // функция создает и отображает диалоговое окно, позволяя пользователю ввести название города для поиска информации, и предоставляет опции "Search" и "Cancel" для выполнения соответствующих действий.
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        // создание экземпляра UIController
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        // добавление текстового поля
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            // placeholder рандомный элемент массива
            tf.placeholder = cities.randomElement()
        }
        // создание действия seacrh/cancel
        let search = UIAlertAction(title: "Search", style: .default) { action in
            // получает текст из тексового поля
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                print("search info for the \(cityName)")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // добавление действий
        ac.addAction(search)
        ac.addAction(cancel)
        // отображение на экране
        present(ac, animated: true, completion: nil)
    }
}
