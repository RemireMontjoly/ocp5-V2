//
//  Brain.swift
//  CountOnMe
//
//  Created by pith on 25/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Brain {

    var calculateFinished = true
    var resultExpression = ""
    var stringExpression = [String]()
    var numberDisplay = [""]

    func addNewNumber(newNumber: String) {
        // calculateFinished = false

        if var stringMutable = numberDisplay.last {
            stringMutable += newNumber
            numberDisplay = [stringMutable]
            print("Add number: \(numberDisplay)")
        }
    }
    func addPlusOperator() {
        //Todo: check error

        //        if stringExpression.last == "+" || stringExpression.last == "-" || stringExpression.last == "/" || stringExpression.last == "*" {
        //            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        //            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //            self.present(alertVC, animated: true, completion: nil)
        //        }
        stringExpression += numberDisplay
        stringExpression.append("+")
        numberDisplay = [""]
        calculateFinished = false
        print("String Expression: \(stringExpression)")

    }
    func addMinusOperator() {
        //Todo: check error

        stringExpression += numberDisplay
        stringExpression.append("-")
        numberDisplay = [""]
        calculateFinished = false
        print(stringExpression)
    }
    func addDivideOperator() {
        //Todo: check error

        stringExpression += numberDisplay
        stringExpression.append("/")
        numberDisplay = [""]
        calculateFinished = false
        print(stringExpression)
    }
    func addMultiplierOperator() {
        //Todo: check error

        stringExpression += numberDisplay
        stringExpression.append("*")
        numberDisplay = [""]
        calculateFinished = false
        print(stringExpression)
    }

    func calculate() {
        stringExpression += numberDisplay
        numberDisplay = [""]
        print(stringExpression)

        for (i,oprator) in stringExpression.enumerated() {
            if oprator == "/" || oprator == "*" {

                let leftIndex = i - 1
                let rightIndex = i + 1

                print("leftIndex = \(leftIndex)")
                print("RightIndex = \(rightIndex)")

                let left = Int(stringExpression[leftIndex])!
                let operand = stringExpression[i]
                let right = Int(stringExpression[rightIndex])!

                print("left = \(left)")
                print("right = \(right)")
                print("operand = \(operand)")

                let result: Int
                switch operand {
                case "/": result = left / right
                case "*": result = left * right
                default: fatalError("Unknown operator !")

                }
                stringExpression = Array(stringExpression.dropFirst(2))
                 stringExpression[0] = String(result)


                print("The result = \(result)")
                print(stringExpression)
            }

        }
    }
}
