//
//  UIString.swift
//  LawyerApp
//
//  Created by Umair Yousaf on 13/10/2021.
//

import Foundation

class Validate {
    
    func isValidName(testStr:String) -> Bool {
        
       let regexExp =  "^[0-9a-zA-Z ]{1,1000}$"
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", regexExp)
        
        let result = predicateTest.evaluate(with: testStr)
        
        if result == true{
            
            return true
        }
        else{
            
            return false
        }
    }
    
    func isValidPassword(passStr: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,50}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: passStr)
    }
    
    func isValidPassword(testStr:String) -> Bool {
        
        let regexExp = "[A-Z0-9a-z._%+-]{6,64}"
        let predicateTest = NSPredicate(format:  "SELF MATCHES %@ ", regexExp)
        
        let result = predicateTest.evaluate(with: testStr)
        
        if result == true{
            
            return true
        }
        else{
            
            return false
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {

        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result

    }
    
//    func isEmailValid(emailStr: String) -> Bool {
//
//        do {
//            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}$", options: .caseInsensitive).firstMatch(in: emailStr, options: [], range: NSRange(location: 0, length: emailStr.count)) == nil {
//                return false
//            }
//        } catch {
//            return false
//        }
//        return true
//    }
    
    
    func IsValidCNIC(cnicStr:String) -> Bool {
        
        let regexExp = "^[0-9]{13}$"
        
        let predicateTest = NSPredicate(format:  "SELF MATCHES %@ ", regexExp)
        
        let result = predicateTest.evaluate(with: cnicStr)
        
        if result == true{
            
            return true
        }
        else{
            
            return false
        }
    }
    

    func isValidDate(dateString: String) -> Bool {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        let someDate = dateString
        let fromDate = dateFormatterGet.date(from: someDate) ?? Date()
        let today = Date()
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let age = gregorian.components([.year], from: fromDate, to: today, options: [])
        return age.year ?? 0 >= 18
   }
    
    func isValidPhone(testStr:String) -> Bool{
        
//        let regexExp = "^[[0-9]{11}$"
        
        let regexExp = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let predicateTest = NSPredicate(format:  "SELF MATCHES %@ ", regexExp)
        
        let result = predicateTest.evaluate(with: testStr)
        
        if result == true{
            
            return true
        }
        else{
            
            return false
        }
    }
    func isValidAddress(testStr:String) -> Bool {
        
//        let regexExp =  "^[0-9a-zA-Z#.,/ -]{1,}$"
//        let regexExp =  "^([a-zA-z0-9/\\''(),-/.]{2,255})$"
        let regexExp =  "^[0-9a-zA-Z]{1,}$"
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", regexExp)
        
        let result = predicateTest.evaluate(with: testStr)
        
        if result == true{
            
            return true
        }
        else{
            
            return false
        }
    }
}
