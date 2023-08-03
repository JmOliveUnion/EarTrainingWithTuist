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
    private let correctView = CorrectAnswerView()
    private let wrongView = WrongAnswerView()
    private let threeCountdownView = ThreeCountdownView()
    private var choiceButtonDescription: [ASPair] = []

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
        progress.setProgress(0, animated: false)
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
    
    private lazy var typeLabel: UILabel = {
      let label = UILabel()
        label.text = ""
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
    
    private let firstChoice: ASChoiceButton = {
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
        
        vm.initiateTask()
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
        
        contentView.addSubview(correctView)
        correctView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(wrongView)
        wrongView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(threeCountdownView)
        threeCountdownView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.bottom.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func bind() {
        
        // MARK: - Input
        firstChoice.tapPublisher
            .sink {[weak self] _ in
                self?.vm.tapButton((self?.choiceButtonDescription[0])!)
            }
            .store(in: &cancellableBag)
    
        secondChoice.tapPublisher
            .sink {[weak self] _ in
                self?.vm.tapButton((self?.choiceButtonDescription[1])!)
            }
            .store(in: &cancellableBag)
    
        thirdChoice.tapPublisher
            .sink {[weak self] _ in
                self?.vm.tapButton((self?.choiceButtonDescription[2])!)
            }
            .store(in: &cancellableBag)
    
        fourthChoice.tapPublisher
            .sink {[weak self] _ in
                self?.vm.tapButton((self?.choiceButtonDescription[3])!)
            }
            .store(in: &cancellableBag)
        
        // MARK: - OutPut
        vm.$taskCountdown
            .sink { [weak self] level in
                self?.progressView.setProgress(1 - Float((level / 10)), animated: false)
                self?.countdownLabel.text = "\(10 - Int(level + 0.1))"
            }
            .store(in: &cancellableBag)
        
        vm.$questionType
            .sink {[weak self] text in
                self?.typeLabel.text = text
            }
            .store(in: &cancellableBag)
        
        vm.$choices
            .sink { [weak self] _ in
                self?.choiceButtonDescription = self!.vm.choices

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
        
        // MARK: - SubViews
        vm.$isShowingResult
            .sink {[weak self] isOn in
                if isOn {
                    if self!.vm.isCorrect {
                        self?.correctView.isHidden = false
                    } else {
                        self?.wrongView.isHidden = false
                    }
                } else {
                    self?.correctView.isHidden = true
                    self?.wrongView.isHidden = true
                }
            }
            .store(in: &cancellableBag)
        
        vm.$isShowingThreeCountdown
            .sink { [weak self] isOn in
                if isOn {
                    self?.threeCountdownView.isHidden = false
                } else {
                    self?.threeCountdownView.isHidden = true
                }
            }
            .store(in: &cancellableBag)
        
        vm.$threeCountdownString
            .sink { [weak self] text in
                self?.threeCountdownView.update(text: text)
            }
            .store(in: &cancellableBag)
    }
}
