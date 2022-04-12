//
//  CashPaymentViewController.swift
//  Kasir
//
//  Created by Daffa Yagrariksa on 11/04/22.
//

import UIKit

class CashPaymentViewController: UIViewController {

    
    @IBOutlet var labelDibayarkan: UILabel!
    @IBOutlet var labelDiserahkan: UILabel!
    @IBOutlet var labelDikembalikan: UILabel!
    
    var jumlah: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ocKonfirmasiPesanan(_ sender: Any) {
        
    }
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
