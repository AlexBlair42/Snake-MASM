TITLE   Snake   (Snake.asm)
INCLUDE Irvine32.inc

; Last update: 12/8/16

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This program: 
;Simulates the game of Snake. 
;The snake will move via user input as well as it shall eat and grow according to food eaten.
; Then the game will end if the snake collides with a wall, or if the snake collides with itself.
;Also the next level will start if the snake finishes all of its food. 
;Lastly the user may end the game by pressing the escape key.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 218 is the character I want for the snake 
.data

RandomVal DWORD ?                                                ; Stores a random value
SnakeArr WORD  1 (218)                                           ; Array to create snake
FoodArr WORD 1 (249)                                             ; Array to create food

SnakeX BYTE 0                                                    ; This is the x coordinate for the snake
SnakeY BYTE 0                                                    ; This is the y coordinate for the snake

x BYTE 0
y BYTE 0

.code
main PROC
call Randomize
call Clrscr
call CreateSnake
call Crlf
FL:
call FoodRand
loop FL
call Crlf
	exit
main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CreateSnake PROC
; This procedure will genereate a Snake 

mov dl, SnakeX
mov dh, SnakeY

call Gotoxy

mov edx, OFFSET SnakeArr
mov ax, SizeOf SnakeArr                           ; This will set the Ax register to be incremented during the loop 
mov ecx, 30                                       ; This will set the ECX register to be decremented while looping
         
call WriteString

inc ax


ret
CreateSnake ENDP
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

mov eax, 51

call RandomRange

mov RandomVal, eax

mov dh, al
dec eax
call RandomRange

mov dl, al

call Gotoxy

mov edx, OFFSET FoodArr
call WriteString

ret
FoodRand ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UserInput PROC


ret
UserInput ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



END main