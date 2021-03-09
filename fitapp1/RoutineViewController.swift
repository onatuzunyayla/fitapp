//
//  RoutineViewController.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 24.01.2021.
//
import Charts
import UIKit

class RoutineViewController: UIViewController, ChartViewDelegate {

    var lineChart = LineChartView()
    
    let circularPath = UIBezierPath(arcCenter: .zero, radius: 65, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
    
    let percentageLayer: UILabel = {
        let label = UILabel()
        label.text = "200"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let hydrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Hydration"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let nutritionLabel: UILabel = {
        let label = UILabel()
        label.text = "Nutrition"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let trainingLabel: UILabel = {
        let label = UILabel()
        label.text = "Training"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textColor = .black
        return label
    }()
    
    let statisticsLabel: UILabel = {
        let label = UILabel()
        label.text = "Statistics"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textColor = .black
        return label
    }()
    
    let RoutineView = UIView()
    let HydrationView = UIView()
    let NutritionView = UIView()
    let SleepView = UIView()
    let MotivationView = UIView()
    
    let titleLayer = CAShapeLayer()
    let titleLayer_statistic = CAShapeLayer()
    
    
//    let editHydration = UIButton()
    
    
    private func createCircleShapeLayer(strokeColor: UIColor, center: CGPoint) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.lineWidth = 12
        layer.strokeEnd = 0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = strokeColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        layer.position = center
        layer.shadowOffset = .zero
        layer.shadowOpacity = 40
        layer.shadowRadius = 6
        
        return layer
    }
    
    private func createTrackShapeLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.lineWidth = 12
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.strokeColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        
        return layer
    }
    
    private func initiateButton() -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 9
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        
        return button
    }
    let shapeLayer = CAShapeLayer()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Routine"
            
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 1.5)
        view.addSubview(scrollView)
        
        RoutineView.layer.frame = CGRect(x: 0, y: 0, width: 370, height: 300)
        RoutineView.center = CGPoint(x: view.center.x, y: view.center.y - 160)
        RoutineView.layer.cornerRadius = 12
        RoutineView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        
        
        HydrationView.layer.frame = CGRect(x: 0, y: 0, width: 180, height: 320)
        HydrationView.center = CGPoint(x: view.center.x - 95, y: view.center.y + 245)
        HydrationView.layer.cornerRadius = 12
        HydrationView.layer.masksToBounds = true
        HydrationView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        
        
        NutritionView.layer.frame = CGRect(x: 0, y: 0, width: 180, height: 320)
        NutritionView.center = CGPoint(x: view.center.x + 95, y: view.center.y + 245)
        NutritionView.layer.cornerRadius = 12
        NutritionView.layer.masksToBounds = true
        NutritionView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        
        SleepView.layer.frame = CGRect(x: 0, y: 0, width: 180, height: 320)
        SleepView.center = CGPoint(x: view.center.x + 95, y: view.center.y + 580)
        SleepView.layer.cornerRadius = 12
        SleepView.layer.masksToBounds = true
        SleepView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        
        MotivationView.layer.frame = CGRect(x: 0, y: 0, width: 180, height: 320)
        MotivationView.center = CGPoint(x: view.center.x - 95, y: view.center.y + 580)
        MotivationView.layer.cornerRadius = 12
        MotivationView.layer.masksToBounds = true
        MotivationView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        
        scrollView.addSubview(RoutineView)
        scrollView.addSubview(HydrationView)
        scrollView.addSubview(NutritionView)
        scrollView.addSubview(SleepView)
        scrollView.addSubview(MotivationView)
        
        
        
        
        
        
        
        
        //view.addSubview(percentageLayer)
        hydrationLabel.frame = CGRect(x: 0, y: 0, width: 130, height: 50)
        hydrationLabel.center = CGPoint(x: HydrationView.center.x - 20, y: HydrationView.center.y - 130)
        let editHydration = initiateButton()
        editHydration.center = CGPoint(x: HydrationView.center.x + 45, y: HydrationView.center.y + 135)
        editHydration.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        scrollView.addSubview(hydrationLabel)
        scrollView.addSubview(editHydration)
        
        
        nutritionLabel.frame = CGRect(x: 0, y: 0, width: 130, height: 50)
        nutritionLabel.center = CGPoint(x: NutritionView.center.x - 20, y: NutritionView.center.y - 130)
        let editNutrition = initiateButton()
        editNutrition.center = CGPoint(x: NutritionView.center.x + 45, y: NutritionView.center.y + 135)
        editNutrition.addTarget(self, action: #selector(buttonActionNutrition(_:)), for: .touchUpInside)
        scrollView.addSubview(nutritionLabel)
        scrollView.addSubview(editNutrition)
        
        let centerHydration = CGPoint(x: HydrationView.center.x, y: HydrationView.center.y - 30)
        let trackLayer_Hydration = createTrackShapeLayer()
        trackLayer_Hydration.position = centerHydration
        scrollView.layer.addSublayer(trackLayer_Hydration)
        let waterLayer = createCircleShapeLayer(strokeColor: UIColor(red: 45/255, green: 190/255, blue: 210/255, alpha: 1), center: centerHydration)
        waterLayer.shadowColor = UIColor(red: 45/255, green: 210/255, blue: 220/255, alpha: 1.5).cgColor
        scrollView.layer.addSublayer(waterLayer)
        animateShapeLayer(layer: waterLayer)
        
        let centerNutrition = CGPoint(x: NutritionView.center.x, y: NutritionView.center.y - 30)
        let trackLayer_Nutrition = createTrackShapeLayer()
        trackLayer_Nutrition.position = centerNutrition
        scrollView.layer.addSublayer(trackLayer_Nutrition)
        let nutritionLayer = createCircleShapeLayer(strokeColor: UIColor(red: 190/255, green: 190/255, blue: 45/255, alpha: 1), center: centerNutrition)
        nutritionLayer.shadowColor = UIColor(red: 200/255, green: 210/255, blue: 55/255, alpha: 1.1).cgColor
        scrollView.layer.addSublayer(nutritionLayer)
        animateShapeLayer(layer: nutritionLayer)
        
        
        trainingLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        trainingLabel.center = CGPoint(x: RoutineView.center.x + RoutineView.frame.width / 3,
                                       y: RoutineView.center.y - (RoutineView.frame.height / 3) - 90)
        
        let titlepath1 = UIBezierPath()
        titlepath1.move(to: CGPoint(x: view.bounds.width, y: trainingLabel.center.y))
        titlepath1.addLine(to: CGPoint(x: view.bounds.width - 180, y: trainingLabel.center.y))
        titleLayer.path = titlepath1.cgPath
        titleLayer.strokeEnd = 0
        titleLayer.lineWidth = 40
        titleLayer.lineCap = CAShapeLayerLineCap.round
        titleLayer.strokeColor = UIColor.white.cgColor
        titleLayer.shadowOffset = .zero
        titleLayer.shadowOpacity = 40
        titleLayer.shadowRadius = 6
        titleLayer.shadowColor = UIColor.white.cgColor
        scrollView.layer.addSublayer(titleLayer)
        scrollView.addSubview(trainingLabel)
        
        statisticsLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        statisticsLabel.center = CGPoint(x: HydrationView.center.x - HydrationView.frame.width / 8,
                                       y: HydrationView.center.y - (HydrationView.frame.height / 3) - 100)
        
        let titlepath2 = UIBezierPath()
        titlepath2.move(to: CGPoint(x: 0, y: statisticsLabel.center.y))
        titlepath2.addLine(to: CGPoint(x: 180, y: statisticsLabel.center.y))
        titleLayer_statistic.path = titlepath2.cgPath
        titleLayer_statistic.strokeEnd = 0
        titleLayer_statistic.lineWidth = 40
        titleLayer_statistic.lineCap = CAShapeLayerLineCap.round
        titleLayer_statistic.strokeColor = UIColor.white.cgColor
        titleLayer_statistic.shadowOffset = .zero
        titleLayer_statistic.shadowOpacity = 40
        titleLayer_statistic.shadowRadius = 6
        titleLayer_statistic.shadowColor = UIColor.white.cgColor
        scrollView.layer.addSublayer(titleLayer_statistic)
        scrollView.addSubview(statisticsLabel)
        
        lineChart.delegate = self
        lineChart.frame = CGRect(x: 0, y: 0, width: RoutineView.frame.size.width, height: RoutineView.frame.size.height)
        RoutineView.addSubview(lineChart)
        lineChart.backgroundColor = .clear
        lineChart.xAxis.axisLineColor = UIColor.white
        lineChart.rightAxis.gridColor = UIColor.white
        lineChart.xAxis.labelTextColor = UIColor.white
        lineChart.rightAxis.labelTextColor = UIColor.white
        lineChart.xAxis.avoidFirstLastClippingEnabled = true
        lineChart.animate(yAxisDuration: 0.5, easingOption: .easeOutQuad)
        
        let testset = LineChartDataSet(entries: [ChartDataEntry(x: 1, y: 1), ChartDataEntry(x: 2, y: 8), ChartDataEntry(x: 3, y: 6)])
        testset.colors = ChartColorTemplates.liberty()
        let data = LineChartData(dataSet: testset)
        lineChart.data = data
    }
    
    // Allows the animation to appear on View Controller
        override func viewWillAppear(_ animated: Bool) {
            super.viewDidAppear(true)

            // Function call
            
            titleLayerAnimation()
        }

        // Allows the animation to disappear from View Controller
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(true)

            // Function call
            
            titleLayerAnimation()
        }
    
    func animateShapeLayer(layer: CAShapeLayer){
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.8
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        layer.add(basicAnimation, forKey: "Fill")
    }
    
    private func titleLayerAnimation(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0.8
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        titleLayer.add(animation, forKey: "Fill")
        titleLayer_statistic.add(animation, forKey: "Fill")
    }

    @objc func buttonAction(_ sender:UIButton!)
    {
        let vc = EditHydrationViewController()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.navigationController!.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = UIColor.clear
        vc.view.isOpaque = false
        vc.view.insertSubview(blurEffectView, at: 0)
        
        
        self.present(vc, animated: true, completion: nil)
            
    }
    
    @objc func buttonActionNutrition(_ sender:UIButton!)
    {
        let vc = EditNutritionViewController()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.navigationController!.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = UIColor.clear
        vc.view.isOpaque = false
        vc.view.insertSubview(blurEffectView, at: 0)
        self.present(vc, animated: true, completion: nil)
            
    }

}
