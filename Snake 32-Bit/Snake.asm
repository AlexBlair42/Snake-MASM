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

NumOfSegments DWORD 0

score DWORD 0
speed WORD 90         ; Holds the speed of the game

direction BYTE 0      ; Holds Direction
oldDirect BYTE 0      ; Holds the old direction

Sides1 BYTE " ------------------------------------------------------------------------ " , 0
Sides2 BYTE " |                                                                      | " , 0



.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main PROC
call Clrscr

mov dl, 14
mov dh, 1
call Gotoxy
mov edx, OFFSET WelcMsg
call WriteString
call Crlf
call Crlf



mov dl, 14
mov dh, 2
call Gotoxy
mov edx, OFFSET SpeedDisp
call WriteString
call Crlf


mov dl, 14
mov dh, 4
call Gotoxy
mov edx, OFFSET Sides1
call WriteString
mov ah, 20

Sides:
mov dl, 14
mov dh, ah
call Gotoxy
dec ah
mov edx, OFFSET Sides2
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
mov  esi, OFFSET Segments_X
mov [esi], al
mov dl, al

RandomY:
mov eax, 19
call RandomRange
cmp al, 5
jl RandomY
mov y_head, al
mov esi, OFFSET Segments_Y
mov [esi], al
mov dh, al
call Gotoxy
mov al, head
call WriteChar

Start:
call Collide
call ReadKey
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

UpRight:
mov oldDirect, 49H
cmp al, 4H
je DownLeft
dec dh
inc dl
jmp UpdateHead

UpLeft:
mov oldDirect, 47H
cmp al, 51H
je DownRight
dec dh
dec dl
jmp UpdateHead

DownRight:
mov oldDirect, 51H
cmp al, 47H
je UpLeft
inc dh
inc dl
jmp UpdateHead

DownLeft:
mov oldDirect, 4FH
cmp al, 49H
je UpRight
inc dh
dec dl

UpdateHead:
mov x_head, dl
mov y_head, dh
call Gotoxy
mov al, head
call WriteChar

Finish:

ret

GameOver:
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

NewFood:
mov al, foodeaten
cmp al, 0
jne NotEaten

RandomX:
mov foodeaten, 1
mov eax, 64
call RandomRange
cmp al, 15
jl RandomX
mov x_food, al
mov dl, al

RandomY:
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

NotEaten:
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

Eaten:
mov ecx, NumOfSegments
inc ecx

ShiftRight:
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

mov dl, x_tail
mov dh, y_tail

call Gotoxy

mov al, ' '

call WriteChar
mov ecx, NumOfSegments
inc ecx

Print:
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

Loop Print

ret
PrintSegments ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ScoreDisp PROC
; This procedure will display the user's score

mov eax, score
add eax, 1
mov score, eax

ret
ScoreDisp ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GameSpeed PROC USES eax ebx edx

mov edx, 0
mov eax, score
mov ebx, 10
div ebx
cmp edx, 1
jne Finish
mov ax, speed
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
	mov ecx, NumOfSegments		
	cmp ecx, 3
	jle Finish		
	inc ecx
Collision:					
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
Lengthh:				
	mov edx, NumOfSegments
	inc edx				
	cmp ecx, edx
	je Endd
EndOfGame:
	mov dl, x_head			
	mov dh, y_head
	call Gotoxy			
	mov al, head
	call WriteChar
	mov dl, 33
	mov dh, 13			
	call Gotoxy
	mov edx, OFFSET GameOverST
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