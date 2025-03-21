//
//  MainViewController.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import UIKit

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        Task {
            do {
                try await viewModel.fetchImageList(page: "1", perPage: "2")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
