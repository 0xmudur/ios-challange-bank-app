//
//  HomeViewModel.swift
//  iOSDeveloperChallenge
//
//  Created by Muhammed Emin Aydın on 17.06.2022.
//

import Foundation

struct CellViewModel{
    let id: String
    let sube: String
}

class HomeViewModel {

    var bankDataList: [BankDataModel] = []
    var reloadTableView: (()->())?
    var showActivityIndicator: (()->())?
    var hideActivityindicator: (()->())?

    private var cellViewModels: [CellViewModel] = [CellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    func getCellViewModel( at indexPath: IndexPath ) -> CellViewModel {
        return cellViewModels[indexPath.row]
    }

    
    func getData() {
        self.showActivityIndicator?()

        BankDataService.shared.getBankData { response in
            switch response {
            case .success(let result):
                
                self.hideActivityindicator?()
                self.createCell(datas: result)
                self.reloadTableView?()
              
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func createCell(datas: [BankDataModel]){
        self.bankDataList = datas
        var cellViewModels = [CellViewModel]()
        for data in datas {
            cellViewModels.append(CellViewModel(id: String(data.id), sube: data.dcBANKASUBE))
        }
        self.cellViewModels = cellViewModels
    }

}

