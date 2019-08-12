//
//  ViewController.swift
//  Demo
//
//  Created by 余汪送 on 2019/8/9.
//  Copyright © 2019 余汪送. All rights reserved.
//

import UIKit

func randomColor() -> UIColor {
    func randomNum(from: Int = 0, to: Int = 100) -> CGFloat {
        return CGFloat(Int(arc4random()) % (to - from + 1) + from) / 100
    }
    return UIColor(red: randomNum(), green: randomNum(), blue: randomNum(), alpha: 1.0)
}

class DemoModel {
    var title: String
    var color: UIColor = randomColor()
    
    init(title: String) {
        self.title = title
    }
}

class DemoCell: UICollectionViewCell {
    
    var imageView: UIImageView = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 2
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        var labelSize = titleLabel.sizeThatFits(contentView.bounds.size)
        labelSize.height += 10
        titleLabel.frame = CGRect(
            x: 0,
            y: contentView.bounds.size.height - labelSize.height,
            width: contentView.bounds.size.width,
            height: labelSize.height
        )
    }
}

class ViewController: UIViewController, AstaInfiniteScrollViewDelegate {
    
    lazy var infiniteScrollView: AstaInfiniteScrollView = {
        let view = AstaInfiniteScrollView()
        view.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 158)
        view.delegate = self
        view.itemSpacing = 20
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("scroll to", for: .normal)
        button.addTarget(self, action: #selector(scrollTo), for: .touchUpInside)
        button.setTitleColor(.blue, for: .normal)
        let size = self.view.frame.size
        button.center = CGPoint(x: size.width / 2, y: 100 / 2 + size.height - 100)
        button.bounds = CGRect(x: 0, y: 0, width: 120, height: 30)
        return button
    }()
    
    let models = [
        DemoModel(title: "11111111111"),
        DemoModel(title: "22222222222"),
        DemoModel(title: "33333333333"),
        DemoModel(title: "44444444444"),
        DemoModel(title: "55555555555"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(infiniteScrollView)
        view.addSubview(button)
    }

    @objc func scrollTo() {
        let currentIndex = infiniteScrollView.currentIndex
        if currentIndex > models.count / 2 {
            infiniteScrollView.scrollToIndex(currentIndex - 2)
        } else {
            infiniteScrollView.scrollToIndex(currentIndex + 2)
        }
    }

    func numberOfItems(in infiniteScrollView: AstaInfiniteScrollView) -> Int {
        return models.count
    }
    
    func infiniteScrollView(_ infiniteScrollView: AstaInfiniteScrollView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = infiniteScrollView.index(for: indexPath)
        let model = models[index]
        let cell = infiniteScrollView.dequeueReusableCell(withType: .class(DemoCell.self), for: indexPath)
        if let demoCell = cell as? DemoCell {
            demoCell.titleLabel.text = model.title
            demoCell.contentView.backgroundColor = model.color
        }
        return cell
    }
    
    func infiniteScrollView(_ infiniteScrollView: AstaInfiniteScrollView, didSelectedItemAt indexPath: IndexPath) {
        infiniteScrollView.reloadData()
    }
}

