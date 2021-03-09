//
//  exerciseCell.swift
//  fitapp1
//
//  Created by Onat Uzunyayla on 8.01.2021.
//

import UIKit

class exerciseCell: UITableViewCell {

    var exerciseImageView = UIImageView()
    var exerciseTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(exerciseImageView)
        addSubview(exerciseTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(exercise: Exercise){
        exerciseImageView.image = exercise.image
        exerciseTitleLabel.text = exercise.title
    }
    
    func configureImageView(){
        exerciseImageView.layer.cornerRadius = 10
        
        // allows to show the corner radius
        exerciseImageView.clipsToBounds = true
        
        
        exerciseImageView.backgroundColor = .white
        
        
    }
    
    func configureTitleLabel(){
        exerciseTitleLabel.numberOfLines = 0
        exerciseTitleLabel.adjustsFontSizeToFitWidth = true
        exerciseTitleLabel.textColor = UIColor.white
    }
    
    func setImageConstraints() {
        exerciseImageView.translatesAutoresizingMaskIntoConstraints = false
        exerciseImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        exerciseImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        exerciseImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        exerciseImageView.widthAnchor.constraint(equalTo: exerciseImageView.heightAnchor, multiplier: 16/9).isActive = true
        
    }
    
    func setTitleConstraints(){
        exerciseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        exerciseTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        exerciseTitleLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 20).isActive = true
        exerciseTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        exerciseTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    
}
