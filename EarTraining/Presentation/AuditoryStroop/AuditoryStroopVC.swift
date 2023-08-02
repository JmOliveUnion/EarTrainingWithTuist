//
//  AuditoryStroopVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/01.
//

import UIKit
import Combine

import  SnapKit

class AuditoryStroopVC: BaseViewController {
    
    private let vm = AuditoryStroopViewModel()
    // MARK: - Properties
    
    private lazy var questionProgressBar: UIView = {
        let test = Double(2) / Double(10)
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let progress = UIView()
        progress.backgroundColor = .l_gray100
        
        view.addSubview(progress)
        progress.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(5)
            $0.width.equalToSuperview().multipliedBy(test)
        }
        return view
    }()
    
    private lazy var questionNumber: UILabel = {
        let label = UILabel()
        label.text = "2/10"
        label.font = .Roboto_R16
        label.textColor = .l_gray100
        return label
    }()
    
    private let countdownImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SettingTab")
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
        return image
    }()
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.trackTintColor = .l_gray500
        progress.progressTintColor = .l_keyBlue200
        progress.setProgress(1, animated: false)
        progress.layer.cornerRadius = 10
        progress.clipsToBounds = true
        return progress
    }()
    
    private lazy var countdownStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countdownImage, progressView])
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var countdownLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Int(vm.secondsRemaining))"
        label.textColor = .l_gray600
        label.font = .Roboto_B60
        label.textAlignment = .center
        return label
        
    }()
    
    private let typeLabel: UILabel = {
      let label = UILabel()
        label.text = "단어"
        label.font = .Roboto_R48
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }()
    
    private lazy var typeBlock: UIView = {
        let view = UIView()
        
        view.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
       
        
        view.backgroundColor = .l_gray500
        view.layer.cornerRadius = 25
        
        return view
        
    }()
    
    private lazy var firstChoice: ASChoiceButton = {
        let button = ASChoiceButton(title: "RED", color: .red)
        return button
    }()
    
    private let secondChoice: ASChoiceButton = {
        let button = ASChoiceButton(title: "RED", color: .yellow)
        return button
    }()
    
    private let thirdChoice: ASChoiceButton = {
        let button = ASChoiceButton(title: "GREEN", color: .green)
        return button
    }()
    
    private let fourthChoice: ASChoiceButton = {
        let button = ASChoiceButton(title: "BLUE", color: .red)
        return button
    }()
    
    private lazy var choiceStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [firstChoice, secondChoice, thirdChoice, fourthChoice])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBackButton()
        hideNavigationBarLine()
        setUp()
        bind()
    }
    
    // MARK: - View Methods
    
    private func setUp() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(questionProgressBar)
        questionProgressBar.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        contentView.addSubview(questionNumber)
        questionNumber.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(questionProgressBar.snp.bottom).offset(10)
        }
        
        contentView.addSubview(countdownStack)
        countdownStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(questionNumber.snp.bottom).offset(20)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(countdownLabel)
        countdownLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(countdownStack.snp.bottom).offset(30)
        }
        
        contentView.addSubview(typeBlock)
        typeBlock.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(countdownLabel.snp.bottom).offset(20)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        contentView.addSubview(choiceStack)
        choiceStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(typeBlock.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().offset(-10)
            $0.height.equalToSuperview().multipliedBy(0.55)
        }
        
        vm.startTimer()
        vm.initiateTask()
        print(vm.$choices)
    }
    
    private func bind() {
        
        firstChoice.tapPublisher
            .sink {[weak self] _ in
//                self?.vm.initiateTask()
                self?.vm.tapButton((self?.vm.choices[0])!)
            }
            .store(in: &cancellableBag)
    
        secondChoice.tapPublisher
            .sink {[weak self] _ in
                self?.vm.tapButton((self?.vm.choices[1])!)

            }
            .store(in: &cancellableBag)
    
        thirdChoice.tapPublisher
            .sink {[weak self] _ in
                self?.vm.tapButton((self?.vm.choices[2])!)

            }
            .store(in: &cancellableBag)
    
        fourthChoice.tapPublisher
            .sink {[weak self] _ in
                self?.vm.tapButton((self?.vm.choices[3])!)
            }
            .store(in: &cancellableBag)
        
        vm.$secondsRemaining
            .sink { [weak self] level in
                self?.progressView.setProgress(Float(level) * 0.1 - 0.1, animated: true)
                self?.countdownLabel.text = "\(Int(level))"
            }
            .store(in: &cancellableBag)
        
        vm.$choices
            .sink { [weak self] _ in
                print("\(self!.vm.questionType)")
                self?.typeLabel.text = "\(self!.vm.questionType)"
                
                self?.firstChoice.setTitle(self?.vm.choices[0].word.rawValue, for: .normal)
                self?.firstChoice.setTitleColor((self?.vm.choices[0].color.color)!, for: .normal)
                
                self?.secondChoice.setTitle(self?.vm.choices[1].word.rawValue, for: .normal)
                self?.secondChoice.setTitleColor((self?.vm.choices[1].color.color)!, for: .normal)
                
                self?.thirdChoice.setTitle(self?.vm.choices[2].word.rawValue, for: .normal)
                self?.thirdChoice.setTitleColor((self?.vm.choices[2].color.color)!, for: .normal)
                
                self?.fourthChoice.setTitle(self?.vm.choices[3].word.rawValue, for: .normal)
                self?.fourthChoice.setTitleColor((self?.vm.choices[3].color.color)!, for: .normal)
            }
            .store(in: &cancellableBag)
    }
}
