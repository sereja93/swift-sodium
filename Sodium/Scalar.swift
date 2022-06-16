//
//  Scalar.swift
//  Sodium
//
//  Created by Ivanov Sereja on 01.09.2021.
//  Copyright © 2021 Frank Denis. All rights reserved.
//

import Foundation
import Clibsodium

public struct Scalar {
    private let size = Int(crypto_scalarmult_scalarbytes())
}
extension Scalar {
    public func cryptoScalarMult(publicKey: Bytes, secretKey: Bytes) -> Bytes? {
        var result = Bytes.init(count: size)
        guard .SUCCESS == crypto_scalarmult(
            &result,
            secretKey,
            publicKey
        ).exitCode else { return nil }
        return result
    }
    
    public func cryptoScalarMultBase(secretKey: Bytes) -> Bytes? {
        var publicKey = Bytes.init(count: size)
        guard .SUCCESS == crypto_scalarmult_base(
            &publicKey,
            secretKey
        ).exitCode else { return nil }
        return publicKey
    }
    
}
