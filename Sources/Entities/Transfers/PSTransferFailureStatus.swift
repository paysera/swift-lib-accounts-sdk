import ObjectMapper

public class PSTransferFailureStatus: Mappable {
    public var code: String?
    public var message: String?

    required public init?(map: Map) {
    }

    public init() {
    }

    // Mappable
    public func mapping(map: Map) {
        code                <- map["code"]
        message             <- map["message"]

    }
}
