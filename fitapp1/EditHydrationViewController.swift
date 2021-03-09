//
//  EditHydrationViewController.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 18.02.2021.
//

import UIKit

class EditHydrationViewController: UIViewController {
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    let dismissButton = UIButton(type: .close)
    let addWater = UIButton()
    let subtractWater = UIButton()
    
    
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
        
        
        dismissButton.frame = CGRect(x: 20, y: 60, width: 100, height: 50)
        dismissButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(dismissButton)
        
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        addWater.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        addWater.center = CGPoint(x: view.center.x - 120, y: view.center.y + 200)
        addWater.setTitle("+", for: .normal)
        addWater.setTitleColor(UIColor.white, for: .normal)
        addWater.backgroundColor = .clear
        addWater.layer.cornerRadius = 0.5 * addWater.frame.size.width
        addWater.clipsToBounds = true
        addWater.layer.borderWidth = 2
        addWater.layer.borderColor = UIColor.white.cgColor
        view.addSubview(addWater)
        
        subtractWater.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        subtractWater.center = CGPoint(x: view.center.x + 120, y: view.center.y + 200)
        subtractWater.setTitle("-", for: .normal)
        subtractWater.setTitleColor(UIColor.white, for: .normal)
        subtractWater.backgroundColor = .clear
        subtractWater.layer.cornerRadius = 0.5 * subtractWater.frame.size.width
        subtractWater.clipsToBounds = true
        subtractWater.layer.borderWidth = 2
        subtractWater.layer.borderColor = UIColor.white.cgColor
        view.addSubview(subtractWater)
        
        
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
        
        view.layer.addSublayer(dropletLayer)
        view.addSubview(waveLevel)
    }
    // Allows the animation to appear on View Controller
        override func viewWillAppear(_ animated: Bool) {
            super.viewDidAppear(true)

            // Function call
            animateControlPoints(fromPath: path, withPath: path_alternate)
        }

        // Allows the animation to disappear from View Controller
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(true)

            // Function call
            animateControlPoints(fromPath: path, withPath: path_alternate)
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
    

    @objc func buttonAction(_ sender:UIButton!)
    {
        self.dismiss(animated: true, completion: nil)
            
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer){
        
        switch sender.state {
            case .changed:
                viewTranslation = sender.translation(in: view)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                })
            case .ended:
                if viewTranslation.y < 200 {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.view.transform = .identity
                    })
                } else {
                    dismiss(animated: true, completion: nil)
                }
            default:
                break
            }
    }
    

}
