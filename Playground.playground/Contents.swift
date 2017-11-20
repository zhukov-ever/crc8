import Foundation


let poly = 0x07
let mask = 0xff

var table = Array.init(repeating: UInt8(0), count: 256)

for i in 0..<table.count {
    var c = i
    for _ in 0..<8 {
        if c & 0x80 != 0 {
            c = (((c << 1) & mask) ^ poly)
        } else {
            c <<= 1
        }
    }
    table[i] = UInt8(c)
}


func makeCRC8(string:String) -> UInt8 {
    guard let data = string.data(using: String.Encoding.utf8) else { return 0 }
    return makeCRC8(data: data)
}

func makeCRC8(data:Data) -> UInt8 {
    let dataArray = [UInt8](data)
    var crc8:UInt8 = 0x00
    for i in 0..<dataArray.count {
        crc8 = table[ Int(crc8 ^ dataArray[i]) ]
    }
    return crc8
}

print(makeCRC8(string: "hello crc8"))
