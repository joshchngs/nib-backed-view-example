import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customView: CustomView!

    @IBOutlet weak var sliderValueLabel: UILabel!

    @IBAction func sliderValueChanged(_ sender: CustomView) {
        let valueText = String(format: "%.2f", sender.value)
        sliderValueLabel.text = "Slider Value: \(valueText)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
