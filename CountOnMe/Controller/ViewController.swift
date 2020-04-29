

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    private var brain = Brain()
    
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
        // Allow to replace the number on screen with a new number tapped.
        if brain.calculateFinished {
            brain.addNewNumber(newNumber: numberText)
            textView.text = numberText
            
            // Concatenate numbers on screen.
        } else {
            brain.addNewNumber(newNumber: numberText)
            textView.text.append(numberText)
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        
        do {
            try brain.addPlusOperator()
            textView.text.append(" + ")
        } catch  {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        
        do {
            try brain.addMinusOperator()
            textView.text.append(" - ")
        } catch  {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedDivideButton(_ sender: UIButton) {
        
        do {
            try brain.addDivideOperator()
            textView.text.append(" / ")
        } catch  {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedMultiplierButton(_ sender: UIButton) {
        
        do {
            try brain.addMultiplierOperator()
            textView.text.append(" x ")
        } catch  {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        do {
            let result = try brain.calculate()
            textView.text = result

        } catch BrainError.zeroDivisor {
            let alertVC = UIAlertController(title: "Erreur", message: "Vous ne pouvez pas diviser par 0", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            textView.text = "0"
            return self.present(alertVC, animated: true, completion: nil)

        } catch BrainError.expressionIncorrect {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)

        } catch BrainError.notEnoughElements {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
            
        } catch let error {
            print("Unexpected error occurs: \(error)")
        }
    }
    
    @IBAction func tappedClearButton(_ sender: UIButton) {
        brain.clear()
        textView.text = "0"
    }
    
}

