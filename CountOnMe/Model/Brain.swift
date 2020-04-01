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
    var finalResult = ""
    var stringExpression = [String]()
    var numberDisplay = ""

    func addNewNumber(newNumber: String) {
        calculateFinished = false
        numberDisplay += newNumber

        print("numberDisplay = \(numberDisplay)")
        print("stringExpression after addNewNumber tapped = \(stringExpression)")
    }

    func addPlusOperator() {
        //Todo: check error

        appending(op: "+")
        print("stringExpression after + tapped = \(stringExpression)")
    }

    func addMinusOperator() {

        appending(op:"-")
        print("stringExpression after - tapped = \(stringExpression)")

    }

    func addDivideOperator() {

        appending(op: "/")
        print("stringExpression after / tapped = \(stringExpression)")
    }

    func addMultiplierOperator() {

        appending(op: "*")
        print("stringExpression after * tapped = \(stringExpression)")
    }

    func appending(op: String) {
        stringExpression.append(numberDisplay)
        stringExpression.append(op)
        numberDisplay = ""
    }

    func calculate() {
        stringExpression.append(numberDisplay)
        numberDisplay = ""
        print("stringExpression after = tapped : \(stringExpression)")

        // This loop iterates over stringExpression-array while a / or * operand still here
        for (i,oprator) in stringExpression.enumerated() {
            if oprator == "/" || oprator == "*" {

                let leftIndex = i - 1
                let rightIndex = i + 1
                print("leftIndex = \(leftIndex)")
                print("RightIndex = \(rightIndex)")

                let left = Int(stringExpression[leftIndex])!
                let operand = stringExpression[i]
                let right = Int(stringExpression[rightIndex])!

                print("left number = \(left)")
                print("right number = \(right)")
                print("operand = \(operand)")

                let result: Int
                switch operand {
                case "/": result = left / right
                case "*": result = left * right
                default: fatalError("Unknown operator !")

                }
                stringExpression[i+1] = "\(result)"
                stringExpression[i] = ""
                stringExpression[i-1] = ""
            }
        }
        print("stringExpression = \(stringExpression)")
        stringExpression.removeAll(where: { $0 == "" })

        // This loop iterates over stringExpression-array while a + or - operand still here
        while stringExpression.count > 1 {

            let left = Int(stringExpression[0])!
            let operand = stringExpression[1]
            let right = Int(stringExpression[2])!

            let result: Int

            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            stringExpression = Array(stringExpression.dropFirst(3))
            stringExpression.insert("\(result)", at: 0)
        }

        finalResult = stringExpression[0]
        clear()

        print("finalResult = \(finalResult)")
        print("calculatFinished = \(calculateFinished)")
        print("numberDisplay = \(numberDisplay)")
        print("Final stringExpression = \(stringExpression)")
    }

    func clear() {
        stringExpression = [String]()
        calculateFinished = true
        numberDisplay = ""
    }
    // End of class:
}
