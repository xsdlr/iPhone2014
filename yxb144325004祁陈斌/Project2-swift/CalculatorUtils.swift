//
//  CalculatorUtils.swift
//  Project2-swift
//
//  Created by xsdlr on 14/11/8.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

import UIKit

class CalculatorUtils: NSObject {
    class var Instance:CalculatorUtils {
        struct Static {
            static let instance : CalculatorUtils = CalculatorUtils();
        }
        return Static.instance;
    }
    /**
     * 判断字符是否为数字
     */
    func isNumber(char:Character)->Bool {
        var numberArr:Array<Character> = ["0","1","2","3","4","5","6","7","8","9","."];
        for (_, value) in enumerate(numberArr)  {
            if char == value {
                return true;
            }
        }
        return false;
    }
    /**
    * 判断字符串是否为数字
    */
    func isNumber(string:String)->Bool {
        for (_,char) in enumerate(string) {
            if !isNumber(char) {
                return false;
            }
        }
        return true;
    }
    /**
     * 判断是否是操作符
     */
    func isOperation(char:String)->Bool {
        var numberArr:Array<String> = ["+","﹣","×","%","÷"];
        for (_, value) in enumerate(numberArr)  {
            if char == value {
                return true;
            }
        }
        return false;
    }
    /**
     * 将中缀表达式分割为数与运算符分离的数组
     */
    func splitInfixToNumberAndOperate(exp:String)->Array<String> {
        var result = [String]();
        var temp = "";
        for (_, char) in enumerate(exp) {
            if isNumber(char) {
                temp.append(char);
            } else {
                if !temp.isEmpty {
                    result.append(temp);
                }
                result.append(String(char));
                temp = "";
            }
        }
        if !temp.isEmpty {
            result.append(temp);
        }
        return result;
    }
    /**
     * 中缀表达式转换为后缀表达式
     */
    func infixToPostfix(infixExp:String)->Array<String> {
        var result = [String]();
        var infixExpArray = splitInfixToNumberAndOperate(infixExp);
//        println(infixExpArray);
        var opStack = [String]();
        for (_, subExp) in enumerate(infixExpArray) {
            //操作数直接输出
            if isNumber(subExp) {
                result.append(subExp);
            } else {
                if subExp == "(" {
                    opStack.append(subExp);
                } else if subExp == ")" {
                    for var i=0,count=opStack.count;i<count;i++ {
                        if opStack.last == "(" {
                            opStack.removeLast();
                            break;
                        } else {
                            result.append(opStack.removeLast());
                        }
                    }
                } else {
                    for var i=0,count=opStack.count;i<count;i++ {
                        //栈顶优先级>=当前操作符
                        if priority(opStack.last!, opratorTwo:subExp)>=0 {
                            result.append(opStack.removeLast());
                        } else {
                            break;
                        }
                    }
                    opStack.append(subExp);
                }
            }
        }
        for(_, value) in enumerate(opStack.reverse()) {
            result.append(value);
        }
        return result;
    }
    /**
     * 计算后缀表达式的值
     */
    func calcPostfixExp(postfixArray:Array<String>)->String {
        var result = "计算式错误";
        var numberStack = [Double]();
        for (_, subExp) in enumerate(postfixArray) {
            if isNumber(subExp) {
                numberStack.append((subExp as NSString).doubleValue);
            } else {
                if numberStack.count>=2 {
                    var numberTwo = numberStack.last!;
                    numberStack.removeLast();
                    var numberOne = numberStack.last!;
                    numberStack.removeLast();
                    numberStack.append(basicCalc(numberOne,numberTwo: numberTwo,Operator: subExp));
                }
            }
        }
        if let resultDouble = numberStack.last {
            result = resultDouble.description;
        }
        return result;
    }
    /**
     * 计算两个操作符的优先级
     */
    func priority(operatorOne:String,opratorTwo:String)->Int {
        var dir:Dictionary<String,Int> = ["+":1,"﹣":1,"×":2,"÷":2,"%":2,"(":0];
        var result = 0;
        if let one = dir[operatorOne]{
            if let two = dir[opratorTwo] {
                result = one - two;
            }
        }
        return result;
    }
    /**
     * 基本的四则运算
     */
    func basicCalc(numerOne:Double,numberTwo:Double,Operator op:String)->Double {
        var result:Double = 0;
        if op=="+" {
            result = numerOne + numberTwo;
        } else if op=="﹣" {
            result = numerOne - numberTwo;
        } else if op=="×" {
            result = numerOne * numberTwo;
        } else if op=="÷" {
            if numberTwo != 0 {
                result = numerOne / numberTwo;
            }
        } else if op=="%" {
            result = numerOne % numberTwo;
        }
        return result;
    }
}
