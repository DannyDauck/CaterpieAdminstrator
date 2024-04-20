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
            //Der ausgelesene String enthält das Passwort und den Namen
            FirebaseRepository.shared.userName = input.replacingOccurrences(of: Secrets.loginKey.getValue(), with: "")
            authorized = true
        }
    }
    
}
