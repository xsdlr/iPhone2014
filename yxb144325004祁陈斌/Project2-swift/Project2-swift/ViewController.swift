//
//  ViewController.swift
//  Project2-swift
//
//  Created by xsdlr on 14/11/8.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFild: UITextField!
    @IBOutlet weak var memoryLabel: UILabel!

    var memoryValue:Double = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inputExp(sender: UIButton) {
        var displayText:String = "";
        var inputStrNow:String? = sender.currentTitle;
        displayText = textFild.text;
        displayText += inputStrNow!;
        textFild.text = displayText;
    }
    
    @IBAction func calcExp(sender: UIButton) {
        var array = CalculatorUtils.Instance.infixToPostfix(textFild.text);
        textFild.text = CalculatorUtils.Instance.calcPostfixExp(array);
    }

    @IBAction func clear(sender: UIButton) {
        textFild.text = "";
    }
    @IBAction func mClear(sender: UIButton) {
        memoryLabel.hidden = true;
        memoryValue = 0;
    }
    @IBAction func mPlus(sender: UIButton) {
        memoryLabel.hidden = false;
        memoryValue += (textFild.text as NSString).doubleValue;
    }
    @IBAction func mMinus(sender: UIButton) {
        memoryLabel.hidden = false;
        memoryValue -= (textFild.text as NSString).doubleValue;
    }
    @IBAction func mRead(sender: UIButton) {
        textFild.text = memoryValue.description;
    }
    @IBAction func breakspace(sender: UIButton) {
        var displayValue:NSString = textFild.text;
        if displayValue.length>0 {
            textFild.text = displayValue.substringToIndex(displayValue.length-1);
        }
    }
}

