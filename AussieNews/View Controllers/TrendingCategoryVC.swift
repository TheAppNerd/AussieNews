//
//  TrendingCategoryVCViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

class TrendingCategoryVC: UIViewController, SafariProtocol {
    
    //MARK: - Variables & Constants
    
    
    // TODO: make articles random order. 
    
    let progressStack       = UIStackView()
    let trendingView        = TrendingView()
    let readArticleButton  = CustomButton()
    var newsArticles: [Article] = []
    var topic: String = ""
    var progressStatus: Int = 0
    var timer               = Timer()
    var progressViewArray: [UIProgressView] = []
    var topicLabel = CustomLabel()
    let topView = UIView()
    let line = UIView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getArticles(params: .topic)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureProgressStack()
        layoutUI()
        setupGestures()
        configureReadButton()
    }
    
    //create in customvc
    func getArticles(params: NewsManager.networkParams) {
        NewsManager.Shared.topic = topic
        NewsManager.Shared.getNews(params:params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async {
                    self.newsArticles.append(contentsOf: newsArticles.articles)
                    self.trendingView.set(self.newsArticles[self.progressStatus])
                    self.animateProgressViews(startingNum: self.progressStatus)
                }
                
            case.failure(let error): print(error.rawValue)
            }
        }
    }
    
    
    private func configure() {
        view.backgroundColor = .systemBackground
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .secondarySystemBackground
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .tertiarySystemBackground
        
        topicLabel.text = topic.uppercased()
        topicLabel.textAlignment = .center
        
        
    }
   
    
    private func configureProgressStack() {
        for _ in 0...4 {
            let progressView = UIProgressView(progressViewStyle: .bar)
            progressView.translatesAutoresizingMaskIntoConstraints = false
            progressView.backgroundColor   = .systemGray3
            progressView.progressTintColor = .systemBlue
            progressView.layer.cornerRadius = 5
            progressView.layer.masksToBounds = true
            progressViewArray.append(progressView)
        }
        
        progressStack.translatesAutoresizingMaskIntoConstraints = false
        for view in progressViewArray {
            progressStack.addArrangedSubview(view)
        }
        progressStack.alignment = .fill
        progressStack.spacing = 10
        progressStack.distribution = .fillEqually
        progressStack.axis = .horizontal
        
    }
    
    func configureReadButton() {
        readArticleButton.backgroundColor = .systemBlue
        readArticleButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        readArticleButton.tintColor = .label
        readArticleButton.setTitle("Read Article", for: .normal)
        readArticleButton.setTitleColor(.label, for: .normal)
        readArticleButton.addTarget(self, action: #selector(readButtonPressed), for: .touchUpInside)
    }
    
    
    @objc func readButtonPressed() {
        let article = newsArticles[progressStatus]
        showArticle(self, article: trendingView.article!)
        timer.invalidate()
    }
    
    private func layoutUI() {
        topView.addSubview(line)
       
        view.addSubviews(topView, topicLabel, progressStack, trendingView, readArticleButton)
       
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 40),
            
            line.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            line.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.widthAnchor.constraint(equalToConstant: 30),
            
            topicLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            topicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topicLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topicLabel.heightAnchor.constraint(equalToConstant: 40),
            
            progressStack.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 5),
            progressStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            progressStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            progressStack.heightAnchor.constraint(equalToConstant: 7),
            
            trendingView.topAnchor.constraint(equalTo: progressStack.bottomAnchor, constant: padding),
            trendingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trendingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingView.bottomAnchor.constraint(equalTo: readArticleButton.topAnchor, constant: -5),
            
            readArticleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            readArticleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            readArticleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            readArticleButton.heightAnchor.constraint(equalToConstant: 40)
           
        ])
    }
    
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(gesturePressed))
        trendingView.addGestureRecognizer(tap)
        trendingView.isUserInteractionEnabled = true
    }
    
    //goal change animation to start loadfing immediately on button press
    //dismiss after completion
    //have article button line up with current article
    
    
    func animate(num: Int, duration: Double) {

        UIView.animate(withDuration: duration, delay: 0) {
            let progress: Float = 1.0
            self.progressViewArray[num].setProgress(progress, animated: true)
        } completion: { _ in
            let article = self.newsArticles[num]
            self.trendingView.set(article)
        }

    }
    
    func progressReset() {
        
        for (index, view) in progressViewArray.enumerated() {
            if index < progressStatus {
                view.setProgress(1.0, animated: false)
            } else {
              view.progress = 0.0
        }
        }
    }
    
    func animateProgressViews(startingNum: Int) {
        
        var num = startingNum
        let duration = 3.0
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.animate(num: num, duration: duration)
            num += 1
            self.progressStatus += 1
            print(self.progressStatus)
            if num >= 5 {
                timer.invalidate()
            }
        }
    }
    
    @objc func gesturePressed(_ tap: UITapGestureRecognizer) {
        timer.invalidate()
        let point = tap.location(in: trendingView)
        let leftArea = CGRect(x: 0, y: 0, width: trendingView.frame.width / 2, height: trendingView.frame.height)
        if leftArea.contains(point) {
            if progressStatus >= 1 {
           progressStatus -= 1
            }
        } else {
            if progressStatus <= 3 {
            progressStatus += 1
            }
        }
        progressReset()
        let article = self.newsArticles[progressStatus]
        self.trendingView.set(article)
        animateProgressViews(startingNum: progressStatus)
    }

    
  
    
}
