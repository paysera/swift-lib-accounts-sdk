import PayseraCommonSDK
import ObjectMapper

public class PSBullionOption: Mappable {
    public var identifier: String!
    public var type: String!
    public var photos: [String] = []
    public var weights: [PSBullionOptionWeight] = []
    public var fineness: String!
    public var dimensions: String?
    public var diameter: String?
    public var edge: String?
    public var maker: String!
    public var originCountry: String!
    public var preciousMetalType: String!
    public var purchaseAmount: PSMoney!
    public var availableForPurchase: Bool!

    public init() {}

    required public init?(map: Map) {}

    public func mapping(map: Map) {
        identifier              <- map["identifier"]
        type                    <- map["type"]
        photos                  <- map["photos"]
        weights                 <- map["weights"]
        fineness                <- map["fineness"]
        dimensions              <- map["dimensions"]
        diameter                <- map["diameter"]
        edge                    <- map["edge"]
        maker                   <- map["maker"]
        originCountry           <- map["country_of_origin"]
        preciousMetalType       <- map["precious_metal_type"]
        purchaseAmount          <- map["purchase_amount"]
        availableForPurchase    <- map["available_for_purchase"]
    }
}
