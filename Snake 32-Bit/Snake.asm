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
rows BYTE ?
cols BYTE ?

.code
main PROC


call GetMaxXY
mov rows, al
mov cols, dl




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

END main