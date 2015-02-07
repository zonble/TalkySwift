import UIKit

class ViewController: UIViewController {
	var talky = Talky()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	@IBAction func start() {
		self.talky.start()
	}

	@IBAction func stop() {
		self.talky.stop()
	}
}
