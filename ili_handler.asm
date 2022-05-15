.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
  pushq %rsi
  pushq %rbp
  pushq %rsp
  pushq %rax
  pushq %rbx
  pushq %rcx
  pushq %rdx
  pushq %r8
  pushq %r9
  pushq %r10
  pushq %r11
  pushq %r12
  pushq %r13
  pushq %r14
  pushq %r15

  xorq %rax, %rax
  xorq %rcx, %rcx
  xorq %rdi, %rdi
  movq 120(%rsp), %rcx
  movq (%rcx), %rcx
  cmpb $0x0f, %cl
  jne one_byte_opcode

two_byte_opcode:
  movb %ch, %al
  movq %rax, %rdi
  call what_to_do
  cmpq $0, %rax
  je default_ili_handler
  jmp modified_ili_handler 

one_byte__opcode:
  movb %cl, %al
  movq %rax, %rdi
  call what_to_do
  cmpq $0, %rax
  je default_ili_handler
  jmp modified_ili_handler

default_ili_handler:
  popq %rsi
  popq %rbp
  popq %rsp
  popq %rax
  popq %rbx
  popq %rcx
  popq %rdx
  popq %r8
  popq %r9
  popq %r10
  popq %r11
  popq %r12
  popq %r13
  popq %r14
  popq %r15
  jmp * old_ili_handler
  jmp end

modified_ili_handler:
  movq %rax, %rdi
  popq %rsi
  popq %rbp
  popq %rsp
  popq %rax
  popq %rbx
  popq %rcx
  popq %rdx
  popq %r8
  popq %r9
  popq %r10
  popq %r11
  popq %r12
  popq %r13
  popq %r14
  popq %r15
  addq $2, (%rsp)

end:
  iretq
