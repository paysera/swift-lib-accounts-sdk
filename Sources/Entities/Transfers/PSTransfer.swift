import ObjectMapper
import PayseraCommonSDK

public class PSTransfer: Mappable {
    public var id: String!
    public var status: String!
    public var beneficiary: PSTransferBeneficiary!
    public var initiator: PSTransferInitiator?
    public var createdAt: TimeInterval!
    public var performAt: TimeInterval?
    public var performedAt: TimeInterval?
    public var failureStatus: PSTransferFailureStatus?
    public var outCommission: PSMoney?
    public var urgency: String?
    public var amount: PSMoney!
    public var payer: PSTransferPayer!
    public var purpose: PSTransferPurpose?
    public var allowedToCancel: Bool!
    public var cancelable: Bool!
    public var notifications: [PSTransferNotification]?
    public var password: PSPassword?

    public init() {}
    
    required public init?(map: Map) {
        notifications = mapEnumeratedJSON(json: map.JSON["notifications"] as? [String: Any], enumeratedElementKey: "status")
    }

    public func mapping(map: Map) {
        id              <- map["id"]
        failureStatus   <- map["failure_status"]
        urgency         <- map["urgency"]
        amount          <- map["amount"]
        outCommission   <- map["out_commission"]
        payer           <- map["payer"]
        purpose         <- map["purpose"]
        allowedToCancel <- map["allowed_to_cancel"]
        cancelable      <- map["cancelable"]
        initiator       <- map["initiator"]
        performAt       <- map["perform_at"]
        performedAt     <- map["performed_at"]
        createdAt       <- map["created_at"]
        status          <- map["status"]
        beneficiary     <- map["beneficiary"]
        password        <- map["password"]
    }

    public func isSigned() -> Bool {
        return self.status == PSTransferStatus.signed.description
    }

    public func isProccesing() -> Bool {
        return self.status == PSTransferStatus.processing.description
    }

    public func isReady() -> Bool {
        return self.status == PSTransferStatus.ready.description
    }

    public func isReserved() -> Bool {
        return self.status == PSTransferStatus.reserved.description
    }
}
