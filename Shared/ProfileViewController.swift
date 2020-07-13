//
//  ViewController.swift
//  iOS
//
//  Created by DouKing on 2020/7/1.
//

import SwiftUI
import UIKit
import PhotosUI

class ProfileViewController: UIViewController, PHPickerViewControllerDelegate {
    let avatarWidth: CGFloat = 80

    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = avatarWidth / 2
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    override func viewDidLoad() {
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarWidth),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10)
        ])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [self] (image, error) in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        avatarImageView.image = image
                    }
                }
            }
        }
    }
}

struct ProfileRepresent: UIViewControllerRepresentable {
    typealias UIViewControllerType = ProfileViewController

    let name: String

    func makeUIViewController(context: Context) -> ProfileViewController {
        return ProfileViewController()
    }

    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        
    }
}
