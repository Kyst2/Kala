
import Foundation

enum Currency: Int, RawRepresentable, CaseIterable {
    case usd = 0
    case uah = 1
    case eur = 2
    case gbp = 3
    case cny = 4
    case mnt = 5
    case kzt = 6
}
extension Currency {
    func asStr() -> String {
        switch self {
        case .usd:
            return "$"
        case .uah:
            return "₴"
        case .eur:
            return "€"
        case .gbp:
            return "£"
        case .cny:
            return "¥"
        case .mnt:
            return "₮"
        case .kzt:
            return "₸"
            
        }
    }
}
