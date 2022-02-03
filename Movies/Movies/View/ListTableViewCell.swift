// ListTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ListTableViewCell
final class ListTableViewCell: UITableViewCell {
    // MARK: - Properties

    static let identifier = "ListTableViewCell"

    // MARK: - Private Properties

    private let filmView = UIView()
    private let filmImage = UIImageView()
    private let filmLable = UILabel()
    private let filmDescription = UILabel()

    // MARK: - UITableViewCell

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createVisualElements()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods

    func configCell(films: Films, image: UIImage) {
        filmImage.image = image
        filmLable.text = films.title
        filmDescription.text = films.overview
    }

    // MARK: - Private Methods

    private func createFilmView() {
        filmView.layer.cornerRadius = 10
        filmView.backgroundColor = .systemGray5
        addSubview(filmView)

        filmView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            filmView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            filmView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            filmView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }

    private func createFilmImage() {
        filmView.addSubview(filmImage)

        filmImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            filmImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            filmImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            filmImage.heightAnchor.constraint(equalToConstant: 180),
            filmImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func createFilmLable() {
        filmLable.numberOfLines = 0
        filmLable.textAlignment = .center
        filmView.addSubview(filmLable)

        filmLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmLable.leadingAnchor.constraint(equalTo: filmImage.trailingAnchor, constant: 10),
            filmLable.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            filmLable.trailingAnchor.constraint(equalTo: filmView.trailingAnchor, constant: 10)
        ])
    }

    private func createFilmDescription() {
        filmDescription.numberOfLines = 0
        filmView.addSubview(filmDescription)

        filmDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmDescription.leadingAnchor.constraint(equalTo: filmLable.leadingAnchor),
            filmDescription.trailingAnchor.constraint(equalTo: filmLable.trailingAnchor, constant: -15),
            filmDescription.topAnchor.constraint(equalTo: filmLable.bottomAnchor, constant: 10),
            filmDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    private func createVisualElements() {
        createFilmView()
        createFilmImage()
        createFilmLable()
        createFilmDescription()
    }
}
