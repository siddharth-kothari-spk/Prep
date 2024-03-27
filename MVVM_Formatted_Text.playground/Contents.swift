import UIKit
import Foundation

// For Playground support
import PlaygroundSupport
PlaygroundPage.current.liveView = viewController

struct TextStyle {
    var isBold: Bool
    var isItalic: Bool
    var isCapitalized: Bool
}

struct TextPart {
    let text: String
    let styles: [String]
    
    func applyStyles() -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        var textStyle = TextStyle(isBold: false, isItalic: false, isCapitalized: false)
        
        for style in styles {
            switch style {
            case "bold":
                textStyle.isBold = true
            case "italic":
                textStyle.isItalic = true
            case "capitalized":
                textStyle.isCapitalized = true
            default:
                break
            }
        }
        
        if textStyle.isBold {
            attributes[.font] = UIFont.boldSystemFont(ofSize: 17)
        }
        if textStyle.isItalic {
            attributes[.font] = UIFont.italicSystemFont(ofSize: 17)
        }
        if textStyle.isCapitalized {
            attributes[.font] = UIFont.systemFont(ofSize: 17)
        }
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}

class ViewModel {
    var textParts: [TextPart] = []
    
    init(jsonString: String) {
        if let data = jsonString.data(using: .utf8) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for item in jsonArray {
                        if let text = item["text"] as? String, let styles = item["styles"] as? [String] {
                            let textPart = TextPart(text: text, styles: styles)
                            textParts.append(textPart)
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
    }
}

class ViewController: UIViewController {
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var viewModel: ViewModel! {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    private func updateUI() {
        var attributedString = NSMutableAttributedString()
        print(attributedString)
        for textPart in viewModel.textParts {
            let partAttributedString = textPart.applyStyles()
            attributedString.append(partAttributedString)
        }
        
        label.attributedText = attributedString
    }
}

// Usage
let jsonString = """
[
    {
        "text": "h",
        "styles": ["bold", "capitalized" ]
    },
    {
        "text": "ello ",
        "styles": []
    },
    {
        "text": "w",
        "styles": ["bold", "italic"]
    },
    {
        "text": "orld",
        "styles": ["italic"]
    },
    {
        "text": "!",
        "styles": ["bold"]
    }
]
"""

let viewModel = ViewModel(jsonString: jsonString)
let viewController = ViewController()
viewController.viewModel = viewModel
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

