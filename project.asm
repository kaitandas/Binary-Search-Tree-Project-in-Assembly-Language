INCLUDE irvine32.inc

.data

Handler Dword 0
Root Dword 0
Total_Nodes Dword 0
Multiplier Byte 4
Divisor Byte 4
Index Dword 0
Min Sdword 0
Max Sdword 0
Insert Proto Value:Sdword
Search Proto Value:Sdword
Delete_Leaf Proto Value:Sdword
Find_Min Proto 
Find_Max Proto 
Print_Tree_Level_Order_Traversing Proto 
Print_Tree_Pre_Order_Traversing Proto Root_Node:Dword
Print_Tree_In_Order_Traversing Proto Root_Node:Dword
Print_Tree_Post_Order_Traversing Proto Root_Node:Dword
Prompt1 Byte "Breadth First Search , " , 0
Prompt2 Byte "Pre Order Traversal , " , 0
Prompt3 Byte "In Order Traversal , " , 0
Prompt4 Byte "Post Order Traversal , " , 0
Prompt5 Byte "Minimum = " , 0
Prompt6 Byte "Maximum = " , 0
Prompt7 Byte "The Value Which Is To Be Deleted Is Not Found ", 0
Prompt8 Byte "The Value Has Been Deleted Successfully ",0
SearchF Byte "Search Result Found" , 0
SearchNF Byte "Search Result Not Found" , 0
Operations  Byte "                             Operations Available In Binary Search Tree",0
Choice1 Byte "1.  Insert",0
Choice2 Byte "2.  Search",0
Choice3 Byte "3.  Print Pre-Order Traversal ",0
Choice4 Byte "4.  Print Post-Order Traversal ",0
Choice5 Byte "5.  Print In Order Traversal ",0
Choice6 Byte "6.  Breadth First Search ",0
Choice7 Byte "7.  Find Minimum ",0
Choice8 Byte "8.  Find Maximum",0
Choice9 Byte "9.  Delete A Leaf Node ",0
Choice10 Byte "10. Exit ",0
Select_Option Byte "Select Any Option : ",0
Insert_A_Value  Byte "Enter A Value To Be Inserted : ",0
Value_Inserted_Successfully Byte "Value Inserted Successfully",0
Press_Any_Key_To_Continue  Byte "...Press Any Key To Continue...",0
Insert_A_Value_To_Be_Searched   Byte "Enter A Value To Be Searched : ",0
Insert_A_Leaf_Value_To_Be_Deleted  Byte "Enter A Value Of A Leaf To Be Deleted : ",0
ThankYou Byte "                                            ....ThankYou....                       ",0
; For Characters Tree The Formula For Left & Right Children Will Be : ( 2*index + 1 ) , ( 2*index + 2 ) 
.code
main PROC
; https://yongdanielliang.github.io/animation/web/BST.html visualization link
call Getprocessheap
mov Handler , Eax
invoke Heapalloc , Handler , HEAP_ZERO_MEMORY , 1500
mov Root , Eax
mov Esi , Eax
Choices:
call clrscr
mov Edx , offset Operations
call writestring
call crlf
call crlf
mov Edx , Offset Choice1
call writestring
call crlf
mov Edx , Offset Choice2
call writestring
call crlf
mov Edx , Offset Choice3
call writestring
call crlf
mov Edx , Offset Choice4
call writestring
call crlf
mov Edx , Offset Choice5
call writestring
call crlf
mov Edx , Offset Choice6
call writestring
call crlf
mov Edx , Offset Choice7
call writestring
call crlf
mov Edx , Offset Choice8
call writestring
call crlf
mov Edx , Offset Choice9
call writestring
call crlf
mov Edx , Offset Choice10
call writestring
call crlf
call crlf
call crlf
mov edx , offset Select_Option
call writestring
call readdec
cmp al , 1
je Insert_Value 
cmp al , 2
je Search_Value
cmp al , 3
je Pre_Order_Tra
cmp al , 4
je Post_Order_Tra
cmp al , 5
je In_Order_Tra
cmp al , 6
je BFS
cmp al , 7
je Find_Min_
cmp al , 8
je Find_Max_
cmp al , 9
je Delete_A_Leaf_Node
cmp al , 10
je Exit_Main
jne Exit_Main

Insert_Value :
call clrscr
mov edx , offset Insert_A_Value 
call writestring
call readint
invoke Insert , eax
mov edx , offset Value_Inserted_Successfully
call crlf
call writestring
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
jmp Choices

Search_Value:
call clrscr
mov edx , offset Insert_A_Value_To_Be_Searched
call writestring
call readint
invoke Search , eax
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
call crlf
jmp Choices

Pre_Order_Tra:
call clrscr
mov edx , offset Prompt2
call writestring
call crlf
invoke Print_Tree_Pre_Order_Traversing , Root
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
jmp Choices

Post_Order_Tra:
call clrscr
mov edx , offset Prompt4
call writestring
call crlf
invoke Print_Tree_Post_Order_Traversing , Root
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
jmp Choices

In_Order_Tra:
call clrscr
mov edx , offset Prompt3
call writestring
call crlf
invoke Print_Tree_In_Order_Traversing , Root
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
jmp Choices

BFS:
call clrscr
invoke Print_Tree_Level_Order_Traversing 
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
jmp Choices

Find_Min_:
call clrscr
invoke Find_Min
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
jmp Choices

Find_Max_:
call clrscr
invoke Find_Max
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
jmp Choices

Delete_A_Leaf_Node:
call clrscr
mov edx , offset Insert_A_Leaf_Value_To_Be_Deleted
call writestring
call readint
invoke Delete_Leaf,eax
call crlf
mov edx , offset Press_Any_Key_To_Continue
call writestring
call readchar
jmp Choices

Exit_Main:
call clrscr
call crlf
call crlf
call crlf
call crlf
call crlf
call crlf
call crlf
mov edx , offset ThankYou
call crlf
call crlf
call crlf
call crlf
call crlf
call crlf
call crlf
call crlf
main Endp


;--------------------------------------------------------
Insert PROC , Value : Sdword   ; Start Of Insert Procedure
mov eax , Esi
sub eax , Root
idiv Divisor
mov Index , eax
mov ebx , [Esi]
cmp ebx , 0
je Root_Case
cmp Value , ebx
jg Right_Child_Case
jl Left_Child_Case
je Leave_Insert
;------------------
Root_Case :
mov Eax , Value
mov [Esi] , eax
inc Total_Nodes
jmp Leave_Insert
;------------------
Right_Child_Case:
mov eax , Index
imul Multiplier
add eax , 8
Add Esi ,  eax
invoke Insert , Value
jmp Leave_Insert
;------------------
Left_Child_Case:
mov eax , Index
imul Multiplier
Add eax , 4
Add Esi ,  Eax
invoke Insert , Value
jmp Leave_Insert
;------------------
Leave_Insert:
mov Esi , Root
Mov Index , 0
ret
Insert Endp                  ; End Of Insert Procedure
;-----------------------------------------------------




;------------------------------------------------------
Print_Tree_Level_Order_Traversing PROC
push Ebp 
mov Ebp , Esp
mov Ecx , Total_Nodes
mov Edx , Offset Prompt1
call writestring
call crlf
mov Esi , Root
Printing_Tree:
mov Eax , [Esi]
cmp eax , 0
je Do_Not_Write_Number
call writeint
call crlf
add Esi , 4
Loop Printing_Tree
Do_Not_Write_Number :
add Esi , 4
inc ecx
Loop Printing_Tree
pop Ebp
mov esi , Root
ret
Print_Tree_Level_Order_Traversing Endp
;--------------------------------------------------------






;--------------------------------------------------------
Print_Tree_Pre_Order_Traversing PROC , Root_Node : Dword
mov Eax , Root_Node
sub Eax , Root
div Divisor
mov Index , Eax
mov Eax , Root_Node
mov Eax , [Eax]
cmp Eax , 0
je Leave_Print_Tree_Pre_Order_Traversing
call Writeint
call crlf
mov Esi , Root_Node
mov Eax , Index
mul Multiplier
add Eax , 4
add esi , eax
invoke Print_Tree_Pre_Order_Traversing , Esi
mov Eax , Root_Node
sub Eax , Root
div Divisor
mov Index , Eax
mov Esi , Root_Node
mov Eax , Index
mul Multiplier
add Eax , 8
add esi , eax
mov bl , [esi]
invoke Print_Tree_Pre_Order_Traversing , Esi
jmp Leave_Print_Tree_Pre_Order_Traversing
Leave_Print_Tree_Pre_Order_Traversing:
mov esi , Root
ret
Print_Tree_Pre_Order_Traversing Endp
;--------------------------------------------------------







;--------------------------------------------------------
Print_Tree_In_Order_Traversing PROC , Root_Node : Dword
mov esi , Root_Node
mov al , [esi]
cmp al , 0
je Leave_Print_Tree_In_Order_Traversing
mov Eax , Root_Node
mov Esi , Root_Node
sub Eax , Root
div Divisor
mov Index , Eax
mul Multiplier
add eax , 4
add esi , eax
invoke Print_Tree_In_Order_Traversing , esi
mov Eax , Root_Node
mov eax , [eax]
call writeint
call crlf
mov eax , Root_Node
mov Esi , Root_Node
sub Eax , Root
div Divisor
mov Index , Eax
mul Multiplier
add eax , 8
add esi , eax
invoke Print_Tree_In_Order_Traversing , esi
jmp Leave_Print_Tree_In_Order_Traversing
Leave_Print_Tree_In_Order_Traversing:
mov esi , Root
ret
Print_Tree_In_Order_Traversing Endp
;--------------------------------------------------------






;--------------------------------------------------------
Print_Tree_Post_Order_Traversing PROC , Root_Node : Dword
mov esi , Root_Node
mov al , [esi]
cmp al , 0
je Leave_Print_Tree_Post_Order_Traversing
mov Eax , Root_Node
mov Esi , Root_Node
sub Eax , Root
div Divisor
mov Index , Eax
mul Multiplier
add eax , 4
add esi , eax
invoke Print_Tree_Post_Order_Traversing , esi
mov eax , Root_Node
mov Esi , Root_Node
sub Eax , Root
div Divisor
mov Index , Eax
mul Multiplier
add eax , 8
add esi , eax
invoke Print_Tree_Post_Order_Traversing , esi
mov Eax , Root_Node
mov eax , [eax]
call writeint
call crlf
jmp Leave_Print_Tree_Post_Order_Traversing
Leave_Print_Tree_Post_Order_Traversing:
mov esi , Root
ret
Print_Tree_Post_Order_Traversing Endp
;--------------------------------------------------------




;--------------------------------------------------------
Search PROC , Value : Sdword   
mov eax , Esi
sub eax , Root
idiv Divisor
mov Index , eax
mov ebx , [Esi]
cmp ebx , 0
je Not_Found_Case
cmp Value , ebx
je Found_Case
jg Search_Right_Sub_Tree_Case
jl Search_Left_Sub_Tree_Case
;------------------
Not_Found_Case :
mov Edx , Offset SearchNF
call crlf
call writestring
jmp Leave_Search
;------------------
Found_Case:
mov edx , offset SearchF
call crlf
call writestring
jmp Leave_Search
;------------------
Search_Right_Sub_Tree_Case:
mov eax , Index
imul Multiplier
add eax , 8
Add Esi ,  eax
invoke Search , Value
jmp Leave_Search
;------------------
Search_Left_Sub_Tree_Case:
mov eax , Index
imul Multiplier
Add eax , 4
Add Esi ,  Eax
invoke Search , Value
jmp Leave_Search
;------------------
Leave_Search:
mov Esi , Root
Mov Index , 0
ret
Search Endp                 
;-----------------------------------------------------



Find_Min PROC 
mov eax , Esi
sub eax , Root
div Divisor
mov Index , eax
mov bl , 0
cmp [esi] , bl
je Print_Min
mov eax , Index
imul Multiplier
Add eax , 4
mov ebx , [esi]
mov min , ebx
Add Esi ,  Eax
invoke Find_Min 
jmp Leave_Find_Min
Print_Min:
mov edx , offset Prompt5
call crlf
call crlf
call writestring
mov eax , min
call writeint
jmp Leave_Find_Min
Leave_Find_Min:
mov esi , root
ret
Find_Min Endp
;-----------------------------------------------------


Find_Max PROC 
mov eax , Esi
sub eax , Root
div Divisor
mov Index , eax
mov bl , 0
cmp [esi] , bl
je Print_Max
mov eax , Index
imul Multiplier
Add eax , 8
mov ebx , [esi]
mov max , ebx
Add Esi ,  Eax
invoke Find_Max
jmp Leave_Find_Max
Print_Max:
mov edx , offset Prompt6
call crlf
call crlf
call writestring
mov eax , max
call writedec
jmp Leave_Find_Max
Leave_Find_Max:
mov esi , root
ret
Find_Max Endp
;-----------------------------------------------------

Delete_Leaf PROC , Value : Sdword   
mov ecx , Total_Nodes
mov eax , ecx
imul Multiplier
mov ecx , eax
mov eax , Value
Find_Value:
cmp [esi] , eax
je Delete_Value
add esi , 4
loop Find_Value
;---- Value Not Found Case -------
mov edx , offset Prompt7
call crlf
call writestring
call crlf
jmp Leave_Delete
;----- Delete Case -----------
Delete_Value:
mov eax , 0
mov [esi] , eax
dec Total_Nodes
mov edx , offset Prompt8
call crlf
call writestring
call crlf
jmp Leave_Delete
;----------------
Leave_Delete:
mov esi , root
ret
Delete_Leaf Endp
;----------------------------------------------------------------------


End Main