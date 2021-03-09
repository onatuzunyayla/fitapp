//
//  ProgressViewController.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 6.03.2021.
//

import UIKit

class ProgressViewController: UIViewController {

    let scrollView = UIScrollView()
    let testview = UIView()
    let programView = UIView()
    
    private func initiateProgramView(frame: CGRect) -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // first UIView CGRect(x: (view.bounds.width - 360)/2, y: 0, width: 360, height: 260)
        view.layer.frame = frame
        view.layer.cornerRadius = 9
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let size = 640 + 20 + (view.bounds.width - 320)
        let secondViewStart = 340 + (view.bounds.width - 320)/2
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 220)
        scrollView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: view.bounds.width, height: 220))
        scrollView.center = CGPoint(x: view.center.x, y: view.center.y - 100)
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize = CGSize(width: size, height: 220)
        scrollView.isPagingEnabled = true
        view.addSubview(scrollView)
        
        programView.translatesAutoresizingMaskIntoConstraints = false
        programView.layer.frame = CGRect(x: (view.bounds.width - 360)/2, y: 0, width: 320, height: 220)
        programView.layer.cornerRadius = 9
        programView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        
        
        scrollView.addSubview(programView)
        
        testview.layer.frame = CGRect(x: secondViewStart, y: 0, width: 320, height: 220)
        testview.layer.cornerRadius = 9
        testview.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        scrollView.addSubview(testview)
    }
    

    

}
