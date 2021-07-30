// InformationFilmViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// InformationFilmViewController
final class InformationFilmViewController: UIViewController {
    // MARK: - Private Properties

    private var infoTableView = UITableView()
    private let identifire = "MyCell"

    // MARK: - Properties

    var infoImage = UIImageView()
    var infoLable = UILabel()
    var idFilm = Int()
    var infoCategory: Films?

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = infoCategory?.title

        createTable()
    }

    // MARK: - Private Methods

    private func createTable() {
        infoTableView.register(InformationFilmViewCellTableViewCell.self, forCellReuseIdentifier: identifire)
        infoTableView.separatorStyle = .none
        infoTableView.estimatedRowHeight = 700
        infoTableView.rowHeight = UITableView.automaticDimension
        view.addSubview(infoTableView)

        let safeArea = view.safeAreaLayoutGuide
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            infoTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            infoTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            infoTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        ])

        infoTableView.delegate = self
        infoTableView.dataSource = self
    }

    private func fetchData() {
        let jsonUrlString =
            "https://api.themoviedb.org/3/movie/\(idFilm)?api_key=d21445c991b862f2b5da36887c777ba4&language=ru-RU&page=1"
        guard let url = URL(string: jsonUrlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.infoCategory = try decoder.decode(Films.self, from: data)

                DispatchQueue.main.async {
                    self.infoTableView.reloadData()
                }
            } catch {
                print("error")
            }
        }.resume()
    }

    private func configureCell(cell: InformationFilmViewCellTableViewCell, for indexPath: IndexPath) {
        let filmOverview = infoCategory?.overview
        let filmImage = infoCategory?.posterPath

        cell.filmDeascription.text = filmOverview

        DispatchQueue.global().async {
            let const = "https://image.tmdb.org/t/p/w500"
            guard let urlImage = URL(string: "\(const)\(filmImage ?? "")") else { return }
            guard let imageData = try? Data(contentsOf: urlImage) else { return }

            DispatchQueue.main.async {
                cell.imageFilm.image = UIImage(data: imageData)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension InformationFilmViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension InformationFilmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? InformationFilmViewCellTableViewCell
        else { return UITableViewCell() }
        configureCell(cell: cell, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
}
