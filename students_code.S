.global hamming_weight, negate_first_k, bring_balance_to_the_word, read_input

.section .bss
.lcomm path, 1024

.section .text
read_input:
#rdi = codeword_ptr
push %rbp
mov %rsp,%rbp
push %r12
push %rbx
push %r14
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
mov %rax, %r12
mov $3, %rax
syscall
mov %r12, %rax
pop %rbp #intentionally 2 times pop
pop %r14
pop %rbx
pop %r12
pop %rbp
ret
  

hamming_weight:
#codeword_ptr <- rdi
#len <- rsi
push %rbp
mov %rsp,%rbp
push %rbx
cmp $0,%rsi
je hamming_weight_end
xor %rcx,%rcx #i=0
xor %rax,%rax #sum=0

weight_loop:
movq (%rdi,%rcx,8),%rbx
xor %rdx,%rdx
popcnt %rbx,%rdx
add %rdx,%rax
inc %rcx
cmp %rcx,%rsi
jne weight_loop

hamming_weight_end:
  pop %rbx
  pop %rbp
  ret

negate_first_k:
push %rbp
mov %rsp, %rbp
push %r14
xor %rcx, %rcx
xor %r14, %r14
cmp $0, %rdi
je negate_end

loop_negate_ones:
sal %r14
inc %r14
inc %rcx
cmp %rcx, %rsi
jne loop_negate_ones

negate_end:
xor %r14, %rdi
mov %rdi, %rax
pop %r14
pop %rbp
  ret

bring_balance_to_the_word:
push %rbp
mov %rsp, %rbp
push %r12
push %r13
push %r14
push %r15
push %rbx
#rdi- pointer to codeword, rsi-len
xor %rcx, %rcx #i from first to the len word
mov %rdi, %r12 #r12<-- pointer to codeword
mov %rsi, %r13 #r13<-- len
imul $32, %rsi, %rbx #rbx- the size of hamming weight

mov %r12, %rdi
mov %r13, %rsi
push %rcx
call hamming_weight
pop %rcx
cmp %rax,%rbx
je end_loops
negate_ext_loop:
movq (%r12, %rcx, 8), %r14 #current word working on
mov $1, %r15 #k
negate_int_loop:
mov %r14, %rdi
mov %r15, %rsi
push %rcx
call negate_first_k
pop %rcx
movq %rax, (%r12, %rcx, 8)
mov %r12, %rdi
mov %r13, %rsi
push %rcx
call hamming_weight
pop %rcx
cmp %rax, %rbx
je end_loops
inc %r15
cmp $65, %r15
jne negate_int_loop
inc %rcx
cmp %rcx, %r13
je end_loops
jmp negate_ext_loop


end_loops:
mov %r15, %rax
imul $64, %rcx
add %rcx, %rax
pop %rbx
pop %r15
pop %r14
pop %r13
pop %r12
pop %rbp
  ret
