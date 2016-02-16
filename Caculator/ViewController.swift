//
//  ViewController.swift
//  Caculator
//
//  Created by 刘述清 on 16/2/14.
//  Copyright © 2016年 刘述清. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var isUserClickTheButton=false;
    
    var cacutator=CaculatorBrain()
    
    var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = "\(newValue)"
            isUserClickTheButton=false
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        print("\(digit)")
        if isUserClickTheButton{
            display.text = display.text!+digit
            
        }else{
            display.text=digit
            isUserClickTheButton=true;
        }
    }
    
    @IBAction func enter() {
        isUserClickTheButton=false
        cacutator.pushOperand(displayValue)
        
    }
    
    @IBAction func cleanInput(sender: UIButton) {
        display.text = "0"
        isUserClickTheButton=false;
    }
    
    @IBAction func operate(sender: UIButton) {
        if isUserClickTheButton{
            enter()
            cacutator.performOperation(sender.currentTitle!)
            displayValue=cacutator.evaluate()!
        }
    }
    
}

