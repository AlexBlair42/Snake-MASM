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

;;;;;;;;;;;;;;;;;;;;;;; These are the Snake elements
x_head BYTE ?         ; X coordinate of the head of the snake
y_head BYTE ?         ; Y coordinate of the head of the snake
head BYTE 2H          ; Character for the head of the snake
segment BYTE "#"      ; Character for snake segments

x_food BYTE ?         ; X coordinate for the food
y_food BYTE ?         ; Y coordinate for the food
foodeaten BYTE 0      ; Amount of food eaten
Food BYTE "a"         ; Character for the food

x_tail BYTE ?         ; Holds the x coordinate for the tail of the snake
y_tail BYTE ?         ; Holds the y coordinate for the tail of the snake

Segments_X BYTE 800 DUP(0)  ; Array for the X coordinate of the segments
Segments_Y BYTE 800 DUP(0)  ; Array for the Y coordinate of the segments

speed WORD 90         ; Holds the speed of the game

direction BYTE 0      ; Holds Direction
oldDirect BYTE 0      ; Holds the old direction



.code
main PROC
call Randomize
call Clrscr
SG:

call Snake
push SnakeArr

call Crlf

FL:
call FoodRand
je FL
call Crlf
	exit
main ENDP


COORD STRUCT

x WORD ?        ; x Coordinate

y WORD ?        ; y Coordinate

COORD ENDS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Snake STRUCT
; This procedure will genereate a Snake 

mov dl, SnakeX
mov dh, SnakeY

call Gotoxy

mov edx, OFFSET SnakeArr
mov ax, SizeOf SnakeArr                           ; This will set the Ax register to be incremented during the loop 
mov ecx, 15                                      ; This will set the ECX register to be decremented while looping
         
call WriteString

inc ax


ret
Snake ENDS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SnakeMovement PROC USES eax edx
; This procedure will take user input and interpret it 
; Into snake movement

mov direction, ah
call GamesSpeed
mov ax, speed
movzx eax, ax           ; This delays motion
call Delay
mov dl, 0
mov dh, 9
call Gotoxy
mov ax, speed
movzx eax, ax
call WriteInt          ; This is the speed of the game

mov dl, x_head
mov dh, y_head
call Gotoxy

mov al, ' '
call WriteChar
call EatFood
mov ah, direction     ; This passes the new direction to ah
mov al, oldDirect     ; This passes the old direction to al

cmp dl, 64
jge GameOver

cmp dl, 14
jle GameOver

cmp dh, 21
jge GameOver

cmp dh, 4
jle GameOver

cmp ah, 48H
je Up

cmp ah, 50H
je Down

cmp ah, 4DH
je Right

cmp ah, 4BH
je Left

cmp ah, 49H
je UpRight

cmp ah, 47H
je UpLeft

cmp ah, 51H
je DownRight

cmp ah, 4FH
je DownLeft

jmp Finish


Up:
mov oldDirect, 48H
cmp al, 50H
je Down
dec dh
jmp UpdateHead

Down:
mov oldDirect, 50H
cmp al, 48H
je Up
inc dh
jmp UpdateHead

Right:
mov oldDirect, 4DH
cmp al, 4BH
je Left
inc dl
jmp UpdateHead

Left:
mov oldDirect, 4BH
cmp al, 4DH
je Right
dec dl
jmp UpdateHead
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; This is where I left off

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

call Random32

mov dh, ah

call Random32

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