import UIKit
import Sodium

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let sodium = Sodium()
        let aliceKeyPair = sodium.box.keyPair()!
        let bobKeyPair = sodium.box.keyPair()!
        let message = "My Test Message".bytes

        print("Original Message:\(message.utf8String!)")

        let encryptedMessageFromAliceToBob: Bytes =
            sodium.box.seal(
                message: message,
                recipientPublicKey: bobKeyPair.publicKey,
                senderSecretKey: aliceKeyPair.secretKey)!

        print("Encrypted Message:\(encryptedMessageFromAliceToBob)")

        let messageVerifiedAndDecryptedByBob =
            sodium.box.open(
                nonceAndAuthenticatedCipherText: encryptedMessageFromAliceToBob,
                senderPublicKey: bobKeyPair.publicKey,
                recipientSecretKey: aliceKeyPair.secretKey)

        print("Decrypted Message:\(messageVerifiedAndDecryptedByBob!.utf8String!)")
        
        
       let data =  sodium.scalar.cryptoScalarMult(publicKey: "TCtY-E8kl3mH5T0JTggJYgR5du4CxCBd73sdgT-WQXU".bytes, secretKey: "TCtY-E8kl3mH5T0JTggJYgR5du4CxCBd73sdgT-WQX1".bytes)!
    print("----")
        
       let s = data.reduce(into: "") {
          var s = String($1, radix: 16)
          if s.count == 1 {
            s = "0" + s
          }
          $0 += s
        }
        
        print(s)

        
        let pair = sodium.keyExchange.keyPair()!
        let ss = sodium.scalar.cryptoScalarMultBase(secretKey: [UInt8](Data(base64Encoded: pair.secretKey.toBase64(), options: .ignoreUnknownCharacters)!))

        
        print(sodium.utils.bin2base64(pair.publicKey))
        print(sodium.utils.bin2base64(pair.secretKey))
        print(sodium.utils.bin2base64(ss!))
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension Array where Element == UInt8 {
  func toBase64() -> String {
    Data(self).base64EncodedString()
  }
}
