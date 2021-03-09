//
//  ProgressListVC.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 8.01.2021.
//

import UIKit

struct Exercise {
    var image: UIImage
    var title: String
}

struct Images {
    static let benchpress = UIImage(named: "benchpress")!
    static let shoulderpress = UIImage(named: "shoulderpress")!
    static let deadlift = UIImage(named: "deadlift")!
    static let squat = UIImage(named: "squat")!
    static let bicepscurl = UIImage(named: "bicepscurl")!
    static let inclinebpress = UIImage(named: "inclinebench")!
    static let declinebpress = UIImage(named: "declinebench")!
    static let latpulldown = UIImage(named: "latpulldown")!
    static let lateralraise = UIImage(named: "lateralraise")!
}

class ProgressListVC: UIViewController, UIViewControllerTransitioningDelegate {

    var tableView = UITableView()
    var exercies: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Exercises"
        self.tableView.backgroundColor = UIColor.black
        exercies = fetchData()
        configureTableView()
        
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        // set delegates
        setTableViewDelegates()
        
        // set row height
        tableView.rowHeight = 100
        
        // register cells
        tableView.register(exerciseCell.self, forCellReuseIdentifier: "ExerciseCell")
        // set constraints
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProgressListVC: UITableViewDelegate, UITableViewDataSource {
    // how many cell i am gonna show, set here, return as int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercies.count
    }
    
    // what cells am i showing
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // sending custom cell to the tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! exerciseCell
        let exercise = exercies[indexPath.row]
        cell.set(exercise: exercise)
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(yourVC.yourfuncName))
        //cell.addGestureRecognizer(tapGesture)
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(exercies[indexPath.row])
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        
        self.present(slideVC, animated: true, completion: nil)
        slideVC.exName.text = exercies[indexPath.row].title
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
}

extension ProgressListVC {
    
    func fetchData() -> [Exercise] {
        let exercise1 = Exercise(image: Images.benchpress, title: "Bench Press")
        let exercise2 = Exercise(image: Images.deadlift, title: "Deadlift")
        let exercise3 = Exercise(image: Images.bicepscurl, title: "Biceps Curl")
        let exercise4 = Exercise(image: Images.declinebpress, title: "Decline Bench Press")
        let exercise5 = Exercise(image: Images.inclinebpress, title: "Incline Bench Press")
        let exercise6 = Exercise(image: Images.lateralraise, title: "Lateral Raise")
        let exercise7 = Exercise(image: Images.latpulldown, title: "Lat Pulldown")
        let exercise8 = Exercise(image: Images.shoulderpress, title: "Shoulder Press")
        let exercise9 = Exercise(image: Images.squat, title: "Squat")
        
        return [exercise1, exercise2, exercise3, exercise4, exercise5, exercise6, exercise7, exercise8, exercise9]
        
    }
    
    
}

extension ProgressListVC{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension UIView {
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        
        
    }
    
    
}


