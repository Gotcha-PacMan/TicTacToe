//
//  MenuViewController.swift
//  Text-TTT game
//
//  Created by Warat T on 2022-12-10.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// Player vs bot/ai menu
class OnePlayerMenuViewController: UIViewController {

    @IBOutlet weak var playerOne: UITextField!
    @IBOutlet weak var playerTwo: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }


}

// Player vs bot/ai
class OnePlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }


}

// Player vs player
class TwoPlayerViewController: UIViewController {
    
    // This functions turns "turn" to cross or nought for whos turn it is.
    enum Turn {
        case Nought
        case Cross
    }

    //Shows whos turn it is
    @IBOutlet weak var turnLabel: UILabel!
    
    // Input for first line
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    // Input for second line
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    // Input for third line
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    // Check for who turn it is and randomize turns everytime a turn ends
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross

    // Array of buttons
    var board = [UIButton]()
    
    // Symbols for characters
    var Nought = "O"
    var Cross = "X"
    
    // Starting scores and this builds up overtime (as long as you keep playing).
    var noughtScore = 0
    var crossesScore = 0
    
    // Runs the functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBoard()
        
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        
        board.append(b1)
        board.append(b2)
        board.append(b3)
        
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    // This function runs whenever the screen is being tapped on, with what said the boxes on the board.
    @IBAction func boardTapAction(_ sender: UIButton) {
        
        addToBoard(sender)
        
        // Checking if crosses have won the game, if yes then give score + 1 and title Crosses Wins!
        if checkForVictory(Cross){
            crossesScore += 1
            resultAlert(title: "Crosses Wins!")
        }
        
        // Checking if nought have won the game, if yes then give score + 1 and title Noughts Wins!
        if checkForVictory(Nought){
            noughtScore += 1
            resultAlert(title: "Noughts Wins!")
        }
        
        // Checking if no box left then it's a draw and no points given.
        if (fullBoard()){
            resultAlert(title: "Draw")
        }
        
    }
    
    func checkForVictory(_ s : String) ->Bool {
        
        // Checking for HORIZONTAL wins
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s){
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s){
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s){
            return true
        }
        
        // Checking for VERTICAL wins
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s){
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s){
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s){
            return true
        }
        
        // Checking for DIAGONAL wins
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s){
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s){
            return true
        }
        
        
        return false
    }
    
    func thisSymbol(_ button : UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    // Popup message that shows scores and have restart button.
    func resultAlert(title: String) {
        // Message that holds scores and tells who has which score.
        let message = "\nNoughts " + String(noughtScore) + "\nCrosses " + String(crossesScore)
        // Alert controller
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        // Clickable reset button added in the alert.
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        //Present the alert.
        self.present(ac, animated: true)
    }
    
    // Reset the board
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if (firstTurn == Turn.Nought)
        {
            
            firstTurn = Turn.Cross
            turnLabel.text = Cross
            
        } else if (firstTurn == Turn.Cross) {
            
            firstTurn = Turn.Nought
            turnLabel.text = Nought
        }
        
        currentTurn = firstTurn
    }
    
    
    func fullBoard() -> Bool {
        
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    // Adds nought and crosses to the board functions.
    func addToBoard (_ sender: UIButton){
        
        // Check if box is not occupied by another character
        if(sender.title( for: .normal ) == nil) {
            
            // Current turn Nought, after Cross
            if(currentTurn == Turn.Nought){
                sender.setTitle(Nought, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = Cross
            }
            
            // Current turn Cross, after Nought
            else if(currentTurn == Turn.Cross){
                sender.setTitle(Cross, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = Nought
            }
            
            // Remove the animation when trying to override a cross or a nought
            sender.isEnabled = false
        }
    }

    
}





