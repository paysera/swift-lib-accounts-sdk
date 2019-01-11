import Foundation

public enum PSTransferStatus: CustomStringConvertible {
    case signed
    case unsigned
    case processing
    case ready
    case prepared
    case reserved
    case registered
    case success
    case waitingFunds
    case waitingRegistration
    case waitingPassword

    public var description: String {
        switch self {
        case .signed: return "signed"
        case .unsigned: return "registered"
        case .processing: return "processing"
        case .ready: return "ready"
        case .prepared: return "prepared"
        case .reserved: return "reserved"
        case .registered: return "registered"
        case .success: return "success"
        case .waitingFunds: return "waiting_funds"
        case .waitingRegistration: return "waiting_registration"
        case .waitingPassword: return "waiting_password"
        }
    }
}
