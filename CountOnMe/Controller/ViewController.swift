//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    private var brain = Brain()

    //Tapped equal func set numberDisplay to empty after adding it to stringExpression array.So elements property is the whole expression.
    var elements: [String] {

        if brain.numberDisplay.isEmpty == true {
            return brain.stringExpression
        }
        return [] //Not empty -> user is tapping a number, so we can add an operatorbecause "return []" gives: canAddOperator elements.last = "" (return true).
    }

    //Redondant, on peut l'enlever.
    //    var expressionIsCorrect: Bool {
    //        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*"
    //    }


    // Error check computed variables
    var expressionHaveEnoughElement: Bool {
        return brain.stringExpression.count >= 2
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*" && brain.firstCalculation == false
    }

    // Inutilisé, on peut l'enlever.Cela servait dans le projet de base a clear le display si un calcul a été effectué (expression complète avec le = ).
    //    var expressionHaveResult: Bool {
    //        return textView.text.firstIndex(of: "=") != nil
    //    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if brain.calculateFinished {
            // If the calculation is finished, replace the result on screen with the new number tapped.
            brain.addNewNumber(newNumber: numberText)
            textView.text = brain.numberDisplay
        } else {
            // Else, concatenate numbers and display on textField.
            brain.addNewNumber(newNumber: numberText)
            textView.text.append(numberText)
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {

        if canAddOperator {
            brain.addPlusOperator()
            textView.text.append("+")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {

        if canAddOperator {
            brain.addMinusOperator()
            textView.text.append("-")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedDivideButton(_ sender: UIButton) {

        if canAddOperator {
            brain.addDivideOperator()
            textView.text.append(":")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedMultiplierButton(_ sender: UIButton) {

        if canAddOperator {
            brain.addMultiplierOperator()
            textView.text.append("x")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {

        guard canAddOperator else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }

        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        let divideBy0 = brain.calculate()
        if divideBy0 {
            textView.text = "Error"
        } else {
            textView.text = brain.finalResult
        }
    }
    
    @IBAction func tappedClearButton(_ sender: UIButton) {
        brain.clear()
        textView.text = "0"
    }
    
}

