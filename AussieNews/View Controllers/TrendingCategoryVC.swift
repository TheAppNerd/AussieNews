//
//  TrendingCategoryVCViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

class TrendingCategoryVC: UIViewController, SafariProtocol {
    
    
    //MARK: - Properties
    
    let progressStack           = TrendingStackView()
    let trendingView            = TrendingView()
    let readArticleButton       = UIButton()
    let topView                 = UIView()
    let line                    = UIView()
    
    var topicLabel              = CustomLabel()
    var newsArticles: [Article] = []
    var topic: String           = ""
    var progressStatus: Int     = 0
    var timer                   = Timer()
    var progressViewArray: [UIProgressView] = []
    
    
    
    //MARK: - View Funcs
    
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
    
    
    //MARK: - Functions
    
    ///Parses news to instagram style view.
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
    
    
    ///Appends progressViews to stacj & to array for easy management.
    private func configureProgressStack() {
        for _ in 0...4 {
            let progressView = TrendingProgressView()
            progressViewArray.append(progressView)
            progressStack.addArrangedSubview(progressView)
        }
    }
    
    
    func configureReadButton() {
        readArticleButton.setButtonPurpose(.readArticle)
        readArticleButton.addTarget(self, action: #selector(readButtonPressed), for: .touchUpInside)
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
    
    ///Adds back and forward tap gestures to trendingView to allow user to go to previous or next article.
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(gesturePressed))
        trendingView.addGestureRecognizer(tap)
        trendingView.isUserInteractionEnabled = true
    }
    
    
    ///Animates progressView & sets new news article to view.
    func animate(num: Int, duration: Double) {
        UIView.animate(withDuration: duration, delay: 0) {
            let progress: Float = 1.0
            self.progressViewArray[num].setProgress(progress, animated: true)
        } completion: { _ in
            let article = self.newsArticles[num]
            self.trendingView.set(article)
        }
    }
    
    
    ///Every time the user manually changes which news article is present this func updates the progress view array to properly show where in the array the user is up to.
    func progressReset() {
        for (index, view) in progressViewArray.enumerated() {
            if index < progressStatus {
                view.setProgress(1.0, animated: false)
            } else {
                view.progress = 0.0
            }
        }
    }
    
    
    ///Works in unision with gesture press & animating of progress View array to load animation for wherever in the array the user wants.
    func animateProgressViews(startingNum: Int) {
        var num = startingNum
        let duration = 3.0
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.animate(num: num, duration: duration)
            num += 1
            self.progressStatus += 1
            if num >= 5 {
                timer.invalidate()
            }
        }
    }
    
    //MARK: - @objc funcs
    
    ///Allows user to tape left or right of the article to progress through the progress view array and view different news articles.
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
    
    
    ///Loads SFSafari browser and pauses timer while in there.
    @objc func readButtonPressed() {
        if let article = trendingView.article {
            showArticle(self, article: article)
            timer.invalidate()
        }
    }
    
}
