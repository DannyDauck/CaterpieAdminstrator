//
//  LoginView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 20.04.24.
//

import SwiftUI
import AVFoundation
import Vision

struct LoginView: View {
    
    
    @State private var scannedEANCode = ""
    @State private var isCameraAuthorized = false
    @State private var isImagePickerPresented = false
    @State private var capturedImage: UIImage?
    
    @StateObject var vm: LoginViewViewmodel
    
    
    var body: some View {
        VStack{
            Spacer()
            Image(.caterpie)
                .resizable()
                .frame(width: 300, height: 30)
            Image(.administartorLogo)
                .resizable()
                .frame(width: 305, height: 30)
                .padding(.leading, 5)
            
            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                Text("Login")
                    .font(.title)
                    .padding(.vertical, 5)
                    .foregroundColor(.black)
                    .frame(width: 300)
                    .background(Capsule().foregroundColor(.white))
                    .padding(5)
                    .background(Capsule().foregroundStyle(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)))
            }
            .padding()
            .sheet(isPresented: $isImagePickerPresented, onDismiss: {
                isCameraAuthorized = false
                if let capturedImage = capturedImage {
                    vm.checkScan(readEANCode(from: capturedImage))
                }
            }) {
                ImagePicker(capturedImage: $capturedImage)
            }
            Spacer()
        }.background(
            ZStack{
                Image(.zero)
                    .resizable()
                    .scaledToFill()
                Color.white.opacity(0.4)
            }.background(.white.opacity(0.4))
        )
    }
    
    
    func readEANCode(from image: UIImage) -> String {
        guard let ciImage = CIImage(image: image) else { return "" }
        
        // Erstellen eines VNImageRequestHandler-Objekts
        let handler = VNImageRequestHandler(ciImage: ciImage)
        var returnValue = ""
        // Erstellen einer VNBarcodeObservation Request
        let request = VNDetectBarcodesRequest { request, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            
            guard let observations = request.results as? [VNBarcodeObservation] else {
                print("No barcode observations found")
                return
            }
            
            // Durchlaufen der erkannten Barcodes und Extrahieren des Barcode-Werts
            
            for observation in observations {
                if let payload = observation.payloadStringValue {
                    scannedEANCode = payload
                    isImagePickerPresented = false
                    if payload != ""{
                        returnValue = payload
                    }
                    
                    print("Barcode detected: \(payload)")
                    
                }
            }
            
        }
        
        
        
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform barcode detection: \(error)")
        }
        
        
        return returnValue
    }
}




#Preview {
    LoginView(vm: LoginViewViewmodel())
}
