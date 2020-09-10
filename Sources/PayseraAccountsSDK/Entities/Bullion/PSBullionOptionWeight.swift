import ObjectMapper

public class PSBullionOptionWeight: Mappable {
    public var measurementUnit: String!
    public var amount: String!

    public init() {}

    required public init?(map: Map) {}

    public func mapping(map: Map) {
        measurementUnit     <- map["measurement_unit"]
        amount              <- map["amount"]
    }
}
