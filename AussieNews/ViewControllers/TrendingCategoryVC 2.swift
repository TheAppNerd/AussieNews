//
//  TrendingCategoryVCViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

//create 5 lines across top with 2 second animation left to right color fill - Complete
//create view to fill with article data - complete
//create func to make articles change every 3 seconds
//add left and right tap gestures
//create fab at bottom to go to page
//create x top right to dismiss and return to home


class TrendingCategoryVC: UIViewController {
    
    var newsArticles: [Article] = []
    var progressViewArray: [UIProgressView] = []
    let progressStack = UIStackView()
    let trendingView = TrendingView()
    let trendingButtonView = TrendingButtonView()
    var progressStatus: Int = -1
    var timer = Timer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getArticles(params: .trending)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureProgressStack()
        layoutUI()
        setupGestures()
    }
    
    
    func getArticles(params: NewsManager.networkParams) {
        NewsManager.Shared.getNews(params:params) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async {
                    self.newsArticles.append(contentsOf: newsArticles.articles)
                    self.trendingView.set(self.newsArticles[0])
                    self.animateProgressViews(startingNum: 0)
                }
                
            case.failure(let error): print(error.rawValue)
            }
        }
    }
    
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
    }
   
    private func configureProgressStack() {
        
        for _ in 0...4 {
            let progressView = UIProgressView(progressViewStyle: .bar)
            progressView.translatesAutoresizingMaskIntoConstraints = false
            progressView.backgroundColor = .systemGray3
            progressView.progressTintColor = .orange
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
    
    private func layoutUI() {
       
        view.addSubviews(progressStack, trendingView, trendingButtonView)
       
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            progressStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            progressStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            progressStack.heightAnchor.constraint(equalToConstant: padding / 2),
            
            trendingView.topAnchor.constraint(equalTo: progressStack.bottomAnchor, constant: padding),
            trendingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            trendingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            trendingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            trendingButtonView.topAnchor.constraint(equalTo: trendingView.bottomAnchor, constant: 20),
            trendingButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            trendingButtonView.widthAnchor.constraint(equalTo: trendingView.widthAnchor),
            trendingButtonView.heightAnchor.constraint(equalTo: trendingView.heightAnchor, multiplier: 0.3)
        ])
    }
    
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(gesturePressed))
        trendingView.addGestureRecognizer(tap)
        trendingView.isUserInteractionEnabled = true
    }
    
    
    private func setupButtons() {
        
        
    }
    
    
    func animate(num: Int, duration: Double) {

        UIView.animate(withDuration: duration, delay: 0) {
            let progress: Float = 1.0
            self.progressViewArray[num].setProgress(progress, animated: true)
        } completion: { _ in
            let article = self.newsArticles[num]
            self.trendingView.set(article)
        }

    }
    
    func animateProgressViews(startingNum: Int) {
        for (index, view) in progressViewArray.enumerated() {
            if index < startingNum {
                view.progress = 1.0
            } else {
              view.progress = 0.0
        }
        }
        var num = startingNum
        let duration = 3.0
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
            self.animate(num: num, duration: duration)
            num += 1
            self.progressStatus += 1
            print(self.progressStatus)
            if num == 5 {
                timer.invalidate()
            }
        }
    }
    
    
    func changeProgressViews() {
        
    }
    
    @objc func gesturePressed(_ tap: UITapGestureRecognizer) {
        print("tapped")
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
        print(progressStatus)
        
        let article = self.newsArticles[progressStatus]
        self.trendingView.set(article)
        animateProgressViews(startingNum: progressStatus)
        
    }
    
}
