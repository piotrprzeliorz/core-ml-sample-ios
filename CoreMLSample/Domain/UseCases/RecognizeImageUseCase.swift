//
//  RecognizerUseCase.swift
//  CoreMLSample
//
//  Created by Piotr Przeliorz on 15.03.2018.
//  Copyright © 2018 Piotr Przeliorz. All rights reserved.
//

import CoreML
import Vision

typealias ImageRecognitionResult = (ImageRecognitionData) -> Void

final class RecognizeImageUseCase: UseCase {

    //MARK:- Contants

    private let mlModel: RN1015k500
    private let completion: ImageRecognitionResult
    private let picture: CGImage

    init(picture: CGImage, mlModel: RN1015k500, completion: @escaping ImageRecognitionResult) {
        self.mlModel = mlModel
        self.completion = completion
        self.picture = picture
    }

    func execute() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let `self` = self else { return }
            self.predict(for: self.picture)
        }
    }

    private func predict(`for` image: CGImage) {
        guard let visionModel = try? VNCoreMLModel(for: mlModel.model) else { return }
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            self.processRequest(request: request)
        }
        request.imageCropAndScaleOption = .centerCrop
        let handler = VNImageRequestHandler(cgImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }

    private func processRequest(request: VNRequest) {
        guard let observations = request.results as? [VNClassificationObservation] else {  return }
        let results = observations.prefix(through: 0).map { ($0.identifier, Double($0.confidence)) }.first
        guard let coorindatesData = results?.0 else { return }
        guard let confidence = results?.1 else { return }
        let latLong = coorindatesData.components(separatedBy: "\t").dropFirst().compactMap { Double($0) }
        guard let lat = latLong.first else { return }
        guard let long = latLong.last else { return }
        let result = ImageRecognitionData(latitude: lat, longitude: long, confidence: confidence)
        DispatchQueue.main.async {
            self.completion(result)
        }
    }
}
