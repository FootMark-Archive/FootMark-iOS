//
//  DiaryViewController.swift
//  FootMark
//
//  Created by 윤성은 on 3/24/24.
//

import UIKit
import ElegantEmojiPicker
import DropDown

class DiaryViewController: BaseViewController {
    var diaryView = DiaryView()
    let dropDown = DropDown()
    
    var postReviewGoal1Content: String = ""
    var postReviewGoal2Content: String = ""
    var postReviewThankfulContent: String = ""
    var postReviewBestContent: String = ""
    
    var categoryTodos: [String: String] = [:]
    
    var categoryTag: Bool = true
    var dropdowncount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(resource: .black1)
        
        navigationController?.navigationBar.isHidden = true
        
        setUpDelegates()
        setUpClosures()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: Date())
        diaryView.dateLabel.text = currentDate
        
        updateTodo()
        
        // Send data to server based on the number of categories
        let categoriesCount = dropDown.dataSource.count
        
        dropdowncount = categoriesCount
    }
    
    override func setLayout() {
        view.addSubviews(diaryView)
        
        diaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiLabelTapped))
        diaryView.emojiLabel.addGestureRecognizer(tapGesture)
        
        diaryView.categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        diaryView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func addEmoji() {
        NetworkService.shared.emojiService.postEmoji(request: PostEmojiRequestModel(createAt: diaryView.dateLabel.text ?? "", todayEmoji: diaryView.emojiLabel.text ?? "")) { result in
            switch result {
            case .success(let EmojiResponseDTO):
                print(EmojiResponseDTO)
                DispatchQueue.main.async {
                    self.diaryView.dateLabel.text = EmojiResponseDTO.data.createAt
                    self.diaryView.emojiLabel.text = EmojiResponseDTO.data.todayEmoji
                }
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
            case .requestErr:
                print("요청 오류입니다")
            case .decodedErr:
                print("디코딩 오류입니다")
            case .pathErr:
                print("경로 오류입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    func editEmoji(createAt: String) {
        NetworkService.shared.emojiService.putEmoji(createAt: createAt, request: PutEmojiRequestModel(todayEmoji: diaryView.emojiLabel.text ?? "")) { result in
            switch result {
            case .success(let EmojiResponseDTO):
                print(EmojiResponseDTO)
                DispatchQueue.main.async {
                    self.diaryView.emojiLabel.text = EmojiResponseDTO.data.todayEmoji
                }
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
            case .requestErr:
                print("요청 오류입니다")
            case .decodedErr:
                print("디코딩 오류입니다")
            case .pathErr:
                print("경로 오류입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    func addReview() {
        NetworkService.shared.reviewService.postReview(request: PostReviewRequestModel(createAt: diaryView.dateLabel.text ?? "2024-06-18", categoryId: 42, content: "")) { result in
            switch result {
            case .success(let ReviewResponseDTO):
                print(ReviewResponseDTO)
                DispatchQueue.main.async {
                    self.diaryView.todoTextView.text = ReviewResponseDTO.data.content
                    self.diaryView.thankfulLabel.text = ReviewResponseDTO.data.content
                    self.diaryView.bestTextView.text = ReviewResponseDTO.data.content
                }
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
            case .requestErr:
                print("요청 오류입니다")
            case .decodedErr:
                print("디코딩 오류입니다")
            case .pathErr:
                print("경로 오류입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    func editReview(content: String) {
        NetworkService.shared.reviewService.putReview(content: content, request: PutReviewRequestModel(content: "")) { result in
            switch result {
            case .success(let ReviewResponseDTO):
                print(ReviewResponseDTO)
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
            case .requestErr:
                print("요청 오류입니다")
            case .decodedErr:
                print("디코딩 오류입니다")
            case .pathErr:
                print("경로 오류입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    func sendReview(requestModel: PostReviewRequestModel) {
        NetworkService.shared.reviewService.postReview(request: requestModel) { result in
            switch result {
            case .success(let response):
                print("PostReview 성공: \(response)")
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
            case .requestErr:
                print("요청 오류입니다")
            case .decodedErr:
                print("디코딩 오류입니다")
            case .pathErr:
                print("경로 오류입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    func updateTodo() {
        guard let createAt = diaryView.dateLabel.text else { return }
        print("getTodo 호출됨, createAt: \(createAt)")
        NetworkService.shared.categoryService.getTodo(createAt: createAt) { result in
            switch result {
            case .success(let TodosResponseDTO):
                print("🥵🥵🥵🥵🥵🥵")
                print(TodosResponseDTO)
                DispatchQueue.main.async {
                    // 각 TodoDateResDto의 content 배열을 꺼내와서 하나의 문자열로 조인
                    let allContents = TodosResponseDTO.data.todoDateResDtos.flatMap { $0.content }.joined(separator: ", ")
                    self.diaryView.todoLabel.text = allContents
                    
                    // 각 카테고리 이름을 데이터 소스로 사용
                    self.dropDown.dataSource = TodosResponseDTO.data.todoDateResDtos.map { $0.categoryName }
                    
                    // 카테고리 이름과 그에 해당하는 콘텐츠를 딕셔너리로 만듦
                    self.categoryTodos = Dictionary(uniqueKeysWithValues: TodosResponseDTO.data.todoDateResDtos.map { ($0.categoryName, $0.content.joined(separator: ", ")) })
                    
                    self.setupDropDown()
                    print("😗😗😗😗😗")
                    print(self.categoryTag)
                }
            case .tokenExpired(_):
                print("만료된 accessToken 입니다. \n재발급을 시도합니다.")
            case .requestErr:
                print("요청 오류입니다")
            case .decodedErr:
                print("디코딩 오류입니다")
            case .pathErr:
                print("경로 오류입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    
    func setUpDelegates() {
        diaryView.todoTextView.delegate = self
        diaryView.thankfulTextView.delegate = self
        diaryView.bestTextView.delegate = self
    }
    
    func setUpClosures() {
        diaryView.emojiPickerHandler = { [weak self] in
            self?.PresentEmojiPicker()
        }
        
        let _: (UIAction) -> Void = { [weak self] action in
            self?.diaryView.categoryLabel.text = action.title
        }
    }
    
    @objc func categoryButtonTapped() {
        dropDown.show()
    }
    
    func setupDropDown() {
        dropDown.anchorView = diaryView.categoryButton
        dropDown.bottomOffset = CGPoint(x: 0, y: diaryView.categoryButton.bounds.height + 15)
        dropDown.dataSource = Array(categoryTodos.keys)
        dropDown.backgroundColor = .white
        
        dropDown.textFont = UIFont.pretendard(size: 18, weight: .regular)
        
        if let firstCategory = dropDown.dataSource.first {
            diaryView.categoryButton.setTitle(firstCategory, for: .normal)
            diaryView.categoryLabel.text = firstCategory
            diaryView.todoLabel.text = categoryTodos[firstCategory] ?? ""
            diaryView.todoTextView.text = ""
        }
        
        var beforecategorylabel = self.diaryView.categoryLabel.text
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.diaryView.categoryButton.setTitle(item, for: .normal)
            self?.diaryView.categoryLabel.text = item
            self?.diaryView.todoLabel.text = self?.categoryTodos[item] ?? ""
            self?.diaryView.todoTextView.text = ""
            
            print("현재 iten: \(item)")
            print("현재 self?.diaryView.categoryLabel.text: \(self?.diaryView.categoryLabel.text)")
            if item != beforecategorylabel {
                print("~~~")
                self?.categoryTag.toggle()
                beforecategorylabel = item
            }
        }
    }
    
    @objc func saveButtonTapped() {
        print("save")
        //        addEmoji()
        editEmoji(createAt: "2024-06-18")
        
        let goal1RequestModel = PostReviewRequestModel(createAt: "2024-06-18", categoryId: 1, content: postReviewGoal1Content)
        let goal2RequestModel = PostReviewRequestModel(createAt: "2024-06-18", categoryId: 2, content: postReviewGoal2Content)
        let thankfulRequestModel = PostReviewRequestModel(createAt: "2024-06-18", categoryId: 3, content: postReviewThankfulContent)
        let bestRequestModel = PostReviewRequestModel(createAt: "2024-06-18", categoryId: 4, content: postReviewBestContent)
        
        if dropdowncount == 1 {
            // If there's only one category, send only these three contents
            sendReview(requestModel: goal1RequestModel)
            sendReview(requestModel: thankfulRequestModel)
            sendReview(requestModel: bestRequestModel)
        } else {
            // If there are more than one category, send all four contents
            sendReview(requestModel: goal1RequestModel)
            sendReview(requestModel: goal2RequestModel)
            sendReview(requestModel: thankfulRequestModel)
            sendReview(requestModel: bestRequestModel)
        }
    }
}

extension DiaryViewController: ElegantEmojiPickerDelegate {
    func PresentEmojiPicker() {
        let picker = ElegantEmojiPicker(delegate: self)
        self.present(picker, animated: true)
    }
    
    func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
        guard let emoji = emoji else { return }
        diaryView.emojiLabel.text = emoji.emoji
    }
    
    @objc func emojiLabelTapped() {
        diaryView.emojiPickerHandler?()
    }
}

extension DiaryViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("텍스트 필드 편집 시작")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("🤪")
        
        if textView == diaryView.todoTextView {
            if categoryTag == true {
                postReviewGoal1Content = diaryView.todoTextView.text
                print("goal1content에 저장된 텍스트: \(self.postReviewGoal1Content)")
            } else if categoryTag == false {
                postReviewGoal2Content = diaryView.todoTextView.text
                print("goal2content에 저장된 텍스트: \(self.postReviewGoal2Content)")
            }
        }
        
        if textView == diaryView.thankfulTextView {
            postReviewThankfulContent = diaryView.thankfulTextView.text
            print("postReviewThankfulContent에 저장된 텍스트: \(self.postReviewThankfulContent)")
        }
        
        if textView == diaryView.bestTextView {
            postReviewBestContent = diaryView.bestTextView.text
        }
    }
}
