//
//  ViewController.swift
//  CodeTest
//
//  Created by Attique Ullah on 02/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var baseCashews: GradientView!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var proteins: UILabel!
    @IBOutlet weak var fats: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFood()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func getFood() {
        APIManager.sharedInstance.getFood(id : "1",completion: {result in
            switch result{
            case .success(let food):
                self.calories.text = "\(food.response.calories)"
                self.carbs.text = "\(food.response.carbs)%"
                self.proteins.text = "\(food.response.protein)%"
                self.fats.text = "\(food.response.fat)%"
            case .failure(let error):
                print(error)
            }
        })
    }
}

