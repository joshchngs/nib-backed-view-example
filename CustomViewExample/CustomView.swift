import Foundation
import UIKit

@IBDesignable
class CustomView : UIControl, NibBackedView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        try! addNibViewAsSubview()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)

        try! addNibViewAsSubview()
    }

    @IBInspectable
    public var text: String = "" {
        didSet {
            label.text = text
        }
    }

    @IBInspectable
    public var value: CGFloat {
        get {
            return CGFloat(slider.value)
        }
        set {
            slider.value = Float(value)
        }
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        // Forward the action on to the consumer of this control
        sendActions(for: .valueChanged)
    }

    @IBOutlet private weak var label: UILabel!
    @IBOutlet public weak var slider: UISlider!

    override func awakeFromNib() {
        layer.cornerRadius = 10
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let ctx = UIGraphicsGetCurrentContext()!

            let colorSpace = ctx.colorSpace!

            guard colorSpace.numberOfComponents == 3 && colorSpace.model == .rgb else {

                return
            }

            let colors: [CGFloat] = [
                1.0, 0.2, 0.2, 1.0, // red
                0.8, 0.7, 0.05, 1.0, // amber
                0.2, 1.0, 0.2, 1.0, // green
            ]
            let locations: [CGFloat] = [0.0, 0.2, 1.0]

            let gradient = colors.withUnsafeBufferPointer { colors in
                locations.withUnsafeBufferPointer { locations in
                    CGGradient(colorSpace: colorSpace,
                               colorComponents: colors.baseAddress!,
                               locations: locations.baseAddress!,
                               count: 3)
                }
            }

            ctx.drawLinearGradient(gradient!,
                                   start: CGPoint.zero,
                                   end: CGPoint(x: bounds.midX, y: bounds.maxY),
                                   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
    }
}
