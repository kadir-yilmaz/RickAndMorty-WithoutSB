//
//  RickAndMortyViewModel.swift
//  RickAndMorty-WithoutSB
//
//  Created by Kadir Yılmaz on 18.05.2023.
//

import Foundation

protocol IRickAndMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickAndMortyCharacters: [Result] { get set }
    var rickAndMortyService: IRickAndMortyService { get }
    
    var rickAndMortyOutPut: RickAndMortyOutPut? { get }
    
    func setDelegate(output: RickAndMortyOutPut)
    
}

class RickAndMortyViewModel: IRickAndMortyViewModel {
    
    var rickAndMortyOutPut: RickAndMortyOutPut?
    
    func setDelegate(output: RickAndMortyOutPut) {
        rickAndMortyOutPut = output
    }
    
    func fetchItems() {
        changeLoading()
        rickAndMortyService.fetchAllData { [weak self] response in
            self?.changeLoading()
            self?.rickAndMortyCharacters = response ?? []
            self?.rickAndMortyOutPut?.saveData(values: self?.rickAndMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickAndMortyOutPut?.changeLoading(isLoad: isLoading)
    }
    
    var rickAndMortyCharacters: [Result] = []
    
    var rickAndMortyService: IRickAndMortyService
    
    init() {
        rickAndMortyService = RickAndMortyService()
    }
    
    private var isLoading = false
    
}
