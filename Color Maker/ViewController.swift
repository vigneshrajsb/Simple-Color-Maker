//
//  ViewController.swift
//  Color Maker
//
//  Created by Vigneshraj Sekar Babu on 8/18/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let redSwitch = UISwitch()
    let greenSwitch = UISwitch()
    let blueSwitch = UISwitch()
    
    let redSlider = UISlider()
    let greenSlider = UISlider()
    let blueSlider = UISlider()
    
    let redLabel = UILabel()
    let greenLabel = UILabel()
    let blueLabel = UILabel()
    
    let colorView = UIView()
    
    let advancedButton = UIButton()
    
    let hexLabel = UILabel()
    
    var mode : Mode = .simple
    
    var redValue: CGFloat = 0
    var greenValue: CGFloat = 0
    var blueValue: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        configureUI()
    }
    
    //MARK: - Mix Color
    
    @objc func mixColor() {
        if mode == .simple {
            redValue  = redSwitch.isOn ? 1 : 0
            greenValue = greenSwitch.isOn ? 1 : 0
            blueValue = blueSwitch.isOn ? 1 : 0
            
            colorView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
            hexLabel.text = "Red: \(String(format: "%.2f", redValue)), Green: \(String(format: "%.2f", greenValue)), Blue: \(String(format: "%.2f", blueValue))"
            
        } else if mode == .advanced {
            redValue = CGFloat(redSlider.value)
            greenValue = CGFloat(greenSlider.value)
            blueValue = CGFloat(blueSlider.value)
            colorView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
            hexLabel.text = "Red: \(String(format: "%.2f", redValue)), Green: \(String(format: "%.2f", greenValue)), Blue: \(String(format: "%.2f", blueValue))"
            
        }
    }
    
    @objc func toggleAdvanced(_ sender: UIButton){
        print("toggle Advanced")
        if mode == Mode.simple {
            mode = .advanced
            redSwitch.removeFromSuperview()
            blueSwitch.removeFromSuperview()
            greenSwitch.removeFromSuperview()
        } else {
            mode = .simple
            redSlider.removeFromSuperview()
            greenSlider.removeFromSuperview()
            blueSlider.removeFromSuperview()
        }
        configureUI()
    }
    
    //MARK: - Setup UI
    func configureUI() {
        
        //Advanced Button
        
        advancedButton.setTitle(mode == Mode.simple ? "Toggle to Advanced" : "Toggle to Simple", for: .normal)
        advancedButton.setTitleColor(UIColor.white, for: .normal)
        advancedButton.frame = CGRect(x: 180.0, y: 30.0, width: 200.0, height: 30.0)
        advancedButton.addTarget(self, action: #selector(toggleAdvanced(_:)), for: .touchUpInside)
        view.addSubview(advancedButton)
        
        //Labels
        
        redLabel.text = "Red"
        redLabel.textColor = .red
        redLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        greenLabel.text = "Green"
        greenLabel.textColor = .green
        greenLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        blueLabel.text = "Blue"
        blueLabel.textColor = .blue
        blueLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        //Switches
        redSwitch.onTintColor = .red
        greenSwitch.onTintColor = .green
        blueSwitch.onTintColor = .blue
        
        //Sliders
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        
        //Horizontal Color stacks
        let stackWidth: CGFloat = mode == Mode.simple ? 150.0 : 250.0
        let stackHeight: CGFloat = 150.0
        
        let redStackView = UIStackView()
        redStackView.axis = .horizontal
        redStackView.backgroundColor = .red
        redStackView.alignment = .center
        redStackView.spacing = 10
        redStackView.contentMode = .scaleAspectFit
        redStackView.distribution = .fillEqually
        
        redStackView.addArrangedSubview(redLabel)
        
        
        let greenStackView = UIStackView()
        greenStackView.axis = .horizontal
        greenStackView.alignment = .center
        greenStackView.contentMode = .scaleAspectFit
        greenStackView.spacing = 10
        greenStackView.distribution = .fillEqually
        greenStackView.addArrangedSubview(greenLabel)
        
        
        let blueStackView = UIStackView()
        blueStackView.axis = .horizontal
        blueStackView.alignment = .center
        blueStackView.contentMode = .scaleAspectFit
        blueStackView.spacing = 10
        blueStackView.distribution = .fillEqually
        blueStackView.addArrangedSubview(blueLabel)
        
        
        if mode == Mode.simple{
            redStackView.addArrangedSubview(redSwitch)
            greenStackView.addArrangedSubview(greenSwitch)
            blueStackView.addArrangedSubview(blueSwitch)
        } else if mode == Mode.advanced {
            redStackView.addArrangedSubview(redSlider)
            greenStackView.addArrangedSubview(greenSlider)
            blueStackView.addArrangedSubview(blueSlider)
        }
        //Vertical Stack view wrapping the color stacks
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.addArrangedSubview(redStackView)
        verticalStack.addArrangedSubview(greenStackView)
        verticalStack.addArrangedSubview(blueStackView)
        verticalStack.frame = CGRect(x: view.frame.width/2 - stackWidth/2, y: 120, width: stackWidth, height: stackHeight)
        self.view.addSubview(verticalStack)
        
        
        //Color Maker View
        let colorViewSize : CGFloat = 200
        colorView.frame = CGRect(x: view.frame.width/2 - colorViewSize/2, y: 380, width: colorViewSize, height: colorViewSize)
        colorView.layer.borderWidth = 5
        colorView.layer.borderColor = UIColor.white.cgColor
        self.view.addSubview(colorView)
        
        //Hex Label setup
        hexLabel.frame = CGRect(x: 0, y: 610, width: view.frame.maxX, height: 40)
        hexLabel.textColor = .white
        hexLabel.textAlignment = .center
        hexLabel.text = "Red: \(String(format: "%.2f", redValue)), Green: \(String(format: "%.2f", greenValue)), Blue: \(String(format: "%.2f", blueValue))"
        self.view.addSubview(hexLabel)
        
        // Set Up Targets for the switches
        redSwitch.addTarget(self, action: #selector(mixColor), for: .touchUpInside)
        greenSwitch.addTarget(self, action: #selector(mixColor), for: .touchUpInside)
        blueSwitch.addTarget(self, action: #selector(mixColor), for: .touchUpInside)
        
        
        //Set up target for the sliders
        redSlider.addTarget(self, action: #selector(mixColor), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(mixColor), for: .valueChanged)
        blueSlider.addTarget(self, action: #selector(mixColor), for: .valueChanged)
    }
    
    
}

enum Mode {
    case advanced
    case simple
}

