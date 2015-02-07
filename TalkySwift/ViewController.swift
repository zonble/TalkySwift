import UIKit

class ViewController: UIViewController {
	var talky = Talky()

	@IBAction func start() {
		self.talky.start()
	}

	@IBAction func stop() {
		self.talky.stop()
	}
}
