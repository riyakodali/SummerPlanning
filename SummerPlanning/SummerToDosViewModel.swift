//
//  SummerToDosViewModel.swift
//  SummerPlanning
//
//  Created by Riya Kodali on 4/26/23.
//

import Foundation
import FirebaseFirestore


class SummerToDosViewModel: ObservableObject {
    @Published var mayToDos: [SummerToDo] = []
    @Published var juneToDos: [SummerToDo] = []
    @Published var julyToDos: [SummerToDo] = []
    @Published var augustToDos: [SummerToDo] = []
    @Published var summerToDo = SummerToDo()
    
    
    
    
    
    init() {
        loadDataMay()
        loadDataJune()
        loadDataJuly()
        loadDataAugust()
    }
    
    func saveDataMay() {
        let path = URL.documentsDirectory.appending(component: "mayToDos")
        let data = try? JSONEncoder().encode(mayToDos)
        do {
            try data?.write(to: path)
        } catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    func saveDataJune() {
        let path = URL.documentsDirectory.appending(component: "juneToDos")
        let data = try? JSONEncoder().encode(juneToDos)
        do {
            try data?.write(to: path)
        } catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    func saveDataJuly() {
        let path = URL.documentsDirectory.appending(component: "julyToDos")
        let data = try? JSONEncoder().encode(julyToDos)
        do {
            try data?.write(to: path)
        } catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    func saveDataAugust() {
        let path = URL.documentsDirectory.appending(component: "augustToDos")
        let data = try? JSONEncoder().encode(augustToDos)
        do {
            try data?.write(to: path)
        } catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    func loadDataMay() {
        let path = URL.documentsDirectory.appending(component: "mayToDos")
        guard let data = try? Data(contentsOf: path) else {return}
        do {
            mayToDos = try JSONDecoder().decode(Array<SummerToDo>.self, from: data)
        } catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    func loadDataJune() {
        let path = URL.documentsDirectory.appending(component: "juneToDos")
        guard let data = try? Data(contentsOf: path) else {return}
        do {
            juneToDos = try JSONDecoder().decode(Array<SummerToDo>.self, from: data)
        } catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    func loadDataJuly() {
        let path = URL.documentsDirectory.appending(component: "julyToDos")
        guard let data = try? Data(contentsOf: path) else {return}
        do {
            julyToDos = try JSONDecoder().decode(Array<SummerToDo>.self, from: data)
        } catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    func loadDataAugust() {
        let path = URL.documentsDirectory.appending(component: "augustToDos")
        guard let data = try? Data(contentsOf: path) else {return}
        do {
            augustToDos = try JSONDecoder().decode(Array<SummerToDo>.self, from: data)
        } catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    
    func deleteMayToDo(indexSetM:IndexSet) {
        mayToDos.remove(atOffsets: indexSetM)
        saveDataMay()
    }
    func moveMayToDo(fromOffsetsM: IndexSet, toOffsetM: Int) {
        mayToDos.move(fromOffsets: fromOffsetsM, toOffset: toOffsetM)
        saveDataMay()
    }
    func deleteJuneToDo(indexSetJn:IndexSet) {
        juneToDos.remove(atOffsets: indexSetJn)
        saveDataJune()
    }
    func moveJuneToDo(fromOffsetsJn: IndexSet, toOffsetJn: Int) {
        juneToDos.move(fromOffsets: fromOffsetsJn, toOffset: toOffsetJn)
        saveDataJune()
    }
    func deleteJulyToDo(indexSetJy:IndexSet) {
        julyToDos.remove(atOffsets: indexSetJy)
        saveDataJuly()
    }
    func moveJulyToDo(fromOffsetsJy: IndexSet, toOffsetJy: Int) {
        julyToDos.move(fromOffsets: fromOffsetsJy, toOffset: toOffsetJy)
        saveDataJuly()
    }
    func deleteAugustToDo(indexSetA:IndexSet) {
        augustToDos.remove(atOffsets: indexSetA)
        saveDataAugust()
    }
    func moveAugustToDo(fromOffsetsA: IndexSet, toOffsetA: Int) {
        augustToDos.move(fromOffsets: fromOffsetsA, toOffset: toOffsetA)
        saveDataAugust()
    }
    
    func saveSummerToDo(summerToDo: SummerToDo) async -> String? {
        let db = Firestore.firestore()
        if let id = summerToDo.id { // place must already exist, so save
            do {
                try await db.collection("summerToDos").document(id).setData(summerToDo.dictionary)
                print("😎 Data updated successfully!")
                return summerToDo.id
            } catch {
                print("😡 ERROR: Could not update data in 'summerToDos' \(error.localizedDescription)")
                return nil
            }
        } else { // no id? Then this must be a new student to add
            do {
                let docRef = try await db.collection("summerToDos").addDocument(data: summerToDo.dictionary)
                print("🐣 Data added successfully!")
                return docRef.documentID
            } catch {
                print("😡 ERROR: Could not create a new place in 'summerToDos' \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    func deleteData(summerToDo: SummerToDo) async {
        let db = Firestore.firestore()
        guard let id = summerToDo.id else {
            print("😡 ERROR: id was nil. This should not have happened!")
            return
        }
        
        do {
            let _ = try await db.collection("summerToDos").document(id).delete()
            print("🗑 Document successfully removed!")
            return
        } catch {
            print("😡 ERROR: removing document: \(error.localizedDescription)")
            return
        }
    }
    
    func saveSummerToDoMay(mayToDo: SummerToDo) {
        var newToDoMay = mayToDo
        newToDoMay.id = UUID().uuidString
        mayToDos.append(newToDoMay)
    }
    
    func saveSummerToDoJune(juneToDo: SummerToDo) {
        var newToDoJune = juneToDo
        newToDoJune.id = UUID().uuidString
        juneToDos.append(newToDoJune)
    }
    
    func saveSummerToDoJuly(julyToDo: SummerToDo) {
        var newToDoJuly = julyToDo
        newToDoJuly.id = UUID().uuidString
        julyToDos.append(newToDoJuly)
    }
    
    func saveSummerToDoAugust(augustToDo: SummerToDo) {
        var newToDoAugust = augustToDo
        newToDoAugust.id = UUID().uuidString
        augustToDos.append(newToDoAugust)
    }
}








