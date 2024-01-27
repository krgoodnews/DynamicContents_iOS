//
//  ContentListViewController.swift
//  JsonToUIKit
//
//  Created by Tim Guk on 1/15/24.
//

import UIKit

struct Screen: Decodable {
    var navigation: Navigation?
    var body: UIElement?
    var bottom: [UIElement]?

    enum CodingKeys: String, CodingKey {
        case navigation
        case body
        case bottom
    }
}

struct Navigation: Decodable {
    var title: String?

    enum CodingKeys: String, CodingKey {
        case title
    }
}
struct UIElement: Decodable, Hashable {
    var type: String
    var title: String?
    var imageURLString: String?
    var font: String?
    var children: [UIElement]?

    enum CodingKeys: String, CodingKey {
        case type
        case title
        case font
        case imageURLString = "image_url"

        case children
    }
}

class ContentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var screenData: Screen?
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    private func fetchData() {
        guard let url = URL(string: "http://localhost:8080/api/ui/elements") else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                // Handle error
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else { return }

            do {
                let screenData = try JSONDecoder().decode(Screen.self, from: data)
                DispatchQueue.main.async {
                    self.screenData = screenData
                    self.tableView.reloadData()
                }
            } catch {
                // Handle decoding error
                print("Error decoding data: \(error)")
            }
        }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenData?.body?.children?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let element = screenData?.body?.children?[indexPath.row] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        switch element.type {
        case "TEXT":
            cell.textLabel?.text = element.title
            // 여기서 폰트 설정 등 추가적인 구성을 할 수 있습니다.
        case "IMAGE":
            if let urlString = element.imageURLString, let url = URL(string: urlString) {
                // 이미지를 다운로드하고 표시하는 로직을 추가합니다.
                // 예: URLSession.shared.dataTask로 이미지 다운로드
            }
        case "BUTTON_CTA":
            break
            // 버튼 형태의 셀을 구성합니다.k
            // 예: UIButton을 cell의 contentView에 추가
        default:
            break
        }

        return cell
    }
}

