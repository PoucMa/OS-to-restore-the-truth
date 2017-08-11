;主引导程序

SECTION MBR vstart=0x7c00
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov sp, 0x7c00
    mov ax, 0xb800
    mov gs, ax

    mov ax, 0x600		  ;清屏利用功能号0x60(AH), 上卷的行数（AL）
    mov bx, 0x700		  ;上卷行属性（AH）
    mov cx, 0			  ;(CL, CH) = 窗口左上角的（X， Y）位置
    mov dx, 0x184f		  ;(DL, DH) = 窗口右下角的（X， Y）位置

    int 0x10			  ; 0x10中断

;输出背景色绿色，前景色红色，并且跳动的字符串“1 MBR”

    mov byte [gs:0x00], '1'
    mov byte [gs:0x01], 0xA4    ;A表示绿色背景闪烁，4表示前景色为红色

    mov byte [gs:0x02], ' '
    mov byte [gs:0x03], 0xA4

    mov byte [gs:0x04], 'M'
    mov byte [gs:0x05], 0xA4

    mov byte [gs:0x06], 'B'
    mov byte [gs:0x07], 0xA4

    mov byte [gs:0x08], 'R'
    mov byte [gs:0x09], 0xA4

    jmp $                       ;通过死循环使得程序悬停在此

    times 510-($-$$) db 0
    db 0x55, 0xaa



