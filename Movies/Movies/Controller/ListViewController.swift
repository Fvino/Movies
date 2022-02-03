// ListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// LIstViewController
final class ListViewController: UIViewController {
    // MARK: - Private Properties

    private var filmTableView = UITableView()
    private var genresSegmentControl = UISegmentedControl()
    private let identifire = "MyCell"
    private var genresArray = ["Popular", "Top Rated", "Up Coming"]
    private var jsonUrlString =
        "https://api.themoviedb.org/3/movie/popular?api_key=d21445c991b862f2b5da36887c777ba4&language=ru-RU&page=1"
    private var category: Category?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Popular"

        createSegmentControl()
        createTable()
        fetchData()
    }

    // MARK: - Private Methods

    private func createTable() {
        filmTableView.register(ListTableViewCell.self, forCellReuseIdentifier: identifire)
        filmTableView.separatorStyle = .none
        filmTableView.estimatedRowHeight = 200
        filmTableView.rowHeight = UITableView.automaticDimension
        view.addSubview(filmTableView)

        let safeArea = view.safeAreaLayoutGuide
        filmTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            filmTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            filmTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            filmTableView.bottomAnchor.constraint(equalTo: genresSegmentControl.topAnchor, constant: -5)
        ])

        filmTableView.delegate = self
        filmTableView.dataSource = self
    }

    private func createSegmentControl() {
        genresSegmentControl = UISegmentedControl(items: genresArray)
        genresSegmentControl.isMomentary = true
        genresSegmentControl.backgroundColor = .systemGray2
        genresSegmentControl.addTarget(self, action: #selector(selectGendersSegmentControl), for: .valueChanged)
        view.addSubview(genresSegmentControl)

        let safeArea = view.safeAreaLayoutGuide
        genresSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresSegmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            genresSegmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            genresSegmentControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -5),
            genresSegmentControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func selectGendersSegmentControl() {
        switch genresSegmentControl.selectedSegmentIndex {
        case 0:
            jsonUrlString =
                "https://api.themoviedb.org/3/movie/popular?api_key=d21445c991b862f2b5da36887c777ba4&language=ru-RU&page=1"
            navigationItem.title = "Popular"
        case 1:
            jsonUrlString =
                "https://api.themoviedb.org/3/movie/top_rated?api_key=d21445c991b862f2b5da36887c777ba4&language=ru-Ru&page=1"
            navigationItem.title = "Top Rated"
        case 2:
            jsonUrlString =
                "https://api.themoviedb.org/3/movie/upcoming?api_key=d21445c991b862f2b5da36887c777ba4&language=ru-Ru&page=1"
            navigationItem.title = "Up Coming"
        default:
            break
        }
        fetchData()
    }

    private func fetchData() {
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.category = try decoder.decode(Category.self, from: data)

                weak var weakSelf = self
                DispatchQueue.main.async {
                    guard weakSelf == self else { return }
                    weakSelf?.filmTableView.reloadData()
                }
            } catch {
                print("error")
            }
        }.resume()
    }

    func configureCell(cell: ListTableViewCell, for indexPath: IndexPath) {
        guard let result = category?.results[indexPath.row] else { return }
        let filmImage = result.posterPath

        DispatchQueue.global().async {
            let const = "https://image.tmdb.org/t/p/w500"
            guard let urlImage = URL(string: "\(const)\(filmImage ?? "")") else { return }
            guard let imageData = try? Data(contentsOf: urlImage) else { return }

            DispatchQueue.main.async {
                guard let image = UIImage(data: imageData) else { return }
                cell.configCell(films: result, image: image)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? ListTableViewCell
        else { return UITableViewCell() }
        configureCell(cell: cell, for: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countRow = category?.results.count else { return Int() }
        return countRow
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = category?.results[indexPath.row] else { return }

        let informationFilmVC = InformationFilmViewController()

        informationFilmVC.idFilm = category.id
        informationFilmVC.infoCategory = category
        navigationController?.pushViewController(informationFilmVC, animated: true)
    }
}
