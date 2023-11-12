//
//  GuessImageView.swift
//  Assignment4
//
//  Created by admin on 2023-10-22.
//

import CoreML
import Vision
import Foundation
import SwiftUI
import UIKit

class GuessImageViewModel : ObservableObject {
    @Published var imageName : String = ""
    @Published var aiGuess : String = ""
    func tellImage(_ imageName: String) {
        let image = UIImage(named: imageName)
        ImageClassifier.classifyImage(image: image!.cgImage!, completionHandler: {
            classification in
            DispatchQueue.main.async {
                self.aiGuess = classification
            }
        })
    }
}
	
struct GuessImageView : View {
    @StateObject private var model = GuessImageViewModel()
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                VStack {
                    Image("fish.jpg")
                    Button(action: {
                        model.tellImage("fish.jpg")
                    }) {
                        Text("Tell what is it")
                    }
                }
                VStack {
                    Image("giraff.jpg")
                    Button(action: {
                        model.tellImage("giraff.jpg")
                    }) {
                        Text("Tell what is it")
                    }
                }
            }
            
            Text(model.aiGuess)
        }
    }
}
