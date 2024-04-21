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
        
        let splits = input.split(separator: ", ")
        if splits[0] == Secrets.loginKey.getValue() && splits.count == 3{
            FirebaseRepository.shared.userName = splits[1].replacingOccurrences(of: "name: ", with: "")
            ColorManager.shared.backgroundURL = splits[2].replacingOccurrences(of: "wp: ", with: "")
            ColorManager.shared.primary = ColorManager.shared.getColor(splits[3].replacingOccurrences(of: "primary: ", with: ""))
            authorized = true
        }
    }
    
}
