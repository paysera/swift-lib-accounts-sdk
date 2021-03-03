import ObjectMapper

public class PSXpayToken: Mappable {
    public var activationData: String!
    public var encryptedData: String?
    public var ephemeralPublicKey: String?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        activationData     <- map["activation_data"]
        encryptedData      <- map["encrypted_data"]
        ephemeralPublicKey <- map["ephemeral_public_key"]
    }
}
