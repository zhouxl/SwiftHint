//
//  SwingHint.swift
//  SwingHint
//
//  Created by 小六 on 2018/11/28.
//  Copyright © 2018 小六. All rights reserved.
//

import UIKit

final public class SwingHint: UIView {
    // Min padding of view to left or to right,width of view is less than Width `ScreenWidth - 2 * horizontalPadding`
    var horizontalPadding: CGFloat = 20 {
        didSet {
            update()
        }
    }

    var topCenter: CGPoint = .zero {
        didSet {
            update()
        }
    }

    var textInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) {
        didSet {
            update()
        }
    }

    var fillColor: UIColor = UIColor.init(red: 255/255.0, green: 83/255.0, blue: 114/255.0, alpha: 1) {
        didSet {
            bgLayer.fillColor = fillColor.cgColor
            updateBGLayer()
        }
    }
    // auto create by text hight if set 0
    var cornerRadius: CGFloat = 0 {
        didSet {
            updateBGLayer()
        }
    }
    var textLine: Int = 1 {
        didSet {
            if textLine > 2 {
                textLine = 2
            }
            contentLabel.numberOfLines = textLine
        }
    }
    private let arrowHeight: CGFloat = 4
    private(set) var contentLabel: UILabel
    private var bgLayer: CAShapeLayer

    private override init(frame: CGRect) {
        contentLabel = UILabel()
        contentLabel.numberOfLines = 1;
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.textColor = UIColor.white
        contentLabel.textAlignment = .center
        contentLabel.backgroundColor = .clear

        bgLayer = CAShapeLayer.init()
        bgLayer.fillColor = fillColor.cgColor
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(contentLabel)
        layer.insertSublayer(bgLayer, at: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func updateBGLayer() {
        let width = bounds.width
        let height = bounds.height
        let rect = CGRect(x: 0, y: arrowHeight, width: width, height: height-arrowHeight)
        var radius = cornerRadius
        if radius == 0 {
            radius = (height-arrowHeight)/2.0
        }
        let path = UIBezierPath.init(roundedRect: rect, cornerRadius: radius)
        path.move(to: CGPoint(x: width/2.0 - arrowHeight, y: arrowHeight))
        path.addLine(to: CGPoint(x: width/2.0, y: 0))
        path.addLine(to: CGPoint(x: width/2.0 + arrowHeight, y: arrowHeight))
        bgLayer.path = path.cgPath
    }

    fileprivate func updateFrame() {
        let screenWidth = UIScreen.main.bounds.size.width
        var suitableX = ((screenWidth - self.bounds.size.width)/2).rounded(.up)
        if topCenter.x > self.bounds.size.width/2 {
            suitableX = (topCenter.x - self.bounds.size.width/2).rounded(.up)
        }
        let width = contentLabel.frame.size.width + textInsets.left + textInsets.right
        let height = contentLabel.frame.size.height + arrowHeight + textInsets.top + textInsets.bottom
        let rect = CGRect(x: suitableX, y: topCenter.y, width: width, height: height)
        self.frame = rect
        self.updateBGLayer()
    }

    fileprivate func update() {
        guard contentLabel.text != nil else {
            return
        }
        let screenWidth = UIScreen.main.bounds.size.width

        let textMaxWidth = (screenWidth - horizontalPadding * 2 - textInsets.left - textInsets.right).rounded(.up)
        let textHeight = (contentLabel.font.lineHeight).rounded(.up)
        let textWidth = (contentLabel.text!.boundingRect(with: CGSize(width: textMaxWidth, height: textHeight), options: .usesLineFragmentOrigin, attributes: [.font: contentLabel.font], context: nil).width).rounded(.up)

        let textRect = CGRect(x: textInsets.left, y: textInsets.top + arrowHeight, width: textWidth, height: textHeight)
        contentLabel.frame = textRect
        self.updateFrame()
    }

    func updateText(_ text: String?) {
        guard let content = text else {
            return
        }
        contentLabel.text = content
        update()
    }
    // MARK: text config
    func updateTextColor(_ color: UIColor) {
        contentLabel.textColor = color
    }

    func updateFont(_ font: UIFont) {
        contentLabel.font = font
        update()
    }

}

final class PaddingLabel: UILabel {
    var padding: UIEdgeInsets = .zero
    var actionEnabled: Bool = false
    var roundCorner: CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = roundCorner;
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.padding))
    }
}
