TITLE   Snake   (Snake.asm)
INCLUDE Irvine32.inc

; Last update: 12/8/16

; Alex Blair
; Mckenna Galle
; Julia Abbott
; Eben Schumann

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This program: 
;Simulates the game of Snake. 
;The snake will move via user input as well as it shall eat and grow according to food eaten.
; Then the game will end if the snake collides with a wall, or if the snake collides with itself.
;Also the next level will start if the snake finishes all of its food. 
;Lastly the user may end the game by pressing the escape key.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



.data

;;;;;;;;;;;;;;;;;;;;;;;
; These are strings to be printed to the console

; Strings

WelcMsg BYTE " Welcome to Snake! Press an Arrow Key to start. :) ", 0
GameoverST BYTE " Game Over! ",0
ScoreDispST BYTE " Your Score Is: ",0
SpeedDisp BYTE " Game Speed is: ",0

;;;;;;;;;;;;;;;;;;;;;;; These are the Snake elements
x_head BYTE ?         ; X coordinate of the head of the snake
y_head BYTE ?         ; Y coordinate of the head of the snake
head BYTE 2H          ; Character for the head of the snake
part BYTE "0"       ; Character for snake segments

x_food BYTE ?         ; X coordinate for the food
y_food BYTE ?         ; Y coordinate for the food
foodeaten BYTE 0      ; Amount of food eaten
Food BYTE "*"         ; Character for the food

x_tail BYTE ?         ; Holds the x coordinate for the tail of the snake
y_tail BYTE ?         ; Holds the y coordinate for the tail of the snake

Segments_X BYTE 800 DUP(0)  ; Array for the X coordinate of the segments
Segments_Y BYTE 800 DUP(0)  ; Array for the Y coordinate of the segments

NumOfSegments DWORD 0    ; This is for the number of segments of the snake

score DWORD 0
speed WORD 90         ; Holds the speed of the game

direction BYTE 0      ; Holds Direction
oldDirect BYTE 0      ; Holds the old direction

Sides1 BYTE " ------------------------------------------------------------------------ " , 0
Sides2 BYTE " |                                                                      | " , 0



.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main PROC
call Clrscr             ; Clears the screen first

mov dl, 14
mov dh, 1
call Gotoxy
mov edx, OFFSET WelcMsg                   ; Displays the welcome message
call WriteString
call Crlf
call Crlf



mov dl, 14
mov dh, 2
call Gotoxy
mov edx, OFFSET SpeedDisp                 ; Displays the current speed that the snake is moving
call WriteString
call Crlf


mov dl, 14
mov dh, 4
call Gotoxy
mov edx, OFFSET Sides1                    ; Generates the top and bottom of the game bored
call WriteString
mov ah, 20

Sides:
mov dl, 14
mov dh, ah
call Gotoxy
dec ah
mov edx, OFFSET Sides2                    ; Generates the sides of the game bored
call WriteString
cmp ah, 4
jg Sides
mov dl, 14
mov dh, 21
call Gotoxy
mov edx, OFFSET Sides1
call WriteString

RandomX:
Call Randomize
mov eax, 64
call RandomRange
cmp al, 15
jl RandomX
mov x_head, al
mov  esi, OFFSET Segments_X               ; Generates a random value for the x coordinates of the head of the snake
mov [esi], al
mov dl, al

RandomY:
mov eax, 19
call RandomRange
cmp al, 5
jl RandomY
mov y_head, al
mov esi, OFFSET Segments_Y                ; Generates a random y coordinate for the head of the snake
mov [esi], al
mov dh, al
call Gotoxy
mov al, head
call WriteChar

Start:                                     ; Conditions for starting the game
call Collide                               ; Checks for collisions
call ReadKey                               ; Takes user input with the arrow keys
jz SameDirect
cmp ah, 51H
jg Start
cmp ah, 47H
jl Start
cmp ah, 4CH
je Start
call SnakeMovement
call SetGame
call PrintSegments
jmp Start

SameDirect:
mov ah, direction
cmp ax, 0001H
je Start
call SnakeMovement
call SetGame
call PrintSegments
jmp Start
main ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SnakeMovement PROC USES eax edx
; This procedure will take user input and interpret it 
; Into snake movement

mov direction, ah
call GameSpeed
mov ax, speed
movzx eax, ax           ; This delays motion
call Delay
mov dl, 30
mov dh, 2
call Gotoxy
mov ax, speed
movzx eax, ax
call WriteInt          ; This is the speed of the game

mov dl, x_head
mov dh, y_head
call Gotoxy

mov al, ' '
call WriteChar
call FoodEat
mov ah, direction     ; This passes the new direction to ah
mov al, oldDirect     ; This passes the old direction to al

cmp dl, 64                          ; Checks for invalid movements
jge GameOver                        ; Checks foor Game Over conditions being met

cmp dl, 14
jle GameOver

cmp dh, 21
jge GameOver

cmp dh, 4                            ; Checks for Game Over conditions being met
jle GameOver

cmp ah, 48H                          ; Checks for necessayr UP direction
je Up

cmp ah, 50H                          ; Checks down
je Down

cmp ah, 4DH                          ; Checks Right
je Right

cmp ah, 4BH
je Left                              ; Checks Left

cmp ah, 49H
je UpRight                           ; Checks UpRight

cmp ah, 47H
je UpLeft                            ; Checks UpLeft

cmp ah, 51H
je DownRight                         ; Checks DownRight

cmp ah, 4FH
je DownLeft                          ; Checks DownLeft

jmp Finish                           ; End of checks


Up:                                 ; Up movement
mov oldDirect, 48H
cmp al, 50H
je Down
dec dh
jmp UpdateHead

Down:                                ; Down movement
mov oldDirect, 50H
cmp al, 48H
je Up
inc dh
jmp UpdateHead

Right:                               ; Right movement
mov oldDirect, 4DH
cmp al, 4BH
je Left
inc dl
jmp UpdateHead

Left:                               ; Left movement
mov oldDirect, 4BH
cmp al, 4DH
je Right
dec dl
jmp UpdateHead

UpRight:                             ; Up and right movement
mov oldDirect, 49H
cmp al, 4H
je DownLeft
dec dh
inc dl
jmp UpdateHead

UpLeft:                               ; Up and left movement
mov oldDirect, 47H
cmp al, 51H
je DownRight
dec dh
dec dl
jmp UpdateHead

DownRight:                            ; Down and right movement
mov oldDirect, 51H
cmp al, 47H
je UpLeft
inc dh
inc dl
jmp UpdateHead

DownLeft:                             ; Down and left movement
mov oldDirect, 4FH
cmp al, 49H
je UpRight
inc dh
dec dl

UpdateHead:                           ; Updates the head of the snake as it relates to its position
mov x_head, dl
mov y_head, dh
call Gotoxy
mov al, head
call WriteChar

Finish:

ret

GameOver:                             ; Conditions for Game Over
mov dl, x_head
mov dh, y_head
call Gotoxy
mov al, head
call WriteChar
mov eax, 1000
call Delay
mov dl, 45
mov dh, 13
call Gotoxy
mov edx, OFFSET GameoverST
call WriteString
mov dl, 20
mov dh, 24
call Gotoxy
exit
SnakeMovement ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FoodEat PROC USES eax edx
; This procedure will randomize and display the food for the snake

NewFood:                       ; Checks if there is already food.
mov al, foodeaten
cmp al, 0
jne NotEaten

RandomX:                        ; Random X for food
mov foodeaten, 1
mov eax, 64
call RandomRange
cmp al, 15
jl RandomX
mov x_food, al
mov dl, al

RandomY:                         ; Random Y for Food
mov eax, 18
call RandomRange
cmp al, 5
jl RandomY
mov y_food, al
mov dh, al
call Gotoxy
mov al, food
call WriteChar
mov al, dl

NotEaten:                        ; Checks if the food that has been eaten
mov al, x_head
mov ah, y_head
mov dl, x_food
mov dh, y_food
cmp ax, dx
jne Finish
mov eax, NumOfSegments
inc eax
mov NumOfSegments, eax
mov foodeaten, 0
call PrintSegments
call ScoreDisp
mov dl, 30
mov dh, 23
call Gotoxy
mov edx, OFFSET ScoreDispST
call WriteString
mov eax, score
call WriteInt
jmp Finish
Finish:

ret
FoodEat ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Snake PROC USES eax ebx ecx esi
; This procedure will genereate a Snake 
mov ebx, NumOfSegments
cmp ebx, 1
jge Continue
mov esi, OFFSET Segments_X
mov al, x_head
mov [esi], al
mov al, [esi]
mov esi, OFFSET Segments_Y
mov al, y_head
mov [esi], al
mov al,[esi]
jmp Finish

Continue:
mov al, foodeaten
movzx eax, al
cmp al, 0
jne NotEaten

Eaten:                                           ; Generates a segment if food is eaten
mov ecx, NumOfSegments
inc ecx

ShiftRight:                                      ; Shifts the head right to append segment
mov ebx, ecx
mov esi, OFFSET Segments_X
mov al, [esi+ebx-1]
mov [esi+ebx], al
mov esi, OFFSET Segments_Y
mov al, [esi+ebx-1]
mov [esi+ebx], al

Loop ShiftRight

mov esi, OFFSET Segments_X
mov al, x_food
mov [esi], al
mov esi, OFFSET Segments_Y
mov al, y_food
mov [esi], al

NotEaten:

call SetGame
call PrintSegments

Finish:

ret
Snake ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SetGame PROC
; This procedure sets up the starting conditions of the game

mov esi, OFFSET Segments_X
mov al, [esi]
mov x_tail, al
mov esi, OFFSET Segments_Y
mov al, [esi]
mov y_tail, al
mov ebx, 1
mov ecx, NumOfSegments
inc ecx

ShiftLeft:
mov esi, OFFSET Segments_X
mov al, [esi+ebx]
mov [esi+ebx-1],al
mov esi, OFFSET Segments_Y
mov al, [esi+ebx]
mov [esi+ebx-1], al
mov al, [esi]
inc ebx

Loop ShiftLeft

mov ebx, NumOfSegments
mov esi, OFFSET Segments_X
mov al, x_head
mov[esi+ebx], al
mov al, [esi]
mov esi, OFFSET Segments_Y
mov al, y_head
mov [esi+ebx], al

ret
SetGame ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PrintSegments PROC USES eax ebx ecx edx esi
; This project prints segments that need to be appended to the end of the snake

mov dl, x_tail                 
mov dh, y_tail
                                         ; Finds the location of the tail of the snake
call Gotoxy

mov al, ' '

call WriteChar
mov ecx, NumOfSegments
inc ecx

Print:                                    ; Print a new segment if the food has been eaten
mov ebx, ecx
mov esi, OFFSET Segments_X
mov al, [esi+ebx-1]
mov dl, al
mov esi, OFFSET Segments_Y
mov al, [esi+ebx-1]
mov dh, al
call Gotoxy
mov edx, NumOfSegments
inc edx
cmp ecx, edx
jne PrintSeg
mov al, head
jmp Printtail

PrintSeg:
mov al, part

Printtail:
call WriteChar

Loop Print                                  ; Loops for continuous printing of segments.

ret
PrintSegments ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ScoreDisp PROC
; This procedure will display the user's score

mov eax, score
add eax, 1                                      ; Displays the score that the user has. The score is the pieces of food eaten
mov score, eax

ret
ScoreDisp ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GameSpeed PROC USES eax ebx edx
; This is the quantified game speed. 

mov edx, 0
mov eax, score
mov ebx, 10
div ebx
cmp edx, 1
jne Finish
mov ax, speed                              ; Sets a speed for the game and the snake
mov bx, 10
sub ax, bx
mov speed, ax
mov eax, score
add eax, 1
mov score, eax

Finish:

ret
GameSpeed ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Collide PROC USES eax ebx ecx edx esi
; Tests for collisions

	mov ecx, NumOfSegments		
	cmp ecx, 3
	jle Finish		
	inc ecx
Collision:                                                 ; This tests for a collision with a wall or the snake itself					
	mov ebx, ecx	
	mov esi, OFFSET Segments_X		
	mov al, [esi+ebx-2]
	mov dl, al
	mov esi, OFFSET Segments_Y		
	mov al, [esi+ebx-2]
	mov dh, al			
	mov al, x_head
	mov ah, y_head			
	cmp dx, ax
	je Lengthh			
	jmp Endd
Lengthh:				                                  ; Checks the length of the snake 
	mov edx, NumOfSegments
	inc edx				
	cmp ecx, edx
	je Endd
EndOfGame:                                                 ; Sets conditions for ending the game
	mov dl, x_head			
	mov dh, y_head
	call Gotoxy			
	mov al, head
	call WriteChar
	mov dl, 33
	mov dh, 13			
	call Gotoxy
	mov edx, OFFSET GameOverST                             ; Displays Game Over Message
	call WriteString
	mov dl, 20			
	mov dh, 24
	call Gotoxy			
	mov eax, 1500
	call Delay
	exit
Endd:
	Loop Collision
Finish:

ret
Collide ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


exit
END main