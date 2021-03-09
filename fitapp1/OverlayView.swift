//
//  OverlayView.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 9.01.2021.
//

import Charts
import UIKit

class OverlayView: UIViewController, ChartViewDelegate {

    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var barChart = BarChartView()
    
    @IBOutlet weak var slideIdicator: UIView!
    
    @IBOutlet weak var segments: UISegmentedControl!
    
    @IBOutlet weak var ChartFrame: UIView!
    
    @IBOutlet weak var exName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        slideIdicator.roundCorners(.allCorners, radius: 10)
        //subscribeButton.roundCorners(.allCorners, radius: 10)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
            
        }
        barChart.frame = CGRect(x: 0, y: 0, width: ChartFrame.frame.size.width, height: ChartFrame.frame.size.width)
        ChartFrame.addSubview(barChart)
        let testset = BarChartDataSet(entries: [BarChartDataEntry(x: 1, y: 1), BarChartDataEntry(x: 2, y: 2), BarChartDataEntry(x: 3, y: 3)])
        testset.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSet: testset)
        barChart.data = data
        
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
