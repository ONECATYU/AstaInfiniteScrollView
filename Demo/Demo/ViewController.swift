//
//  ViewController.swift
//  Demo
//
//  Created by 余汪送 on 2019/8/9.
//  Copyright © 2019 余汪送. All rights reserved.
//

import UIKit
import Kingfisher

func randomColor() -> UIColor {
    func randomNum(from: Int = 0, to: Int = 100) -> CGFloat {
        return CGFloat(Int(arc4random()) % (to - from + 1) + from) / 100
    }
    return UIColor(red: randomNum(), green: randomNum(), blue: randomNum(), alpha: 1.0)
}

class DemoModel {
    var title: String
    var color: UIColor = randomColor()
    var imageUrl: String
    
    init(title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
    }
}

extension DemoModel: CustomStringConvertible {
    var description: String {
        return "title: \(title), imageUrl: \(imageUrl)"
    }
}

class AstaImageCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}

class ViewController: UIViewController {
    
    lazy var banner: AstaSimpleInfiniteView = {
        let banner = AstaSimpleInfiniteView(frame: .zero, cellType: .class(AstaImageCell.self))
        banner.itemSpacing = 20
        banner.scrollDirection = .vertical
        banner.scrollDirection = .horizontal
        banner.pageControl.style = .line
        banner.scrollPosition = .center
        banner.itemSize = CGSize(width: self.view.frame.size.width - 40, height: 0)
        banner.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 160)
        banner.renderItem({ (index, model, cell) in
            let imageCell = cell as! AstaImageCell
            let demoModel = model as! DemoModel
            imageCell.imageView.kf.setImage(with: URL(string: demoModel.imageUrl))
        })
        banner.didTapItem({ (index, model) in
            print("didTap index: ", index, "model: ", model)
        })
        return banner
    }()
    
    let models = [
        DemoModel(title: "11111111111", imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566290625282&di=456243042e10c72fcb7456230dd97173&imgtype=0&src=http%3A%2F%2Fpic.k73.com%2Fup%2Fsoft%2F2016%2F0102%2F092635_44907394.jpg"),
        DemoModel(title: "22222222222", imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566290625281&di=9049b298ba19b92ed268fa00f2a50fe6&imgtype=0&src=http%3A%2F%2Fimage.finance.china.cn%2Fupload%2Fimages%2F2014%2F0410%2F085000%2F0_2323627_580fd395d60d023a4cf8b45c31cd1218.jpg"),
        DemoModel(title: "33333333333", imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566290625277&di=efb7ef4e1665eeffca7605de0ffa7fff&imgtype=0&src=http%3A%2F%2Fp1.pstatp.com%2Flarge%2Fpgc-image%2F948b049950354e949b115205ceda925c"),
        DemoModel(title: "44444444444", imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566290625272&di=15bee3b3c4c3802d10809faa2e031e65&imgtype=0&src=http%3A%2F%2Fs16.sinaimg.cn%2Fmw690%2F006wmg2Hzy76gSxP8Hd4f%26690"),
        DemoModel(title: "55555555555", imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566290625272&di=3fe73dc1f1ee6bc8050502beb42e6844&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201111%2F24%2F20111124171617_iNukV.jpg"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(banner)
        banner.dataModels = models
    }

}

