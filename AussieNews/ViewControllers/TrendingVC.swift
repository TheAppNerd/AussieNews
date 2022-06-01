//
//  TrendingCategoryVCViewController.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

class TrendingVC: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties

    let pageControl             = PageControl()
    let scrollView              = ScrollView()
    var topicLabel              = CustomLabel(textColor: .label, alignment: .center, font: UIFont.boldSystemFont(ofSize: 30))
    var newsArticles: [Article] = []
    var topic: String           = ""
    var array: [CardView]       = []
    let newsManager = NewsManager()

    // MARK: - Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles(params: .topic)
        configure()
        configurePageControl()
        configureScrollView()
        layoutUI()
        configureTap()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureScrollView()
    }

    // MARK: - Methods

    private func configure() {
        view.backgroundColor     = .systemBackground
        topicLabel.text          = topic.uppercased()
        topicLabel.sizeToFit()
    }

    private func configurePageControl() {
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
    }

    private func configureTap() {
        let tap      = UITapGestureRecognizer(target: self, action: #selector(articleTapped))
        tap.delegate = self
        scrollView.addGestureRecognizer(tap)
    }

    private func configureScrollView() {
        scrollView.delegate        = self
        let numberOfPages          = pageControl.numberOfPages

        scrollView.contentSize     = CGSize(width: scrollView.frame.size.width * CGFloat(numberOfPages),
                                            height: scrollView.frame.size.height)

        for num in 0...numberOfPages - 1 {
            let page = CardView(frame: CGRect(x: CGFloat(num) * view.frame.size.width,
                                              y: 0, width: view.frame.size.width,
                                              height: scrollView.frame.size.height))
            array.append(page)
            scrollView.addSubview(page)
        }
    }

    /// Parses news to card style view.
    private func getArticles(params: NewsManager.NetworkParams) {
        newsManager.topic = topic
         newsManager.getNews(params:params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async { [self] in
                    self.newsArticles.append(contentsOf: newsArticles.articles)
                    self.newsArticles.shuffle()
                    self.setCardViews()
                }
            case.failure(let error): print(error.rawValue)
            }
        }
    }

    /// Applies to parsed news data to the cardViews
    private func setCardViews() {
        for (index, cardViews) in array.enumerated() {
            cardViews.set(article: newsArticles[index])
            cardViews.card.backgroundColor = .secondarySystemBackground
        }
    }

    private func layoutUI() {
        view.addSubviews(pageControl, topicLabel, scrollView)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),

            topicLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            topicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topicLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topicLabel.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10),

            scrollView.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - @Objc Methods

    @objc func pageControlChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }

    @objc func articleTapped(sender: UITapGestureRecognizer) {
        showArticle(self, article: newsArticles[pageControl.currentPage])
    }

}

// MARK: - ScrollView - UIScrollViewDelegate

extension TrendingVC: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }

}
