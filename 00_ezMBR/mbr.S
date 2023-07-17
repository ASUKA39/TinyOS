;主引导程序
;
SECTION MBR vstart=0x7c00
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax     ;cx=0，初始化寄存器
    mov sp, 0x7c00 ;栈顶（MBR之前的内存安全）

;利用0x60号中断清屏
;
;AH 功能号 = 0x60
;AL = 上卷行数（0为全部）
;BH = 上卷行属性
;(CL,CH) = 左上角(x,y)
;(DL,DH) = 右下角(x,y)
;
    mov ax, 0x600
    mov bx, 0x700
    mov cx, 0       ;(0,0)
    mov dx, 0x184f  ;(80.25)
    int 0x10

;获取光标，在此打印字符
;
    mov ah, 3
    mov bh, 0
    int 0x10

;打印字符串
;
    mov ax, message
    mov bp, ax
    mov cx, 5
    mov ax, 0x1301
    mov bx, 0x2
    int 0x10

;结束
;
    jmp $

    message db "1 MBR"
    times 510-($-$$) db 0
    db 0x55, 0xaa
