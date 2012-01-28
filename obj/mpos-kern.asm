
obj/mpos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 d5 02 00 00       	call   1002ee <start>
  100019:	90                   	nop

0010001a <sys_int48_handler>:

# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 93 00 00 00       	call   1000f6 <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 56 b9 10 00    	add    %dl,0x10b956(%eax)

0010008c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10008c:	56                   	push   %esi
	pid_t pid = current->p_pid;
	while (1) {
		pid = (pid + 1) % NPROCS;
  10008d:	b9 10 00 00 00       	mov    $0x10,%ecx
 *
 *****************************************************************************/

void
schedule(void)
{
  100092:	53                   	push   %ebx
  100093:	83 ec 04             	sub    $0x4,%esp
	pid_t pid = current->p_pid;
  100096:	a1 2c 98 10 00       	mov    0x10982c,%eax
  10009b:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009d:	8d 42 01             	lea    0x1(%edx),%eax
  1000a0:	99                   	cltd   
  1000a1:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a3:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a6:	8d 98 90 8a 10 00    	lea    0x108a90(%eax),%ebx
  1000ac:	8d 73 40             	lea    0x40(%ebx),%esi
  1000af:	8b 5b 40             	mov    0x40(%ebx),%ebx
  1000b2:	83 fb 01             	cmp    $0x1,%ebx
  1000b5:	74 31                	je     1000e8 <schedule+0x5c>
			run(&proc_array[pid]);
        else if(proc_array[pid].p_state == P_BLOCKED)   //XIA: the process it is waiting have EXIT
  1000b7:	83 fb 02             	cmp    $0x2,%ebx
  1000ba:	75 e1                	jne    10009d <schedule+0x11>
        {
            if(proc_array[(proc_array[pid].wait_pid)].p_state == P_ZOMBIE)
  1000bc:	6b 98 88 8a 10 00 54 	imul   $0x54,0x108a88(%eax),%ebx
  1000c3:	83 bb d0 8a 10 00 03 	cmpl   $0x3,0x108ad0(%ebx)
  1000ca:	75 d1                	jne    10009d <schedule+0x11>
            {
                proc_array[pid].p_registers.reg_eax = proc_array[proc_array[pid].wait_pid].p_exit_status;
  1000cc:	8b 93 d4 8a 10 00    	mov    0x108ad4(%ebx),%edx
	//	proc_array[proc_array[pid].wait_pid].p_state = P_EMPTY; //SK:set the zombie process's status as empty
//		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now empty by schedule\n",proc_array[proc_array[pid].wait_pid]);
		
//		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now scheduled\n",pid);
                proc_array[pid].p_state = P_RUNNABLE;
  1000d2:	c7 06 01 00 00 00    	movl   $0x1,(%esi)
                proc_array[pid].wait_pid = -1;
  1000d8:	c7 80 88 8a 10 00 ff 	movl   $0xffffffff,0x108a88(%eax)
  1000df:	ff ff ff 
			run(&proc_array[pid]);
        else if(proc_array[pid].p_state == P_BLOCKED)   //XIA: the process it is waiting have EXIT
        {
            if(proc_array[(proc_array[pid].wait_pid)].p_state == P_ZOMBIE)
            {
                proc_array[pid].p_registers.reg_eax = proc_array[proc_array[pid].wait_pid].p_exit_status;
  1000e2:	89 90 a8 8a 10 00    	mov    %edx,0x108aa8(%eax)
//		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now empty by schedule\n",proc_array[proc_array[pid].wait_pid]);
		
//		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now scheduled\n",pid);
                proc_array[pid].p_state = P_RUNNABLE;
                proc_array[pid].wait_pid = -1;
                run(&proc_array[pid]);
  1000e8:	83 ec 0c             	sub    $0xc,%esp
  1000eb:	05 84 8a 10 00       	add    $0x108a84,%eax
  1000f0:	50                   	push   %eax
  1000f1:	e8 1a 04 00 00       	call   100510 <run>

001000f6 <interrupt>:
static pid_t do_fork(process_t *parent);
static pid_t do_newthread(void (*start_function)(void),process_t *parent);

void
interrupt(registers_t *reg)
{
  1000f6:	55                   	push   %ebp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000f7:	b9 11 00 00 00       	mov    $0x11,%ecx
static pid_t do_fork(process_t *parent);
static pid_t do_newthread(void (*start_function)(void),process_t *parent);

void
interrupt(registers_t *reg)
{
  1000fc:	57                   	push   %edi
  1000fd:	56                   	push   %esi
  1000fe:	53                   	push   %ebx
  1000ff:	83 ec 1c             	sub    $0x1c,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  100102:	8b 1d 2c 98 10 00    	mov    0x10982c,%ebx
static pid_t do_fork(process_t *parent);
static pid_t do_newthread(void (*start_function)(void),process_t *parent);

void
interrupt(registers_t *reg)
{
  100108:	8b 44 24 30          	mov    0x30(%esp),%eax
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  10010c:	8d 7b 08             	lea    0x8(%ebx),%edi
  10010f:	89 c6                	mov    %eax,%esi
  100111:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100113:	8b 40 28             	mov    0x28(%eax),%eax
  100116:	83 e8 30             	sub    $0x30,%eax
  100119:	83 f8 06             	cmp    $0x6,%eax
  10011c:	0f 87 ca 01 00 00    	ja     1002ec <interrupt+0x1f6>
  100122:	ff 24 85 c8 0a 10 00 	jmp    *0x100ac8(,%eax,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  100129:	8b 03                	mov    (%ebx),%eax
		run(current);
  10012b:	83 ec 0c             	sub    $0xc,%esp
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  10012e:	89 43 24             	mov    %eax,0x24(%ebx)
		run(current);
  100131:	53                   	push   %ebx
  100132:	e9 93 00 00 00       	jmp    1001ca <interrupt+0xd4>
  100137:	b8 24 8b 10 00       	mov    $0x108b24,%eax
  10013c:	ba 01 00 00 00       	mov    $0x1,%edx
    
    pid_t child = -1;
    int i = 1;
    while(i < NPROCS)
    {
        if(proc_array[i].p_state == P_EMPTY)
  100141:	83 38 00             	cmpl   $0x0,(%eax)
  100144:	74 0e                	je     100154 <interrupt+0x5e>
        {    
            child = i;
            break;
        }
        i++;
  100146:	42                   	inc    %edx
  100147:	83 c0 54             	add    $0x54,%eax
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.
    
    pid_t child = -1;
    int i = 1;
    while(i < NPROCS)
  10014a:	83 fa 10             	cmp    $0x10,%edx
  10014d:	75 f2                	jne    100141 <interrupt+0x4b>
  10014f:	83 ca ff             	or     $0xffffffff,%edx
  100152:	eb 6a                	jmp    1001be <interrupt+0xc8>
    }
    
    if(child == -1)
        return -1;
            
    proc_array[child].p_registers = (*parent).p_registers;  //initialize process descriptor
  100154:	6b ea 54             	imul   $0x54,%edx,%ebp
  100157:	b9 11 00 00 00       	mov    $0x11,%ecx
  10015c:	8d 73 08             	lea    0x8(%ebx),%esi
  10015f:	8d 85 84 8a 10 00    	lea    0x108a84(%ebp),%eax
  100165:	89 c7                	mov    %eax,%edi
  100167:	83 c7 08             	add    $0x8,%edi
  10016a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	dest_stack_bottom =  dest_stack_top - (src_stack_top - src_stack_bottom);
  10016c:	8b b5 84 8a 10 00    	mov    0x108a84(%ebp),%esi
    }
    
    if(child == -1)
        return -1;
            
    proc_array[child].p_registers = (*parent).p_registers;  //initialize process descriptor
  100172:	89 44 24 0c          	mov    %eax,0xc(%esp)
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
  100176:	8b 03                	mov    (%ebx),%eax
	src_stack_bottom = src->p_registers.reg_esp;
  100178:	8b 4b 44             	mov    0x44(%ebx),%ecx
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	dest_stack_bottom =  dest_stack_top - (src_stack_top - src_stack_bottom);
  10017b:	c1 e6 12             	shl    $0x12,%esi
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
  10017e:	83 c0 0a             	add    $0xa,%eax
  100181:	c1 e0 12             	shl    $0x12,%eax
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	dest_stack_bottom =  dest_stack_top - (src_stack_top - src_stack_bottom);
  100184:	8d b4 0e 00 00 28 00 	lea    0x280000(%esi,%ecx,1),%esi
    /* YOUR CODE HERE: calculate based on the other variables */
    
    memcpy((void*)dest_stack_bottom,(void*)src_stack_bottom, (src_stack_top-src_stack_bottom));
  10018b:	57                   	push   %edi
	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	dest_stack_bottom =  dest_stack_top - (src_stack_top - src_stack_bottom);
  10018c:	29 c6                	sub    %eax,%esi
    /* YOUR CODE HERE: calculate based on the other variables */
    
    memcpy((void*)dest_stack_bottom,(void*)src_stack_bottom, (src_stack_top-src_stack_bottom));
  10018e:	29 c8                	sub    %ecx,%eax
  100190:	50                   	push   %eax
  100191:	51                   	push   %ecx
  100192:	56                   	push   %esi
  100193:	89 54 24 18          	mov    %edx,0x18(%esp)
  100197:	e8 4c 04 00 00       	call   1005e8 <memcpy>
    dest->p_registers.reg_esp = dest_stack_bottom;
  10019c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
            
    proc_array[child].p_registers = (*parent).p_registers;  //initialize process descriptor
    copy_stack(&proc_array[child],parent);          //copy stack 
    
    proc_array[child].p_state = P_RUNNABLE;         //initialize process state
    proc_array[child].p_registers.reg_eax = 0;      //return 0 to child process
  1001a0:	83 c4 10             	add    $0x10,%esp
  1001a3:	8b 54 24 08          	mov    0x8(%esp),%edx
        return -1;
            
    proc_array[child].p_registers = (*parent).p_registers;  //initialize process descriptor
    copy_stack(&proc_array[child],parent);          //copy stack 
    
    proc_array[child].p_state = P_RUNNABLE;         //initialize process state
  1001a7:	c7 85 d0 8a 10 00 01 	movl   $0x1,0x108ad0(%ebp)
  1001ae:	00 00 00 
    proc_array[child].p_registers.reg_eax = 0;      //return 0 to child process
  1001b1:	c7 85 a8 8a 10 00 00 	movl   $0x0,0x108aa8(%ebp)
  1001b8:	00 00 00 
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	dest_stack_bottom =  dest_stack_top - (src_stack_top - src_stack_bottom);
    /* YOUR CODE HERE: calculate based on the other variables */
    
    memcpy((void*)dest_stack_bottom,(void*)src_stack_bottom, (src_stack_top-src_stack_bottom));
    dest->p_registers.reg_esp = dest_stack_bottom;
  1001bb:	89 70 44             	mov    %esi,0x44(%eax)
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  1001be:	89 53 24             	mov    %edx,0x24(%ebx)
		run(current);
  1001c1:	83 ec 0c             	sub    $0xc,%esp
  1001c4:	ff 35 2c 98 10 00    	pushl  0x10982c
  1001ca:	e8 41 03 00 00       	call   100510 <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  1001cf:	e8 b8 fe ff ff       	call   10008c <schedule>
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  1001d4:	a1 2c 98 10 00       	mov    0x10982c,%eax
		current->p_exit_status = current->p_registers.reg_eax;
  1001d9:	8b 50 24             	mov    0x24(%eax),%edx
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  1001dc:	c7 40 4c 03 00 00 00 	movl   $0x3,0x4c(%eax)
		current->p_exit_status = current->p_registers.reg_eax;
  1001e3:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  1001e6:	e8 a1 fe ff ff       	call   10008c <schedule>
		else
			current->p_registers.reg_eax = WAIT_TRYAGAIN;
		schedule();
        	*/
		
        	pid_t p = current->p_registers.reg_eax;
  1001eb:	a1 2c 98 10 00       	mov    0x10982c,%eax
  1001f0:	8b 50 24             	mov    0x24(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001f3:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001f6:	83 f9 0e             	cmp    $0xe,%ecx
  1001f9:	77 14                	ja     10020f <interrupt+0x119>
  1001fb:	3b 10                	cmp    (%eax),%edx
  1001fd:	74 10                	je     10020f <interrupt+0x119>
		    || proc_array[p].p_state == P_EMPTY)
  1001ff:	6b da 54             	imul   $0x54,%edx,%ebx
  100202:	8d 8b 90 8a 10 00    	lea    0x108a90(%ebx),%ecx
  100208:	8b 71 40             	mov    0x40(%ecx),%esi
			current->p_registers.reg_eax = WAIT_TRYAGAIN;
		schedule();
        	*/
		
        	pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  10020b:	85 f6                	test   %esi,%esi
  10020d:	75 09                	jne    100218 <interrupt+0x122>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  10020f:	c7 40 24 ff ff ff ff 	movl   $0xffffffff,0x24(%eax)
			current->p_registers.reg_eax = WAIT_TRYAGAIN;
		schedule();
        	*/
		
        	pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100216:	eb 21                	jmp    100239 <interrupt+0x143>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE){
  100218:	83 fe 03             	cmp    $0x3,%esi
  10021b:	75 12                	jne    10022f <interrupt+0x139>
			current->p_registers.reg_eax = proc_array[p].p_exit_status;        		
  10021d:	8b 93 d4 8a 10 00    	mov    0x108ad4(%ebx),%edx
			proc_array[p].p_state = P_EMPTY;	
  100223:	c7 41 40 00 00 00 00 	movl   $0x0,0x40(%ecx)
        	pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE){
			current->p_registers.reg_eax = proc_array[p].p_exit_status;        		
  10022a:	89 50 24             	mov    %edx,0x24(%eax)
  10022d:	eb 0a                	jmp    100239 <interrupt+0x143>
			proc_array[p].p_state = P_EMPTY;	
		}
		else
        	{
        	    current->p_state = P_BLOCKED;
  10022f:	c7 40 4c 02 00 00 00 	movl   $0x2,0x4c(%eax)
        	    current->wait_pid = p;
  100236:	89 50 04             	mov    %edx,0x4(%eax)
        	}
        	schedule();
  100239:	e8 4e fe ff ff       	call   10008c <schedule>
	    }
            
	case INT_SYS_KILL:{
		pid_t p = current->p_registers.reg_eax;
  10023e:	a1 2c 98 10 00       	mov    0x10982c,%eax
  100243:	8b 50 24             	mov    0x24(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid 
  100246:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100249:	83 f9 0e             	cmp    $0xe,%ecx
  10024c:	77 14                	ja     100262 <interrupt+0x16c>
  10024e:	3b 10                	cmp    (%eax),%edx
  100250:	74 10                	je     100262 <interrupt+0x16c>
		    || proc_array[p].p_state == P_EMPTY)
  100252:	6b d2 54             	imul   $0x54,%edx,%edx
  100255:	8d 8a 90 8a 10 00    	lea    0x108a90(%edx),%ecx
  10025b:	8b 59 40             	mov    0x40(%ecx),%ebx
        	schedule();
	    }
            
	case INT_SYS_KILL:{
		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid 
  10025e:	85 db                	test   %ebx,%ebx
  100260:	75 09                	jne    10026b <interrupt+0x175>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  100262:	c7 40 24 ff ff ff ff 	movl   $0xffffffff,0x24(%eax)
        	schedule();
	    }
            
	case INT_SYS_KILL:{
		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid 
  100269:	eb 78                	jmp    1002e3 <interrupt+0x1ed>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if(proc_array[p].p_state != P_ZOMBIE){
  10026b:	83 fb 03             	cmp    $0x3,%ebx
  10026e:	74 11                	je     100281 <interrupt+0x18b>
			proc_array[p].p_state = P_ZOMBIE;
  100270:	c7 41 40 03 00 00 00 	movl   $0x3,0x40(%ecx)
			proc_array[p].p_exit_status = -1;
  100277:	c7 82 d4 8a 10 00 ff 	movl   $0xffffffff,0x108ad4(%edx)
  10027e:	ff ff ff 
			current->p_registers.reg_eax = 1;
		}
		else{
			current->p_registers.reg_eax = 1;
  100281:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  100288:	eb 59                	jmp    1002e3 <interrupt+0x1ed>
    }
            //XIA: new thread
    case INT_SYS_NEWTHREAD:{
//        cursorpos = console_printf(cursorpos, 0x0700, "new Thread in kernel\n");
        
        void (*f)(void) = (void(*)(void)) current->p_registers.reg_eax;
  10028a:	8b 7b 24             	mov    0x24(%ebx),%edi
  10028d:	b8 24 8b 10 00       	mov    $0x108b24,%eax
  100292:	bb 01 00 00 00       	mov    $0x1,%ebx
{
    pid_t new = -1;
    int i = 1;
    while(i < NPROCS)
    {
        if(proc_array[i].p_state == P_EMPTY)
  100297:	83 38 00             	cmpl   $0x0,(%eax)
  10029a:	74 0e                	je     1002aa <interrupt+0x1b4>
        {    
            new = i;
            break;
        }
        i++;
  10029c:	43                   	inc    %ebx
  10029d:	83 c0 54             	add    $0x54,%eax
static pid_t 
do_newthread(void (*start_function)(void),process_t *parent)
{
    pid_t new = -1;
    int i = 1;
    while(i < NPROCS)
  1002a0:	83 fb 10             	cmp    $0x10,%ebx
  1002a3:	75 f2                	jne    100297 <interrupt+0x1a1>
  1002a5:	83 cb ff             	or     $0xffffffff,%ebx
  1002a8:	eb 31                	jmp    1002db <interrupt+0x1e5>
    }
    if(new == -1)
        return -1;
    
    //proc_array[new].p_registers = (*parent).p_registers; 
    special_registers_init(&proc_array[new]);
  1002aa:	6b f3 54             	imul   $0x54,%ebx,%esi
  1002ad:	83 ec 0c             	sub    $0xc,%esp
  1002b0:	8d 86 84 8a 10 00    	lea    0x108a84(%esi),%eax
  1002b6:	50                   	push   %eax
  1002b7:	e8 6b 02 00 00       	call   100527 <special_registers_init>
    //fail to load the program   don't have solution yet
    proc_array[new].p_registers.reg_eip = (int)start_function;//this line needs modification
    proc_array[new].p_registers.reg_esp = PROC1_STACK_ADDR + new * PROC_STACK_SIZE;
  1002bc:	8d 43 0a             	lea    0xa(%ebx),%eax
    proc_array[new].p_state = P_RUNNABLE; 
  1002bf:	83 c4 10             	add    $0x10,%esp
    
    //proc_array[new].p_registers = (*parent).p_registers; 
    special_registers_init(&proc_array[new]);
    //fail to load the program   don't have solution yet
    proc_array[new].p_registers.reg_eip = (int)start_function;//this line needs modification
    proc_array[new].p_registers.reg_esp = PROC1_STACK_ADDR + new * PROC_STACK_SIZE;
  1002c2:	c1 e0 12             	shl    $0x12,%eax
        return -1;
    
    //proc_array[new].p_registers = (*parent).p_registers; 
    special_registers_init(&proc_array[new]);
    //fail to load the program   don't have solution yet
    proc_array[new].p_registers.reg_eip = (int)start_function;//this line needs modification
  1002c5:	89 be bc 8a 10 00    	mov    %edi,0x108abc(%esi)
    proc_array[new].p_registers.reg_esp = PROC1_STACK_ADDR + new * PROC_STACK_SIZE;
  1002cb:	89 86 c8 8a 10 00    	mov    %eax,0x108ac8(%esi)
    proc_array[new].p_state = P_RUNNABLE; 
  1002d1:	c7 86 d0 8a 10 00 01 	movl   $0x1,0x108ad0(%esi)
  1002d8:	00 00 00 
    case INT_SYS_NEWTHREAD:{
//        cursorpos = console_printf(cursorpos, 0x0700, "new Thread in kernel\n");
        
        void (*f)(void) = (void(*)(void)) current->p_registers.reg_eax;
        pid_t new = do_newthread(f,current);
        current->p_registers.reg_eax = new;
  1002db:	a1 2c 98 10 00       	mov    0x10982c,%eax
  1002e0:	89 58 24             	mov    %ebx,0x24(%eax)
        
//        cursorpos = console_printf(cursorpos, 0x0700, "new Thread in kernel\n");
        run(current);
  1002e3:	83 ec 0c             	sub    $0xc,%esp
  1002e6:	50                   	push   %eax
  1002e7:	e9 de fe ff ff       	jmp    1001ca <interrupt+0xd4>
  1002ec:	eb fe                	jmp    1002ec <interrupt+0x1f6>

001002ee <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1002ee:	53                   	push   %ebx
  1002ef:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002f2:	68 40 05 00 00       	push   $0x540
  1002f7:	6a 00                	push   $0x0
  1002f9:	68 84 8a 10 00       	push   $0x108a84
  1002fe:	e8 49 03 00 00       	call   10064c <memset>
  100303:	b8 84 8a 10 00       	mov    $0x108a84,%eax
  100308:	31 d2                	xor    %edx,%edx
  10030a:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10030d:	89 10                	mov    %edx,(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10030f:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100310:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
        proc_array[i].wait_pid = -1;        //XIA: initializing waiting pid
  100317:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10031e:	83 c0 54             	add    $0x54,%eax
  100321:	83 fa 10             	cmp    $0x10,%edx
  100324:	75 e7                	jne    10030d <start+0x1f>
		proc_array[i].p_state = P_EMPTY;
        proc_array[i].wait_pid = -1;        //XIA: initializing waiting pid
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100326:	c7 05 2c 98 10 00 d8 	movl   $0x108ad8,0x10982c
  10032d:	8a 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  100330:	e8 73 00 00 00       	call   1003a8 <segments_init>
	special_registers_init(current);
  100335:	83 ec 0c             	sub    $0xc,%esp
  100338:	ff 35 2c 98 10 00    	pushl  0x10982c
  10033e:	e8 e4 01 00 00       	call   100527 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  100343:	e8 2f 01 00 00       	call   100477 <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  100348:	83 c4 0c             	add    $0xc,%esp
  10034b:	68 e4 0a 10 00       	push   $0x100ae4
  100350:	68 00 07 00 00       	push   $0x700
  100355:	ff 35 00 00 06 00    	pushl  0x60000
  10035b:	e8 4e 07 00 00       	call   100aae <console_printf>
  100360:	83 c4 10             	add    $0x10,%esp
  100363:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  100368:	e8 4d 01 00 00       	call   1004ba <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  10036d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100370:	83 fb 01             	cmp    $0x1,%ebx
  100373:	77 f3                	ja     100368 <start+0x7a>
	console_clear();
  100375:	e8 fd 00 00 00       	call   100477 <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  10037a:	50                   	push   %eax
  10037b:	50                   	push   %eax
  10037c:	a1 2c 98 10 00       	mov    0x10982c,%eax
  100381:	83 c0 38             	add    $0x38,%eax
  100384:	50                   	push   %eax
  100385:	53                   	push   %ebx
  100386:	e8 d1 01 00 00       	call   10055c <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  10038b:	a1 2c 98 10 00       	mov    0x10982c,%eax
  100390:	c7 40 44 00 00 2c 00 	movl   $0x2c0000,0x44(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  100397:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)

	// Switch to the main process using run().
	run(current);
  10039e:	89 04 24             	mov    %eax,(%esp)
  1003a1:	e8 6a 01 00 00       	call   100510 <run>
  1003a6:	90                   	nop
  1003a7:	90                   	nop

001003a8 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003a8:	b8 c4 8f 10 00       	mov    $0x108fc4,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003ad:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b2:	89 c2                	mov    %eax,%edx
  1003b4:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003b7:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003b8:	bb 56 00 10 00       	mov    $0x100056,%ebx
  1003bd:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003c0:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1003c6:	c1 e8 18             	shr    $0x18,%eax
  1003c9:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003cf:	ba 2c 90 10 00       	mov    $0x10902c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003d4:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003d9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003db:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1003e2:	68 00 
  1003e4:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003eb:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003f2:	c7 05 c8 8f 10 00 00 	movl   $0x80000,0x108fc8
  1003f9:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003fc:	66 c7 05 cc 8f 10 00 	movw   $0x10,0x108fcc
  100403:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100405:	66 89 0c c5 2c 90 10 	mov    %cx,0x10902c(,%eax,8)
  10040c:	00 
  10040d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100414:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100419:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10041e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100423:	40                   	inc    %eax
  100424:	3d 00 01 00 00       	cmp    $0x100,%eax
  100429:	75 da                	jne    100405 <segments_init+0x5d>
  10042b:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10042f:	ba 2c 90 10 00       	mov    $0x10902c,%edx
  100434:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  10043b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100442:	66 89 0c c5 2c 90 10 	mov    %cx,0x10902c(,%eax,8)
  100449:	00 
  10044a:	c1 e9 10             	shr    $0x10,%ecx
  10044d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100452:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100457:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  10045c:	40                   	inc    %eax
  10045d:	83 f8 3a             	cmp    $0x3a,%eax
  100460:	75 d2                	jne    100434 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100462:	b0 28                	mov    $0x28,%al
  100464:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10046b:	0f 00 d8             	ltr    %ax
  10046e:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100475:	5b                   	pop    %ebx
  100476:	c3                   	ret    

00100477 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100477:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100478:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10047a:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10047b:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  100482:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100485:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  10048c:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10048f:	40                   	inc    %eax
  100490:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100495:	75 ee                	jne    100485 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100497:	be d4 03 00 00       	mov    $0x3d4,%esi
  10049c:	b0 0e                	mov    $0xe,%al
  10049e:	89 f2                	mov    %esi,%edx
  1004a0:	ee                   	out    %al,(%dx)
  1004a1:	31 c9                	xor    %ecx,%ecx
  1004a3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004a8:	88 c8                	mov    %cl,%al
  1004aa:	89 da                	mov    %ebx,%edx
  1004ac:	ee                   	out    %al,(%dx)
  1004ad:	b0 0f                	mov    $0xf,%al
  1004af:	89 f2                	mov    %esi,%edx
  1004b1:	ee                   	out    %al,(%dx)
  1004b2:	88 c8                	mov    %cl,%al
  1004b4:	89 da                	mov    %ebx,%edx
  1004b6:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004b7:	5b                   	pop    %ebx
  1004b8:	5e                   	pop    %esi
  1004b9:	c3                   	ret    

001004ba <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004ba:	ba 64 00 00 00       	mov    $0x64,%edx
  1004bf:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004c0:	a8 01                	test   $0x1,%al
  1004c2:	74 45                	je     100509 <console_read_digit+0x4f>
  1004c4:	b2 60                	mov    $0x60,%dl
  1004c6:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004c7:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004ca:	80 fa 08             	cmp    $0x8,%dl
  1004cd:	77 05                	ja     1004d4 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004cf:	0f b6 c0             	movzbl %al,%eax
  1004d2:	48                   	dec    %eax
  1004d3:	c3                   	ret    
	else if (data == 0x0B)
  1004d4:	3c 0b                	cmp    $0xb,%al
  1004d6:	74 35                	je     10050d <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004d8:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004db:	80 fa 02             	cmp    $0x2,%dl
  1004de:	77 07                	ja     1004e7 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004e0:	0f b6 c0             	movzbl %al,%eax
  1004e3:	83 e8 40             	sub    $0x40,%eax
  1004e6:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004e7:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004ea:	80 fa 02             	cmp    $0x2,%dl
  1004ed:	77 07                	ja     1004f6 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004ef:	0f b6 c0             	movzbl %al,%eax
  1004f2:	83 e8 47             	sub    $0x47,%eax
  1004f5:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004f6:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004f9:	80 fa 02             	cmp    $0x2,%dl
  1004fc:	77 07                	ja     100505 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004fe:	0f b6 c0             	movzbl %al,%eax
  100501:	83 e8 4e             	sub    $0x4e,%eax
  100504:	c3                   	ret    
	else if (data == 0x53)
  100505:	3c 53                	cmp    $0x53,%al
  100507:	74 04                	je     10050d <console_read_digit+0x53>
  100509:	83 c8 ff             	or     $0xffffffff,%eax
  10050c:	c3                   	ret    
  10050d:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10050f:	c3                   	ret    

00100510 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100510:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100514:	a3 2c 98 10 00       	mov    %eax,0x10982c

	asm volatile("movl %0,%%esp\n\t"
  100519:	83 c0 08             	add    $0x8,%eax
  10051c:	89 c4                	mov    %eax,%esp
  10051e:	61                   	popa   
  10051f:	07                   	pop    %es
  100520:	1f                   	pop    %ds
  100521:	83 c4 08             	add    $0x8,%esp
  100524:	cf                   	iret   
  100525:	eb fe                	jmp    100525 <run+0x15>

00100527 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100527:	53                   	push   %ebx
  100528:	83 ec 0c             	sub    $0xc,%esp
  10052b:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10052f:	6a 44                	push   $0x44
  100531:	6a 00                	push   $0x0
  100533:	8d 43 08             	lea    0x8(%ebx),%eax
  100536:	50                   	push   %eax
  100537:	e8 10 01 00 00       	call   10064c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  10053c:	66 c7 43 3c 1b 00    	movw   $0x1b,0x3c(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100542:	66 c7 43 2c 23 00    	movw   $0x23,0x2c(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100548:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10054e:	66 c7 43 48 23 00    	movw   $0x23,0x48(%ebx)
}
  100554:	83 c4 18             	add    $0x18,%esp
  100557:	5b                   	pop    %ebx
  100558:	c3                   	ret    
  100559:	90                   	nop
  10055a:	90                   	nop
  10055b:	90                   	nop

0010055c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10055c:	55                   	push   %ebp
  10055d:	57                   	push   %edi
  10055e:	56                   	push   %esi
  10055f:	53                   	push   %ebx
  100560:	83 ec 1c             	sub    $0x1c,%esp
  100563:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100567:	83 f8 01             	cmp    $0x1,%eax
  10056a:	7f 04                	jg     100570 <program_loader+0x14>
  10056c:	85 c0                	test   %eax,%eax
  10056e:	79 02                	jns    100572 <program_loader+0x16>
  100570:	eb fe                	jmp    100570 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100572:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100579:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10057f:	74 02                	je     100583 <program_loader+0x27>
  100581:	eb fe                	jmp    100581 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100583:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100586:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10058a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10058c:	c1 e5 05             	shl    $0x5,%ebp
  10058f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100592:	eb 3f                	jmp    1005d3 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100594:	83 3b 01             	cmpl   $0x1,(%ebx)
  100597:	75 37                	jne    1005d0 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100599:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10059c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10059f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005a2:	01 c7                	add    %eax,%edi
	memsz += va;
  1005a4:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005a6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005ab:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005af:	52                   	push   %edx
  1005b0:	89 fa                	mov    %edi,%edx
  1005b2:	29 c2                	sub    %eax,%edx
  1005b4:	52                   	push   %edx
  1005b5:	8b 53 04             	mov    0x4(%ebx),%edx
  1005b8:	01 f2                	add    %esi,%edx
  1005ba:	52                   	push   %edx
  1005bb:	50                   	push   %eax
  1005bc:	e8 27 00 00 00       	call   1005e8 <memcpy>
  1005c1:	83 c4 10             	add    $0x10,%esp
  1005c4:	eb 04                	jmp    1005ca <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005c6:	c6 07 00             	movb   $0x0,(%edi)
  1005c9:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005ca:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005ce:	72 f6                	jb     1005c6 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005d0:	83 c3 20             	add    $0x20,%ebx
  1005d3:	39 eb                	cmp    %ebp,%ebx
  1005d5:	72 bd                	jb     100594 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005d7:	8b 56 18             	mov    0x18(%esi),%edx
  1005da:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005de:	89 10                	mov    %edx,(%eax)
}
  1005e0:	83 c4 1c             	add    $0x1c,%esp
  1005e3:	5b                   	pop    %ebx
  1005e4:	5e                   	pop    %esi
  1005e5:	5f                   	pop    %edi
  1005e6:	5d                   	pop    %ebp
  1005e7:	c3                   	ret    

001005e8 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005e8:	56                   	push   %esi
  1005e9:	31 d2                	xor    %edx,%edx
  1005eb:	53                   	push   %ebx
  1005ec:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005f0:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005f4:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005f8:	eb 08                	jmp    100602 <memcpy+0x1a>
		*d++ = *s++;
  1005fa:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005fd:	4e                   	dec    %esi
  1005fe:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100601:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100602:	85 f6                	test   %esi,%esi
  100604:	75 f4                	jne    1005fa <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100606:	5b                   	pop    %ebx
  100607:	5e                   	pop    %esi
  100608:	c3                   	ret    

00100609 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100609:	57                   	push   %edi
  10060a:	56                   	push   %esi
  10060b:	53                   	push   %ebx
  10060c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100610:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100614:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100618:	39 c7                	cmp    %eax,%edi
  10061a:	73 26                	jae    100642 <memmove+0x39>
  10061c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10061f:	39 c6                	cmp    %eax,%esi
  100621:	76 1f                	jbe    100642 <memmove+0x39>
		s += n, d += n;
  100623:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100626:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100628:	eb 07                	jmp    100631 <memmove+0x28>
			*--d = *--s;
  10062a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10062d:	4a                   	dec    %edx
  10062e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100631:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100632:	85 d2                	test   %edx,%edx
  100634:	75 f4                	jne    10062a <memmove+0x21>
  100636:	eb 10                	jmp    100648 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100638:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10063b:	4a                   	dec    %edx
  10063c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10063f:	41                   	inc    %ecx
  100640:	eb 02                	jmp    100644 <memmove+0x3b>
  100642:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100644:	85 d2                	test   %edx,%edx
  100646:	75 f0                	jne    100638 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100648:	5b                   	pop    %ebx
  100649:	5e                   	pop    %esi
  10064a:	5f                   	pop    %edi
  10064b:	c3                   	ret    

0010064c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10064c:	53                   	push   %ebx
  10064d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100651:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100655:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100659:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10065b:	eb 04                	jmp    100661 <memset+0x15>
		*p++ = c;
  10065d:	88 1a                	mov    %bl,(%edx)
  10065f:	49                   	dec    %ecx
  100660:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100661:	85 c9                	test   %ecx,%ecx
  100663:	75 f8                	jne    10065d <memset+0x11>
		*p++ = c;
	return v;
}
  100665:	5b                   	pop    %ebx
  100666:	c3                   	ret    

00100667 <strlen>:

size_t
strlen(const char *s)
{
  100667:	8b 54 24 04          	mov    0x4(%esp),%edx
  10066b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10066d:	eb 01                	jmp    100670 <strlen+0x9>
		++n;
  10066f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100670:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100674:	75 f9                	jne    10066f <strlen+0x8>
		++n;
	return n;
}
  100676:	c3                   	ret    

00100677 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100677:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10067b:	31 c0                	xor    %eax,%eax
  10067d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100681:	eb 01                	jmp    100684 <strnlen+0xd>
		++n;
  100683:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100684:	39 d0                	cmp    %edx,%eax
  100686:	74 06                	je     10068e <strnlen+0x17>
  100688:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10068c:	75 f5                	jne    100683 <strnlen+0xc>
		++n;
	return n;
}
  10068e:	c3                   	ret    

0010068f <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10068f:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100690:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100695:	53                   	push   %ebx
  100696:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100698:	76 05                	jbe    10069f <console_putc+0x10>
  10069a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10069f:	80 fa 0a             	cmp    $0xa,%dl
  1006a2:	75 2c                	jne    1006d0 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006a4:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006aa:	be 50 00 00 00       	mov    $0x50,%esi
  1006af:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006b1:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006b4:	99                   	cltd   
  1006b5:	f7 fe                	idiv   %esi
  1006b7:	89 de                	mov    %ebx,%esi
  1006b9:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006bb:	eb 07                	jmp    1006c4 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006bd:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006c0:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1006c1:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006c4:	83 f8 50             	cmp    $0x50,%eax
  1006c7:	75 f4                	jne    1006bd <console_putc+0x2e>
  1006c9:	29 d0                	sub    %edx,%eax
  1006cb:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006ce:	eb 0b                	jmp    1006db <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006d0:	0f b6 d2             	movzbl %dl,%edx
  1006d3:	09 ca                	or     %ecx,%edx
  1006d5:	66 89 13             	mov    %dx,(%ebx)
  1006d8:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006db:	5b                   	pop    %ebx
  1006dc:	5e                   	pop    %esi
  1006dd:	c3                   	ret    

001006de <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006de:	56                   	push   %esi
  1006df:	53                   	push   %ebx
  1006e0:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006e4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006e7:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006eb:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006f0:	75 04                	jne    1006f6 <fill_numbuf+0x18>
  1006f2:	85 d2                	test   %edx,%edx
  1006f4:	74 10                	je     100706 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006f6:	89 d0                	mov    %edx,%eax
  1006f8:	31 d2                	xor    %edx,%edx
  1006fa:	f7 f1                	div    %ecx
  1006fc:	4b                   	dec    %ebx
  1006fd:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100700:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100702:	89 c2                	mov    %eax,%edx
  100704:	eb ec                	jmp    1006f2 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100706:	89 d8                	mov    %ebx,%eax
  100708:	5b                   	pop    %ebx
  100709:	5e                   	pop    %esi
  10070a:	c3                   	ret    

0010070b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10070b:	55                   	push   %ebp
  10070c:	57                   	push   %edi
  10070d:	56                   	push   %esi
  10070e:	53                   	push   %ebx
  10070f:	83 ec 38             	sub    $0x38,%esp
  100712:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100716:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10071a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10071e:	e9 60 03 00 00       	jmp    100a83 <console_vprintf+0x378>
		if (*format != '%') {
  100723:	80 fa 25             	cmp    $0x25,%dl
  100726:	74 13                	je     10073b <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100728:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10072c:	0f b6 d2             	movzbl %dl,%edx
  10072f:	89 f0                	mov    %esi,%eax
  100731:	e8 59 ff ff ff       	call   10068f <console_putc>
  100736:	e9 45 03 00 00       	jmp    100a80 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10073b:	47                   	inc    %edi
  10073c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100743:	00 
  100744:	eb 12                	jmp    100758 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100746:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100747:	8a 11                	mov    (%ecx),%dl
  100749:	84 d2                	test   %dl,%dl
  10074b:	74 1a                	je     100767 <console_vprintf+0x5c>
  10074d:	89 e8                	mov    %ebp,%eax
  10074f:	38 c2                	cmp    %al,%dl
  100751:	75 f3                	jne    100746 <console_vprintf+0x3b>
  100753:	e9 3f 03 00 00       	jmp    100a97 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100758:	8a 17                	mov    (%edi),%dl
  10075a:	84 d2                	test   %dl,%dl
  10075c:	74 0b                	je     100769 <console_vprintf+0x5e>
  10075e:	b9 18 0b 10 00       	mov    $0x100b18,%ecx
  100763:	89 d5                	mov    %edx,%ebp
  100765:	eb e0                	jmp    100747 <console_vprintf+0x3c>
  100767:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100769:	8d 42 cf             	lea    -0x31(%edx),%eax
  10076c:	3c 08                	cmp    $0x8,%al
  10076e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100775:	00 
  100776:	76 13                	jbe    10078b <console_vprintf+0x80>
  100778:	eb 1d                	jmp    100797 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10077a:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10077f:	0f be c0             	movsbl %al,%eax
  100782:	47                   	inc    %edi
  100783:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100787:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10078b:	8a 07                	mov    (%edi),%al
  10078d:	8d 50 d0             	lea    -0x30(%eax),%edx
  100790:	80 fa 09             	cmp    $0x9,%dl
  100793:	76 e5                	jbe    10077a <console_vprintf+0x6f>
  100795:	eb 18                	jmp    1007af <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100797:	80 fa 2a             	cmp    $0x2a,%dl
  10079a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007a1:	ff 
  1007a2:	75 0b                	jne    1007af <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007a4:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007a7:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007a8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007ab:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007af:	83 cd ff             	or     $0xffffffff,%ebp
  1007b2:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007b5:	75 37                	jne    1007ee <console_vprintf+0xe3>
			++format;
  1007b7:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007b8:	31 ed                	xor    %ebp,%ebp
  1007ba:	8a 07                	mov    (%edi),%al
  1007bc:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007bf:	80 fa 09             	cmp    $0x9,%dl
  1007c2:	76 0d                	jbe    1007d1 <console_vprintf+0xc6>
  1007c4:	eb 17                	jmp    1007dd <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007c6:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007c9:	0f be c0             	movsbl %al,%eax
  1007cc:	47                   	inc    %edi
  1007cd:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007d1:	8a 07                	mov    (%edi),%al
  1007d3:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007d6:	80 fa 09             	cmp    $0x9,%dl
  1007d9:	76 eb                	jbe    1007c6 <console_vprintf+0xbb>
  1007db:	eb 11                	jmp    1007ee <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007dd:	3c 2a                	cmp    $0x2a,%al
  1007df:	75 0b                	jne    1007ec <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007e1:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007e4:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007e5:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007e8:	85 ed                	test   %ebp,%ebp
  1007ea:	79 02                	jns    1007ee <console_vprintf+0xe3>
  1007ec:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007ee:	8a 07                	mov    (%edi),%al
  1007f0:	3c 64                	cmp    $0x64,%al
  1007f2:	74 34                	je     100828 <console_vprintf+0x11d>
  1007f4:	7f 1d                	jg     100813 <console_vprintf+0x108>
  1007f6:	3c 58                	cmp    $0x58,%al
  1007f8:	0f 84 a2 00 00 00    	je     1008a0 <console_vprintf+0x195>
  1007fe:	3c 63                	cmp    $0x63,%al
  100800:	0f 84 bf 00 00 00    	je     1008c5 <console_vprintf+0x1ba>
  100806:	3c 43                	cmp    $0x43,%al
  100808:	0f 85 d0 00 00 00    	jne    1008de <console_vprintf+0x1d3>
  10080e:	e9 a3 00 00 00       	jmp    1008b6 <console_vprintf+0x1ab>
  100813:	3c 75                	cmp    $0x75,%al
  100815:	74 4d                	je     100864 <console_vprintf+0x159>
  100817:	3c 78                	cmp    $0x78,%al
  100819:	74 5c                	je     100877 <console_vprintf+0x16c>
  10081b:	3c 73                	cmp    $0x73,%al
  10081d:	0f 85 bb 00 00 00    	jne    1008de <console_vprintf+0x1d3>
  100823:	e9 86 00 00 00       	jmp    1008ae <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100828:	83 c3 04             	add    $0x4,%ebx
  10082b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10082e:	89 d1                	mov    %edx,%ecx
  100830:	c1 f9 1f             	sar    $0x1f,%ecx
  100833:	89 0c 24             	mov    %ecx,(%esp)
  100836:	31 ca                	xor    %ecx,%edx
  100838:	55                   	push   %ebp
  100839:	29 ca                	sub    %ecx,%edx
  10083b:	68 20 0b 10 00       	push   $0x100b20
  100840:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100845:	8d 44 24 40          	lea    0x40(%esp),%eax
  100849:	e8 90 fe ff ff       	call   1006de <fill_numbuf>
  10084e:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100852:	58                   	pop    %eax
  100853:	5a                   	pop    %edx
  100854:	ba 01 00 00 00       	mov    $0x1,%edx
  100859:	8b 04 24             	mov    (%esp),%eax
  10085c:	83 e0 01             	and    $0x1,%eax
  10085f:	e9 a5 00 00 00       	jmp    100909 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100864:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100867:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10086c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10086f:	55                   	push   %ebp
  100870:	68 20 0b 10 00       	push   $0x100b20
  100875:	eb 11                	jmp    100888 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100877:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10087a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10087d:	55                   	push   %ebp
  10087e:	68 34 0b 10 00       	push   $0x100b34
  100883:	b9 10 00 00 00       	mov    $0x10,%ecx
  100888:	8d 44 24 40          	lea    0x40(%esp),%eax
  10088c:	e8 4d fe ff ff       	call   1006de <fill_numbuf>
  100891:	ba 01 00 00 00       	mov    $0x1,%edx
  100896:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10089a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10089c:	59                   	pop    %ecx
  10089d:	59                   	pop    %ecx
  10089e:	eb 69                	jmp    100909 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008a0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008a3:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008a6:	55                   	push   %ebp
  1008a7:	68 20 0b 10 00       	push   $0x100b20
  1008ac:	eb d5                	jmp    100883 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008ae:	83 c3 04             	add    $0x4,%ebx
  1008b1:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008b4:	eb 40                	jmp    1008f6 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008b6:	83 c3 04             	add    $0x4,%ebx
  1008b9:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008bc:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1008c0:	e9 bd 01 00 00       	jmp    100a82 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008c5:	83 c3 04             	add    $0x4,%ebx
  1008c8:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008cb:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008cf:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008d4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008d8:	88 44 24 24          	mov    %al,0x24(%esp)
  1008dc:	eb 27                	jmp    100905 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008de:	84 c0                	test   %al,%al
  1008e0:	75 02                	jne    1008e4 <console_vprintf+0x1d9>
  1008e2:	b0 25                	mov    $0x25,%al
  1008e4:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008e8:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008ed:	80 3f 00             	cmpb   $0x0,(%edi)
  1008f0:	74 0a                	je     1008fc <console_vprintf+0x1f1>
  1008f2:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008f6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008fa:	eb 09                	jmp    100905 <console_vprintf+0x1fa>
				format--;
  1008fc:	8d 54 24 24          	lea    0x24(%esp),%edx
  100900:	4f                   	dec    %edi
  100901:	89 54 24 04          	mov    %edx,0x4(%esp)
  100905:	31 d2                	xor    %edx,%edx
  100907:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100909:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10090b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10090e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100915:	74 1f                	je     100936 <console_vprintf+0x22b>
  100917:	89 04 24             	mov    %eax,(%esp)
  10091a:	eb 01                	jmp    10091d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10091c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10091d:	39 e9                	cmp    %ebp,%ecx
  10091f:	74 0a                	je     10092b <console_vprintf+0x220>
  100921:	8b 44 24 04          	mov    0x4(%esp),%eax
  100925:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100929:	75 f1                	jne    10091c <console_vprintf+0x211>
  10092b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10092e:	89 0c 24             	mov    %ecx,(%esp)
  100931:	eb 1f                	jmp    100952 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100933:	42                   	inc    %edx
  100934:	eb 09                	jmp    10093f <console_vprintf+0x234>
  100936:	89 d1                	mov    %edx,%ecx
  100938:	8b 14 24             	mov    (%esp),%edx
  10093b:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10093f:	8b 44 24 04          	mov    0x4(%esp),%eax
  100943:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100947:	75 ea                	jne    100933 <console_vprintf+0x228>
  100949:	8b 44 24 08          	mov    0x8(%esp),%eax
  10094d:	89 14 24             	mov    %edx,(%esp)
  100950:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100952:	85 c0                	test   %eax,%eax
  100954:	74 0c                	je     100962 <console_vprintf+0x257>
  100956:	84 d2                	test   %dl,%dl
  100958:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10095f:	00 
  100960:	75 24                	jne    100986 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100962:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100967:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10096e:	00 
  10096f:	75 15                	jne    100986 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100971:	8b 44 24 14          	mov    0x14(%esp),%eax
  100975:	83 e0 08             	and    $0x8,%eax
  100978:	83 f8 01             	cmp    $0x1,%eax
  10097b:	19 c9                	sbb    %ecx,%ecx
  10097d:	f7 d1                	not    %ecx
  10097f:	83 e1 20             	and    $0x20,%ecx
  100982:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100986:	3b 2c 24             	cmp    (%esp),%ebp
  100989:	7e 0d                	jle    100998 <console_vprintf+0x28d>
  10098b:	84 d2                	test   %dl,%dl
  10098d:	74 40                	je     1009cf <console_vprintf+0x2c4>
			zeros = precision - len;
  10098f:	2b 2c 24             	sub    (%esp),%ebp
  100992:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100996:	eb 3f                	jmp    1009d7 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100998:	84 d2                	test   %dl,%dl
  10099a:	74 33                	je     1009cf <console_vprintf+0x2c4>
  10099c:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009a0:	83 e0 06             	and    $0x6,%eax
  1009a3:	83 f8 02             	cmp    $0x2,%eax
  1009a6:	75 27                	jne    1009cf <console_vprintf+0x2c4>
  1009a8:	45                   	inc    %ebp
  1009a9:	75 24                	jne    1009cf <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009ab:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009ad:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009b0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009b5:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009b8:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009bb:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009bf:	7d 0e                	jge    1009cf <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1009c1:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009c5:	29 ca                	sub    %ecx,%edx
  1009c7:	29 c2                	sub    %eax,%edx
  1009c9:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009cd:	eb 08                	jmp    1009d7 <console_vprintf+0x2cc>
  1009cf:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009d6:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009d7:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009db:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009dd:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009e1:	2b 2c 24             	sub    (%esp),%ebp
  1009e4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009e9:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009ec:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009ef:	29 c5                	sub    %eax,%ebp
  1009f1:	89 f0                	mov    %esi,%eax
  1009f3:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009fb:	eb 0f                	jmp    100a0c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009fd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a01:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a06:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a07:	e8 83 fc ff ff       	call   10068f <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a0c:	85 ed                	test   %ebp,%ebp
  100a0e:	7e 07                	jle    100a17 <console_vprintf+0x30c>
  100a10:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a15:	74 e6                	je     1009fd <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a17:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a1c:	89 c6                	mov    %eax,%esi
  100a1e:	74 23                	je     100a43 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a20:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a25:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a29:	e8 61 fc ff ff       	call   10068f <console_putc>
  100a2e:	89 c6                	mov    %eax,%esi
  100a30:	eb 11                	jmp    100a43 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a32:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a36:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a3b:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a3c:	e8 4e fc ff ff       	call   10068f <console_putc>
  100a41:	eb 06                	jmp    100a49 <console_vprintf+0x33e>
  100a43:	89 f0                	mov    %esi,%eax
  100a45:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a49:	85 f6                	test   %esi,%esi
  100a4b:	7f e5                	jg     100a32 <console_vprintf+0x327>
  100a4d:	8b 34 24             	mov    (%esp),%esi
  100a50:	eb 15                	jmp    100a67 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a52:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a56:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a57:	0f b6 11             	movzbl (%ecx),%edx
  100a5a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a5e:	e8 2c fc ff ff       	call   10068f <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a63:	ff 44 24 04          	incl   0x4(%esp)
  100a67:	85 f6                	test   %esi,%esi
  100a69:	7f e7                	jg     100a52 <console_vprintf+0x347>
  100a6b:	eb 0f                	jmp    100a7c <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a6d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a71:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a76:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a77:	e8 13 fc ff ff       	call   10068f <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a7c:	85 ed                	test   %ebp,%ebp
  100a7e:	7f ed                	jg     100a6d <console_vprintf+0x362>
  100a80:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a82:	47                   	inc    %edi
  100a83:	8a 17                	mov    (%edi),%dl
  100a85:	84 d2                	test   %dl,%dl
  100a87:	0f 85 96 fc ff ff    	jne    100723 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a8d:	83 c4 38             	add    $0x38,%esp
  100a90:	89 f0                	mov    %esi,%eax
  100a92:	5b                   	pop    %ebx
  100a93:	5e                   	pop    %esi
  100a94:	5f                   	pop    %edi
  100a95:	5d                   	pop    %ebp
  100a96:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a97:	81 e9 18 0b 10 00    	sub    $0x100b18,%ecx
  100a9d:	b8 01 00 00 00       	mov    $0x1,%eax
  100aa2:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100aa4:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100aa5:	09 44 24 14          	or     %eax,0x14(%esp)
  100aa9:	e9 aa fc ff ff       	jmp    100758 <console_vprintf+0x4d>

00100aae <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100aae:	8d 44 24 10          	lea    0x10(%esp),%eax
  100ab2:	50                   	push   %eax
  100ab3:	ff 74 24 10          	pushl  0x10(%esp)
  100ab7:	ff 74 24 10          	pushl  0x10(%esp)
  100abb:	ff 74 24 10          	pushl  0x10(%esp)
  100abf:	e8 47 fc ff ff       	call   10070b <console_vprintf>
  100ac4:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100ac7:	c3                   	ret    
