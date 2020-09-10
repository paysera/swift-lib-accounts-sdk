import PayseraCommonSDK
import ObjectMapper

public class PSBullion: Mappable {
    public var hash: String!
    public var type: String!
    public var identifier: String!
    public var amount: PSMoney!

    public init() {}

    required public init?(map: Map) {}

    public func mapping(map: Map) {
        hash        <- map["hash"]
        type        <- map["type"]
        identifier  <- map["identifier"]
        amount      <- map["amount"]
    }
}
