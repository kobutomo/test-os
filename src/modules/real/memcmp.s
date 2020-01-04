; ========================
; メモリ比較
; ========================

memcmp:
              ; +8 バイト数
              ; +6 アドレス1
              ; +4 アドレス0
  push bp     ; +2 IP
  mov bp, sp  ; +0 BP

  ; =================
  ; レジスタの保存
  ; =================
  push bx
  push cx
  push dx
  push si
  push di

  ; =================
  ; 引数の取得
  ; =================
  cld
  mov si, [bp + 4]
  mov di, [bp + 6]
  mov cx, [bp + 8]

  ; =================
  ; バイト単位での比較
  ; =================
  repe cmpsb
  jnz .10F      ;jump not zero(一致したときジャンプ)
  mov ax, 0     ;return 0

.10F:
  mov ax, -1    ;return -1

.10E:
  ; =================
  ; レジスタの復帰
  ; =================
  pop di
  pop si
  pop dx
  pop cx
  pop bx


  ; =================
  ; スタックフレームの破棄
  ; =================
  mov sp, bp
  pop bp

  ret