//
//  ScannerView.swift
//  CaterpieAdminstrator
//
//  Created by Danny Dauck on 25.03.24.
//

import SwiftUI
import AVFoundation
import Vision

struct ScannerView: View {
    @State private var scannedEANCode = ""
    @State private var isCameraAuthorized = false
    @State private var isImagePickerPresented = false
    @State private var txtFieldIsVisible = false
    @State private var capturedImage: UIImage?
    
    var body: some View {
        VStack {
            if capturedImage != nil {
                Text("Scanned EAN Code: \(scannedEANCode)")
            }
            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                Text("Kamera benutzen")
                    .font(.title)
                    .padding(.vertical, 5)
                    .foregroundColor(.black)
                    .frame(width: 300)
                    .background(Capsule().foregroundColor(.white))
                    .padding(5)
                    .background(Capsule().foregroundStyle(LinearGradient(colors: [.yellow, .gray], startPoint: .bottomLeading, endPoint: .topTrailing)))
            }
            .padding()
            Button(action: {
                txtFieldIsVisible.toggle()
            }) {
                Text("Manuelle Eingabe")
                    .font(.title)
                    .padding(.vertical, 5)
                    .foregroundColor(.black)
                    .frame(width: 300)
                    .background(Capsule().foregroundColor(.white))
                    .padding(5)
                    .background(Capsule().foregroundStyle(LinearGradient(colors: [.gray, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
            }
            .padding()
            if txtFieldIsVisible{
                TextField("EAN", text: $scannedEANCode)
                    .frame(width: 200)
                    .padding(5)
                    .background(.gray.opacity(0.4))
            }
        }
        .sheet(isPresented: $isImagePickerPresented, onDismiss: {
            isCameraAuthorized = false
            if let capturedImage = capturedImage {
                scannedEANCode = readEANCode(from: capturedImage)
            }
        }) {
            ImagePicker(capturedImage: $capturedImage)
        }
        if !scannedEANCode.isEmpty{
            NavigationLink(destination: NewArticleView(vm: NewArticleViewViewmodel(ean: scannedEANCode))){
                Text("Artikel anlegen")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
                    .frame(width: 300)
                    .background(Capsule().foregroundColor(.black))
                    .padding(5)
                    .background(Capsule().foregroundStyle(LinearGradient(colors: [.gray, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
            }
        }
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


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var capturedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = .camera
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(capturedImage: $capturedImage)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var capturedImage: UIImage?
        
        init(capturedImage: Binding<UIImage?>) {
            _capturedImage = capturedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                capturedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}



#Preview {
    ScannerView()
}

