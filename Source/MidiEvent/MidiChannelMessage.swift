//
//  MidiChannelMessage.swift
//  MidiParser
//
//  Created by Yuma Matsune on 2017/11/05.
//  Copyright © 2017年 matsune. All rights reserved.
//

import AudioToolbox
import Foundation

public struct MidiChannelMessage: MidiEventProtocol {
    public let timeStamp: MidiTime
    public let status: UInt8
    public let data1: UInt8
    public let data2: UInt8
    public let reserved: UInt8
    
    public init(regularTimeStamp: MusicTimeStamp, status: UInt8, data1: UInt8, data2: UInt8, reserved: UInt8, beatsPerMinute: BeatsPerMinute = BeatsPerMinute.regular, ticksPerBeat: TicksPerBeat = TicksPerBeat.regular) {
        self.timeStamp = MidiTime(regularTimeStamp: regularTimeStamp, beatsPerMinute: beatsPerMinute, ticksPerBeat: ticksPerBeat)
        self.status = status
        self.data1 = data1
        self.data2 = data2
        self.reserved = reserved
    }

    public func toCC() -> (channel: UInt8, controller: UInt8, value: UInt8)? {
        guard (status & 0xf0) == 0xb0,
              let channel = status.hexString.suffix(1).number
        else { return nil }
        
        return (channel: channel, controller: data1, value: data2)
    }
}
