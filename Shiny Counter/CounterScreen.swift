//
//  ViewController.swift
//  Shiny Counter
//
//  Created by The Real Kaiser on 8/21/18.
//  Copyright © 2018 William Donnelly. All rights reserved.
//

import UIKit

class CounterScreen: UIViewController {

    @IBOutlet weak var Counter: UILabel!
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var shinyImage: UIImageView!
    
    var chosenPokemon = ""
    var chosenGame = ""
    var alolan = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let pokemon = UserDefaults.standard.string(forKey: "pokemon")
        UserDefaults.standard.set(chosenPokemon, forKey: "pokemon")
        let alola = UserDefaults.standard.bool(forKey: "alola")
        UserDefaults.standard.set(alolan, forKey: "alola")
        let count = UserDefaults.standard.integer(forKey: "count")
        Counter.text = String(count)
        */
        
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
    func calculateOdds(){
        var chance = 0.0
        /*let game = UserDefaults.standard.string(forKey: "game")
        UserDefaults.standard.set(chosenGame, forKey: "game")
        print(chosenGame)
        print(game!)
        */
 
        if(chosenGame == "Red" || chosenGame == "Blue" || chosenGame == "Green" || chosenGame == "Yellow" || chosenGame == "Gold" || chosenGame == "Silver" || chosenGame == "Crystal" || chosenGame == "Ruby" || chosenGame == "Sapphire" || chosenGame == "Emerald" || chosenGame == "FireRed" || chosenGame == "LeafGreen" || chosenGame == "Diamond" || chosenGame == "Pearl" || chosenGame == "Platinum" || chosenGame == "HeartGold" || chosenGame == "SoulSilver"){
            chance = 100.0/8192.0
        }
        else{
            chance = 100.0/4096.0
        }
        //print(chance)
        let odds = String(format: "%.4f", chance)
        oddsLabel.text = "\(odds)%"
    }
    
    /*public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
    public enum DispatchLevel {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }*/

    @IBAction func Minus(_ sender: UIButton) {
        var num = Int(Counter.text!)
        if(num! > 0){
            num! -= 1
            Counter.text = String(num!)
        }
        //UserDefaults.standard.set(num, forKey: "count")
    }
    @IBAction func Plus(_ sender: UIButton) {
        var num = Int(Counter.text!)
        num! += 1
        Counter.text = String(num!)
        //UserDefaults.standard.set(num, forKey: "count")
    }
    
    /*@IBAction func longPlus(_ sender: UILongPressGestureRecognizer) {
        //sender.minimumPressDuration = 2
        var num = Int(Counter.text!)
        if(sender.state != .ended){
            //delay(bySeconds: 0.1){
            num! += 1
            //}
        /*}
        else{
            num! += 1
        }*/
            Counter.text = String(num!)
        }
    }*/
    
    @IBAction func Reset(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure you want to restart this counter?", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let understandAction = UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.Counter.text = String(0)
            //UserDefaults.standard.set(0, forKey: "count")

        })
        alert.addAction(understandAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func Success(_ sender: UIButton) {
        /*if let text: String = Counter.text {
            Counter.text = text
        }
         */
        let alert = UIAlertController(title: "Congratulations! Your total encounters was \(Counter.text!).", message: nil, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Awesome!", style: .default, handler: {action in
            self.Counter.text = String(0)
            /*UserDefaults.standard.set("", forKey: "pokemon")
            UserDefaults.standard.set("", forKey: "game")
            UserDefaults.standard.set(false, forKey: "alola")
            UserDefaults.standard.set(0, forKey: "count")*/
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
            //UserDefaults.standard.set(0, forKey: "count")
            self.performSegue(withIdentifier: "toMenu", sender: nil)
        })
        alert.addAction(understandAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func quitApp(_ sender: UIBarButtonItem) {
        exit(0)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! Menu
        print("Moving back to Menu")
    }
    */
}

