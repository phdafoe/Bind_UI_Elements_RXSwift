//
//  ViewController.swift
//  Bind_UI_Elements_RXSwift
//
//  Created by Andres Felipe Ocampo Eljaiesk on 10/3/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    // Varibales locales
    let disposeBag = DisposeBag()
    lazy var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    // IBOutlets
    @IBOutlet var myTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var myTexttFieldUni: UITextField!
    @IBOutlet weak var myTextFieldDos: UITextField!
    @IBOutlet weak var myTextViewUni: UITextView!
    @IBOutlet weak var myButtonUno: UIButton!
    @IBOutlet weak var myLabelUNo: UILabel!
    @IBOutlet weak var mySegmentControlUNi: UISegmentedControl!
    @IBOutlet weak var mySliderUni: UISlider!
    @IBOutlet weak var mySwitchUni: UISwitch!
    @IBOutlet weak var myAxtivityIndicatorUni: UIActivityIndicatorView!
    @IBOutlet weak var myStepperUNi: UIStepper!
    @IBOutlet weak var myLabelStepper: UILabel!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var myLabelTres: UILabel!
    @IBOutlet weak var myProgressVieUno: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTapGestureRecognizer.rx.event
            .bind(onNext:{ [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        myTexttFieldUni.rx.text
            .bind(to:myLabelUNo.rx.text)
            .disposed(by: disposeBag)
        
        myTextFieldDos.rx.text
            .bind(to: myLabelStepper.rx.text)
            .disposed(by: disposeBag)
        
        myTextViewUni.rx.text.orEmpty.asDriver()
            .map{
                "Characters count \($0.count)"
            }
            .drive(myLabelTres.rx.text)
            .disposed(by: disposeBag)
        
        myButtonUno.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.myLabelUNo.text! += "Tapped!"
                self?.view.endEditing(true)
                UIView.animate(withDuration: 0.3, animations: {
                    self?.view.layoutIfNeeded()
                })
            })
        .disposed(by: disposeBag)
        
        mySegmentControlUNi.rx.value
            .skip(1)
            .bind(onNext:{ [weak self] in
                self?.myLabelStepper.text = "Selected segment \($0)"
                UIView.animate(withDuration: 0.3, animations: {
                    self?.view.layoutIfNeeded()
                })
            })
            .disposed(by: disposeBag)
        
        mySliderUni.rx.value
            .bind(to: myProgressVieUno.rx.progress)
            .disposed(by: disposeBag)
        
        mySwitchUni.rx.value
            .map{!$0}
            .bind(to: myAxtivityIndicatorUni.rx.isHidden)
            .disposed(by: disposeBag)
        
        mySwitchUni.rx.value.asDriver()
            .drive(myAxtivityIndicatorUni.rx.isAnimating)
            .disposed(by: disposeBag)
        
        
        myStepperUNi.rx.value
            .map{String(Int($0))}
            .bind(to: myLabelStepper.rx.text)
            .disposed(by: disposeBag)
        
        myDatePicker.rx.date
            .map { [weak self] in
                "Selected date " + (self?.dateFormatter.string(from: $0))!
            }
            .bind(to:myLabelUNo.rx.text)
            .disposed(by: disposeBag)
        
        
        
    }

    


}

