import Foundation

func asCurrency(number: Int?) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency

    let dividedNumber = Double(number ?? 0) / 100
    let numberAsDouble = NSNumber(value: dividedNumber)

    return formatter.string(from: numberAsDouble) ?? ""
}
