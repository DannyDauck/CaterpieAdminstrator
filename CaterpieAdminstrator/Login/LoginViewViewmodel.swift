//
//  LoginViewViewmodel.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 20.04.24.
//

import Foundation


class LoginViewViewmodel: ObservableObject{
    
    @Published var authorized = false
    
    func checkScan(_ input: String){
        if input.contains(Secrets.loginKey.getValue()){
            authorized = true
        }
    }
    
}
