//
//  UIString.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 17/10/2021.
//

import Foundation

extension String {
    
    
    var isValidEmail: Bool {
           NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
       }
    var isValidEmailInput: Bool {
//        let emailRegEx = "[[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]]"
        let emailRegEx = "[[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]\\s\\b{2,64}]"
//        let emailRegEx = #"^\S+@\S+\.\S+$"#
//        let emailRegEx = "^[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isValidNameInput: Bool {
        let emailRegEx = "[A-Za-z\\s\\b]"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isValidAddressInput: Bool {
        let emailRegEx = "[A-Za-z0-9/_\\s\\b]"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isValidNumberInput: Bool {
        let emailRegEx = "^[0-9]{0,11}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isValidCNICInput: Bool {
        let emailRegEx = "[0-9]{0,13}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidDate(dateString: String) -> Bool {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        let someDate = dateString
        let fromDate = dateFormatterGet.date(from: someDate) ?? Date()
        let today = Date()
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let age = gregorian.components([.year], from: fromDate, to: today, options: [])
        if age.year ?? 0 >= 18 {
            return true
        } else {
            return false
        }
//        if dateFormatterGet.date(from: someDate) != nil {
//            return true
//
//        } else {
//            return false
//        }
   }
    
    func isValidName(testStr:String) -> Bool {
        
       let regexExp =  "^[0-9a-zA-Z ]{1,}$"
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", regexExp)
        
        let result = predicateTest.evaluate(with: testStr)
        
        if result == true{
            
            return true
        }
        else{
            
            return false
        }
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
    
    
    
    func isEmailValid(emailStr: String) -> Bool {
        
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}$", options: .caseInsensitive).firstMatch(in: emailStr, options: [], range: NSRange(location: 0, length: emailStr.count)) == nil {
                return false
            }
        } catch {
            return false
        }
        return true
    }
    
    
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
    

//    func isValidDate(dateString: String) -> Bool {
//
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "dd-MM-yyyy"
//        let someDate = dateString
//
//        if dateFormatterGet.date(from: someDate) != nil {
//            return true
//
//        } else {
//            return false
//        }
//   }
    
    func isValidPhone(testStr:String) -> Bool{
        
        let regexExp = "^[03]{1}[0-9]{11}$"
        
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
        
        let regexExp =  "^[0-9a-zA-Z#.,/ -]{1,}$"
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", regexExp)
        
        let result = predicateTest.evaluate(with: testStr)
        
        if result == true{
            
            return true
        }
        else{
            
            return false
        }
    }
    
    var isBlank: Bool {
            get {
                let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
                return trimmed.isEmpty
            }
        }

        //Validate Email

    var isEmail: Bool {
            do {
                let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
                return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
            } catch {
                return false
            }
        }

        var isAlphanumeric: Bool {
            return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
        }

    
    func getRandomNumber() -> String{
        
        let timeStamp: NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        return "\(timeStamp)"
    }
}
