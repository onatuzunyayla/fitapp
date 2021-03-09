//
//  EditNutritionViewController.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 22.02.2021.
//

import UIKit

class EditNutritionViewController: UIViewController {

    let chronoView = UIView()
    let dismissButton = UIButton(type: .close)
    let sleepImage = UIImage(named: "sleep")
    let bedImage = UIImage(named: "bed")
    let windowImage = UIImage(named: "window")
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton.frame = CGRect(x: 20, y: 60, width: 100, height: 50)
        dismissButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(dismissButton)
        
        chronoView.layer.frame = CGRect(x: 0, y: 0, width: 360, height: 260)
        chronoView.center = CGPoint(x: view.center.x, y: view.center.y)
        chronoView.layer.cornerRadius = 9
        chronoView.backgroundColor = UIColor.gray
        //view.addSubview(chronoView)
        
        createParticles()
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        self.dismiss(animated: true, completion: nil)
            
    }
    
    func calculateAngle() -> CGFloat {
        let startPoint = CGPoint(x: view.center.x + 150, y: view.center.y + 150)
        let endPoint = CGPoint(x: view.center.x - 150, y: view.center.y - 150)
        let deltaX = endPoint.x - startPoint.x
        let deltaY = endPoint.y - startPoint.y
        
        return atan2(deltaY, deltaX)
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()

        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: 200)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: chronoView.frame.width, height: 2)
        

        let cell = CAEmitterCell()
        let image = UIImage(named: "raindrop")!
        let targetSize = CGSize(width: 15, height: 15)
        let scaledImage = image.scalePreservingAspectRatio(
            targetSize: targetSize)
        let cellImage = scaledImage.rotate(radians: -(.pi / 6))
        
        cell.birthRate = 7
        cell.lifetime = 5
        cell.velocity = 300
        cell.velocityRange = 30
        //cell.velocityRange = 50
        //cell.emissionLongitude = (180 * (.pi / 180))
        cell.emissionLongitude = calculateAngle()
        //cell.color = UIColor(white: 1, alpha: 0.1).cgColor
        cell.contents = cellImage?.cgImage
        particleEmitter.emitterCells = [cell]

        view.layer.addSublayer(particleEmitter)
    }
    
    func setImages(){
        
    }


    

}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
    
    func rotate(radians: Float) -> UIImage? {
            var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
            // Trim off the extremely small float value to prevent core graphics from rounding it up
            newSize.width = floor(newSize.width)
            newSize.height = floor(newSize.height)

            UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
            let context = UIGraphicsGetCurrentContext()!

            // Move origin to middle
            context.translateBy(x: newSize.width/2, y: newSize.height/2)
            // Rotate around middle
            context.rotate(by: CGFloat(radians))
            // Draw the image at its center
            self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage
        }
}
