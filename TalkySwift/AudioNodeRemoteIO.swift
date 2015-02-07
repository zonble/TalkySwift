import UIKit
import AudioToolbox

class AudioNodeRemoteIO : NSObject {
	var audioUnitDescription :AudioComponentDescription {
		get {
			return  AudioComponentDescription(componentType: OSType(kAudioUnitType_Output),
				componentSubType: OSType(kAudioUnitSubType_RemoteIO),
				componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
				componentFlags: 0,
				componentFlagsMask: 0)
		}
	}
	var node = AUNode()
	var audioUnit = AudioUnit()

	init(audioGraph: AUGraph) {
		super.init()
		var desc = self.audioUnitDescription
		AUGraphAddNode(audioGraph, &desc, &self.node);
		AUGraphNodeInfo(audioGraph, node, &desc, &audioUnit);

		var flag = UInt32(1)
		var status :OSStatus
		status = AudioUnitSetProperty(self.audioUnit,
			AudioUnitPropertyID(kAudioOutputUnitProperty_EnableIO),
			AudioUnitScope(kAudioUnitScope_Input),
			1, &flag, UInt32(sizeof(UInt32.self)))
		status = AudioUnitSetProperty(self.audioUnit,
			AudioUnitPropertyID(kAudioOutputUnitProperty_EnableIO),
			AudioUnitScope(kAudioUnitScope_Output),
			0, &flag, UInt32(sizeof(UInt32.self)))
	}

	deinit {
		AudioComponentInstanceDispose(self.audioUnit)
	}
}

