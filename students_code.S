.global hamming_weight, negate_first_k, bring_balance_to_the_word, read_input

.section .bss
.lcomm path, 1024

.section .text
read_input:
#rdi = codeword_ptr
push %rbp
mov %rsp,%rbp
mov %rdi,%r12
open_file:
lea path(%rip), %rdi
call get_path
mov $2,%rax
mov $0, %rsi
syscall

mov %rax,%rdi #rdi <- fd
push $0
mov %rsp,%rsi
mov $1,%rdx
xor %rbx,%rbx #i=0
get_input_len_loop:
  mov $0,%rax
  syscall
  cmpb $0xa, (%rsi)
  je get_input_len_end
  inc %rbx
  inc %rsi
  cmp $7,%rbx
  je get_input_len_end
  jmp get_input_len_loop
 
get_input_len_end:
  movb $0, (%rsi)
  mov %rdi,%r14
  mov %rsp,%rdi
  call atam_atol
  
mov %r14,%rdi 
mov %r12,%rsi
mov %rax,%rdx
mov $0,%rax
syscall

xor %rdx,%rdx
mov $8,%r12
div %r12
pop %rbp
pop %rbp
ret
  

hamming_weight:
  ret

negate_first_k:
  ret

bring_balance_to_the_word:
  ret
