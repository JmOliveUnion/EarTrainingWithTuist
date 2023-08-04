//
//  AuditoryStroopVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/01.
//

import UIKit
import Combine

import  SnapKit

final class AuditoryStroopVC: BaseViewController {
    
    private let vm = AuditoryStroopViewModel()
    private let correctView = CorrectAnswerView()
    private let wrongView = WrongAnswerView()
    private let threeCountdownView = ThreeCountdownView()
    private let finishedView = AuditoryStroopDoneView()

    private var choiceButtonDescription: [ASPair] = []
    private var quetionType: String = ""
    private var qIndex: Int = 0

    // MARK: - Properties
    
    private let questionProgressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.trackTintColor = .white
        progress.progressTintColor = .l_gray800
        progress.setProgress(0, animated: false)
        progress.clipsToBounds = true
        return progress
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
        image.image = UIImage(named: "Clock")
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
        return image
    }()
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.trackTintColor = .l_gray500
        progress.progressTintColor = .l_gray500
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
    
    private let coundownSoundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SoundSpeaker")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var countdownLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Int(vm.secondsRemaining))"
        label.textColor = .l_gray600
        label.font = .Roboto_B60
        label.textAlignment = .center
        return label
    }()
    
    private lazy var countdownSoundImageView: UIView = {
      let view = UIView()

        view.addSubview(coundownSoundImage)
        coundownSoundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.addSubview(countdownLabel)
        countdownLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return view
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
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .l_gray700
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
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
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
        
        contentView.addSubview(countdownSoundImageView)
        countdownSoundImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(countdownStack.snp.bottom).offset(30)
        }
        
        contentView.addSubview(typeBlock)
        typeBlock.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(countdownLabel.snp.bottom).offset(20)
            $0.height.equalToSuperview().multipliedBy(0.12)
        }
        
        contentView.addSubview(choiceStack)
        choiceStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(typeBlock.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().offset(-100)
            $0.height.equalToSuperview().multipliedBy(0.5)
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
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(finishedView)
        finishedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        
        finishedView.stopButton.tapPublisher
            .sink {[weak self] _ in
                let vc = MainTabBarController.instance
                let nav = UINavigationController(rootViewController: vc)
                self?.changeRootViewController(to: nav)
            }
            .store(in: &cancellableBag)
        
        finishedView.retryButton.tapPublisher
            .sink {[weak self] _ in
                self?.vm.retryTask()
            }
            .store(in: &cancellableBag)
        
        // MARK: - OutPut
        vm.$qIndex
            .sink {[weak self] index in
                print(index)
                self?.qIndex = index
                self?.questionProgressBar.setProgress(Float(index + 1) / Float(10), animated: false)
                self?.questionNumber.text = "\(index + 1)/10"
            }
            .store(in: &cancellableBag)
        
        vm.$taskCountdown
            .sink { [weak self] level in
                self?.progressView.setProgress(1 - Float((level / 10)), animated: false)
                self?.countdownLabel.text = "\(10 - Int(level + 0.1))"
            }
            .store(in: &cancellableBag)
        
        vm.$questionType
            .sink {[weak self] text in
                self?.quetionType = text
            }
            .store(in: &cancellableBag)
        
        vm.$choices
            .sink { [weak self] _ in
                self?.choiceButtonDescription = self!.vm.choices
            }
            .store(in: &cancellableBag)
        
        vm.$isPlayingAudio
            .sink {[weak self] isOn in
                if isOn {
                    self?.typeLabel.text = ""
                    self?.countdownLabel.isHidden = isOn
                    self?.coundownSoundImage.isHidden = !isOn
                    self?.progressView.progressTintColor = .l_gray500
                    [self?.firstChoice, self?.secondChoice, self?.thirdChoice, self?.fourthChoice].forEach {
                        $0?.setTitle("", for: .normal)
                        $0?.isEnabled = false
                    }
                } else {
                    self?.typeLabel.text = self?.quetionType
                    self?.countdownLabel.isHidden = isOn
                    self?.coundownSoundImage.isHidden = !isOn
                    self?.progressView.progressTintColor = .l_keyBlue200
                    [self?.firstChoice, self?.secondChoice, self?.thirdChoice, self?.fourthChoice].enumerated().forEach { (index, button) in
                        button?.isEnabled = true
                        button?.setTitle(self?.choiceButtonDescription[index].word.rawValue, for: .normal)
                        button?.setTitleColor(self?.choiceButtonDescription[index].color.color, for: .normal)
                    }
                }
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
        
        vm.$isFinished
            .sink {[weak self] isOn in
                if isOn {
                    self?.navigationController?.navigationBar.isHidden = isOn
                    self?.finishedView.isHidden = !isOn
                } else {
                    self?.navigationController?.navigationBar.isHidden = isOn
                    self?.finishedView.isHidden = !isOn
                }
            }
            .store(in: &cancellableBag)
        
        vm.$totalScore
            .sink {[weak self] text in
                self?.finishedView.myScore.text = "\(text)"
            }
            .store(in: &cancellableBag)
    }
}
