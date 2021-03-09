//
//  HomeViewController.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 23.01.2021.
//

import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var check_state = false
    let transition = CircularTransition()
    var pulsatingLayer: CAShapeLayer!
    let trackLayer = CAShapeLayer()
    let shapeLayer = CAShapeLayer()
    
    let scrollView = UIScrollView()
    let currentWorkoutView = UIView()
    let titleLayer = CAShapeLayer()
    let startLabel: UILabel = {
        let label = UILabel()
        label.text = "Start\nWorkout"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarConfig()
        
        
        
        let center = CGPoint(x: view.center.x, y: view.center.y - 150)
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        // set startAngle to -CGFloat.pi / 2 is to start the stroke from 12 o'clock
        
        
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = 10
        pulsatingLayer.fillColor = UIColor.white.withAlphaComponent(0.6).cgColor
        pulsatingLayer.lineCap = CAShapeLayerLineCap.round  // rounds the bezier curve around
        pulsatingLayer.position = center
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.darkGray.withAlphaComponent(0.4).cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.black.cgColor // clear the filling inside
        trackLayer.lineCap = CAShapeLayerLineCap.round  // rounds the bezier curve around
        trackLayer.shadowPath = trackLayer.path
        trackLayer.shadowColor = UIColor.white.cgColor
        trackLayer.shadowOpacity = 1
        trackLayer.shadowRadius = 8
        trackLayer.shadowOffset = .zero
        trackLayer.position = center
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(red: 180/255, green: 38/255, blue: 100/255, alpha: 1).cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor  // clear the filling inside
        shapeLayer.lineCap = CAShapeLayerLineCap.round  // rounds the bezier curve around
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        //view.layer.addSublayer(shapeLayer)
        
        view.addSubview(startLabel)
        startLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 120)
        startLabel.center = center
        startLabel.isUserInteractionEnabled = true
        
        welcomeLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        welcomeLabel.center = CGPoint(x: view.center.x - 100, y: view.center.y - 350)
       
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: welcomeLabel.center.y))
        path.addLine(to: CGPoint(x: 220, y: welcomeLabel.center.y))
        titleLayer.path = path.cgPath
        titleLayer.strokeEnd = 0
        titleLayer.lineWidth = 34
        titleLayer.lineCap = CAShapeLayerLineCap.round
        titleLayer.strokeColor = UIColor.white.withAlphaComponent(0.8).cgColor
        view.layer.addSublayer(titleLayer)
        view.addSubview(welcomeLabel)
        
        
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePress))
        gesture.minimumPressDuration = 0.1
        startLabel.addGestureRecognizer(gesture)
        
        
        currentWorkoutView.layer.frame = CGRect(x: 0, y: 0, width: 360, height: 260)
        currentWorkoutView.layer.cornerRadius = 12
        currentWorkoutView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        currentWorkoutView.center = CGPoint(x: view.center.x, y: view.center.y + 170)
        view.addSubview(currentWorkoutView)
        
        scrollView.layer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 260)
        scrollView.frame = CGRect(origin: CGPoint(x: 0, y: view.center.y + 135), size: CGSize(width: view.bounds.width, height: 260))
        scrollView.center = CGPoint(x: view.center.x, y: view.center.y + 170)
        
        
        
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize = CGSize(width: 1000, height: 260)
        scrollView.isPagingEnabled = true
        
        
    }
    
    // Allows the animation to appear on View Controller
        override func viewWillAppear(_ animated: Bool) {
            super.viewDidAppear(true)

            // Function call
            animatePulsatingLayer()
            titleLayerAnimation()
        }

        // Allows the animation to disappear from View Controller
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(true)

            // Function call
            animatePulsatingLayer()
            titleLayerAnimation()
        }
    
    private func titleLayerAnimation(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0.8
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        titleLayer.add(animation, forKey: "Fill")
    }
    
    private func animatePulsatingLayer(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.2  // how much the circle scales during the animation
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        let animation2 = CABasicAnimation(keyPath: "strokeColor")
        animation2.toValue = UIColor(red: 180/255, green: 38/255, blue: 100/255, alpha: 0.6).cgColor
        animation2.duration = 1
        animation2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation2.autoreverses = true
        animation2.repeatCount = Float.infinity
        
        let fadeanimation = CABasicAnimation(keyPath: "opacity")
        fadeanimation.fromValue = 1
        fadeanimation.toValue = 0
        fadeanimation.duration = 1.5
        fadeanimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        fadeanimation.repeatCount = Float.infinity
        
        let group = CAAnimationGroup()
        group.animations = [animation, animation2, fadeanimation]
        group.duration = 1
        group.repeatCount = HUGE
        group.autoreverses = true
        group.fillMode = CAMediaTimingFillMode.forwards
        
        pulsatingLayer.add(group, forKey: "pulsing")
    }
    
    func tabbarConfig(){
        guard let tabbar = self.tabBarController?.tabBar else {
            return}
        
        tabbar.barTintColor = .white
        tabbar.tintColor = .red
        tabbar.unselectedItemTintColor = .black
        
        tabbar.layer.cornerRadius = 30
        tabbar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabbar.layer.masksToBounds = true
        
    }
    
    func handleTransition2NextController(){
        if check_state {
            let secondVC = WorkoutViewController()
            secondVC.transitioningDelegate = self
            secondVC.view.backgroundColor = UIColor.white
            secondVC.modalPresentationStyle = .custom
            self.present(secondVC, animated: true, completion: nil)
            
        }
        
    }
    
    @objc private func handlePress(sender: UILongPressGestureRecognizer){
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let revAnimation = CABasicAnimation(keyPath: "fillColor")
        let colorAnimation = CABasicAnimation(keyPath: "strokeColor")
        let fillcolorAnim = CABasicAnimation(keyPath: "fillColor")
        
        basicAnimation.toValue = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        
        colorAnimation.toValue = UIColor.white.cgColor
        colorAnimation.duration = 1
        colorAnimation.autoreverses = true
        
        fillcolorAnim.fromValue = UIColor.black.cgColor
        fillcolorAnim.toValue = UIColor.white.cgColor
        fillcolorAnim.duration = 1
        fillcolorAnim.autoreverses = true
        
        basicAnimation.duration = 1
        if sender.state == .ended {
            check_state = false
            
            revAnimation.duration = 1
                // every Core Animation has a 'presentation layer' that contains the animated changes
            
            revAnimation.fromValue = trackLayer.presentation()?.fillColor
            revAnimation.toValue = UIColor.black.cgColor
            revAnimation.isRemovedOnCompletion = true
            trackLayer.add(revAnimation, forKey: "revFillColor")
            // remove fill animation after 0.1 second to maintain smoothness
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.trackLayer.removeAnimation(forKey: "FillColor")
                
                }
            
            
            //basicAnimation.fromValue = shapeLayer.strokeEnd
            
            
            
            }
        
        else if sender.state == .began {
            check_state = true
            
            shapeLayer.add(basicAnimation, forKey: "Fill")
            shapeLayer.add(colorAnimation, forKey: "Color")
            trackLayer.add(fillcolorAnim, forKey: "FillColor")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.handleTransition2NextController()
                }
            
            }
        
        
        
        
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = startLabel.center
        transition.circleColor = UIColor.white
        
        return transition
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = startLabel.center
        transition.circleColor = UIColor.white
        
        return transition
    }
    

}

/*
 
 @objc private func handlePress(sender: UILongPressGestureRecognizer){
     
     let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
     let revAnimation = CABasicAnimation(keyPath: "strokeEnd")
     let colorAnimation = CABasicAnimation(keyPath: "strokeColor")
     let fillcolorAnim = CABasicAnimation(keyPath: "fillColor")
     
     basicAnimation.toValue = 1
     basicAnimation.fillMode = CAMediaTimingFillMode.forwards
     basicAnimation.isRemovedOnCompletion = true
     
     colorAnimation.toValue = UIColor.white.cgColor
     colorAnimation.duration = 1
     colorAnimation.autoreverses = true
     
     fillcolorAnim.fromValue = UIColor.black.cgColor
     fillcolorAnim.toValue = UIColor.white.cgColor
     fillcolorAnim.duration = 1
     fillcolorAnim.autoreverses = true
     
     basicAnimation.duration = 1
     if sender.state == .ended {
         check_state = false
         
         revAnimation.duration = 1
             // every Core Animation has a 'presentation layer' that contains the animated changes
         revAnimation.fromValue = shapeLayer.presentation()?.strokeEnd
         revAnimation.toValue = 0.0
         revAnimation.isRemovedOnCompletion = true
         shapeLayer.add(revAnimation, forKey: "strokeEnd")
         // remove fill animation after 0.1 second to maintain smoothness
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
             self.shapeLayer.removeAnimation(forKey: "Fill")
             
             }
         
         
         //basicAnimation.fromValue = shapeLayer.strokeEnd
         
         
         
         }
     
     else if sender.state == .began {
         check_state = true
         
         shapeLayer.add(basicAnimation, forKey: "Fill")
         shapeLayer.add(colorAnimation, forKey: "Color")
         trackLayer.add(fillcolorAnim, forKey: "FillColor")
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             self.handleTransition2NextController()
             }
         
         }
     
     
     
     
 }
 
 
 
 */
