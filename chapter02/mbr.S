SECTION MBR vstart=0x7c00 ;1M内存中，MBR起始地址
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov fs, ax
	mov sp, 0x7c00

	mov ax, 0x600		  ;清屏利用功能号0x60(AH), 上卷的行数（AL）
	mov bx, 0x700		  ;上卷行属性（AH）
	mov cx, 0			  ;(CL, CH) = 窗口左上角的（X， Y）位置
	mov dx, 0x184f		  ;(DL, DH) = 窗口右下角的（X， Y）位置

	int 0x10			  ; 0x10中断
;以下三行获取光标位置，在光标位置打印字符
	mov ah, 3
	mov bh, 0

	int 0x10

;用x010中断，调用13号子功能打印字符串
	mov ax, message       

	mov bp, ax             ;es:bp 为串首地址，es此时同 cs一致
						   ;开头时已经为sreg初始化
	mov cx, 5			   ;cx为串长度，不包括结束符0的字符个数
	mov ax, 0x1301		   ;AH显示字符及属性
						   ;AL设置写字符方式
	mov bx, 0x2			   ;BH存储要显示的页号，此处是第0页
					       ;BL是字符属性

	int 0x10

	jmp $				   ;使程序悬停在此
	message db "1 MBR"
	times 510-($-$$) db 0
	db 0x55, 0xaa

