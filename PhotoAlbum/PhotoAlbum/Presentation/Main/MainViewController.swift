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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        input.send(.viewWillAppear)
    }
}

private extension MainViewController {
    func setupBinding() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output.sink { [weak self] event in
            switch event {
            case .getImageList(let array):
                print(array)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.store(in: &cancellables)
    }
}
