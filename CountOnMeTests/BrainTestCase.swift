//
//  BrainTestCase.swift
//  CountOnMeTests
//
//  Created by pith on 06/04/2020.



import XCTest
@testable import CountOnMe

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

    func test_addMultiplierOperator() {
        testingHelper(ope: brain.addMultiplierOperator)
    }

    func test_addDivideOperator() {
        testingHelper(ope: brain.addDivideOperator)
    }

    //Helper methode for testing add-operators functions
    func testingHelper(ope: () throws -> () ) {
        //Given: canAddOperator and stringExpression.isEmpty == true
        if brain.canAddOperator, brain.stringExpression.isEmpty {
            //Then: error not throwing
            XCTAssertNoThrow(try ope())
        }

        //Given: only canAddOperator == true
        brain.stringExpression = [""]
        if brain.canAddOperator {
            //Then: error not throwing
            XCTAssertNoThrow(try ope())
        }

        if brain.canAddOperator == false {
            XCTAssertThrowsError(try ope()) { error in
                XCTAssertEqual(error as! BrainError, BrainError.cannotAddOperator)
            }
        }
    }
    //MARK: Testing addNewNumber, clear and calculate functions:
    func test_addNewNumber() {
        //When: adding "1"
        brain.addNewNumber(newNumber: "1")

        //Then: last element of stringExpression array == "1" and calculateFinished property is set to false.
        XCTAssertTrue(brain.calculateFinished == false)
        XCTAssertTrue(brain.stringExpression.last == "1")
    }

    func test_clear() {
        //When: clear func is called
        brain.clear()
        //Then: reset globals properties
        XCTAssertTrue(brain.stringExpression == [String]())
        XCTAssertTrue(brain.calculateFinished)
        XCTAssertTrue(brain.finalResult == "0")
    }

    func testFirstGuardInCalculate() throws {
        //Given: expressionIsCorrect == false
        brain.stringExpression.append(" * ")
        if brain.expressionIsCorrect == false {

            //When: calculate
            XCTAssertThrowsError(try brain.calculate()) {
                error in

                //Then: error throws
                XCTAssertTrue(error is BrainError)
                XCTAssertEqual(error as! BrainError, BrainError.expressionIncorrect)
            }
        }
    }

    func testSecondGuardInCalculate() throws {
        //Given: expressionHaveEnoughElement == false
        brain.stringExpression = [String]()
        if brain.expressionHaveEnoughElement == false {

            //When: calculate
            XCTAssertThrowsError(try brain.calculate()) {
                error in

                //Then: error throws
                XCTAssertTrue(error is BrainError)
                XCTAssertEqual(error as! BrainError, BrainError.notEnoughElements)
            }
        }
    }

    func testCalculation() throws {
        //Given: starting point
        brain.clear()

        //When: 2 + 1 / 4 * 2 - 1
        brain.addNewNumber(newNumber: "2")
        try brain.addPlusOperator()
        brain.addNewNumber(newNumber: "1")
        try brain.addMultiplierOperator()
        brain.addNewNumber(newNumber: "4")
        try brain.addDivideOperator()
        brain.addNewNumber(newNumber: "2")
        try brain.addMinusOperator()
        brain.addNewNumber(newNumber: "1")

        //Then: result = 3
        _ = try brain.calculate()
        XCTAssertTrue(brain.finalResult == "3")
    }

    func testDivideBy0() throws {
        //Given: the prior result is 3

        //When: divide by 0
        try brain.addDivideOperator()
        brain.addNewNumber(newNumber: "0")

        //Then: throwing alert
        XCTAssertThrowsError(try brain.calculate()) {
            error in
            XCTAssertTrue(error is BrainError)
            XCTAssertEqual(error as! BrainError, BrainError.zeroDivisor)
        }
    }

}

