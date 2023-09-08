//
//  LoanModel.swift
//  animatedView
//
//  Created by Agata on 06.09.2023.
//

import Foundation

struct CurrentLoanProductModel: Codable {
    let amount : Int
    let productType : Int
    let sdoPriority : Int
    let transactionAmount : Int
    let interestRate : Int
    let productId : Int
    let term : Int
    let name : String
}

struct NewLoanProductModel : Codable {
    //Текст на зеленом лейбле. Лейбла может не быть
    let greenLineText : String?
    
    //Эти поля будут всегда
    let loanName : String
    let maxLoanSum : Int
    let percentTop : Double
    let daysTopMenu : Int
    
    //Выбор срока займа. Может не быть
    let selectedDays : Int?
    
    //Дата возврата. Может не быть
    let percentSize : Float?
    let dateofReturn : String?
    
    //График платежей. Может не быть.
    let sumOfPayment : Int?
    let paymentsCount : Int?
}


var loanProducts = [
    NewLoanProductModel(greenLineText: "Хит продаж",
                        loanName: "Первый займ 0%",
                        maxLoanSum: 15000,
                        percentTop: 0,
                        daysTopMenu: 30,
                        selectedDays: nil,
                        percentSize: 0.0,
                        dateofReturn: "30.08.2023",
                        sumOfPayment: nil,
                        paymentsCount: nil),
    
    NewLoanProductModel(greenLineText: "Персональное предложение",
                        loanName: "Перекредитование оптимальный на 180 дней 0,74%",
                        maxLoanSum: 40000,
                        percentTop: 0.8,
                        daysTopMenu: 12,
                        selectedDays: nil,
                        percentSize: nil,
                        dateofReturn: nil,
                        sumOfPayment: 4100,
                        paymentsCount: 10),
    
    NewLoanProductModel(greenLineText: nil,
                        loanName: "Премиальный 0,8% на 12 недель",
                        maxLoanSum: 40000,
                        percentTop: 0.8,
                        daysTopMenu: 12,
                        selectedDays: 63,
                        percentSize: nil,
                        dateofReturn: nil,
                        sumOfPayment: nil,
                        paymentsCount: nil),
]


//MARK: Mock data

let currentJson = """
[
    {
        "Amount" : 12000,
        "productType" : 0,
        "SDOPriority" : 1,
        "TransactionAmount" : 0,
        "interestRate" : 1,
        "ProductId" : 10002623095,
        "Term" : 31,
        "name" : "Займ на 31 день в СДО на БК"
    },
    {
        "Amount" : 12000,
        "productType" : 0,
        "SDOPriority" : 1,
        "TransactionAmount" : 0,
        "interestRate" : 1,
        "ProductId" : 10002623094,
        "Term" : 31,
        "name" : "Займ на 31 день в СДО"
    },
    {
        "Amount" : 12000,
        "productType" : 0,
        "SDOPriority" : 3,
        "TransactionAmount" : 0,
        "interestRate" : 1,
        "ProductId" : 10002383162,
        "Term" : 30,
        "name" : "Займ на карту 1% до 30 дней"
    }
]
"""




