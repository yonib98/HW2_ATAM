.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
  ####### Some smart student's code here #######
mov $to_print, %rdi
call print
iret
push %rbp
mov %rsp, %rbp
push %rax
push %rdi
push %rsi
push %rdx
push %rcx
push %r8
push %r9
push %r10
push %r11
mov 80(%rsp), %r11
movb (%r11), %cl
cmp $0x0F, %cl
jne one_byte_only
movb 1(%r11), %cl
movb %cl, %dil
call what_to_do
jmp finish_what_to_do

one_byte_only:
movb %cl, %dil
call what_to_do
jmp finish_what_to_do


finish_what_to_do:
pop %r11
pop %r10
pop %r9
pop %r8
pop %rcx
pop %rdx
pop %rsi
pop %rdi
cmp $0, %rax
je jump_to_original
mov %rax, %rdi
pop %rax
pop %rbp
add $8, (%rsp)
  iretq

jump_to_original:
pop %rax
pop %rbp
jmp old_ili_handler











