public enum Country {
    case russia
    case germany
    case france

    var name: String {
        switch self {
        case .russia: return "Russia"
        case .germany: return "Germany"
        case .france: return "France"
        }
    }
}
