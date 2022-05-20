import Foundation
import ObjectMapper
import PayseraCommonSDK

public class PSConversionTransfer: Mappable {
    public var id: String!
    public var identifier: String!
    public var status: String!
    public var details: String!
    public var accountNumber: String!
    public var from: PSMoney?
    public var to: PSMoney?
    public var type: String!
    public var createdAt: TimeInterval?
    public var performAt: TimeInterval?
    public var payer: PSTransferPayer!
    public var allowedToCancel: Bool!
    
    public init() {}
    
    required public init?(map: Map) { }

    public func mapping(map: Map) {
        id                <- map["id"]
        identifier        <- map["identifier"]
        status            <- map["status"]
        details           <- map["details"]
        accountNumber     <- map["account_number"]
        from              <- map["from"]
        to                <- map["to"]
        type              <- map["type"]
        createdAt         <- map["created_at"]
        performAt         <- map["perform_at"]
        payer             <- map["payer"]
        allowedToCancel   <- map["allowed_to_cancel"]
    }
}
