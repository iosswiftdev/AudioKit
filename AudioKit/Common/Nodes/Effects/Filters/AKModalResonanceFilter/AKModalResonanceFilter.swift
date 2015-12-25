//
//  AKModalResonanceFilter.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/** A modal resonance filter used for modal synthesis. Plucked and bell sounds can
 be created using  passing an impulse through a combination of modal filters. */
public struct AKModalResonanceFilter: AKNode {

    // MARK: - Properties
    
    /// Required property for AKNode
    public var avAudioNode: AVAudioNode
    
    private var internalAU: AKModalResonanceFilterAudioUnit?
    private var token: AUParameterObserverToken?

    private var frequencyParameter: AUParameter?
    private var qualityFactorParameter: AUParameter?

    /** Resonant frequency of the filter. */
    public var frequency: Double = 500.0 {
        didSet {
            frequencyParameter?.setValue(Float(frequency), originator: token!)
        }
    }
    /** Quality factor of the filter. Roughly equal to Q/frequency. */
    public var qualityFactor: Double = 50.0 {
        didSet {
            qualityFactorParameter?.setValue(Float(qualityFactor), originator: token!)
        }
    }

    // MARK: - Initializers

    /** Initialize this filter node */
    public init(
        _ input: AKNode,
        frequency: Double = 500.0,
        qualityFactor: Double = 50.0) {

        self.frequency = frequency
        self.qualityFactor = qualityFactor

        var description = AudioComponentDescription()
        description.componentType         = kAudioUnitType_Effect
        description.componentSubType      = 0x6d6f6466 /*'modf'*/
        description.componentManufacturer = 0x41754b74 /*'AuKt'*/
        description.componentFlags        = 0
        description.componentFlagsMask    = 0

        AUAudioUnit.registerSubclass(
            AKModalResonanceFilterAudioUnit.self,
            asComponentDescription: description,
            name: "Local AKModalResonanceFilter",
            version: UInt32.max)

        self.avAudioNode = AVAudioNode()
        AVAudioUnit.instantiateWithComponentDescription(description, options: []) {
            avAudioUnit, error in

            guard let avAudioUnitEffect = avAudioUnit else { return }

            self.avAudioNode = avAudioUnitEffect
            self.internalAU = avAudioUnitEffect.AUAudioUnit as? AKModalResonanceFilterAudioUnit

            AKManager.sharedInstance.engine.attachNode(self.avAudioNode)
            AKManager.sharedInstance.engine.connect(input.avAudioNode, to: self.avAudioNode, format: AKManager.format)
        }

        guard let tree = internalAU?.parameterTree else { return }

        frequencyParameter     = tree.valueForKey("frequency")     as? AUParameter
        qualityFactorParameter = tree.valueForKey("qualityFactor") as? AUParameter

        token = tree.tokenByAddingParameterObserver {
            address, value in

            dispatch_async(dispatch_get_main_queue()) {
                if address == self.frequencyParameter!.address {
                    self.frequency = Double(value)
                } else if address == self.qualityFactorParameter!.address {
                    self.qualityFactor = Double(value)
                }
            }
        }
        frequencyParameter?.setValue(Float(frequency), originator: token!)
        qualityFactorParameter?.setValue(Float(qualityFactor), originator: token!)
    }
}
