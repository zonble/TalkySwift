import UIKit
import AudioToolbox
import AVFoundation

func check(status:OSStatus) {
	assert(status == noErr, "\(status)")
}

class Talky: NSObject {
	var audioGraph = AUGraph()
	var IONode :AudioNodeRemoteIO

	override init () {
		AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
		AVAudioSession.sharedInstance().setPreferredIOBufferDuration(0.0005, error: nil)
		AVAudioSession.sharedInstance().setActive(true, error: nil)

		check(NewAUGraph(&audioGraph))
		check(AUGraphOpen(audioGraph))
		self.IONode = AudioNodeRemoteIO(audioGraph: self.audioGraph)

		super.init()

		check(AUGraphConnectNodeInput(audioGraph, self.IONode.node, 1, self.IONode.node, 0))
		check(AudioUnitInitialize(self.IONode.audioUnit))
		check(AUGraphInitialize(self.audioGraph))
		CAShow(UnsafeMutablePointer(audioGraph))
		self.start()
	}

	func start() {
		check(AUGraphStart(self.audioGraph))
		check(AudioOutputUnitStart(self.IONode.audioUnit))
	}

	func stop() {
		check(AUGraphStop(self.audioGraph))
		check(AudioOutputUnitStop(self.IONode.audioUnit))
	}

}
