//
//  ViewController.swift
//  Kasir
//
//  Created by Daffa Yagrariksa on 06/04/22.
//0

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // define data
    let dummyBarang = [
        BarangData("Nasi Goreng", 12000),
        BarangData("Mie Goreng", 15000),
        BarangData("Nasi Goreng Mie", 15000),
        BarangData("Mie Kuah", 14000),
        BarangData("Nasi Goreng", 12000),
        BarangData("Mie Goreng", 15000),
        BarangData("Nasi Goreng Mie", 15000),
        BarangData("Mie Kuah", 14000),
        BarangData("Nasi Goreng", 12000),
        BarangData("Mie Goreng", 15000),
        BarangData("Nasi Goreng Mie", 15000),
        BarangData("Mie Kuah", 14000),
    ]
    
    var dummyCart: [CartData] = []
    
    var dummySearch: [BarangData] = []
    
    var jumlah: Int = 0
    
    var selectedBarang: BarangData? = nil
    
    var selectedEdit: CartData? = nil
    var selectedEditRow: Int? = nil
    
    var editState: Bool = false
    
    // define component
    @IBOutlet var cartList: UITableView!
    
    @IBOutlet var searchList: UITableView!
    
    @IBOutlet var inputSearch: UITextField!
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    @IBOutlet var btn9: UIButton!
    @IBOutlet var btn0: UIButton!
    @IBOutlet var btnDel: UIButton!
   
    @IBOutlet var btnMinus: UIButton!
    @IBOutlet var labelJumlah: UILabel!
    
    @IBOutlet var btnAddToCart: UIButton!
    @IBOutlet var btnCancelEdit: UIButton!
    
    @IBOutlet var textTotal: UILabel!
    
    @IBOutlet var btnBayar: UIButton!
    
    
    
    // action
    override func viewDidLoad() {
        super.viewDidLoad()
       
        dummySearch = dummyBarang
        btnCancelEdit.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == cartList {
            selectedEdit = dummyCart[indexPath.row]
            selectedEditRow = indexPath.row
            activateEdit(true)
        }else{
            selectedBarang = dummySearch[indexPath.row]
            updateBtnTambahkan()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == cartList {
            return 55
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == cartList {
            return dummyCart.count
        }else{
            return dummySearch.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cartList {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
            
            let mdata = dummyCart[indexPath.row]
            
            cell.namaBarang?.text = "\(mdata.barang.namaBarang)"
            
            cell.subtotal?.text = "\(mdata.barang.harga * (mdata.jumlah))"
            
            cell.subtitle?.text = "\(mdata.jumlah) x Rp \(mdata.barang.harga)"
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")!
            
            cell.textLabel?.text = dummySearch[indexPath.row].namaBarang
            cell.detailTextLabel?.text = String(dummySearch[indexPath.row].harga)
            return cell
        }
    }
    
    @IBAction func unwindToKasir(unwindSegue: UIStoryboardSegue)
    {
        resetKasir()
    }
    
    func resetKasir()
    {
        dummyCart = []
        jumlah = 0
        updateTotal()
        updateJumlah()
        cartList.reloadData()
    }

    // text-field(search) on-edit listener
    @IBAction func onEditSearch(_ sender: Any) {
        if let value = inputSearch.text {
            dummySearch = dummyBarang.filter { barang in
                return barang.namaBarang.lowercased().contains(value.lowercased())
            }
            if value == "" {
                dummySearch = dummyBarang
            }
        }else{
            dummySearch = dummyBarang
        }
        searchList.reloadData()
    }
    
    // update jumlah item
    func updateJumlah()
    {
        if editState {
            labelJumlah.text = String(jumlah)
            btnMinus.isEnabled = true
            btnDel.isEnabled = true
        }else{
            labelJumlah.text = String(jumlah)
            btnMinus.isEnabled = true
            btnDel.isEnabled = true
        }
        updateBtnTambahkan()
        guard jumlah == 0 else {return}
        btnMinus.isEnabled = false
        btnDel.isEnabled = false
    }
    
    // toggle Edit Mode
    func activateEdit(_ a: Bool)
    {
        editState = a
        if editState {
            btnCancelEdit.isHidden = false
            btnAddToCart.setTitle("Simpan Perubahan", for: .normal)
            jumlah = dummyCart[selectedEditRow!].jumlah
            updateJumlah()
        }else {
            btnCancelEdit.isHidden = true
            btnAddToCart.setTitle("Tambahkan", for: .normal)
            jumlah = 0
            updateJumlah()
        }
        
    }
    
    // toggle Button Tambahkan
    func updateBtnTambahkan()
    {
        if editState, jumlah > 0 {
            btnAddToCart.isEnabled = true
        }else {
            if selectedBarang != nil, jumlah > 0 {
                btnAddToCart.isEnabled = true
            }else {
                btnAddToCart.isEnabled = false
            }
        }
       
    }
    
    // update Total Harga dalam keranjang
    func updateTotal()
    {
        var total = 0
        for i in dummyCart {
            total += i.jumlah * i.barang.harga
        }
        textTotal.text = "Rp \(total)"
        if total > 0 {
            btnBayar.isEnabled = true
        }else{
            btnBayar.isEnabled = false
        }
    }
    
    // on-click listener button-add-to-cart
    @IBAction func ocAddToCart(_ sender: Any) {
        if editState {
            dummyCart[selectedEditRow!].jumlah = jumlah
            searchList.reloadData()
            cartList.reloadData()
            activateEdit(false)
        }else{
            dummyCart.append(CartData(selectedBarang!, jumlah))
            cartList.reloadData()
            searchList.reloadData()
            jumlah = 0
            selectedBarang = nil
            updateJumlah()
        }
        updateTotal()
    }
    
    // on-click listener button-cancel-edit
    @IBAction func ocCancelEdit(_ sender: Any) {
        cartList.reloadData()
        activateEdit(false)
    }
    
    @IBAction func ocBtn1(_ sender: Any) {
        if jumlah == 0  {jumlah = 1}else{

        jumlah = Int(String(jumlah) + "1") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn2(_ sender: Any) {
        if jumlah == 0  {jumlah = 2}else{

        jumlah = Int(String(jumlah) + "2") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn3(_ sender: Any) {
        if jumlah == 0  {jumlah = 3}else{

        jumlah = Int(String(jumlah) + "3") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn4(_ sender: Any) {
        if jumlah == 0  {jumlah = 4}else{

        jumlah = Int(String(jumlah) + "4") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn5(_ sender: Any) {
        if jumlah == 0  {jumlah = 5}else{

        jumlah = Int(String(jumlah) + "5") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn6(_ sender: Any) {
        if jumlah == 0  {jumlah = 6}else{

        jumlah = Int(String(jumlah) + "6") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn7(_ sender: Any) {
        if jumlah == 0  {jumlah = 7}else{

        jumlah = Int(String(jumlah) + "7") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn8(_ sender: Any) {
        if jumlah == 0  {jumlah = 8}else{

        jumlah = Int(String(jumlah) + "8") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn9(_ sender: Any) {
        if jumlah == 0  {jumlah = 9}else{

        jumlah = Int(String(jumlah) + "9") ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtn0(_ sender: Any) {
        guard jumlah != 0 else {return}
        jumlah = Int(String(jumlah) + "0") ?? 0
        updateJumlah()
    }
    
    @IBAction func ocBtnDel(_ sender: Any) {
        guard jumlah != 0 else {return}
        if String(jumlah).count == 1 {
            jumlah = 0
        }else{
            let b = String(jumlah).dropLast()
            jumlah = Int(b) ?? 0
        }
        updateJumlah()
    }
    @IBAction func ocBtnPlus(_ sender: Any) {
        jumlah += 1
        updateJumlah()
    }
    @IBAction func ocBtnMinus(_ sender: Any) {
        guard jumlah != 0 else {return}
        jumlah -= 1
        updateJumlah()
    }
}

