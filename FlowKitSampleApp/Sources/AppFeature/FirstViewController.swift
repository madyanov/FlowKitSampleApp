import UIKit

final class FirstViewController: UIViewController {
    var tapRussiaButtonHandler: (() -> Void)?
    var tapGermanyButtonHandler: (() -> Void)?
    var tapFranceButtonHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        let russiaButton = UIButton(type: .system)
        russiaButton.setTitle("Russia", for: .normal)
        russiaButton.addTarget(self, action: #selector(didTapRussiaButton), for: .touchUpInside)

        let germanyButton = UIButton(type: .system)
        germanyButton.setTitle("Germany", for: .normal)
        germanyButton.addTarget(self, action: #selector(didTapGermanyButton), for: .touchUpInside)

        let franceButton = UIButton(type: .system)
        franceButton.setTitle("France", for: .normal)
        franceButton.addTarget(self, action: #selector(didTapFranceButton), for: .touchUpInside)

        view.addSubview(stackView)
        stackView.addArrangedSubview(russiaButton)
        stackView.addArrangedSubview(germanyButton)
        stackView.addArrangedSubview(franceButton)

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

private extension FirstViewController {
    @objc
    private func didTapRussiaButton() {
        tapRussiaButtonHandler?()
    }

    @objc
    private func didTapGermanyButton() {
        tapGermanyButtonHandler?()
    }

    @objc
    private func didTapFranceButton() {
        tapFranceButtonHandler?()
    }
}
