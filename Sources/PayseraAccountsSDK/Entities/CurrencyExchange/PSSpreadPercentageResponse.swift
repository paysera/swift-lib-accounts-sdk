import ObjectMapper

public class PSSpreadPercentageResponse: Mappable {
    public var spreadPercentage: Double!

    public init() {}

    required public init?(map: Map) {}

    public func mapping(map: Map) {
        spreadPercentage <- map["spread_percentage"]
    }
}
