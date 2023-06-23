//
//  struct.swift
//  MidiParser iOS
//
//  Created by Vladimir Vybornov on 7/1/19.
//  Copyright © 2019 Yuma Matsune. All rights reserved.
//

import Foundation
import AudioToolbox

public struct MidiTime {
    public let inSeconds: TimeInterval
    public let inTicks: Ticks
    
    init(inSeconds: TimeInterval, inTicks: Ticks) {
        self.inSeconds = inSeconds
        self.inTicks = inTicks
    }
    
    init(regularTimeStamp: MusicTimeStamp, beatsPerMinute: BeatsPerMinute = BeatsPerMinute.regular, ticksPerBeat: TicksPerBeat = TicksPerBeat.regular) {
        let timeStampInTicks = Milliseconds(regularTimeStamp).toTicks(andTicksPerBeat: ticksPerBeat)
        self.init(inSeconds: timeStampInTicks.toMs(forBeatsPerMinute: beatsPerMinute, andTicksPerBeat: ticksPerBeat).seconds, 
                  inTicks: Milliseconds(regularTimeStamp).toTicks(andTicksPerBeat: ticksPerBeat))
    }
}

public extension MidiTime {
    static var empty: MidiTime {
        return MidiTime(inSeconds: 0.0, inTicks: Ticks(0))
    }
}
