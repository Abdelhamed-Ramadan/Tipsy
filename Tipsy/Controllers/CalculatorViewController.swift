//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var stepperButtons: UIStepper!
    @IBOutlet weak var spiltNumberLabel: UILabel!
    
    var spiltNum: Int = 0
    var tip: Double = 0.0
    var result: Double = 0.0
    var buttonTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billTextField.keyboardType = .numberPad // Set keyboard type to number pad
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        buttonTitle = sender.currentTitle!
        
        //        Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign = String((buttonTitle.dropLast()))
        
        //        Turn the String into a Double.
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
        
        //        Divide the percent expressed out of 100 into a decimal
        tip = buttonTitleAsNumber / Double(100)
    }
    
    func setupStepper() {
        stepperButtons.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        spiltNumberLabel.text = String(Int(stepperButtons.value))
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        spiltNumberLabel.text = String(Int(sender.value))
        spiltNum = Int(sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let billText = billTextField.text, let billAmount = Double(billText) else {
            // Handle error: invalid bill amount entered
            return
        }
        
        let totalBillWithTip = billAmount * tip
        
        if spiltNum == 0 {
            // Handle division by zero: display error or set default value
            return
        }
        
        result = (totalBillWithTip + billAmount) / Double(spiltNum)
        print(result) // This will now print the correct split amount
        
        self.performSegue(withIdentifier: "goToResult", sender: self)

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalBill = String(result)
            destinationVC.details = spiltNum
            destinationVC.percent = buttonTitle
        }
    }
    
}

