//
//  Brain.swift
//  CountOnMe
//
//  Created by pith on 25/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum ErrorCases: Error {
    case zeroDivisor
    case cannotAddOperator
    case expressionIncorrect
    case notEnoughElements
}

class Brain {

    var finalResult = "0"
    var stringExpression = [String]()
    var calculateFinished = true

    //  Error check computed variables
    var canAddOperator: Bool {
        return stringExpression.last != " + " && stringExpression.last != " - " && stringExpression.last != " / " && stringExpression.last != " * "
    }

    var expressionIsCorrect: Bool {
        return stringExpression.last != " + " && stringExpression.last != " - " && stringExpression.last != " / " && stringExpression.last != " * "
    }

    var expressionHaveEnoughElement: Bool {
        return stringExpression.count >= 3
    }

    func addNewNumber(newNumber: String) {
        calculateFinished = false
        stringExpression.append(newNumber)
        print("stringExpression after addNewNumber = \(stringExpression)")
    }

    func addPlusOperator() throws {
        try appendingOperator(ope: " + ")
        print("StringExpression after add button tapped without error = \(stringExpression)")
    }

    func addMinusOperator() throws {
        try appendingOperator(ope: " - ")
        print("StringExpression after minus button tapped without error = \(stringExpression)")
    }

    func addDivideOperator() throws {
        try appendingOperator(ope: " / ")
        print("StringExpression after divide button tapped without error = \(stringExpression)")
    }

    func addMultiplierOperator() throws {
        try appendingOperator(ope: " * ")
        print("StringExpression after multiplier button tapped without error = \(stringExpression)")
    }

    func appendingOperator(ope: String) throws {
        calculateFinished = false
        if canAddOperator {
            stringExpression.insert(finalResult, at: 0)// Allow to use the result for a calculation
            stringExpression.append(ope)
        } else {
            throw ErrorCases.cannotAddOperator
        }
    }

    func calculate() throws -> String {
        guard expressionIsCorrect else {
            throw ErrorCases.expressionIncorrect }
        guard expressionHaveEnoughElement else {
            throw ErrorCases.notEnoughElements
        }
        //Concatenation of the individual elements in one string
        let joinedExpression = stringExpression.joined()
        print("JoinedExpression = \(joinedExpression)")
        //Separation by string-elements in array where a space is found (like: " + ").
        var elements = joinedExpression.split(separator: " ").map { "\($0)"}
        print("Elements = \(elements)")

        // This loop iterates over stringExpression-array while a / or * operand still here
        for (i,oprator) in elements.enumerated() {

            if oprator == "/" || oprator == "*" {

                let leftIndex = i - 1
                let rightIndex = i + 1

                let left = Double(elements[leftIndex])!
                let operand = elements[i]
                let right = Double(elements[rightIndex])!

                let result: Double
                switch operand {
                //Check divide by 0.
                case "/": if right == 0 {
                    clear()
                    throw ErrorCases.zeroDivisor
                } else {
                    result = left / right
                    }
                case "*": result = left * right
                default: fatalError("Unknown operator !")

                }
                elements[i+1] = "\(result)"
                elements[i] = "" // C'est pourquoi il y a: elements.removeAll(where: { $0 == "" }) mais peut-on faire autrement?
                elements[i-1] = "" // C'est pourquoi il y a: elements.removeAll(where: { $0 == "" })
            }
        }

        // Drop out all empty string: ""
        elements.removeAll(where: { $0 == "" })
        print("Elements after calculation with * and / = \(elements)")

        // This loop iterates over stringExpression-array while a + or - operand still here
        while elements.count > 1 {

            let left = Double(elements[0])!
            let operand = elements[1]
            let right = Double(elements[2])!

            let result: Double

            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            elements = Array(elements.dropFirst(3))
            elements.insert("\(result)", at: 0)
        }
        finalResult = elements[0]
        calculateFinished = true
        stringExpression = [String]()
        print("Final result = \(finalResult)")
        print("StringExpression = \(stringExpression)")

        return finalResult
    }

    func clear() {
        stringExpression = [String]()
        calculateFinished = true
        finalResult = "0"
    }

}

