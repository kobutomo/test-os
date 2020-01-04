BOOT_LOAD equ 0x7C00
ORG BOOT_LOAD

; ===================================
; マクロ
; ===================================
%include "../include/macro.s"

; ===================================
; エントリーポイント
; ===================================
entry:
  jmp ipl

  ; -------------------------
  ; BPB(BIOS Parameter Block)
  ; -------------------------
  times 90 - ($ - $$) db 0x90

; ===================================
; IPL(Initial Program Loader)
; ===================================
ipl:
  cli         ;割り込み禁止
  mov ax, 0x0000
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, BOOT_LOAD

  sti         ;割り込み許可
  mov [BOOT.DRIVE], dl

  cdecl puts, .s0

  jmp $

.s0 db "Booting...", 0x0A, 0x0D, 0 ; 0x0Aカーソルを行頭に, 0x0Dキャリッジリターン

ALIGN 2, db 0

BOOT:
.DRIVE: dw 0

; ===================================
; モジュール
; ===================================
%include "../modules/real/putc.s"
%include "../modules/real/puts.s"

  ; -------------------------
  ; ブートフラグ
  ; -------------------------
  times 510 - ($ - $$) db 0x00
  db 0x55, 0xAA