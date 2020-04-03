//
//  Brain.swift
//  CountOnMe
//
//  Created by pith on 25/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Brain {
    var firstCalculation = true // Pour afficher une erreur si on tape un opérateur sur l'écran d'acceuil (1+2=3)Est-ce utile???
    var calculateFinished = true
    var finalResult = "0"
    var stringExpression = [""]//Plutot que = [String](). Car ça permet de ne pas avoir nil et de toute façon le "" est effacé par stringExpression.removeAll(where: { $0 == "" }) dans func calculate
    var numberDisplay = ""

    func addNewNumber(newNumber: String) {
        firstCalculation = false
        calculateFinished = false
        numberDisplay += newNumber

        print("numberDisplay = \(numberDisplay)")
        print("stringExpression after addNewNumber tapped = \(stringExpression)")
    }

    func addPlusOperator() {
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
        firstCalculation = false
        //This "if" is for appending an operator to the previous result still on the screen and do a calculation with it.
        if calculateFinished {
            calculateFinished = false // To be in the same conf as if addNewNumber func is called.(starting point).
            stringExpression.append(finalResult)
            stringExpression.append(op)
            // NumberDisplay is set to "" by calculate func.
            finalResult = "" //Last result is still in finalResult property.It must be cleared.
            
            // The "else" is the "normal" use. Appending an operator after calling addNewNumber func.The screen is reset in VC and newNumber and operator are displayed.
        } else {
            stringExpression.append(numberDisplay)
            stringExpression.append(op)
            numberDisplay = "" //This func added an operator, numberDisplay is now ready for another number tapped.
            finalResult = ""
        }
    }

    func calculate() {
        stringExpression.append(numberDisplay) //The last number on screen must be added to stringExpression array
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
        stringExpression = [""]
        calculateFinished = true
        numberDisplay = ""

        print("finalResult = \(finalResult)")
        print("calculatFinished = \(calculateFinished)")
        print("numberDisplay = \(numberDisplay)")
        print("Final stringExpression = \(stringExpression)")
    }

    func clear() {
        stringExpression = [""]
        calculateFinished = true
        numberDisplay = ""
        finalResult = "0"
    }
    // End of class:
}
