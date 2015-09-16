//
//  AKWhiteNoise.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka on 9/16/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import Foundation

/** White noise generator


*/
@objc class AKWhiteNoise : AKParameter {

    // MARK: - Properties

    private var noise = UnsafeMutablePointer<sp_noise>.alloc(1)


    /** Amplitude. (Value between 0-1). [Default Value: 1.0] */
    var amplitude: AKParameter = akp(1.0) {
        didSet {
            amplitude.bind(&noise.memory.amp)
            dependencies.append(amplitude)
        }
    }


    // MARK: - Initializers

    /** Instantiates the noise with default values
    */
    override init()
    {
        super.init()
        setup()
        dependencies = []
        bindAll()
    }

    /** Instantiates the noise with all values

    - parameter amplitude: Amplitude. (Value between 0-1). [Default Value: 1.0]
    */
    convenience init(
        amplitude ampInput: AKParameter)
    {
        self.init()

        amplitude = ampInput

        bindAll()
    }

    // MARK: - Internals

    /** Bind every property to the internal noise */
    internal func bindAll() {
        amplitude.bind(&noise.memory.amp)
        dependencies.append(amplitude)
    }

    /** Internal set up function */
    internal func setup() {
        sp_noise_create(&noise)
        sp_noise_init(AKManager.sharedManager.data, noise)
    }

    /** Computation of the next value */
    override func compute() {
        sp_noise_compute(AKManager.sharedManager.data, noise, nil, &leftOutput);
        rightOutput = leftOutput
    }

    /** Release of memory */
    override func teardown() {
        sp_noise_destroy(&noise)
    }
}