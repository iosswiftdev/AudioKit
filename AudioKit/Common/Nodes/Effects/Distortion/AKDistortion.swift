//
//  AKDistortion.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/** AudioKit version of Apple's Distortion Audio Unit */
public struct AKDistortion: AKNode {
    
    private let cd = AudioComponentDescription(
        componentType: kAudioUnitType_Effect,
        componentSubType: kAudioUnitSubType_Distortion,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)
    
    private var internalEffect = AVAudioUnitEffect()
    private var internalAU = AudioUnit()
    
    /// Required property for AKNode
    public var avAudioNode: AVAudioNode
        
    /** Delay (Milliseconds) ranges from 0.1 to 500 (Default: 0.1) */
    public var delay: Double = 0.1 {
        didSet {
            if delay < 0.1 {
                delay = 0.1
            }
            if delay > 500 {
                delay = 500
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_Delay,
                kAudioUnitScope_Global, 0,
                Float(delay), 0)
        }
    }
    
    /** Decay (Rate) ranges from 0.1 to 50 (Default: 1.0) */
    public var decay: Double = 1.0 {
        didSet {
            if decay < 0.1 {
                decay = 0.1
            }
            if decay > 50 {
                decay = 50
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_Decay,
                kAudioUnitScope_Global, 0,
                Float(decay), 0)
        }
    }
    
    /** Delay Mix (Percent) ranges from 0 to 100 (Default: 50) */
    public var delayMix: Double = 50 {
        didSet {
            if delayMix < 0 {
                delayMix = 0
            }
            if delayMix > 100 {
                delayMix = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_DelayMix,
                kAudioUnitScope_Global, 0,
                Float(delayMix), 0)
        }
    }
    
    /** Decimation (Percent) ranges from 0 to 100 (Default: 50) */
    public var decimation: Double = 50 {
        didSet {
            if decimation < 0 {
                decimation = 0
            }
            if decimation > 100 {
                decimation = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_Decimation,
                kAudioUnitScope_Global, 0,
                Float(decimation), 0)
        }
    }
    
    /** Rounding (Percent) ranges from 0 to 100 (Default: 0) */
    public var rounding: Double = 0 {
        didSet {
            if rounding < 0 {
                rounding = 0
            }
            if rounding > 100 {
                rounding = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_Rounding,
                kAudioUnitScope_Global, 0,
                Float(rounding), 0)
        }
    }
    
    /** Decimation Mix (Percent) ranges from 0 to 100 (Default: 50) */
    public var decimationMix: Double = 50 {
        didSet {
            if decimationMix < 0 {
                decimationMix = 0
            }
            if decimationMix > 100 {
                decimationMix = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_DecimationMix,
                kAudioUnitScope_Global, 0,
                Float(decimationMix), 0)
        }
    }
    
    /** Linear Term (Percent) ranges from 0 to 100 (Default: 50) */
    public var linearTerm: Double = 50 {
        didSet {
            if linearTerm < 0 {
                linearTerm = 0
            }
            if linearTerm > 100 {
                linearTerm = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_LinearTerm,
                kAudioUnitScope_Global, 0,
                Float(linearTerm), 0)
        }
    }
    
    /** Squared Term (Percent) ranges from 0 to 100 (Default: 50) */
    public var squaredTerm: Double = 50 {
        didSet {
            if squaredTerm < 0 {
                squaredTerm = 0
            }
            if squaredTerm > 100 {
                squaredTerm = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_SquaredTerm,
                kAudioUnitScope_Global, 0,
                Float(squaredTerm), 0)
        }
    }
    
    /** Cubic Term (Percent) ranges from 0 to 100 (Default: 50) */
    public var cubicTerm: Double = 50 {
        didSet {
            if cubicTerm < 0 {
                cubicTerm = 0
            }
            if cubicTerm > 100 {
                cubicTerm = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_CubicTerm,
                kAudioUnitScope_Global, 0,
                Float(cubicTerm), 0)
        }
    }
    
    /** Polynomial Mix (Percent) ranges from 0 to 100 (Default: 50) */
    public var polynomialMix: Double = 50 {
        didSet {
            if polynomialMix < 0 {
                polynomialMix = 0
            }
            if polynomialMix > 100 {
                polynomialMix = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_PolynomialMix,
                kAudioUnitScope_Global, 0,
                Float(polynomialMix), 0)
        }
    }
    
    /** Ring Mod Freq1 (Hertz) ranges from 0.5 to 8000 (Default: 100) */
    public var ringModFreq1: Double = 100 {
        didSet {
            if ringModFreq1 < 0.5 {
                ringModFreq1 = 0.5
            }
            if ringModFreq1 > 8000 {
                ringModFreq1 = 8000
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_RingModFreq1,
                kAudioUnitScope_Global, 0,
                Float(ringModFreq1), 0)
        }
    }
    
    /** Ring Mod Freq2 (Hertz) ranges from 0.5 to 8000 (Default: 100) */
    public var ringModFreq2: Double = 100 {
        didSet {
            if ringModFreq2 < 0.5 {
                ringModFreq2 = 0.5
            }
            if ringModFreq2 > 8000 {
                ringModFreq2 = 8000
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_RingModFreq2,
                kAudioUnitScope_Global, 0,
                Float(ringModFreq2), 0)
        }
    }
    
    /** Ring Mod Balance (Percent) ranges from 0 to 100 (Default: 50) */
    public var ringModBalance: Double = 50 {
        didSet {
            if ringModBalance < 0 {
                ringModBalance = 0
            }
            if ringModBalance > 100 {
                ringModBalance = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_RingModBalance,
                kAudioUnitScope_Global, 0,
                Float(ringModBalance), 0)
        }
    }
    
    /** Ring Mod Mix (Percent) ranges from 0 to 100 (Default: 0) */
    public var ringModMix: Double = 0 {
        didSet {
            if ringModMix < 0 {
                ringModMix = 0
            }
            if ringModMix > 100 {
                ringModMix = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_RingModMix,
                kAudioUnitScope_Global, 0,
                Float(ringModMix), 0)
        }
    }
    
    /** Soft Clip Gain (dB) ranges from -80 to 20 (Default: -6) */
    public var softClipGain: Double = -6 {
        didSet {
            if softClipGain < -80 {
                softClipGain = -80
            }
            if softClipGain > 20 {
                softClipGain = 20
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_SoftClipGain,
                kAudioUnitScope_Global, 0,
                Float(softClipGain), 0)
        }
    }
    
    /** Final Mix (Percent) ranges from 0 to 100 (Default: 50) */
    public var finalMix: Double = 50 {
        didSet {
            if finalMix < 0 {
                finalMix = 0
            }
            if finalMix > 100 {
                finalMix = 100
            }
            AudioUnitSetParameter(
                internalAU,
                kDistortionParam_FinalMix,
                kAudioUnitScope_Global, 0,
                Float(finalMix), 0)
        }
    }
    
    /** Initialize the distortion node */
    public init(
        _ input: AKNode,
        delay: Double = 0.1,
        decay: Double = 1.0,
        delayMix: Double = 50,
        decimation: Double = 50,
        rounding: Double = 0,
        decimationMix: Double = 50,
        linearTerm: Double = 50,
        squaredTerm: Double = 50,
        cubicTerm: Double = 50,
        polynomialMix: Double = 50,
        ringModFreq1: Double = 100,
        ringModFreq2: Double = 100,
        ringModBalance: Double = 50,
        ringModMix: Double = 0,
        softClipGain: Double = -6,
        finalMix: Double = 50) {
            
            self.delay = delay
            self.decay = decay
            self.delayMix = delayMix
            self.decimation = decimation
            self.rounding = rounding
            self.decimationMix = decimationMix
            self.linearTerm = linearTerm
            self.squaredTerm = squaredTerm
            self.cubicTerm = cubicTerm
            self.polynomialMix = polynomialMix
            self.ringModFreq1 = ringModFreq1
            self.ringModFreq2 = ringModFreq2
            self.ringModBalance = ringModBalance
            self.ringModMix = ringModMix
            self.softClipGain = softClipGain
            self.finalMix = finalMix
            
            internalEffect = AVAudioUnitEffect(audioComponentDescription: cd)
            self.avAudioNode = internalEffect
            AKManager.sharedInstance.engine.attachNode(self.avAudioNode)
            AKManager.sharedInstance.engine.connect(input.avAudioNode, to: self.avAudioNode, format: AKManager.format)
            internalAU = internalEffect.audioUnit
            
            AudioUnitSetParameter(internalAU, kDistortionParam_Delay, kAudioUnitScope_Global, 0, Float(delay), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_Decay, kAudioUnitScope_Global, 0, Float(decay), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_DelayMix, kAudioUnitScope_Global, 0, Float(delayMix), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_Decimation, kAudioUnitScope_Global, 0, Float(decimation), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_Rounding, kAudioUnitScope_Global, 0, Float(rounding), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_DecimationMix, kAudioUnitScope_Global, 0, Float(decimationMix), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_LinearTerm, kAudioUnitScope_Global, 0, Float(linearTerm), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_SquaredTerm, kAudioUnitScope_Global, 0, Float(squaredTerm), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_CubicTerm, kAudioUnitScope_Global, 0, Float(cubicTerm), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_PolynomialMix, kAudioUnitScope_Global, 0, Float(polynomialMix), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_RingModFreq1, kAudioUnitScope_Global, 0, Float(ringModFreq1), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_RingModFreq2, kAudioUnitScope_Global, 0, Float(ringModFreq2), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_RingModBalance, kAudioUnitScope_Global, 0, Float(ringModBalance), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_RingModMix, kAudioUnitScope_Global, 0, Float(ringModMix), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_SoftClipGain, kAudioUnitScope_Global, 0, Float(softClipGain), 0)
            AudioUnitSetParameter(internalAU, kDistortionParam_FinalMix, kAudioUnitScope_Global, 0, Float(finalMix), 0)
    }
}
