import ObjectMapper

public class PSXpayTokenRequest: Mappable {
    public var cardId: Int!
    public var certificateLeaf: String!
    public var certificateSubCA: String!
    public var nonce: String!
    public var nonceSignature: String!
    public var tokenRequestorCode: String!

    public init() {}

    public init(
        cardId: Int,
        certificateLeaf: String,
        certificateSubCA: String,
        nonce: String,
        nonceSignature: String,
        tokenRequestorCode: String = "APLPAY"
    ) {
        self.cardId = cardId
        self.certificateLeaf = certificateLeaf
        self.certificateSubCA = certificateSubCA
        self.nonce = nonce
        self.nonceSignature = nonceSignature
        self.tokenRequestorCode = tokenRequestorCode
    }

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        cardId             <- map["card_id"]
        certificateLeaf    <- map["certificate_leaf"]
        certificateSubCA   <- map["certificate_sub_ca"]
        nonce              <- map["nonce"]
        nonceSignature     <- map["nonce_signature"]
        tokenRequestorCode <- map["token_requestor_code"]
    }
}
