//
//  TierViewController.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 27.01.2021.
//

import UIKit

class TierViewController: UIViewController {


    let path = UIBezierPath()
    let path_alternate = UIBezierPath()
    var path1 = UIBezierPath()
    var path2 = UIBezierPath()
    let waveLayer = CAShapeLayer()
    let dropletMask = CAShapeLayer()
    let dropletLayer = CAShapeLayer()
    var waveLevel = UIView()
    var displayLink: CADisplayLink?
    var controlPoint1 = CGPoint()
    var controlPoint2 = CGPoint()
    var newCenter = CGPoint()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        waveLevel.frame = CGRect(x: 0, y: 0, width: 100, height: 10)
        waveLevel.backgroundColor = UIColor.clear
        waveLevel.center = CGPoint(x: view.center.x, y: view.center.y)
        newCenter = waveLevel.center
        
        
        controlPoint1 = CGPoint(x: waveLevel.center.x - 50, y: waveLevel.center.y - 70)
        controlPoint2 = CGPoint(x: waveLevel.center.x + 50, y: waveLevel.center.y + 70)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        let startingPoint = CGPoint(x: waveLevel.center.x - 150, y: waveLevel.center.y)
        path.move(to: startingPoint)
        path.addCurve(to: CGPoint(x: waveLevel.center.x + 150, y: waveLevel.center.y),
                      controlPoint1: controlPoint1,
                      controlPoint2: controlPoint2)
        path.addLine(to: CGPoint(x: waveLevel.center.x + 150, y: waveLevel.center.y + 150))
        path.addLine(to: CGPoint(x: waveLevel.center.x - 150, y: waveLevel.center.y + 150))
        path.close()
        
        path_alternate.move(to: startingPoint)
        path_alternate.addCurve(to: CGPoint(x: waveLevel.center.x + 150, y: waveLevel.center.y),
                      controlPoint1: controlPoint2,
                      controlPoint2: controlPoint1)
        path_alternate.addLine(to: CGPoint(x: waveLevel.center.x + 150, y: waveLevel.center.y + 150))
        path_alternate.addLine(to: CGPoint(x: waveLevel.center.x - 150, y: waveLevel.center.y + 150))
        path_alternate.close()

        
        waveLayer.path = path.cgPath
        waveLayer.lineWidth = 10
        waveLayer.strokeColor = UIColor.systemBlue.cgColor
        waveLayer.fillColor = UIColor.systemBlue.cgColor
        
        
        
        let dropletPath = UIBezierPath()
        let droppletStartingPoint = CGPoint(x: view.center.x, y: view.center.y - 130)
        dropletPath.move(to: droppletStartingPoint)
        dropletPath.addQuadCurve(to: CGPoint(x: view.center.x, y: view.center.y + 130),
                                 controlPoint: CGPoint(x: view.center.x - 180, y: view.center.y + 125))
        dropletPath.addQuadCurve(to: droppletStartingPoint,
                                 controlPoint: CGPoint(x: view.center.x + 180, y: view.center.y + 125))
        
        dropletMask.path = dropletPath.cgPath
        dropletMask.lineWidth = 10
        dropletMask.lineCap = CAShapeLayerLineCap.round
        
        dropletLayer.path = dropletPath.cgPath
        dropletLayer.lineWidth = 5
        dropletLayer.lineCap = CAShapeLayerLineCap.round
        dropletLayer.strokeColor = UIColor.white.cgColor
        dropletLayer.fillColor = UIColor.clear.cgColor
        
        waveLayer.mask = dropletMask
        view.layer.addSublayer(waveLayer)
        animateControlPoints(fromPath: path, withPath: path_alternate)
        view.layer.addSublayer(dropletLayer)
        view.addSubview(waveLevel)

    }
    
    func createNewPath() -> UIBezierPath{
        let path = UIBezierPath()
        let startingPoint = CGPoint(x: waveLevel.center.x - 150, y: waveLevel.center.y)
        path.move(to: startingPoint)
        path.addCurve(to: CGPoint(x: waveLevel.center.x + 150, y: waveLevel.center.y),
                      controlPoint1: controlPoint1,
                      controlPoint2: controlPoint2)
        path.addLine(to: CGPoint(x: waveLevel.center.x + 150, y: waveLevel.center.y + 150))
        path.addLine(to: CGPoint(x: waveLevel.center.x - 150, y: waveLevel.center.y + 150))
        path.close()
        
        
        return path
    }
    
    func createAlternatePath() -> UIBezierPath{
        let path = UIBezierPath()
        let startingPoint = CGPoint(x: waveLevel.center.x - 150, y: waveLevel.center.y)
        
        path.move(to: startingPoint)
        path.addCurve(to: CGPoint(x: waveLevel.center.x + 150, y: waveLevel.center.y),
                      controlPoint1: controlPoint2,
                      controlPoint2: controlPoint1)
        path.addLine(to: CGPoint(x: waveLevel.center.x + 150, y: waveLevel.center.y + 150))
        path.addLine(to: CGPoint(x: waveLevel.center.x - 150, y: waveLevel.center.y + 150))
        path.close()
        return path
    }
    
    func animateControlPoints(fromPath: UIBezierPath, withPath: UIBezierPath){
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1
        animation.fromValue = fromPath.cgPath
        animation.toValue = withPath.cgPath
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        waveLayer.add(animation, forKey: "wave")
    
    }
    
    func animate2NewPath(toPath: UIBezierPath, controlPath: UIBezierPath){
        waveLayer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.5
        animation.fromValue = path.cgPath
        animation.toValue = toPath.cgPath
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        waveLayer.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animateControlPoints(fromPath: toPath, withPath: controlPath)
            }
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        startDisplayLink()
    }
    
    func startDisplayLink() {

        
        

        // create displayLink & add it to the run-loop
        let displayLink = CADisplayLink(
          target: self, selector: #selector(handleUpdate)
        )
        displayLink.add(to: .main, forMode: .default)
        self.displayLink = displayLink
      }
    
    func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
      }
    
    var startValue = 0
    let endValue = 50
    @objc func handleUpdate(){
        print(startValue)
        startValue += 1
        newCenter = CGPoint(x: newCenter.x, y: newCenter.y + 1)
        waveLevel.center = newCenter
        
        if startValue > endValue {
            startValue = endValue
            stopDisplayLink()
            controlPoint1 = CGPoint(x: waveLevel.center.x - 50, y: waveLevel.center.y - 70)
            controlPoint2 = CGPoint(x: waveLevel.center.x + 50, y: waveLevel.center.y + 70)
            path1 = createNewPath()
            path2 = createAlternatePath()
            
            animate2NewPath(toPath: path1, controlPath: path2)
            
        }
    }
    
    /*
     
     
     let path = UIBezierPath()
     let path_alternate = UIBezierPath()
     let waveLayer = CAShapeLayer()
     let dropletMask = CAShapeLayer()
     let dropletLayer = CAShapeLayer()
     
     var controlPoint1 = CGPoint()
     var controlPoint2 = CGPoint()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         controlPoint1 = CGPoint(x: view.center.x - 50, y: view.center.y - 70)
         controlPoint2 = CGPoint(x: view.center.x + 50, y: view.center.y + 70)
         
         
         let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
         displayLink.add(to: RunLoop.main, forMode: .default)
         
         let startingPoint = CGPoint(x: view.center.x - 150, y: view.center.y)
         path.move(to: startingPoint)
         path.addCurve(to: CGPoint(x: view.center.x + 150, y: view.center.y),
                       controlPoint1: controlPoint1,
                       controlPoint2: controlPoint2)
         path.addLine(to: CGPoint(x: view.center.x + 150, y: view.center.y + 150))
         path.addLine(to: CGPoint(x: view.center.x - 150, y: view.center.y + 150))
         path.close()
         
         path_alternate.move(to: startingPoint)
         path_alternate.addCurve(to: CGPoint(x: view.center.x + 150, y: view.center.y),
                       controlPoint1: controlPoint2,
                       controlPoint2: controlPoint1)
         path_alternate.addLine(to: CGPoint(x: view.center.x + 150, y: view.center.y + 150))
         path_alternate.addLine(to: CGPoint(x: view.center.x - 150, y: view.center.y + 150))
         path_alternate.close()

         
         waveLayer.path = path.cgPath
         waveLayer.lineWidth = 10
         waveLayer.strokeColor = UIColor.systemBlue.cgColor
         waveLayer.fillColor = UIColor.systemBlue.cgColor
         
         
         let dropletPath = UIBezierPath()
         let droppletStartingPoint = CGPoint(x: view.center.x, y: view.center.y - 130)
         dropletPath.move(to: droppletStartingPoint)
         dropletPath.addQuadCurve(to: CGPoint(x: view.center.x, y: view.center.y + 130),
                                  controlPoint: CGPoint(x: view.center.x - 180, y: view.center.y + 125))
         dropletPath.addQuadCurve(to: droppletStartingPoint,
                                  controlPoint: CGPoint(x: view.center.x + 180, y: view.center.y + 125))
         
         dropletMask.path = dropletPath.cgPath
         dropletMask.lineWidth = 10
         dropletMask.lineCap = CAShapeLayerLineCap.round
         
         dropletLayer.path = dropletPath.cgPath
         dropletLayer.lineWidth = 5
         dropletLayer.lineCap = CAShapeLayerLineCap.round
         dropletLayer.strokeColor = UIColor.white.cgColor
         dropletLayer.fillColor = UIColor.clear.cgColor
         
         waveLayer.mask = dropletMask
         view.layer.addSublayer(waveLayer)
         animateControlPoints()
         view.layer.addSublayer(dropletLayer)
         

     }
     
     func animateControlPoints(){
         
         let animation = CABasicAnimation(keyPath: "path")
         animation.duration = 1
         animation.fromValue = path.cgPath
         animation.toValue = path_alternate.cgPath
         animation.autoreverses = true
         animation.repeatCount = Float.infinity
         animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
         waveLayer.add(animation, forKey: nil)
     
     }
     
     
     
     
     */
    
    

   

}
