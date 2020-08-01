//
//  ViewController.swift
//  Calculator for iPad
//
//  Created by Luke Lazzaro on 31/7/20.
//  Copyright © 2020 Luke Lazzaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var copyResultButton: UIButton!
    
    private var isFinishedTypingNumber: Bool = true
    private var calculator = CalculatorLogic()
    
    private var displayValue: Decimal {
        get {
            guard let newNum = Decimal(string: displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Decimal")
            }
            return newNum
        }
        set {
            // Only show decimal places when needed
            displayLabel.text = "\(newValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        copyResultButton.imageView?.contentMode = .scaleAspectFit
    }

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(with: calcMethod) {
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    if !displayValue.isWholeNumber { return }
                }
                displayLabel.text?.append(contentsOf: String(numValue))
            }
        }
    }
    
    @IBAction func copyResultPressed(_ sender: UIButton) {
        // Copy display value to general pasteboard
        UIPasteboard.general.string = "\(displayValue)"
    }
}

extension Decimal {
    var isWholeNumber: Bool {
        return self.isZero || (self.isNormal && self.exponent >= 0)
    }
}
