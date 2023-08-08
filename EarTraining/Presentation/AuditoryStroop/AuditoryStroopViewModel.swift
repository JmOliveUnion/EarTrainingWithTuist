//
//  AuditoryStroopViewModel.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/01.
//

import Foundation
import AVFoundation

final class AuditoryStroopViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    enum QuestionType: String, CaseIterable {
        case word = "단어"
        case color = "색깔"
    }
    
    struct Question {
        let colorWord: ASColorWord
        let type: QuestionType
    }
    
    @Published var qIndex: Int = 0
    @Published var totalScore: Int = 0
    @Published var taskCountdown: Double = 0.0
    @Published var isShowingThreeCountdown: Bool = true
    @Published var secondsRemaining: Double = 10.0
    @Published var questionType: String = ""
    @Published var isPlayingAudio: Bool = true
    @Published var isCorrect: Bool = false
    @Published var isShowingResult: Bool = false
    @Published var isFinished: Bool = false
    @Published var threeCountdownString: String = ""
    @Published var choices: [ASPair] = [
        ASPair(word: .red, color: .red),
        ASPair(word: .green, color: .green),
        ASPair(word: .blue, color: .blue),
        ASPair(word: .yellow, color: .yellow)]
    
    private var threeCountdownTimer: Timer?
    private var taskCountdownTimer: Timer?
    private var resultTimer: Timer?
    private var taskStartTime: Date?
    private var taskEndTime: Date?
    private var trialStartTime: Date?
    private var trialEndTime: Date?

//    let numOfQuestions: Int = 10
    private var threeCountdown: Int = 3
    private var extractedQuestions: [Question] = []
    private var audioPlayer: AVAudioPlayer?
    private var auditoryStroopBestScore: Int = 0
    
    // MARK: - Input from AuditoryStroopVC
    func tapButton(_ asPair: ASPair) {
        taskCountdownTimer?.invalidate()
        taskCountdownTimer = nil
        checkAnswer(userAnswer: asPair)
    }
    // 메소드 1번
    func initiateTask() {
        taskStartTime = Date()

        extractedQuestions = pickAndShuffleQuestions()
        print("extractedQuestions == \(extractedQuestions)")
        choices = allocateChoices(question: extractedQuestions[qIndex])
        startThreeCountdown()
    }
    
    // MARK: - Make Questions
    private func pickAndShuffleQuestions() -> [Question] {
        var questions: [Question] = []
        
        while questions.count < 10 {
            let colorWord = [ASColorWord.red, ASColorWord.blue, ASColorWord.green, ASColorWord.yellow].randomElement()!
            let type = QuestionType.allCases.randomElement()!
            let question = Question(colorWord: colorWord, type: type)
            questions.append(question)
        }
        return questions.shuffled()
    }
    
    // choice변수에 문제 할당을 위한 메소드
    private func allocateChoices(question: Question) -> [ASPair] {
        var filteredChoices: [ASPair] = []
        
        let data = asPairData.shuffled()
        for datum in data {
            if filteredChoices.isEmpty {
                filteredChoices.append(datum)
                
            } else {
                print("filteredChoices == \(filteredChoices)")
                if filteredChoices.count < 4, filteredChoices.contains(where: { element in
                    print("element == \(element)")
                    print("datum == \(datum)")

                    if question.type == .color {
                        return element.color == datum.color
                    } else {
                        return element.word == datum.word
                    }
                }) == false {
                    filteredChoices.append(datum)
                }
            }
        }
//        print("Filtered Choices = \(filteredChoices)")
        return filteredChoices
    }
    
    // MARK: - CountDown Model
    // 게임시작 전 삡 소리와 카운트다운 3,2,1 : 메소드 2번
    private func startThreeCountdown() {
        isShowingThreeCountdown = true
        threeCountdownString = String(describing: self.threeCountdown)
        playAudioForThreeCountdown()
        
        threeCountdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            Task { await MainActor.run {
                if self.threeCountdown > 1 {
                    self.threeCountdown -= 1
                    self.threeCountdownString = String(describing: self.threeCountdown)
                    
                } else if self.threeCountdown == 1 {
                    self.threeCountdown -= 1
                    self.threeCountdownString = "시작!"
                    
                } else {
                    self.threeCountdownTimer?.invalidate()
                    self.stopAudio()
                    self.isShowingThreeCountdown = false
                    self.setTypeAndSpeakWord()
                }
            }}
        }
    }
    
    // MARK: - Audio Play 이후 문제 시작

    private func startTaskCountdown() {
        trialStartTime = Date()

        taskCountdownTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            Task { await MainActor.run {
                if self.taskCountdown < 9.9 {
                    self.taskCountdown += 0.01
                    
                } else {
                    self.taskCountdownTimer?.invalidate()
                    let userAnswer = ASPair(word: .none, color: .none)
                    self.checkAnswer(userAnswer: userAnswer)
                }
            }}
        }
    }
    
    private func checkAnswer(userAnswer: ASPair) {
        trialEndTime = Date()
        
        if let trialStartTime = trialStartTime, let trialEndTime = trialEndTime {
            isCorrect = checkCorrectWrong(question: extractedQuestions[qIndex], userAnswer: userAnswer)
            
            let score = calculateScore(isCorrect: isCorrect, trialStartTime: trialStartTime, trialEndTime: trialEndTime)
            totalScore += score
            
//            addTrialDate(
//                trialStartTime: trialStartTime,
//                trialEndTime: trialEndTime,
//                question: extractedQuestions[qIndex],
//                userAnswer: userAnswer,
//                score: score,
//                isCorrect: isCorrect)
            
            // Show the result
            isShowingResult = true
            
            if isCorrect {
                HapticManager.instace.impact(type: .medium)
                print("맞음")
            } else {
                HapticManager.instace.impact(type: .soft)
                print("틀림")
            }
            
            resultTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                
                Task { await MainActor.run {
                    self.isShowingResult = false
                    self.isPlayingAudio = true
                    
                    self.goToNextTrialOrEndTrial()
                }}
            }
        } else {
            print("Check Error")
        }
    }
    
    private func checkCorrectWrong(question: Question, userAnswer: ASPair) -> Bool {
        if question.type == .color {
            return question.colorWord == userAnswer.color
            
        } else if question.type == .word {
            return question.colorWord == userAnswer.word
            
        } else {
            return false
        }
    }
    
    // 다음 단계 진행
    private func goToNextTrialOrEndTrial() {
        taskCountdown = 0
        
        if qIndex < extractedQuestions.count - 1 {
            qIndex += 1
            
            choices = allocateChoices(question: extractedQuestions[qIndex])
            setTypeAndSpeakWord()
            
        } else {
            stopTask()
            
            taskEndTime = Date()
//            if let taskStartTime = taskStartTime, let taskEndTime = taskEndTime {
//                saveTaskDataToCoreData(taskStartTime: taskStartTime, taskEndTime: taskEndTime)
//            }
            // TODO: 최고점수 저장 로직 수정 필요
//            if totalScore > bestScore { bestScore = totalScore }

            isFinished = true
        }
    }
    
    // MARK: - 일시정지 및 재시작
    private func stopTask() {
        stopAudio()
        
        threeCountdownTimer?.invalidate()
        taskCountdownTimer?.invalidate()
        resultTimer?.invalidate()
        
        threeCountdownTimer = nil
        taskCountdownTimer = nil
        resultTimer = nil
    }
    
    // MARK: - 점수 계산
    private func calculateScore(isCorrect: Bool, trialStartTime: Date, trialEndTime: Date) -> Int {
        if isCorrect {
            return 1000 - Int(trialEndTime.timeIntervalSince(trialStartTime) * 100)
        } else {
            return 0
        }
    }
    
    // MARK: - AudioPlayer
    
    // 소리가 끝나면 AVAudio delegate로 호출됨 다음 단계 진행 : 메소드 4번
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished")
        if flag, !isShowingThreeCountdown {
            Task { await MainActor.run { [weak self] in
                self?.isPlayingAudio = false
                self?.startTaskCountdown()
            }}
        }
    }
    
    // 3초카운트다운 소리 재생 삡삡삡 - 메소드 3번
    private func playAudioForThreeCountdown() {
        isPlayingAudio = true
        
        do {
            // Session
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            // Play Audio
            audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "countdown", withExtension: "mp3")!)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            
        } catch {
            print("playAudioForAuditoryStroop Error: \(error.localizedDescription)")
        }
    }
    
    private func playAudioForAuditoryStroop(url: URL) {
        isPlayingAudio = true
        
        do {
            // Session
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            // Play Audio
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            
        } catch {
            print("playAudioForAuditoryStroop Error: \(error.localizedDescription)")
        }
    }
    
    // 문제 소리 재생 - 메소드 3번
    private func setTypeAndSpeakWord() {
        questionType = extractedQuestions[qIndex].type.rawValue

        let mp3Url = extractedQuestions[qIndex].colorWord.enMp3Url
        playAudioForAuditoryStroop(url: mp3Url)
    }
    
    private func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
        
        isPlayingAudio = false
    }
    
    func retryTask() {
        qIndex = 0
        totalScore = 0
        taskCountdown = 0.0
        threeCountdownString = ""
        questionType = ""
        choices = [
            ASPair(word: .red, color: .red),
            ASPair(word: .green, color: .green),
            ASPair(word: .blue, color: .blue),
            ASPair(word: .yellow, color: .yellow)]
        
        threeCountdown = 3
        threeCountdownTimer?.invalidate()
        taskCountdownTimer?.invalidate()
        resultTimer?.invalidate()
        threeCountdownTimer = nil
        taskCountdownTimer = nil
        resultTimer = nil
        taskStartTime = nil
        taskEndTime = nil
        trialStartTime = nil
        trialEndTime = nil
        extractedQuestions = []
        
        isShowingThreeCountdown = true
        isPlayingAudio = true
        isCorrect = false
        isShowingResult = false
        isFinished = false
        
        initiateTask()
    }
}
