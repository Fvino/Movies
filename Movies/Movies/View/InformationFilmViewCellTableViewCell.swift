// InformationFilmViewCellTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// InformationFilmViewCellTableViewCell
final class InformationFilmViewCellTableViewCell: UITableViewCell {
    // MARK: - Properties

    static let identifier = "InfoTableViewCell"

    // MARK: - Private Properties

    private let imageFilm = UIImageView()
    private let filmDeascription = UILabel()

    // MARK: - UITableViewCell

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        createVisualElements()
    }

    // MARK: - Methods

    func configCell(films: Films, image: UIImage) {
        imageFilm.image = image
        filmDeascription.text = films.overview
    }

    // MARK: - Private Methods

    private func createFilmImage() {
        addSubview(imageFilm)

        imageFilm.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageFilm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            imageFilm.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            imageFilm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            imageFilm.heightAnchor.constraint(equalToConstant: 350),
        ])
    }

    private func createFilmDescription() {
        filmDeascription.numberOfLines = 0
        addSubview(filmDeascription)

        filmDeascription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmDeascription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            filmDeascription.topAnchor.constraint(equalTo: imageFilm.bottomAnchor, constant: 10),
            filmDeascription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            filmDeascription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            filmDeascription.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func createVisualElements() {
        createFilmImage()
        createFilmDescription()
    }
}
