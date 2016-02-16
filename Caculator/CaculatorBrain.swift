//
//  CaculatorBrain.swift
//  Caculator
//
//  Created by 刘述清 on 16/2/15.
//  Copyright © 2016年 刘述清. All rights reserved.
//

import Foundation

class CaculatorBrain{
    
    private enum Op:CustomStringConvertible{
        case Operand(Double)//操作数
        case UnaryOperation(String,Double->Double)//运算符
        case BinaryOperation(String,(Double,Double)->Double)
        
        var description:String{
            get{
                switch self{
                case .BinaryOperation(let a,_):
                    return a
                case .UnaryOperation(let b, _):
                    return b
                case .Operand(let c):
                    return String(c)
                }
            }
        }
        
    }
    
    //里面放上运算数字，运算符号
    private var opStack=[Op]()
    //所有已知的运算符号，是一个字典
    private var knownOps=[String:Op]()
    
    init(){
        knownOps["+"]=Op.BinaryOperation("+",+)
        knownOps["−"]=Op.BinaryOperation("−"){$1 - $1}
        knownOps["×"]=Op.BinaryOperation("×",*)
        knownOps["÷"]=Op.BinaryOperation("÷"){$1 / $0}
        knownOps["√"]=Op.UnaryOperation("√",sqrt)
    }
    private func evaluate(ops:[Op])->(resutl:Double?,remainingOps:[Op]){
        if(!ops.isEmpty){
            var remainingOps=ops
            let op=remainingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return (operand,remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEnvaluation=evaluate(remainingOps)
                if let operand=operandEnvaluation.resutl{
                    return (operation(operand),operandEnvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation=evaluate(remainingOps)
                if let operand1=op1Evaluation.resutl{
                    let op2Evaluation=evaluate(op1Evaluation.remainingOps)
                    if let operand2=op2Evaluation.resutl{
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            }
            
        }
        return (nil,ops)
    }
    
    func evaluate()->Double?{
        return evaluate(opStack).resutl
    }
    
    func pushOperand(operand:Double){
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol:String){
        if let operation=knownOps[symbol]{
            opStack.append(operation)
        }
    }
}
