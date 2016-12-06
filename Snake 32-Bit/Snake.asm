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

SnakeArr WORD  1 (218)                                           ; Array to create snake
FoodArr WORD 1 (249)
x BYTE 0
y BYTE 0
.code
main PROC

;call Randomize

call Clrscr

call CreateSnake

call Crlf

call FoodRand

call Crlf

;call CreateGrid
	exit
main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CreateSnake PROC
; This procedure will genereate a Snake 

mov edx, OFFSET SnakeArr
mov ax, SizeOf SnakeArr                           ; This will set the Ax register to be incremented during the loop 
mov ecx, 30                                       ; This will set the ECX register to be decremented while looping

;SL:
              
call WriteString

inc ax

;loop SL


ret
CreateSnake ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CreateGrid PROC
; This procedure will generate the grid system in which the game is played

call GetMaxXY

movzx ax, x
call WriteInt
movzx dx, y
mov ax, dx
call WriteInt

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

mov dh, 10
mov dl, 20

call Gotoxy

mov edx, OFFSET FoodArr
call WriteString

ret
FoodRand ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



END main