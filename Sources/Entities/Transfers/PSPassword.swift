import ObjectMapper

public class PSPassword: Mappable {
    public var value: String!

    public init() {}
    
    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        value      <- map["value"]
    }
}
