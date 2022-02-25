//
//  ViewController.swift
//  Space Cal
//
//  Created by shayan afghan badie on 2/12/1399 AP.
//  Copyright © 1399 AP Shayan Afghan Badie. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = ""
        
    }
    
    var currentOperation: Operation = Operation.Empty
    var runningNumber = ""
    var btnSound: AVAudioPlayer!
    var firstValue = ""
    var secondValue = ""
    var result = ""
    
    @IBOutlet weak var outputLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let pathToSound = Bundle.main.path(forResource: "btn", ofType: "wav")
//        let soundURL = NSURL(fileURLWithPath: pathToSound!)
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "btn", ofType: "wav")!)

        outputLbl.text = ""

        do {

           try btnSound = AVAudioPlayer(contentsOf: soundURL as URL)

            btnSound.prepareToPlay()

        } catch let err as NSError {

            print(err.debugDescription)

        }
    }
    
    
    @IBAction func pressedBtn(btn: UIButton!) {
        
        playSound()
       runningNumber += "\(btn.tag)"
        
        outputLbl.text = runningNumber
    }
    
    
    @IBAction func onDevidePressed(_ sender: Any) {
        
        processOperation(op: Operation.Divide)
    }
    
    
    @IBAction func onMultiplyPressed(_ sender: Any) {
        
        processOperation(op: Operation.Multiply)
    }
    
    
    
    @IBAction func onSubtractPressed(_ sender: Any) {
        
        processOperation(op: Operation.Subtract)
    }
    
    
    
    @IBAction func onAddPressed(_ sender: Any) {
        
        processOperation(op: Operation.Add)
    }
    
    
    
    @IBAction func onEqualPressed(_ sender: Any) {
        
        processOperation(op: currentOperation)
    }
    
    
    
    func playSound() {
        
        if btnSound.isPlaying {
            
            btnSound.stop()
            
        } else {
            
            btnSound.play()
            
        }
    }
    
    
    
    
    func processOperation(op: Operation) {
        
        playSound()
        
        func assignSecondValue() {
            
            secondValue = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
        
        
        func showingResult() {
            
            firstValue = result
            outputLbl.text = firstValue
            
        }
    
        if runningNumber != "" {
            
        
            switch currentOperation {
             
                 case .Add :
                     
                    assignSecondValue()
                    result = "\(Double(firstValue)! + Double(secondValue)!)"
                    showingResult()
                    
                    
                 case .Subtract :

                    assignSecondValue()
                    result = "\(Double(firstValue)! - Double(secondValue)!)"
                    showingResult()

                    
                 case .Multiply :

                     assignSecondValue()
                     result = "\(Double(firstValue)! * Double(secondValue)!)"
                     showingResult()
                    
                     
                 case Operation.Divide :

                    assignSecondValue()
                    result = "\(Double(firstValue)! / Double(secondValue)!)"
                    showingResult()

                     
                case .Empty :
                    
                     firstValue = runningNumber
                     runningNumber = ""
                     currentOperation = op
                     
                 }
        } else {
            currentOperation = op
        }

    }
}
