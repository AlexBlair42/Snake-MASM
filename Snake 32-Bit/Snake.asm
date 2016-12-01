TITLE   Snake   (Snake.asm)
INCLUDE Irvine32.inc

; Last update: 11/29/16

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This program: 
;Simulates the game of Snake. 
;The snake will move via user input as well as it shall eat and grow according to food eaten.
; Then the game will end if the snake collides with a wall, or if the snake collides with itself.
;Also the next level will start if the snake finishes all of its food. 
;Lastly the user may end the game by pressing the escape key.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.data

msg BYTE "Welcome to the Snake!", 0                                                                    ; This will be the welcome message
Instruct_msg BYTE "Use the arrow keys to move the snake in the corosponding direction.", 0             ; This will be the instructions to the user on how to play
EndInstruct_msg BYTE "To end the game either hit something (Wall or yourself) or press Esc.", 0        ; This will be the conditions of how to end the game
EndMsg BYTE "Thank You for playing Snake!", 0                                                          ; This will be the game over message
ScoreMsg BYTE "Score: ", 0                                                                             ; This will display the score


.code
main PROC




	exit
main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CreateSnake PROC
; This procedure will genereate a Snake 


ret
CreateSnake ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CreateGrid PROC
; This procedure will generate the grid system in which the game is played


ret
CreateGrid ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SnakeMovement PROC
; This procedure will take user input and interpret it 
; Into snake movement

ret
SnakeMovement ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ScoreDisp PROC
; This procedure will display the user's score

ret
ScoreDisp ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FoodRand PROC
; This procedure will randomize and display the food for the snake

ret
FoodRand ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



END main