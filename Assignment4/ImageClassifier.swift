//
//  ImageClassifier.swift
//  Assignment4
//
//  Created by admin on 2023-11-11.
//

import CoreML
import Vision
import Foundation
import SwiftUI
import CoreMedia
import UIKit

class ImageClassifier {
    static func classifyImage(image: CGImage, completionHandler: @escaping (String) -> Void) {
        let config = MLModelConfiguration()
        guard let model = try? PoseNetMobileNet075S8FP16(configuration: config) else {
            return
        }
        guard let visionModel = try? VNCoreMLModel(for: model.model) else {
            completionHandler("could not create vision model from coreml model")
            return
        }
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            if let observations = request.results as? [VNClassificationObservation] {
                
                let predictions = observations
                    .prefix(through: 2)
                    .map {
                        $0.identifier
                    }
                completionHandler(predictions.first!)
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: image)
        try? handler.perform([request])
    }
}
