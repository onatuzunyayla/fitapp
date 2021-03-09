//
//  WorkoutViewController.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 26.01.2021.
//

import UIKit

class WorkoutViewController: UIViewController {
    let myButton = UIButton(type: .close)
    let bpmLabel: UILabel = {
        let label = UILabel()
        label.text = "BPM:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let exerciseLabel: UILabel = {
        let label = UILabel()
        label.text = "Exercise:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let startLabel: UILabel = {
        let label = UILabel()
        label.text = "Time Passed:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let calorieLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories Burnt:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let hourLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.textColor = .white
        return label
    }()
    
    let minuteLabel: UILabel = {
        let label = UILabel()
        label.text = "01"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.textColor = .white
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.textColor = .white
        return label
    }()
    
    let bpmView = UIView()
    let heartrate = CAShapeLayer()
    let chronoView = UIView()
    let calorieView = UIView()
    let calorieScrollView = UIScrollView()
    let testview = UIView()
    let chronoSubView = UIView()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        exerciseLabel.frame = CGRect(x: view.center.x - 170, y: view.center.y - 130, width: 100, height: 50)
        startLabel.frame = CGRect(x: view.center.x - 250, y: view.center.y - 400, width: 300, height: 50)
        
        
        myButton.frame = CGRect(x: 20, y: 60, width: 100, height: 50)
        myButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(myButton)
        
        chronoView.layer.frame = CGRect(x: 0, y: 0, width: 360, height: 260)
        chronoView.center = CGPoint(x: view.center.x, y: view.center.y - 270)
        chronoView.layer.cornerRadius = 9
        chronoView.backgroundColor = UIColor.black
        
        chronoSubView.layer.frame = CGRect(x: 0, y: 0, width: 320, height: 100)
        chronoSubView.center = CGPoint(x: view.center.x, y: view.center.y - 300)
        chronoSubView.layer.cornerRadius = 18
        chronoSubView.backgroundColor = UIColor.darkGray
        
        hourLabel.frame = CGRect(x: view.center.x - 210, y: view.center.y - 460, width: 200, height: 300)
        minuteLabel.frame = CGRect(x: view.center.x - 100, y: view.center.y - 460, width: 200, height: 300)
        secondLabel.frame = CGRect(x: view.center.x + 10, y: view.center.y - 460, width: 200, height: 300)
        
        bpmView.layer.frame = CGRect(x: 0, y: 0, width: 360, height: 260)
        bpmView.center = view.center
        bpmView.layer.cornerRadius = 9
        bpmView.layer.masksToBounds = true
        bpmView.backgroundColor = UIColor.black
        
        view.addSubview(bpmView)
        view.addSubview(exerciseLabel)
        view.addSubview(chronoView)
        view.addSubview(chronoSubView)
        view.addSubview(hourLabel)
        view.addSubview(minuteLabel)
        view.addSubview(secondLabel)
        view.addSubview(startLabel)
        
        let size = 720 + 20 + (view.bounds.width - 360)
        let secondViewStart = 380 + (view.bounds.width - 360)/2
        
        
        calorieScrollView.layer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 260)
        calorieScrollView.frame = CGRect(origin: CGPoint(x: 0, y: view.center.y + 135), size: CGSize(width: view.bounds.width, height: 260))
        
        
        //calorieScrollView.layer.position = CGPoint(x: view.center.x, y: view.center.y + 270)
        
        calorieScrollView.center = CGPoint(x: view.center.x, y: view.center.y + 270)
        //calorieScrollView.frame = CGRect(origin: CGPoint(x: 0, y : 0), size: calorieScrollView.frame.size)
        //calorieScrollView.layer.position = CGPoint(x: view.center.x, y: view.center.y + 270)
        
        
        calorieScrollView.backgroundColor = UIColor.clear
        calorieScrollView.contentSize = CGSize(width: size, height: 260)
        calorieScrollView.isPagingEnabled = true
        //calorieScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //calorieScrollView.contentSize = CGSize(width: 2000, height: 260)
        //calorieScrollView.contentOffset = CGPoint(x: , y: 0)
        view.addSubview(calorieScrollView)
        calorieView.translatesAutoresizingMaskIntoConstraints = false
        calorieView.layer.frame = CGRect(x: (view.bounds.width - 360)/2, y: 0, width: 360, height: 260)
        calorieView.layer.cornerRadius = 9
        calorieView.backgroundColor = UIColor.black
        //calorieView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: calorieView.frame.size)
        
        testview.layer.frame = CGRect(x: secondViewStart, y: 0, width: 360, height: 260)
        testview.layer.cornerRadius = 9
        testview.backgroundColor = UIColor.black
        
        
        calorieScrollView.addSubview(calorieView)
        calorieScrollView.addSubview(testview)
        
        
        
        
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bpmLabel.frame = CGRect(x: calorieView.center.x - 190, y: calorieView.center.y - 130, width: 100, height: 50)
        calorieLabel.frame = CGRect(x: 350, y: 0, width: 300, height: 50)
        
        let path = UIBezierPath()
        let startingPoint = CGPoint(x: calorieView.center.x - 160, y: calorieView.center.y)
        path.move(to: startingPoint)
        path.addLine(to: CGPoint(x: calorieView.center.x - 60, y: calorieView.center.y + 3))
        
        path.addQuadCurve(to: CGPoint(x: calorieView.center.x - 20, y: calorieView.center.y),
                          controlPoint: CGPoint(x: calorieView.center.x - 30, y: calorieView.center.y - 30))
        //path.addLine(to: CGPoint(x: view.center.x + 10, y: view.center.y + 80))
        path.addQuadCurve(to: CGPoint(x: calorieView.center.x + 10, y: calorieView.center.y),
                          controlPoint: CGPoint(x: calorieView.center.x, y: calorieView.center.y + 70))
        //path.addLine(to: CGPoint(x: view.center.x + 40, y: view.center.y - 80))
        path.addQuadCurve(to: CGPoint(x: calorieView.center.x + 40, y: calorieView.center.y),
                          controlPoint: CGPoint(x: calorieView.center.x + 25, y: calorieView.center.y - 200))
        path.addQuadCurve(to: CGPoint(x: calorieView.center.x + 70, y: calorieView.center.y + 10),
                          controlPoint: CGPoint(x: calorieView.center.x + 55, y: calorieView.center.y + 150))
        //path.addLine(to: CGPoint(x: view.center.x + 80, y: view.center.y))
        //path.addLine(to: CGPoint(x: view.center.x + 110, y: view.center.y))
        path.addQuadCurve(to: CGPoint(x: calorieView.center.x + 100, y: calorieView.center.y),
                          controlPoint: CGPoint(x: calorieView.center.x + 73, y: calorieView.center.y - 4))
        path.addQuadCurve(to: CGPoint(x: calorieView.center.x + 105, y: calorieView.center.y - 5),
                          controlPoint: CGPoint(x: calorieView.center.x + 103, y: calorieView.center.y))
        path.addQuadCurve(to: CGPoint(x: calorieView.center.x + 130, y: calorieView.center.y - 5),
                          controlPoint: CGPoint(x: calorieView.center.x + 120, y: calorieView.center.y - 100))
        path.addQuadCurve(to: CGPoint(x: calorieView.center.x + 180, y: calorieView.center.y),
                          controlPoint: CGPoint(x: calorieView.center.x + 130, y: calorieView.center.y + 3))
        
        heartrate.path = path.cgPath
        heartrate.lineWidth = 5
        heartrate.strokeColor = UIColor(red: 180/255, green: 38/255, blue: 100/255, alpha: 1).cgColor
        heartrate.fillColor = UIColor.clear.cgColor
        heartrate.frame = calorieScrollView.frame
        heartrate.position = calorieView.center
        //heartrate.shadowPath = path.cgPath
        heartrate.shadowColor = UIColor(red: 180/255, green: 38/255, blue: 100/255, alpha: 1).cgColor
        heartrate.shadowOffset = .zero
        
        heartrate.shadowOpacity = 46
        heartrate.shadowRadius = 6
        
        heartrate.lineCap = CAShapeLayerLineCap.round
        
        heartrate.strokeEnd = 0
        
        
        
        calorieScrollView.layer.addSublayer(heartrate)
        calorieScrollView.addSubview(bpmLabel)
        calorieScrollView.addSubview(calorieLabel)
    }
    
    // Allows the animation to appear on View Controller
        override func viewWillAppear(_ animated: Bool) {
            super.viewDidAppear(true)

            // Function call
            animateHeartrateLayer()
        }

        // Allows the animation to disappear from View Controller
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(true)

            // Function call
            animateHeartrateLayer()
        }
    
    
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        self.dismiss(animated: true, completion: nil)
            
    }
    

    private func animateHeartrateLayer(){
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        let revAnimation = CABasicAnimation(keyPath: "strokeStart")
        let fadeanimation = CABasicAnimation(keyPath: "opacity")
        
        animation.toValue = 1  // how much the circle scales during the animation
        animation.duration = 0.9
        
        
        animation.isRemovedOnCompletion = false
        //animation.repeatCount = Float.infinity
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        
        
        
        revAnimation.toValue = 1
        revAnimation.duration = 1.4
        //revAnimation.beginTime = currentLayerTime + 0.8
        revAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        //revAnimation.repeatCount = Float.infinity
        
        fadeanimation.fromValue = 1
        fadeanimation.toValue = 0
        fadeanimation.duration = 0.9
        fadeanimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        //fadeanimation.repeatCount = Float.infinity
        
        
        
        let group = CAAnimationGroup()
        group.animations = [animation, revAnimation, fadeanimation]
        group.duration = 0.9
        group.repeatCount = HUGE
        group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        group.fillMode = CAMediaTimingFillMode.forwards
        heartrate.add(group, forKey: "rate")
        
 
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.heartrate.add(revAnimation, forKey: "strokeStart")
            }
        */
        
    }
    

}
