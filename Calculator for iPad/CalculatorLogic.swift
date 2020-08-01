//
//  CalculatorLogic.swift
//  Calculator for iPad
//
//  Created by Luke Lazzaro on 1/8/20.
//  Copyright © 2020 Luke Lazzaro. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Decimal?
    private var intermediateCalculation: (n1: Decimal, operation: String)?
    
    mutating func setNumber(_ number: Decimal) {
        self.number = number
    }
    
    mutating func calculate(with symbol: String) -> Decimal? {
        
        if let n = number {
            switch symbol {
            case "+/-":
                return n * -1
            case "AC":
                return 0
            case "%":
                return n * 0.01
            case "=":
                return performTwoNumberCalculation(n2: n)
            default:
                intermediateCalculation = (n1: n, operation: symbol)
            }
        }
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Decimal) -> Decimal? {
        
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.operation {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
    
}
