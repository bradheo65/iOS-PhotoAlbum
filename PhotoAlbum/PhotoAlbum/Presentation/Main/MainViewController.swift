//
//  MainViewController.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    
    private let input: PassthroughSubject<MainViewModel.Input, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var uiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        input.send(.viewWillAppear)
    }
}

private extension MainViewController {
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(uiImageView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            uiImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            uiImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            uiImageView.widthAnchor.constraint(equalToConstant: 150),
            uiImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setupBinding() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output.sink { [weak self] event in
            switch event {
            case .getImageList(let array):
                self?.loadImage(url: array.randomElement()?.urls.regular)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.store(in: &cancellables)
    }
    
    func loadImage(url: String?) {
        guard
            let url = url,
            let url = URL(string: url)
        else { return }
        uiImageView.load(url: url)
    }
}
