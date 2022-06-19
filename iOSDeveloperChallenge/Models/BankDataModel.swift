//
//  Bank.swift
//  iOSDeveloperChallenge
//
//  Created by Muhammed Emin Aydın on 17.06.2022.
//

import Foundation

struct BankDataModel: Codable {
    let id: Int
    var dcSEHIR, dcILCE, dcBANKASUBE, dcBANKATIPI: String
    let dcBANKKODU, dcADRESADI, dcADRES, dcPOSTAKODU: String
    let dcONOFFLINE, dcONOFFSITE, dcBOLGEKOORDINATORLUGU, dcENYAKIMATM: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case dcSEHIR = "dc_SEHIR"
        case dcILCE = "dc_ILCE"
        case dcBANKASUBE = "dc_BANKA_SUBE"
        case dcBANKATIPI = "dc_BANKA_TIPI"
        case dcBANKKODU = "dc_BANK_KODU"
        case dcADRESADI = "dc_ADRES_ADI"
        case dcADRES = "dc_ADRES"
        case dcPOSTAKODU = "dc_POSTA_KODU"
        case dcONOFFLINE = "dc_ON_OFF_LINE"
        case dcONOFFSITE = "dc_ON_OFF_SITE"
        case dcBOLGEKOORDINATORLUGU = "dc_BOLGE_KOORDINATORLUGU"
        case dcENYAKIMATM = "dc_EN_YAKIM_ATM"
    }
}
