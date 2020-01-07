import ObjectMapper
import PayseraCommonSDK

public class PSPaymentCardDesign: Mappable {
    public var id: Int!
    public var name: String!
    public var visualType: String!
    public var selectorColor: String!
    public var priority: Int!
    public var active: Bool!
    public var visualUrl: String!

    public init() {}
    
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        id            <- map["id"]
        name          <- map["name"]
        visualType    <- map["visual_type"]
        selectorColor <- map["selector_color"]
        priority      <- map["priority"]
        active        <- map["active"]
        visualUrl     <- map["visual_url"]
    }
}
