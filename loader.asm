;========================================================= Загрузчик
BITS 16
; Настройка регистров
;	CLI
;	MOV AX, CS
;	MOV DS, AX
;	MOV ES, AX
;	MOV SS, AX
;	MOV BP, 0x7C00
;	MOV SP, 0x7C00
;	STI
; Включение видеорежима 80x25
	MOV AL, 0x02
	MOV AH, 0x00
	INT 10h
; Загрузка остальной ОС с носителя
	MOV AL, 0x06	; Количество загружаемых секторов
	MOV AH, 0x02	; Номер функции BIOS	; Логический номер диска MOV DL, 0x80
	MOV BX, 0x7E00	; Адрес загрузки данных в ОЗУ	; Номер головки MOV DH, 0x00
	MOV CL, 0x02	; Номер сектора, с которого начинается загрузка
	MOV CH, 0x00	; Номер цилиндра
	INT 0x13
; Загрузка GDT
	XOR AX, AX
	MOV DS, AX
	LGDT [GDT]
; Открытие линии A20
	IN AL, 0x92
	OR AL, 0x02
	OUT 0x92, AL
; Включение бита PE в регистре CR0
	MOV EAX, CR0
	OR AL, 0x01
	MOV CR0, EAX
; Запуск ядра операционной системы
	JMP 0x0008:OPERATION_SYSTEM
; GDT таблица
ALIGN 4
GDT_start:
	DD 0x00000000, 0x00000000	; Нулевой дескриптор
	DW 0xFFFF			; Сегмент кода
	DW 0x0000
	DB 0x00
	DB 10011010b
	DB 11001111b
	DB 0x00
	DW 0xFFFF			; Сегмент данных
	DW 0x0000
	DB 0x00
	DB 10010010b
	DB 11001111b
	DB 0x00
GDT:
	DW (GDT - GDT_start - 1)
	DD GDT_start
; Заполнение оставшегося места нулями
TIMES 0x1FE+$$-$ DB 0x00
	DB 0x55
	DB 0xAA

;========================================================= Подготовка операционной системы
BITS 32
OPERATION_SYSTEM:
	MOV AX, 0x10
	MOV DS, AX
	MOV ES, AX
	CLI
EXTERN main
	CALL main
	CLI
	HLT
	JMP $
;    mov ax, 0x1000
;    mov ax, ss
;    mov sp, 0xf000
;    mov ax, 0x5307
;    mov bx, 0x0001
;    mov cx, 0x0003
;    int 0x15
