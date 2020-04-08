//
//  BrainTestCase.swift
//  CountOnMeTests
//
//  Created by pith on 06/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe


// Question: On ne peut pas mettre d'arguments/ param dans les fonctions testées?????

class BrainTestCase: XCTestCase {

    var brain: Brain!

    override func setUp() {
        brain = Brain()
    }

    override func tearDown() {
        brain = nil
    }

    //MARK: Testing add-operators functions:
    func test_addPlusOperator() {
        testingHelper(ope: brain.addPlusOperator)
    }

    func test_addMinusOperator() {
        testingHelper(ope: brain.addMinusOperator)
    }

    // Une autre manière de l'écrire????????????????????????????
    func test_addDivideOperator() {
        testingHelper {
            try brain.addDivideOperator()
        }
    }

    func test_addMultiplierOperator() {
        testingHelper(ope: brain.addMultiplierOperator)
    }

    //Helper methode for testing add-operators functions
    func testingHelper(ope: () throws -> () ) {
        if brain.canAddOperator, brain.stringExpression.isEmpty {
            XCTAssertNoThrow(try ope())
        }

        brain.stringExpression = [""]
        if brain.canAddOperator {
            XCTAssertNoThrow(try ope())
        }

        if brain.canAddOperator == false {
            XCTAssertThrowsError(try ope()) { error in
                XCTAssertEqual(error as! ErrorCases, ErrorCases.cannotAddOperator)
            }
        }
    }
    //MARK: Testing addNewNumber, clear and calculate functions:
    func test_addNewNumber() {
        brain.addNewNumber(newNumber: "1")
        XCTAssertTrue(brain.calculateFinished == false)
        XCTAssertTrue(brain.stringExpression.last == "1")
    }

    func test_clear() {
        brain.clear()
        XCTAssertTrue(brain.stringExpression == [String]())
        XCTAssertTrue(brain.calculateFinished)
        XCTAssertTrue(brain.finalResult == "0")
    }


    func test_calculate() throws {
        //First guard:
        //Given expressionIsCorrect == false
        brain.stringExpression.append(" * ")
        if brain.expressionIsCorrect == false {

            //When calculate
            XCTAssertThrowsError(try brain.calculate()) {
                error in
                
                //Then
                XCTAssertTrue(error is ErrorCases)
                XCTAssertEqual(error as! ErrorCases, ErrorCases.expressionIncorrect)
            }
        }

        //Second guard:
        //Given expressionHaveEnoughElement == false
        brain.stringExpression = [String]()
        if brain.expressionHaveEnoughElement == false {

            //When calculate
            XCTAssertThrowsError(try brain.calculate()) {
                error in

                //Then
                XCTAssertTrue(error is ErrorCases)
                XCTAssertEqual(error as! ErrorCases, ErrorCases.notEnoughElements)
            }
        }
    }

}
