//
//  TrendingCategoryVCViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

class TrendingCategoryVC: UIViewController, SafariProtocol {
    
    
    //MARK: - Properties
    
    let pageControl = UIPageControl()
    let scrollView = UIScrollView()
    var topicLabel              = CustomLabel()
    var newsArticles: [Article] = []
    var topic: String           = ""
    var array: [CardView] = []
    
    
    
    //MARK: - Class Funcs
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NewsManager.Shared.topic = topic
        getArticles(params: .topic)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configurePageControl()
        configureScrollView()
        layoutUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureScrollView()
        addScrollViewPages()
    }
    
    //MARK: - Functions
    
    private func configure() {
        view.backgroundColor = .systemBackground
        topicLabel.text = topic.uppercased()
        topicLabel.textAlignment = .center
    }
    
    private func configurePageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.layer.cornerRadius = 15
        pageControl.numberOfPages = 6
        pageControl.pageIndicatorTintColor = .secondaryLabel
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.backgroundColor = color.aussieGreen
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        let numberOfPages = 6
        scrollView.contentSize     = CGSize(width: scrollView.frame.size.width * CGFloat(numberOfPages), height: scrollView.frame.size.height)
    }
    
    func addScrollViewPages() {
        for num in 0...5 {
            let page = CardView(frame: CGRect(x: CGFloat(num) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            array.append(page)
            scrollView.addSubview(page)
        }

    }
    
    ///Parses news to instagram style view.
    func getArticles(params: NewsManager.networkParams) {
        NewsManager.Shared.topic = topic
        NewsManager.Shared.getNews(params:params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async { [self] in
                    self.newsArticles.append(contentsOf: newsArticles.articles)
                    for (index, views) in self.array.enumerated() {
                    views.set(article: newsArticles.articles[index])
                        views.card.backgroundColor = .secondarySystemBackground
                    }
                    //self.addScrollViewPages()
                }
            case.failure(let error): print(error.rawValue)
            }
        }
    }
    
    
    private func layoutUI() {
        view.addSubviews(pageControl, scrollView)
        
        NSLayoutConstraint.activate([
            
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            scrollView.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            
            
            
        ])
    }
    
    
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
}

//MARK: - ScrollView - UIScrollViewDelegate

extension TrendingCategoryVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
    
}
