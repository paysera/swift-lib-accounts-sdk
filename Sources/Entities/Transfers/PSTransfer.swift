import ObjectMapper

public class PSTransfer: Mappable {
    public let id: String
    public let status: String
    public let beneficiary: PSTransferBeneficiary
    public var initiator: PSTransferInitiator?
    public let createdAt: TimeInterval
    public let performAt: TimeInterval
    public var failureStatus: PSTransferFailureStatus?
    public var outCommission: PSMoney?
    public var urgency: String?
    public var amount: PSMoney
    public var payer: PSTransferPayer
    public var purpose: PSTransferPurpose?
    public var allowedToCancel: Bool
    public var cancelable: Bool
    public var notifications: [PSTransferNotification]?

    required public init?(map: Map) {
        do {
            id = try map.value("id")
            status = try map.value("status")
            beneficiary = try map.value("beneficiary")
            createdAt = try map.value("created_at")
            performAt = try map.value("perform_at")
            amount = try map.value("amount")
            payer = try map.value("payer")
            allowedToCancel = try map.value("allowed_to_cancel")
            cancelable = try map.value("cancelable")
        } catch {
            return nil
        }
        notifications = mapEnumeratedJSON(json: map.JSON["notifications"] as? [String: Any], enumeratedElementKey: "status")
    }

    public func mapping(map: Map) {
        failureStatus   <- map["failure_status"]
        urgency         <- map["urgency"]
        amount          <- map["amount"]
        outCommission   <- map["out_commission"]
        payer           <- map["payer"]
        purpose         <- map["purpose"]
        allowedToCancel <- map["allowed_to_cancel"]
        cancelable      <- map["cancelable"]
        initiator       <- map["initiator"]
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
