//
//  ViewController.swift
//  Shiny Counter
//
//  Created by The Real Kaiser on 8/21/18.
//  Copyright © 2018 William Donnelly. All rights reserved.
//

/*Stuff that MUST be saved
 
 -Counter Status
 -Chosen Pokemon
 -Chosen Game
 -Chosen Method
 
 */

import UIKit

class CounterScreen: UIViewController {
    
    @IBOutlet weak var Counter: UILabel!
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var shinyImage: UIImageView!
    
    var encounterTextField: UITextField?
    var decimalFormat = false
    var chosenPokemon = ""
    var chosenGame = ""
    var chosenMethod = "Full Odds"
    var alolan = false
    var maxOdds = 0
    var chance = 0.0
    
    override func viewDidAppear(_ animated: Bool) {
        if let pokemon = UserDefaults.standard.object(forKey: "pokemon") as? String {
            print(pokemon)
            chosenPokemon = pokemon
        }
        
        if let game = UserDefaults.standard.object(forKey: "game") as? String {
            print(game)
            chosenGame = game
        }
        
        if let method = UserDefaults.standard.object(forKey: "method") as? String {
            print(method)
            chosenMethod = method
        }
        
        if let count = UserDefaults.standard.object(forKey: "count") as? String {
            print(count)
            Counter.text = count
        }
        calculateOdds()
        if(chosenGame == "Sun" || chosenGame == "Ultra Sun" || chosenGame == "Moon" || chosenGame == "Ultra Moon"){
            alolan = true
        }
        else{
            alolan = false
        }
        if(alolan == false){
            shinyImage.image = UIImage(named: "\(chosenPokemon) Shiny")
        }
        else if(UIImage(named: "\(chosenPokemon) Normal Alola") != nil){
            shinyImage.image = UIImage(named: "\(chosenPokemon) Shiny Alola")
        }
        else{
            shinyImage.image = UIImage(named: "\(chosenPokemon) Shiny")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let identity = UserDefaults.standard.object(forKey: "viewIdentifier") as? String {
            if(identity == "CounterScreen"){
                return
            }
            else{
                UserDefaults.standard.set(self.restorationIdentifier, forKey: "viewIdentifier")
                UserDefaults.standard.set(chosenPokemon, forKey: "pokemon")
                UserDefaults.standard.set(chosenGame, forKey: "game")
                UserDefaults.standard.set(chosenMethod, forKey: "method")
                UserDefaults.standard.set(Counter.text, forKey: "count")
        
                calculateOdds()
                if(alolan == false){
                    shinyImage.image = UIImage(named: "\(chosenPokemon) Shiny")
                }
                else if(UIImage(named: "\(chosenPokemon) Normal Alola") != nil){
                    shinyImage.image = UIImage(named: "\(chosenPokemon) Shiny Alola")
                }
                else{
                    shinyImage.image = UIImage(named: "\(chosenPokemon) Shiny")
                }
                //shinyImage.image = UIImage.gifImageWithName("Darkrai Shiny")
            }
        }
    }

    @IBAction func setEncounterNumber(_ sender: UIButton) {
        let alert = UIAlertController(title: "What number would you like to set the counter to?", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter a whole number"
            self.encounterTextField = textField
        }
        
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: {action in
            let count = Int(self.encounterTextField?.text ?? "")
            if(self.encounterTextField?.text != ""){
                if(count! > 999999){
                    self.Counter.text = String(999999)
                }
                else{
                    self.Counter.text = self.encounterTextField?.text
                }
                UserDefaults.standard.set(self.Counter.text, forKey: "count")
                self.calculateOdds()
            }
        })
        
        alert.addAction(doneAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeOddsFormat(_ sender: UIButton) {
        if(decimalFormat == false){
            decimalFormat = true
            calculateOdds()
            sender.setTitle("1/N", for: .normal)
        }
        else{
            decimalFormat = false
            calculateOdds()
            sender.setTitle("%", for: .normal)
        }
    }
    
    @IBAction func changeOdds(_ sender: UIBarButtonItem) {
        let optionSheet = UIAlertController(title: "Choose a hunting method", message: nil, preferredStyle: .actionSheet)
        
        if chosenMethod != "Full Odds"{
            let fullOddsOption = UIAlertAction(title: "Full Odds", style: .default, handler: {action in
                self.chosenMethod = "Full Odds"
                UserDefaults.standard.set(self.chosenMethod, forKey: "method")
                self.calculateOdds()
            })
            optionSheet.addAction(fullOddsOption)
        }
        if chosenMethod != "Chain Fishing"{
            let chainFishOption = UIAlertAction(title: "Chain Fishing", style: .default, handler: {action in
                self.chosenMethod = "Chain Fishing"
                UserDefaults.standard.set(self.chosenMethod, forKey: "method")
                self.calculateOdds()
            })
            optionSheet.addAction(chainFishOption)
        }
        if chosenMethod != "S.O.S."{
            let sosOption = UIAlertAction(title: "S.O.S.", style: .default, handler: {action in
                self.chosenMethod = "S.O.S."
                UserDefaults.standard.set(self.chosenMethod, forKey: "method")
                self.calculateOdds()
            })
            optionSheet.addAction(sosOption)
        }
        if chosenMethod != "DexNav"{
            let dexnavOption = UIAlertAction(title: "DexNav", style: .default, handler: {action in
                self.chosenMethod = "DexNav"
                UserDefaults.standard.set(self.chosenMethod, forKey: "method")
                self.calculateOdds()
            })
            optionSheet.addAction(dexnavOption)
        }
        if chosenMethod != "Masuda"{
            let masudaOption = UIAlertAction(title: "Masuda Method", style: .default, handler: {action in
                self.chosenMethod = "Masuda"
                UserDefaults.standard.set(self.chosenMethod, forKey: "method")
                self.calculateOdds()
            })
            optionSheet.addAction(masudaOption)
        }
        if chosenMethod != "Horde"{
            let hordeOption = UIAlertAction(title: "Horde Hunting", style: .default, handler: {action in
                self.chosenMethod = "Horde"
                UserDefaults.standard.set(self.chosenMethod, forKey: "method")
                self.calculateOdds()
            })
            optionSheet.addAction(hordeOption)
        }
        if chosenMethod != "PokeRadar"{
            let pokeRadarOption = UIAlertAction(title: "PokeRadar", style: .default, handler: {action in
                self.chosenMethod = "PokeRadar"
                UserDefaults.standard.set(self.chosenMethod, forKey: "method")
                self.calculateOdds()
            })
            optionSheet.addAction(pokeRadarOption)
        }
        let cancelOption = UIAlertAction(title: "Cancel", style: .cancel)
        optionSheet.addAction(cancelOption)
        
        self.present(optionSheet, animated: true, completion: nil)
        
        print(chosenMethod)
    }
    
    func calculateOdds(){
        let count = Double(Counter.text!)
        
        if(chosenMethod == "Full Odds"){
            if(chosenGame == "Red" || chosenGame == "Blue" || chosenGame == "Green" || chosenGame == "Yellow" || chosenGame == "Gold" || chosenGame == "Silver" || chosenGame == "Crystal" || chosenGame == "Ruby" || chosenGame == "Sapphire" || chosenGame == "Emerald" || chosenGame == "FireRed" || chosenGame == "LeafGreen" || chosenGame == "Diamond" || chosenGame == "Pearl" || chosenGame == "Platinum" || chosenGame == "HeartGold" || chosenGame == "SoulSilver"){
                maxOdds = 8192
                chance = 100.0/8192.0
            }
            else{
                maxOdds = 4096
                chance = 100.0/4096.0
            }
        }
        else if(chosenMethod == "Chain Fishing"){
            if(count! <= 20.0){
                chance = (1.0 + (count! * 2.0))/4096.0
                maxOdds = Int(round(4096.0/(1.0 + (count! * 2.0))))
                chance = 100.0 * chance
            }
            else{
                maxOdds = Int(round(4096.0/41.0))
                chance = 4100.0/4096.0
            }
        }
        else if(chosenMethod == "S.O.S."){
            if(count! <= 10){
                maxOdds = 4096
                chance = 100.0/4096.0
            }
            else if(count! <= 20){
                maxOdds = 820
                chance = 100.0/820.0
            }
            else if(count! <= 30){
                maxOdds = 455
                chance = 100.0/455.0
            }
            else{
                maxOdds = 315
                chance = 100.0/315.0
            }
        }
        else if(chosenMethod == "DexNav"){
            //4% chance per encounter that n+=4
            //n+=5 on 50th chained encounter
            //n+=10 on 100th chained encounter
            var searchLevel = count!
            //level = 33
            var minValue = 0.0
            if(searchLevel > 200){
                searchLevel = 100
                minValue += (searchLevel - 200.0)
            }
            if(searchLevel > 100){
                searchLevel = 100
                minValue += (searchLevel * 2.0) - 200.0
            }
            if(searchLevel > 0){
                minValue += (searchLevel * 6.0)
            }
            minValue = minValue * 0.01
            let lowestInt = round(minValue)
            print("Lowest Integer = \(lowestInt) and was \(minValue)")
            let dexChance = Double(lowestInt)/10000.0
            let normChance = 100.0/4096.0
            let nChance = (4.0/100.0) * (dexChance * 4)
            var n = 0.0
            if(count! == 50){
                n += 5.0
            }
            else if(count! == 100){
                n += 10.0
            }
            let countChance = dexChance * n
            chance = countChance + nChance + normChance
            maxOdds = 4096
            
            //4% chance that dexChance*4 is run
        }
        else if(chosenMethod == "Masuda"){
            if(chosenGame == "X" || chosenGame == "Y" || chosenGame == "Omega Ruby" || chosenGame == "Alpha Sapphire" || chosenGame == "Sun" || chosenGame == "Moon" || chosenGame == "Ultra Sun" || chosenGame == "Ultra Moon" || chosenGame == "Lets go Pikachu!" || chosenGame == "Lets go Eevee!"){
                maxOdds = 683
                chance = 600.0/4096.0
            }
            else{
                maxOdds = 819
                chance = 500.0/4096.0
            }
        }
        else if(chosenMethod == "Horde"){
            maxOdds = 819
            chance = 500.0/4096.0
        }
        else if(chosenMethod == "PokeRadar"){
            if(count! <= 40){
                maxOdds = Int(65536/(65535.0/(8200.0 - (200.0 * count!))))
                chance = 100.0 * ((65535.0/(8200.0 - (200.0 * count!)))/65536.0)
            }
            else{
                maxOdds = 200
                chance = 32767.5/65536.0
            }
        }
        //print(chance)
        if(decimalFormat){
            let odds = String(format: "%.4f", chance)
            oddsLabel.text = "\(odds)%"
        }
        else{
            oddsLabel.text = "1/\(maxOdds)"
        }
    }

    @IBAction func Minus(_ sender: UIButton) {
        var num = Int(Counter.text!)
        if(num! > 0){
            num! -= 1
            Counter.text = String(num!)
        }
        UserDefaults.standard.set(self.Counter.text, forKey: "count")
        calculateOdds()
    }
    
    @IBAction func Plus(_ sender: UIButton) {
        var num = Int(Counter.text!)
        if(num == 999999){
            return
        }
        num! += 1
        Counter.text = String(num!)
        UserDefaults.standard.set(self.Counter.text, forKey: "count")
        calculateOdds()
    }
    
    @IBAction func Reset(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure you want to restart this counter?", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let understandAction = UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.Counter.text = String(0)
            UserDefaults.standard.set(self.Counter.text, forKey: "count")
            self.calculateOdds()
        })
        alert.addAction(understandAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Success(_ sender: UIButton) {
        let alert = UIAlertController(title: "Congratulations! Your total encounters was \(Counter.text!).", message: nil, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Awesome!", style: .default, handler: {action in
            self.Counter.text = String(0)
            self.performSegue(withIdentifier: "toMenu", sender: nil)
        })
        alert.addAction(continueAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func returnToMenu(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Returning to the menu will erase this counter. Are you sure you want to return to the menu?", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let understandAction = UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.Counter.text = String(0)
            UserDefaults.standard.set(self.Counter.text, forKey: "count")
            self.performSegue(withIdentifier: "toMenu", sender: nil)
        })
        alert.addAction(understandAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func quitApp(_ sender: UIBarButtonItem) {
        exit(0)
    }
}
