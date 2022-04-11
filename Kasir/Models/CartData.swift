//
//  Cart.swift
//  Kasir
//
//  Created by Daffa Yagrariksa on 06/04/22.
//

import Foundation

class CartData {
    var barang: BarangData
    var jumlah: Int
    
    init(_ a: BarangData, _ b: Int){
        barang = a
        jumlah = b
    }
}
