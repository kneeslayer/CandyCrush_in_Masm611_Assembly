.model large
.stack 100h
.data

msg1 db "C R U S H I N ",10,13,
        "                                  C A N D I E S $"
msg2 db "Enter you Name : $"
msg3 db "R U L E S $"
msg4 db "_________$"
msg5 db "Crushin Combo 1$"
msg6 db "DA BOMB$"
msg7 db "____________________________$"
msg8 db "Press Enter to Play !! $"
msg9 db   "Level 1$"
msg9_1 db   "Level 2$"
msg9_2 db   "Level 3$"
msg10 db "User   : $"
msg11 db "Target : $"
msg12 db "Moves  : $"
msg13 db "Score  : $"

grid db 2,1,3,4,7,1,5 ;level1
     db	4,6,1,5,2,3,1
     db	2,5,1,4,6,3,1
     db	4,1,6,3,2,4,7
     db	1,5,2,2,5,6,4
     db	7,4,7,4,3,3,6
     db	3,1,6,1,2,4,3

grid2 db 9,1,3,9,7,1,9 ;level2
      db 9,5,1,5,1,1,9
      db 2,5,1,4,6,3,1
      db 9,1,6,3,2,4,9
      db 1,5,6,2,2,6,4
      db 9,4,7,4,3,3,9
      db 9,1,6,9,2,4,9

grid3 db 2,1,6,9,7,1,2 ;level3
      db 4,6,1,9,2,2,1
      db 6,5,1,9,6,2,1
      db 9,9,9,9,9,9,9
      db 1,5,2,9,5,6,3
      db 7,1,5,9,3,3,6
      db 3,1,5,9,2,4,3

copy db 0,0,0,0,0,0,0
     db	0,0,0,0,0,0,0
     db	0,0,0,0,0,0,0
     db	0,0,0,0,0,0,0
     db	0,0,0,0,0,0,0
     db	0,0,0,0,0,0,0
     db	0,0,0,0,0,0,0

userName db 5 dup (?)

gridCount1 dw 0
gridCount2 dw 0

temp1 dw 0
temp2 dw 0
temp3 dw 0
temp4 dw 0
temp5 db 0
temp6 db 0
temp7 db 0

rows db 0
columns dw 0

target1 db "30$"
moves1 dw 10
level1score dw 0
score1 dw 0
score2 dw 0
score3 dw 0

turns dw 0
turns1 dw 10

tens db 0
units db 0
tens2 db 0
units2 db 0

characters dw 30,245,258,259,260,261,'B'
currentCharacter dw 0

gridx db 0
gridy db 0

xCoordinate dw 0
yCoordinate dw 0
mouseClicks dw 0

obj1X db 0
obj1Y db 0
obj2X db 0
obj2Y db 0

adjacencyBool db 0
vert_bool db 0
combo_bool db 0
candy1 db 0
candy2 db 0

currentLevel db 0

randNum db 0

counter1 dw 0 
spaceCount dw 0

.code 

main proc
    mov ax, @data
    mov ds, ax        

    call firstPage
    call rulesPage

    mov currentLevel,1
    call gamePage1
    cmp level1Score,30
    ja movetoLevel2

    ;call failed_screen
    ;mov dx,level1Score
    ;mov score1,dx
    ;jmp endgame

    movetoLevel2:
    mov dx,level1Score
    mov level1Score,0
    mov score1,dx
    mov currentLevel,2
    call gamePage2
    cmp level1Score,30
    ja movetoLevel3

    movetoLevel3:
    mov dx,level1Score
    mov level1Score,0
    mov currentLevel,3
    call gamePage3
    ;cmp score,30
    ;ja successScreen
    
    ;call failed_screen
    ;jmp endgame

    ;successScreen:
    ;call success_Screen
    endgame:

    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,1 ;-----row
    mov dh,25;-----col
    int 10h

    mov ah,4ch
    int 21h

main endp

firstPage proc

    ;mov ah,00h
    ;mov al, 13h
    ;int 10h

    mov ah,06h
    mov al,0
    mov cx,0
    mov dh,200 ; dimensions of page 200x200
    mov dl,200
    mov bh,05h ;magenta color
    int 10h


    ;mov cl,40
    print:
    mov ah, 02h    
    mov bx, 0      ; display page
    mov dh, 5      ; row (move down if needed)
    mov dl, 33    ; column (adjust to move right)
    int 10h        ; interrupt to set cursor position
    
    mov dx,offset msg1 ; title of game
    mov ah,09h
    ;mov bl
    int 21h

    mov ah, 02h    
    mov bx, 0      ; display page
    mov dh, 10      ; row (move down if needed)
    mov dl, 30    ; column (adjust to move right)
    int 10h        ; interrupt to set cursor position


    mov dx,offset msg2 
    mov ah,09h
    int 21h
    mov si,offset userName
    input1:
        mov ah,01;
        int 21h
        cmp al,13
        je endInput1
        mov [si],al
        inc si
    jmp input1
    endInput1:
    inc si
    mov [si],'$'
    ret
firstPage endp

rulesPage proc
    mov ah,06h 
    mov al,0 
    mov cx,0 
    mov dh,100  ;X COORDINATE
    mov dl,100  ;Y COORDINATE
    mov bh,04h 
    int 10h 

    mov ah,02h ; setting new cursor position
    mov bx,0 
    mov dh,1  ;row
    mov dl,34  ;col
    int 10h
    mov dx,offset msg3 ; 'R U L E S'
    mov ah,09h
    int 21h
    mov ah,02h ; setting new cursor position
    mov bx,0 
    mov dh,2  ;row
    mov dl,34  ;col
    int 10h
    mov dx,offset msg4 ; '_________'
    mov ah,09h
    int 21h

    mov counter1,0
     mov dh,4
     mov dl,25
     mov spaceCount,419h
    repeat1:
        ;here we enter the symbol
        mov ah,02h ; setting cursor position
        mov bx,0
        int 10h
        mov dx,259
        mov ah,02h
        int 21h
        ;mov ah, 09h
        ;mov bh, 00h ; page number
        ;mov bl, 05h ; color attribute
        ;mov cx, 1 ; count of characters to print
        ;int 10h 
        ;mov dx, 30  ; Get the character from the characters array
        ;mov ah, 02h
        ;mov al, 01h
        ;int 10h
        
        inc counter1
        cmp counter1,3
        je exitLoop1
        mov dx,spaceCount
        add dl,3
        mov spaceCount,dx
    jmp repeat1
    exitLoop1:

    mov ah,02h ; setting new cursor position
    mov bx,0 
    mov dh,5  ;row
    mov dl,25  ;col
    int 10h
    mov dx,offset msg7 ; '_________'
    mov ah,09h
    int 21h



    mov ah,02h ; setting cursor position
    mov bx,0
    mov dh,4
    mov dl,35
    int 10h
    mov dl,'='
    mov ah,02h
    int 21h
    mov ah,02h ; setting cursor position
    mov bx,0
    mov dh,4
    mov dl,38
    int 10h
    mov dx,offset msg5
    mov ah,09h
    int 21h

    mov counter1,0
     mov dh,7
     mov dl,25
     mov spaceCount,719h
    repeat2:
        ;here we enter the symbol
        mov ah,02h ; setting cursor position
        mov bx,0
        int 10h
        mov dx,259
        mov ah,02h
        int 21h
        inc counter1
        cmp counter1,3
        je exitLoop2
        mov dx,spaceCount
        add dh,2
        mov spaceCount,dx
    jmp repeat2
    exitLoop2:

    mov ah,02h ; setting cursor position
    mov bx,0
    mov dh,9
    mov dl,35
    int 10h
    mov dl,'='
    mov ah,02h
    int 21h
    mov ah,02h ; setting cursor position
    mov bx,0
    mov dh,9
    mov dl,38
    int 10h
    mov dx,offset msg5
    mov ah,09h
    int 21h


    mov ah,02h ; setting new cursor position
    mov bx,0 
    mov dh,12  ;row
    mov dl,25  ;col
    int 10h
    mov dx,offset msg7 ; '_________'
    mov ah,09h
    int 21h
    
    mov ah,02h ; setting cursor position
    mov bx,0    ;bomb
    mov dh,14
    mov dl,25
    int 10h
    mov dx,233
    mov ah,02h
    int 21h
    mov ah,02h ; setting cursor position
    mov bx,0    ;bomb
    mov dh,14
    mov dl,35
    int 10h
    mov dx,'='
    mov ah,02h
    int 21h
    mov ah,02h ; setting cursor position
    mov bx,0    ;bomb
    mov dh,14
    mov dl,42
    int 10h
    mov dx,offset msg6
    mov ah,09h
    int 21h

    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,27 ;-----row
    mov dh,22;-----col
    int 10h
    mov dx,offset msg8
    mov ah,09h
    int 21h

    checkEnter:
    mov ah,01h
    int 21h
    cmp al,13
    je exitcheckEnter
    jmp checkEnter

    exitcheckEnter:
    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,9 ;-----row
    mov dh,23;-----col
    int 10h

    ret
rulesPage endp

gamePage1 proc

    call createGrid
    ;call fillGrid

    mov turns1,10
    mov turns,0
    .while turns <10
        .if turns1 == 0
            jmp endLevel1
        .endif
        call mouse_pos
        call playLevel1 ; this is basicly for one swap 
        call delay
        call fillgrid
        call delay
    .endw
    
    mov turns1,10
    mov turns,0

    endLevel1:
    ;call checkLevel

    ret
gamePage1 endp

gamePage2 proc
    call createGrid
    ;call fillgrid

    mov turns1,10
    mov turns,0

    .while turns <10
        .if turns1 == 0
            jmp endLevel2
        .endif
        call mouse_pos
        call playLevel1 ; this is basicly for one move at 
        call delay
        call fillgrid
        call delay
    .endw
    
    mov turns1,15
    mov turns,0

    endLevel2:

    ret
gamePage2 endp

gamePage3 proc
    call createGrid
    ;call fillgrid

    mov turns1,10
    mov turns,0

    .while turns <10
        .if turns1 == 0
            jmp endLevel3
        .endif
        call mouse_pos
        call playLevel1 ; this is basicly for one move at 
        call delay
        call fillgrid
        call delay
    .endw
    
    mov turns1,10
    mov turns,0

    endLevel3:
    ret
gamePage3 endp

createGrid proc

    mov ah,00h
    mov al, 13h
    int 10h
    mov ah,06h ;
    mov al,0
    mov cx,0
    mov dh,200
    mov dl,255
    mov bh,00h ;change page 2 color 
    int 10h

    ;columns
    mov cx,15
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=7 
        .while gridCount2<=168
        mov ah,0ch
        mov al,01h
        int 10h
        inc cx
        inc gridCount2

        .endw
        mov cx,15
        add dx,16
        mov gridCount2,0
        inc gridCount1
    .endw

    ;rows
    mov cx,15
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=7 
        .while gridCount2<=112
        mov ah,0ch
        mov al,01h
        int 10h
        inc dx
        inc gridCount2
        .endw
        add cx,24
        mov dx,51
        mov gridCount2,0
        inc gridCount1
    .endw

    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,12 ;-----row
    mov dh,3;-----col
    int 10h

    mov ah,09h ; level 1 title
    mov dx,offset msg9
    int 21h

    .if currentLevel==2


    ;to turn the l;
    mov cx,15
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=1
        .while gridCount2<=23
        mov ah,0ch
        mov al,00h
        int 10h
        inc cx
        inc gridCount2

        .endw
        mov cx,15
        add dx,16
        mov gridCount2,0
        inc gridCount1
    .endw

    mov cx,88
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount2<=22
    mov ah,0ch
    mov al,00h
    int 10h
    inc cx
    inc gridCount2
    .endw
    

    mov cx,15
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount2<=31
    mov ah,0ch
    mov al,00h
    int 10h
    inc dx
    inc gridCount2
    .endw

    mov cx,183
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount2<=31
    mov ah,0ch
    mov al,00h
    int 10h
    inc dx
    inc gridCount2
    .endw


    mov cx,160
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=1
        .while gridCount2<=23
        mov ah,0ch
        mov al,00h
        int 10h
        inc cx
        inc gridCount2

        .endw
        mov cx,160
        add dx,16
        mov gridCount2,0
        inc gridCount1
    .endw



    mov cx,15
    mov dx,147
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=1
        .while gridCount2<=23
        mov ah,0ch
        mov al,00h
        int 10h
        inc cx
        inc gridCount2

        .endw
        mov cx,15
        add dx,16
        mov gridCount2,0
        inc gridCount1
    .endw

    mov cx,15
    mov dx,100
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount2<=14
    mov ah,0ch
    mov al,00h
    int 10h
    inc dx
    inc gridCount2
    .endw

    mov cx,183
    mov dx,100
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount2<=14
    mov ah,0ch
    mov al,00h
    int 10h
    inc dx
    inc gridCount2
    .endw

    mov cx,15
    mov dx,132
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount2<=31
    mov ah,0ch
    mov al,00h
    int 10h
    inc dx
    inc gridCount2
    .endw

    mov cx,183
    mov dx,132
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount2<=31
    mov ah,0ch
    mov al,00h
    int 10h
    inc dx
    inc gridCount2
    .endw

    mov cx,160
    mov dx,147
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=1
        .while gridCount2<=23
        mov ah,0ch
        mov al,00h
        int 10h
        inc cx
        inc gridCount2

        .endw
        mov cx,160
        add dx,16
        mov gridCount2,0
        inc gridCount1
    .endw


    mov cx,88
    mov dx,163
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount2<=22
    mov ah,0ch
    mov al,00h
    int 10h
    inc cx
    inc gridCount2
    .endw

    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,12 ;-----row
    mov dh,3;-----col
    int 10h

    mov ah,09h ; level 2 title
    mov dx,offset msg9_1
    int 21h

    .endif

    .if currentLevel==3
    mov cx,15
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=7 
        .while gridCount2<=112
        mov ah,0ch
        mov al,01h
        int 10h
        inc dx
        inc gridCount2
        .endw
        add cx,24
        mov dx,51
        mov gridCount2,0
        inc gridCount1
    .endw

    mov cx,15
    mov dx,100
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=7 
        .while gridCount2<=14
        mov ah,0ch
        mov al,00h
        int 10h
        inc dx
        inc gridCount2
        .endw
        add cx,24
        mov dx,100
        mov gridCount2,0
        inc gridCount1
    .endw

    mov cx,88
    mov dx,51
    mov gridCount1,0
    mov gridCount2,0
    .while gridCount1<=7 
        .while gridCount2<=22
        mov ah,0ch
        mov al,00h
        int 10h
        inc cx
        inc gridCount2

        .endw
        mov cx,88
        add dx,16
        mov gridCount2,0
        inc gridCount1
    .endw

    mov ah,09h ; level 2 title
    mov dx,offset msg9_2
    int 21h

    .endif



    ;call scoreBoard
    call fillGrid

    ret
createGrid endp

scoreBoard proc
    ;------name-------------------------
    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,24 ;-----row
    mov dh,7;-----col
    int 10h

    mov ah,09h ;"User: "
    mov dx,offset msg10
    int 21h

    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,33 ;-----row
    mov dh,7;-----col
    int 10h

    mov ah,09h ; displaying name
    mov dx,offset userName
    int 21h
    ;------name-------------------------

    ;------target-----------------------
    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,24 ;-----row
    mov dh,9;-----col
    int 10h

    mov ah,09h ; target
    mov dx,offset msg11
    int 21h

    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,33 ;-----row
    mov dh,9;-----col
    int 10h

    mov ah,09h ; target
    mov dx,offset target1
    int 21h

    ;------target-----------------------

    ;------move-------------------------
    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,24 ;-----row
    mov dh,11;-----col
    int 10h

    mov ah,09h ; level 1
    mov dx,offset msg12
    int 21h

    mov ax,0
    mov ax,turns1
    mov bx,10
    div bl

    mov tens,0
    mov units,0
    mov tens,al
    mov units,ah

    mov dl,tens
    add dl,'0'
    mov ah,02h
    int 21h
    mov dl,units
    add dl,'0'
    mov ah,02h
    int 21h



    ;------move-------------------------


    ;------score-------------------------
    mov ah,02h ; setting cursor position
    mov bx,0
    mov dl,24 ;-----row
    mov dh,13;-----col
    int 10h

    mov ah,09h ; level 1
    mov dx,offset msg13
    int 21h

    mov bl,0
    mov ax,level1Score
    cmp ax,9
    jbe dontPerformDivision
    mov bl,10
    div bl
    mov tens2,al
    mov units2,ah
    jmp printDivided

    dontPerformDivision:
    mov tens2,0
    mov units2,al

    printDivided:
    mov dl,tens2
    add dl,'0'
    mov ah,02h
    int 21h
    mov dl,units2
    add dl,'0'
    mov ah,02h
    int 21h

    ;------score-------------------------


    ret

scoreBoard endp

fillGrid proc
    mov ax,0
    mov cx,0
    mov dx,0

    mov si,0
    mov bx,0
    mov dl,3
    mov gridx,dl
    mov dh,7
    mov gridy,dh

    mov rows,0
    mov columns,0

    .while rows<7
        .while columns < 7
            mov si,columns
            mov al,rows
            mov bl,7
            mul bl ; we multiply row number * row size and save in bx
            mov bx,ax
            mov ax,0
            .if currentLevel==1
            mov al,grid[bx + si]
            .endif
            .if currentLevel==2
            mov al,grid2[bx + si]
            .endif
            .if currentLevel==3
            mov al,grid3[bx + si]
            .endif
            mov bx,0
        ; Determine the character index based on the value in the grid
            mov si, 0
            cmp al, 1
            je value_is_1
            cmp al, 2
            je value_is_2
            cmp al, 3
            je value_is_3
            cmp al, 4
            je value_is_4
            cmp al, 5
            je value_is_5
            cmp al, 6
            je value_is_6
            cmp al,7
            je value_is_7
            cmp al,8
            je value_is_Space
            cmp al,9
            je value_is_9

            value_is_1:
                mov dx,262
                mov currentCharacter,dx
                mov temp5,03h
                jmp character_found
            value_is_2:
                mov dx,260
                mov currentCharacter,dx
                mov temp5,0ch
                jmp character_found
            value_is_3:
                mov dx,257
                mov currentCharacter,dx
                mov temp5,04h
                jmp character_found
            value_is_4:
                mov dx,258
                mov currentCharacter,dx
                mov temp5,0bh
                jmp character_found
            value_is_5:
                mov dx,259
                mov currentCharacter,dx
                mov temp5,02h
                jmp character_found
            value_is_6:
                mov dx,245
                mov currentCharacter,dx
                mov temp5,0eh
                jmp character_found
            value_is_7:
                mov dx,'B'
                mov currentCharacter,dx
                mov temp5,0ah
                jmp character_found
            value_is_Space:
                mov dx,'0'
                mov currentCharacter,dx
                mov temp5,0ah
                jmp character_found
            value_is_9:
                mov dx,' '
                mov currentCharacter,dx
                mov temp5,0ah
                jmp character_found
            

            character_found:
                mov ah, 02h
                mov dl, gridx
                mov dh, gridy
                mov bl,01h
                mov cx,0
                int 10h
                

            ;mov ah, 0Bh       ; Function to select background and foreground colors
            ;mov bh, 0         ; Page number
            ;mov bl, temp5     ; Background and foreground colors
            ;int 10h      


            ;mov cx,0
            mov dx, currentCharacter    
            mov ah, 02h
            ;mov bl, temp5
            ;mov cl, temp5
            int 21h ; page number
            
            ;mov cx,0
             ; color attribute
            ; ; count of characters to print
            ;int 10h 
            ;mov dx,0
              ; Get the character from the characters array
            ;mov ah, 02h
            ;mov al, 01h
            ;mov cx,1
            ;int 10h
            ;int 21h

            Next:
            ;mov ax,0
            add gridx,3
            inc columns
        .endw
            mov columns,0
            inc rows

            add gridy,2
            mov gridx,3
    .endw

    call scoreBoard

    ret
fillGrid endp

mouse_pos proc
	;initialise mouse
	mov ax, 01
	int 33h
	
	;;;horizontal
	;Gets horizontal position
	mov cx, 31
	mov dx,365 ;Threshold setting mouse boundary for horizontal axis
    mov ax,7
	int 33h
	
	;;;vertical
	;Gets vertical position
	mov cx, 52
	mov dx, 160;Threshold setting mouse boundary for vertical axis
    mov ax, 8
	int 33h

    ret
mouse_pos endp

playLevel1 proc 
    mov mouseClicks,0
    start:
    ; to check if mouse button has been clicked then go to turn function
    mov ax,5
    int 33h
    cmp bl,1
    jne start 

    ;when mouse has been clicked

    mov yCoordinate,dx ;clicked mouse y coordinate
    mov xCoordinate,cx ;clicked mouse x coordinate

    inc mouseClicks
    cmp mouseClicks,1
    je Click1
    cmp mouseClicks,2
    je Click2

    Click1:
    mov ax,xCoordinate
    sub ax,30
    mov bl,48
    div bl
    mov obj1X,al

    mov ax,yCoordinate
    sub ax,51
    mov bl,16
    div bl
    mov obj1Y,al
    jmp start

    Click2:
    mov ax,xCoordinate
    sub ax,30
    mov bl,48
    div bl
    mov obj2X,al

    mov ax,yCoordinate
    sub ax,51
    mov bl,16
    div bl
    mov obj2Y,al
    ;jmp start

    call checkingAdjacencySwap
    mov cl,adjacencyBool
    cmp cl,1
    ;je endCurrentMove
    je checkCombo
    jmp start

    checkCombo:
    call checkAllCombos
    mov cl,combo_bool
    cmp cl,1
    je endCurrentMove

    mov mouseClicks,0
    jmp start

    endCurrentMove:
    ;call checkAllCombos
    inc turns
    dec turns1

    ret
playLevel1 endp

checkingAdjacencySwap proc

    .if currentLevel==2; check for when user acidentally enter an empty space
        mov dx,0
        mov ax,0
        mov dl,obj1X
        mov si,dx
        mov al,obj1Y
        mov bl,7
        mul bl ; Multiply row number * row size and save in bx
        mov bx,ax
        mov al,grid2[bx + si]
        cmp al,9
        je adjacencyFailed

        mov cx,0
        mov ax,0
        mov cl,obj2X
        mov si,cx
        mov al,obj2Y
        mov bl,7
        mul bl ; Multiply row number * row size and save in bx
        mov bx,ax
        mov al,grid2[bx + si]
        cmp al,9
        je adjacencyFailed
    .endif

    mov vert_bool,0
    checkAlongX:
    mov al,obj1X
    mov bl,obj2X
    cmp al,bl
    je adjacentVertically
    cmp al,bl
    jb obj1X_isSmaller
    jmp obj1X_isLarger

    adjacentVertically:
        mov cl,1
        mov vert_bool,cl
    jmp checkAlongY

    obj1X_isSmaller:
        mov cl,al
        inc cl
        cmp cl,bl; checks if bl is ahead in line
    je checkAlongY
    jne adjacencyFailed

    obj1X_isLarger:
        dec al
        cmp al,bl
    je checkAlongY
    jne adjacencyFailed

    checkAlongY:
        
        mov cl,vert_bool
            cmp cl,0
            je endVertCheck
            mov al,obj1Y
            mov bl,obj2Y
            cmp al,bl
            je adjacencyFailed

            mov al,obj1Y
            mov bl,obj2Y
            cmp al,bl
            je isadjacent
            jb obj1Y_isSmaller
            jmp obj1Y_isLarger

            obj1Y_isSmaller:
            mov cl,al
            inc cl
            cmp cl,bl; checks if bl is ahead in line
            je isadjacent
            jne adjacencyFailed

            obj1Y_isLarger:
            dec al
            cmp al,bl
            je isadjacent
            jne adjacencyFailed
        endVertCheck:


        mov al,obj1Y
        mov bl,obj2Y
        cmp al,bl
        je isadjacent
        jmp adjacencyFailed

    isadjacent:
        mov cl,1
        mov adjacencyBool,cl
        ;call checkAllCombos
    jmp endAdjacencyCheck


    adjacencyFailed:
    mov cl,0
    mov adjacencyBool,cl

    endAdjacencyCheck:

    ret

checkingAdjacencySwap endp

checkAllCombos proc 

    mov combo_bool,0
    call checkBomb
    cmp combo_bool,1
    je return

    call check3Combo
    cmp combo_bool,1
    jne dont_do_anything

    return:;
    call refillEmpty
    call refillEmpty
    call delay
    call fillGrid
    call delay
    call delay
    call fillGrid
    .if currentLevel==1
    call dropOnEmpty;
    .endif
    call dropOnEmpty2
    call refillEmpty
    call refillEmpty
    call fillGrid
    
    dont_do_anything:

    ret
checkAllCombos endp

checkBomb proc
    mov candy1,0
    mov candy2,0

    ; Copying the candy num from mouse using grid
    mov dx,0
    mov ax,0
    mov dl,obj1X
    mov si,dx
    mov al,obj1Y
    mov bl,7
    mul bl ; Multiply row number * row size and save in bx
    mov bx,ax
    .if currentLevel==1
    mov al,grid[bx + si]
    .endif
    .if currentLevel==2
    mov al,grid2[bx + si]
    .endif
    .if currentLevel==3
    mov al,grid3[bx + si]
    .endif
    mov candy1,al; Contains candy of object 1

    mov cx,0
    mov ax,0
    mov cl,obj2X
    mov si,cx
    mov al,obj2Y
    mov bl,7
    mul bl ; Multiply row number * row size and save in bx
    mov bx,ax
    .if currentLevel==1
    mov al,grid[bx + si]
    .endif
    .if currentLevel==2
    mov al,grid2[bx + si]
    .endif
    .if currentLevel==3
    mov al,grid3[bx + si]
    .endif
    mov candy2,al; Contains candy of object 2

    cmp candy1,7 ; Check if candy1 is the bomb
    je bombfound1
    cmp candy2,7 ; Check if candy2 is the bomb
    je bombfound2
    jmp bombNotFound

    bombfound1:
    ; Candy2 contains the candy
    mov rows,0
    .while rows<7
        mov columns,0
        .while columns < 7
            mov si,columns
            mov al,rows
            mov bl,7
            mul bl ; Multiply row number * row size and save in bx
            mov bx,ax
            .if currentLevel==1
            mov al,grid[bx + si]
            cmp candy2,al
            jne moveOn
            mov al,8
            mov grid[bx + si],al ; Replace the candy with 8
            inc level1Score
            mov combo_bool,1
            .endif
            .if currentLevel==2
            mov al,grid2[bx + si]
            cmp candy2,al
            jne moveOn
            mov al,8
            mov grid2[bx + si],al ; Replace the candy with 8
            mov combo_bool,1
            inc level1Score
            .endif
            .if currentLevel==3
            mov al,grid3[bx + si]
            cmp candy2,al
            jne moveOn
            mov al,8
            mov grid3[bx + si],al ; Replace the candy with 8
            mov combo_bool,1
            inc level1Score
            .endif
            ;jmp skip
            moveOn:
            inc columns
        .endw
        inc rows
    .endw
    mov cx,0
    mov ax,0
    mov bx,0
    mov cl,obj1X
    mov si,cx
    mov al,obj1Y
    mov bl,7
    mul bl ; we multiply row number * row size and save in bx
    mov bx,ax
    mov al,8
    .if currentLevel==1
    mov grid[bx + si],al
    .endif
    .if currentLevel==2
    mov grid2[bx + si],al
    .endif
    .if currentLevel==3
    mov grid3[bx + si],al
    .endif
    inc level1Score
    jmp skip

    bombfound2:
    ; Candy1 contains the candy
    mov rows,0
    .while rows<7
        mov columns,0
        .while columns < 7
            mov si,columns
            mov al,rows
            mov bl,7
            mul bl ; Multiply row number * row size and save in bx
            mov bx,ax
            .if currentLevel==1
            mov al,grid[bx + si]
            cmp candy1,al
            jne moveOn2
            mov al,8
            mov grid[bx + si],al ; Replace the candy with 8
            mov combo_bool,1
            inc level1Score
            .endif
            .if currentLevel==2
            mov al,grid2[bx + si]
            cmp candy1,al
            jne moveOn2
            mov al,8
            mov grid2[bx + si],al ; Replace the candy with 8
            mov combo_bool,1
            inc level1Score
            .endif
            .if currentLevel==3
            mov al,grid3[bx + si]
            cmp candy1,al
            jne moveOn2
            mov al,8
            mov grid3[bx + si],al ; Replace the candy with 8
            mov combo_bool,1
            inc level1Score
            .endif
            mov al,1
            ;inc level1Score
            ;jmp skip
            moveOn2:
            inc columns
        .endw
        inc rows
    .endw
    mov cx,0
    mov ax,0
    mov bx,0
    mov cl,obj2X
    mov si,cx
    mov al,obj2Y
    mov bl,7
    mul bl ; we multiply row number * row size and save in bx
    mov bx,ax
    mov al,8
    .if currentLevel==1
    mov grid[bx + si],al
    .endif
    .if currentLevel==2
    mov grid2[bx + si],al
    .endif
    .if currentLevel==3
    mov grid3[bx + si],al
    .endif    
    inc level1score

    jmp skip

    bombNotFound:
    mov combo_bool,0

    skip:
    ret
checkBomb endp

check3Combo proc 

    mov combo_bool,0
    mov si,0
    .while si<49 ;copying grid to copy
        .if currentLevel==1
        mov al,grid[si]
        .endif
        .if currentLevel==2
        mov al,grid2[si]
        .endif
        .if currentLevel==3
        mov al,grid3[si]
        .endif
        mov copy[si],al
        inc si
    .endw


    ; getting the values of in temp from the grid
        mov dx,0
        mov dl,obj1X
        mov si,dx
        mov al,obj1Y
        mov bl,7
        mul bl ; we multiply row number * row size and save in bx
        mov bx,ax
        mov ax,0
        .if currentLevel==1
        mov al,grid[bx + si]
        .endif
        .if currentLevel==2
        mov al,grid2[bx + si]
        .endif
        .if currentLevel==3
        mov al,grid3[bx + si]
        .endif; now al contains the 1st candy
        mov bx,0
        mov temp5,al

        mov dx,0
        mov dl,obj2X
        mov si,dx
        mov al,obj2Y
        mov bl,7
        mul bl ; we multiply row number * row size and save in bx
        mov bx,ax
        mov ax,0
        .if currentLevel==1
        mov al,grid[bx + si]
        .endif
        .if currentLevel==2
        mov al,grid2[bx + si]
        .endif
        .if currentLevel==3
        mov al,grid3[bx + si]
        .endif; now al contains the 2nd candy
        mov bx,0
    mov temp6,al

    ;performing swap
        mov dx,0
        mov dl,obj1X
        mov si,dx
        mov al,obj1Y
        mov bl,7
        mul bl ; we multiply row number * row size and save in bx
        mov bx,ax
        mov ax,0
        mov al,temp6; now cl contains the 2nd candy
        mov copy[bx+si],al        
    mov bx,0

    mov dx,0
        mov dl,obj2X
        mov si,dx
        mov al,obj2Y
        mov bl,7
        mul bl ; we multiply row number * row size and save in bx
        mov bx,ax
        mov ax,0
        mov al,temp5; now cl contains the 2nd candy
        mov copy[bx+si],al
    mov bx,0

    ;performing row combos
    mov temp5,0
    .while temp5 < 2
    mov rows,0
    .while rows<7; techinically this is actually column
        mov columns,0
        .while columns < 5 ; and this actually the row stuff
            mov ax,0
            mov si,columns
            mov al,rows
            mov bl,7
            mul bl ; Multiply row number * row size and save in bx
            mov bx,ax
            mov al,copy[bx+si]
            mov cl,copy[bx+si+1]
            mov dl,copy[bx+si+2]
            .if al==cl && al==dl && al < 8
                mov combo_bool,1
                add level1Score,3
                mov dl,8
                mov copy[bx+si],dl
                mov copy[bx+si+1],dl
                mov copy[bx+si+2],dl
            .endif
            inc columns
        .endw
        inc rows
    .endw

    ;performing column combos
    mov si,0
    .while si <35
        mov al,copy[si]
        mov cl,copy[si+7]
        mov bl,copy[si+14]
        .if al==cl && al==bl && al <8
            mov combo_bool,1
            add level1Score,3
            mov dl,8
            mov copy[si],dl
            mov copy[si+7],dl
            mov copy[si+14],dl
        .endif
        inc si
    .endw
    inc temp5
    .endw

    .if combo_bool ==1
        mov si,0
        .while si <49 ;copying the array
            mov al,copy[si]
            .if currentLevel==1
            mov grid[si],al
            .endif
            .if currentLevel==2
            mov grid2[si],al
            .endif
            .if currentLevel==3
            mov grid3[si],al
            .endif
            inc si
        .endw
    .endif

    ret
check3Combo endp

dropOnEmpty proc
    mov temp5,1
    .while temp5<7
        mov si,35
        .while si<42
            
            mov al,grid[si]; this candy is the one above 
            mov cl,grid[si+7]; this candy is the one below
            .if al < 9 && cl ==8 
            .if cl==8
                mov grid[si+7],al
                mov grid[si],cl
            .endif
            .endif 
        inc si
        .endw

        mov si,28
        .while si<35
            mov al,grid[si]; this candy is the one above 
            mov cl,grid[si+7]; this candy is the one below
            .if al < 9 && cl ==8 
            .if cl==8
                mov grid[si+7],al
                mov grid[si],cl
            .endif 
            .endif
        inc si
        .endw

        mov si,21
        .while si<28
            mov al,grid[si]; this candy is the one above 
            mov cl,grid[si+7]; this candy is the one below
            .if al < 9 && cl ==8 
            .if cl==8
                mov grid[si+7],al
                mov grid[si],cl
            .endif 
            .endif
        inc si
        .endw

        mov si,14
        .while si<21
            mov al,grid[si]; this candy is the one above 
            mov cl,grid[si+7]; this candy is the one below
            .if al < 9 && cl ==8 
            .if cl==8
                mov grid[si+7],al
                mov grid[si],cl
            .endif
            .endif 
        inc si
        .endw

        mov si,7
        .while si<14
            mov al,grid[si]; this candy is the one above 
            mov cl,grid[si+7]; this candy is the one below
            .if al < 9 && cl ==8 
            .if cl==8
                mov grid[si+7],al
                mov grid[si],cl
            .endif 
            .endif
        inc si
        .endw

        mov si,0
        .while si<7
            mov al,grid[si]; this candy is the one above 
            mov cl,grid[si+7]; this candy is the one below
            .if al < 9 && cl ==8 
            .if cl==8
                mov grid[si+7],al
                mov grid[si],cl
            .endif 
            .endif
        inc si
        .endw
        inc temp5
    .endw
    ret
dropOnEmpty endp

dropOnEmpty2 proc
    mov si,0
    .while si<49 ;copying grid to copy
        .if currentLevel==1
        mov al,grid[si]
        .endif
        .if currentLevel==2
        mov al,grid2[si]
        .endif
        .if currentLevel==3
        mov al,grid3[si]
        .endif
        mov copy[si],al
        inc si
    .endw


    mov temp5,1
    .while temp5<7
        mov si,35
        .while si<42
            
            mov al,copy[si]; this candy is the one above 
            mov cl,copy[si+7]; this candy is the one below
            .if al != 9 && cl ==8 
            .if cl==8
                mov copy[si+7],al
                mov copy[si],cl
            .endif
            .endif 
        inc si
        .endw

        mov si,28
        .while si<35
            mov al,copy[si]; this candy is the one above 
            mov cl,copy[si+7]; this candy is the one below
            .if al != 9 && cl ==8 
            .if cl==8
                mov copy[si+7],al
                mov copy[si],cl
            .endif 
            .endif
        inc si
        .endw

        mov si,21
        .while si<28
            mov al,copy[si]; this candy is the one above 
            mov cl,copy[si+7]; this candy is the one below
            .if al != 9 && cl ==8 
            .if cl==8
                mov copy[si+7],al
                mov copy[si],cl
            .endif 
            .endif
        inc si
        .endw

        mov si,14
        .while si<21
            mov al,copy[si]; this candy is the one above 
            mov cl,copy[si+7]; this candy is the one below
            .if al != 9 && cl ==8 
            .if cl==8
                mov copy[si+7],al
                mov copy[si],cl
            .endif
            .endif 
        inc si
        .endw

        mov si,7
        .while si<14
            mov al,copy[si]; this candy is the one above 
            mov cl,copy[si+7]; this candy is the one below
            .if al != 9 && cl ==8 
            .if cl==8
                mov copy[si+7],al
                mov copy[si],cl
            .endif 
            .endif
        inc si
        .endw

        mov si,0
        .while si<7
            mov al,copy[si]; this candy is the one above 
            mov cl,copy[si+7]; this candy is the one below
            .if al != 9 && cl ==8 
            .if cl==8
                mov copy[si+7],al
                mov copy[si],cl
            .endif 
            .endif
        inc si
        .endw
        inc temp5
    .endw

    mov si,0
    .while si <49 ;copying the array
        mov al,copy[si]
        .if currentLevel==1
        mov grid[si],al
        .endif
        .if currentLevel==2
        mov grid2[si],al
        .endif
        .if currentLevel==3
        mov grid3[si],al
        .endif
        inc si
    .endw


    ret
dropOnEmpty2 endp

refillEmpty proc

    mov si,0
    .while si<49 ;copying grid to copy
        .if currentLevel==1
        mov al,grid[si]
        .endif
        .if currentLevel==2
        mov al,grid2[si]
        .endif
        .if currentLevel==3
        mov al,grid3[si]
        .endif
        mov copy[si],al
        inc si
    .endw

    mov si,0
    .while si<49  ; dropping from 
            mov al,copy[si]; this candy is the one above 
            .if al==8
                call randomNum
                mov al,randNum
                mov copy[si],al
            .endif 
        inc si
    .endw

        mov si,0
    .while si <49 ;copying the array
        mov al,copy[si]
        .if currentLevel==1
        mov grid[si],al
        .endif
        .if currentLevel==2
        mov grid2[si],al
        .endif
        .if currentLevel==3
        mov grid3[si],al
        .endif
        inc si
    .endw
    ret
refillEmpty endp

randomNum proc
    call delay
    call delay
    call delay
    call delay
    call delay
    call delay
    
    mov ah,0h  ; gets system time and clock ticks saved in dx
    int 1ah

    mov ax,dx
    mov dx,0
    mov bx,7
    div bx

    mov randNum,dl;storing the remainderin ah
    cmp randNum,0
    jne notZero
    inc randNum
    notZero:
    ret
randomNum endp

delay proc
    push cx
    push dx

    mov cx,100
    L5: 
    mov dx,100
    L6:
    dec dx
    cmp dx,0
    jne L6  
    loop L5

    pop dx
    pop cx

    ret
delay endp
end main