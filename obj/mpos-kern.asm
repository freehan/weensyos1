
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
  100014:	e8 eb 02 00 00       	call   100304 <start>
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
  100096:	a1 68 97 10 00       	mov    0x109768,%eax
  10009b:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009d:	8d 42 01             	lea    0x1(%edx),%eax
  1000a0:	99                   	cltd   
  1000a1:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a3:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a6:	8d 98 cc 89 10 00    	lea    0x1089cc(%eax),%ebx
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
  1000bc:	6b 98 c4 89 10 00 54 	imul   $0x54,0x1089c4(%eax),%ebx
  1000c3:	83 bb 0c 8a 10 00 03 	cmpl   $0x3,0x108a0c(%ebx)
  1000ca:	75 d1                	jne    10009d <schedule+0x11>
            {
                proc_array[pid].p_registers.reg_eax = proc_array[proc_array[pid].wait_pid].p_exit_status;
  1000cc:	8b 93 10 8a 10 00    	mov    0x108a10(%ebx),%edx
	//	proc_array[proc_array[pid].wait_pid].p_state = P_EMPTY; //SK:set the zombie process's status as empty
//		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now empty by schedule\n",proc_array[proc_array[pid].wait_pid]);
		
//		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now scheduled\n",pid);
                proc_array[pid].p_state = P_RUNNABLE;
  1000d2:	c7 06 01 00 00 00    	movl   $0x1,(%esi)
                proc_array[pid].wait_pid = -1;
  1000d8:	c7 80 c4 89 10 00 ff 	movl   $0xffffffff,0x1089c4(%eax)
  1000df:	ff ff ff 
			run(&proc_array[pid]);
        else if(proc_array[pid].p_state == P_BLOCKED)   //XIA: the process it is waiting have EXIT
        {
            if(proc_array[(proc_array[pid].wait_pid)].p_state == P_ZOMBIE)
            {
                proc_array[pid].p_registers.reg_eax = proc_array[proc_array[pid].wait_pid].p_exit_status;
  1000e2:	89 90 e4 89 10 00    	mov    %edx,0x1089e4(%eax)
//		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now empty by schedule\n",proc_array[proc_array[pid].wait_pid]);
		
//		cursorpos = console_printf(cursorpos, 0x0700, "proc %d is now scheduled\n",pid);
                proc_array[pid].p_state = P_RUNNABLE;
                proc_array[pid].wait_pid = -1;
                run(&proc_array[pid]);
  1000e8:	83 ec 0c             	sub    $0xc,%esp
  1000eb:	05 c0 89 10 00       	add    $0x1089c0,%eax
  1000f0:	50                   	push   %eax
  1000f1:	e8 2e 04 00 00       	call   100524 <run>

001000f6 <interrupt>:
static pid_t do_fork(process_t *parent);
static pid_t do_newthread(void (*start_function)(void));

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
static pid_t do_newthread(void (*start_function)(void));

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
  100102:	8b 1d 68 97 10 00    	mov    0x109768,%ebx
static pid_t do_fork(process_t *parent);
static pid_t do_newthread(void (*start_function)(void));

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
  10011c:	0f 87 e0 01 00 00    	ja     100302 <interrupt+0x20c>
  100122:	ff 24 85 28 0b 10 00 	jmp    *0x100b28(,%eax,4)
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
  100137:	b8 60 8a 10 00       	mov    $0x108a60,%eax
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
  10015f:	8d 85 c0 89 10 00    	lea    0x1089c0(%ebp),%eax
  100165:	89 c7                	mov    %eax,%edi
  100167:	83 c7 08             	add    $0x8,%edi
  10016a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + src->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + dest->p_pid * PROC_STACK_SIZE; /* YOUR CODE HERE */
	dest_stack_bottom =  dest_stack_top - (src_stack_top - src_stack_bottom);
  10016c:	8b b5 c0 89 10 00    	mov    0x1089c0(%ebp),%esi
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
  100197:	e8 60 04 00 00       	call   1005fc <memcpy>
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
  1001a7:	c7 85 0c 8a 10 00 01 	movl   $0x1,0x108a0c(%ebp)
  1001ae:	00 00 00 
    proc_array[child].p_registers.reg_eax = 0;      //return 0 to child process
  1001b1:	c7 85 e4 89 10 00 00 	movl   $0x0,0x1089e4(%ebp)
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
  1001c4:	ff 35 68 97 10 00    	pushl  0x109768
  1001ca:	e8 55 03 00 00       	call   100524 <run>
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
  1001d4:	a1 68 97 10 00       	mov    0x109768,%eax
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
  1001eb:	a1 68 97 10 00       	mov    0x109768,%eax
  1001f0:	8b 50 24             	mov    0x24(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001f3:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001f6:	83 f9 0e             	cmp    $0xe,%ecx
  1001f9:	77 14                	ja     10020f <interrupt+0x119>
  1001fb:	3b 10                	cmp    (%eax),%edx
  1001fd:	74 10                	je     10020f <interrupt+0x119>
		    || proc_array[p].p_state == P_EMPTY)
  1001ff:	6b da 54             	imul   $0x54,%edx,%ebx
  100202:	8d 8b cc 89 10 00    	lea    0x1089cc(%ebx),%ecx
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
  10021d:	8b 93 10 8a 10 00    	mov    0x108a10(%ebx),%edx
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
  10023e:	a1 68 97 10 00       	mov    0x109768,%eax
  100243:	8b 50 24             	mov    0x24(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid 
  100246:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100249:	83 f9 0e             	cmp    $0xe,%ecx
  10024c:	77 14                	ja     100262 <interrupt+0x16c>
  10024e:	3b 10                	cmp    (%eax),%edx
  100250:	74 10                	je     100262 <interrupt+0x16c>
		    || proc_array[p].p_state == P_EMPTY)
  100252:	6b d2 54             	imul   $0x54,%edx,%edx
  100255:	8d 8a cc 89 10 00    	lea    0x1089cc(%edx),%ecx
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
  100269:	eb 1d                	jmp    100288 <interrupt+0x192>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if(proc_array[p].p_state != P_ZOMBIE){
  10026b:	83 fb 03             	cmp    $0x3,%ebx
  10026e:	74 11                	je     100281 <interrupt+0x18b>
			proc_array[p].p_state = P_ZOMBIE;
  100270:	c7 41 40 03 00 00 00 	movl   $0x3,0x40(%ecx)
			proc_array[p].p_exit_status = -1;
  100277:	c7 82 10 8a 10 00 ff 	movl   $0xffffffff,0x108a10(%edx)
  10027e:	ff ff ff 
			current->p_registers.reg_eax = 1;
		}
		else{
			current->p_registers.reg_eax = 1;
  100281:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
		}
        run(current);
  100288:	83 ec 0c             	sub    $0xc,%esp
  10028b:	50                   	push   %eax
  10028c:	e9 39 ff ff ff       	jmp    1001ca <interrupt+0xd4>

    }
            //XIA: new thread
    case INT_SYS_NEWTHREAD:{
        cursorpos = console_printf(cursorpos, 0x0700, "new Thread in kernel\n");
  100291:	51                   	push   %ecx
  100292:	68 dc 0a 10 00       	push   $0x100adc
  100297:	68 00 07 00 00       	push   $0x700
  10029c:	ff 35 00 00 06 00    	pushl  0x60000
  1002a2:	e8 1b 08 00 00       	call   100ac2 <console_printf>
  1002a7:	b9 60 8a 10 00       	mov    $0x108a60,%ecx
  1002ac:	ba 01 00 00 00       	mov    $0x1,%edx
  1002b1:	83 c4 10             	add    $0x10,%esp
  1002b4:	a3 00 00 06 00       	mov    %eax,0x60000
{
    pid_t new = -1;
    int i = 1;
    while(i < NPROCS)
    {
        if(proc_array[i].p_state == P_EMPTY)
  1002b9:	83 39 00             	cmpl   $0x0,(%ecx)
  1002bc:	74 0e                	je     1002cc <interrupt+0x1d6>
        {    
            new = i;
            break;
        }
        i++;
  1002be:	42                   	inc    %edx
  1002bf:	83 c1 54             	add    $0x54,%ecx
static pid_t 
do_newthread(void (*start_function)(void))
{
    pid_t new = -1;
    int i = 1;
    while(i < NPROCS)
  1002c2:	83 fa 10             	cmp    $0x10,%edx
  1002c5:	75 f2                	jne    1002b9 <interrupt+0x1c3>
  1002c7:	83 ca ff             	or     $0xffffffff,%edx
  1002ca:	eb 19                	jmp    1002e5 <interrupt+0x1ef>
        return -1;
    
    //program_loader(2,&proc_array[new].p_registers.reg_eip); //fail: make the instruction pointer point to the function
    //fail to load the program   // don't have solution yet

    proc_array[new].p_registers.reg_esp = PROC1_STACK_ADDR + new * PROC_STACK_SIZE;
  1002cc:	6b da 54             	imul   $0x54,%edx,%ebx
  1002cf:	8d 4a 0a             	lea    0xa(%edx),%ecx
  1002d2:	c1 e1 12             	shl    $0x12,%ecx
  1002d5:	89 8b 04 8a 10 00    	mov    %ecx,0x108a04(%ebx)
    proc_array[new].p_state = P_RUNNABLE; 
  1002db:	c7 83 0c 8a 10 00 01 	movl   $0x1,0x108a0c(%ebx)
  1002e2:	00 00 00 
    case INT_SYS_NEWTHREAD:{
        cursorpos = console_printf(cursorpos, 0x0700, "new Thread in kernel\n");
        
        void (*f)(void) = (void(*)(void)) current->p_registers.reg_eax;
        pid_t new = do_newthread(f);
        current->p_registers.reg_eax = new;
  1002e5:	8b 0d 68 97 10 00    	mov    0x109768,%ecx
  1002eb:	89 51 24             	mov    %edx,0x24(%ecx)
        cursorpos = console_printf(cursorpos, 0x0700, "new Thread in kernel\n");
  1002ee:	52                   	push   %edx
  1002ef:	68 dc 0a 10 00       	push   $0x100adc
  1002f4:	68 00 07 00 00       	push   $0x700
  1002f9:	50                   	push   %eax
  1002fa:	e8 c3 07 00 00       	call   100ac2 <console_printf>
  1002ff:	83 c4 10             	add    $0x10,%esp
  100302:	eb fe                	jmp    100302 <interrupt+0x20c>

00100304 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100304:	53                   	push   %ebx
  100305:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100308:	68 40 05 00 00       	push   $0x540
  10030d:	6a 00                	push   $0x0
  10030f:	68 c0 89 10 00       	push   $0x1089c0
  100314:	e8 47 03 00 00       	call   100660 <memset>
  100319:	b8 c0 89 10 00       	mov    $0x1089c0,%eax
  10031e:	31 d2                	xor    %edx,%edx
  100320:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100323:	89 10                	mov    %edx,(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100325:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100326:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
        proc_array[i].wait_pid = -1;        //XIA: initializing waiting pid
  10032d:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100334:	83 c0 54             	add    $0x54,%eax
  100337:	83 fa 10             	cmp    $0x10,%edx
  10033a:	75 e7                	jne    100323 <start+0x1f>
		proc_array[i].p_state = P_EMPTY;
        proc_array[i].wait_pid = -1;        //XIA: initializing waiting pid
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  10033c:	c7 05 68 97 10 00 14 	movl   $0x108a14,0x109768
  100343:	8a 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  100346:	e8 71 00 00 00       	call   1003bc <segments_init>
	special_registers_init(current);
  10034b:	83 ec 0c             	sub    $0xc,%esp
  10034e:	ff 35 68 97 10 00    	pushl  0x109768
  100354:	e8 e2 01 00 00       	call   10053b <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  100359:	e8 2d 01 00 00       	call   10048b <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  10035e:	83 c4 0c             	add    $0xc,%esp
  100361:	68 f2 0a 10 00       	push   $0x100af2
  100366:	68 00 07 00 00       	push   $0x700
  10036b:	ff 35 00 00 06 00    	pushl  0x60000
  100371:	e8 4c 07 00 00       	call   100ac2 <console_printf>
  100376:	83 c4 10             	add    $0x10,%esp
  100379:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  10037e:	e8 4b 01 00 00       	call   1004ce <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  100383:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100386:	83 fb 01             	cmp    $0x1,%ebx
  100389:	77 f3                	ja     10037e <start+0x7a>
	console_clear();
  10038b:	e8 fb 00 00 00       	call   10048b <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  100390:	50                   	push   %eax
  100391:	50                   	push   %eax
  100392:	a1 68 97 10 00       	mov    0x109768,%eax
  100397:	83 c0 38             	add    $0x38,%eax
  10039a:	50                   	push   %eax
  10039b:	53                   	push   %ebx
  10039c:	e8 cf 01 00 00       	call   100570 <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  1003a1:	a1 68 97 10 00       	mov    0x109768,%eax
  1003a6:	c7 40 44 00 00 2c 00 	movl   $0x2c0000,0x44(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  1003ad:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)

	// Switch to the main process using run().
	run(current);
  1003b4:	89 04 24             	mov    %eax,(%esp)
  1003b7:	e8 68 01 00 00       	call   100524 <run>

001003bc <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003bc:	b8 00 8f 10 00       	mov    $0x108f00,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003c1:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003c6:	89 c2                	mov    %eax,%edx
  1003c8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003cb:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003cc:	bb 56 00 10 00       	mov    $0x100056,%ebx
  1003d1:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003d4:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1003da:	c1 e8 18             	shr    $0x18,%eax
  1003dd:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003e3:	ba 68 8f 10 00       	mov    $0x108f68,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003e8:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003ed:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003ef:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1003f6:	68 00 
  1003f8:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003ff:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100406:	c7 05 04 8f 10 00 00 	movl   $0x80000,0x108f04
  10040d:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100410:	66 c7 05 08 8f 10 00 	movw   $0x10,0x108f08
  100417:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100419:	66 89 0c c5 68 8f 10 	mov    %cx,0x108f68(,%eax,8)
  100420:	00 
  100421:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100428:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10042d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100432:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100437:	40                   	inc    %eax
  100438:	3d 00 01 00 00       	cmp    $0x100,%eax
  10043d:	75 da                	jne    100419 <segments_init+0x5d>
  10043f:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100443:	ba 68 8f 10 00       	mov    $0x108f68,%edx
  100448:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  10044f:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100456:	66 89 0c c5 68 8f 10 	mov    %cx,0x108f68(,%eax,8)
  10045d:	00 
  10045e:	c1 e9 10             	shr    $0x10,%ecx
  100461:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100466:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10046b:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  100470:	40                   	inc    %eax
  100471:	83 f8 3a             	cmp    $0x3a,%eax
  100474:	75 d2                	jne    100448 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100476:	b0 28                	mov    $0x28,%al
  100478:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10047f:	0f 00 d8             	ltr    %ax
  100482:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100489:	5b                   	pop    %ebx
  10048a:	c3                   	ret    

0010048b <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  10048b:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10048c:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10048e:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10048f:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  100496:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100499:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  1004a0:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004a3:	40                   	inc    %eax
  1004a4:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  1004a9:	75 ee                	jne    100499 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004b0:	b0 0e                	mov    $0xe,%al
  1004b2:	89 f2                	mov    %esi,%edx
  1004b4:	ee                   	out    %al,(%dx)
  1004b5:	31 c9                	xor    %ecx,%ecx
  1004b7:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004bc:	88 c8                	mov    %cl,%al
  1004be:	89 da                	mov    %ebx,%edx
  1004c0:	ee                   	out    %al,(%dx)
  1004c1:	b0 0f                	mov    $0xf,%al
  1004c3:	89 f2                	mov    %esi,%edx
  1004c5:	ee                   	out    %al,(%dx)
  1004c6:	88 c8                	mov    %cl,%al
  1004c8:	89 da                	mov    %ebx,%edx
  1004ca:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004cb:	5b                   	pop    %ebx
  1004cc:	5e                   	pop    %esi
  1004cd:	c3                   	ret    

001004ce <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004ce:	ba 64 00 00 00       	mov    $0x64,%edx
  1004d3:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004d4:	a8 01                	test   $0x1,%al
  1004d6:	74 45                	je     10051d <console_read_digit+0x4f>
  1004d8:	b2 60                	mov    $0x60,%dl
  1004da:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004db:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004de:	80 fa 08             	cmp    $0x8,%dl
  1004e1:	77 05                	ja     1004e8 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004e3:	0f b6 c0             	movzbl %al,%eax
  1004e6:	48                   	dec    %eax
  1004e7:	c3                   	ret    
	else if (data == 0x0B)
  1004e8:	3c 0b                	cmp    $0xb,%al
  1004ea:	74 35                	je     100521 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004ec:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004ef:	80 fa 02             	cmp    $0x2,%dl
  1004f2:	77 07                	ja     1004fb <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004f4:	0f b6 c0             	movzbl %al,%eax
  1004f7:	83 e8 40             	sub    $0x40,%eax
  1004fa:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004fb:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004fe:	80 fa 02             	cmp    $0x2,%dl
  100501:	77 07                	ja     10050a <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100503:	0f b6 c0             	movzbl %al,%eax
  100506:	83 e8 47             	sub    $0x47,%eax
  100509:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10050a:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10050d:	80 fa 02             	cmp    $0x2,%dl
  100510:	77 07                	ja     100519 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100512:	0f b6 c0             	movzbl %al,%eax
  100515:	83 e8 4e             	sub    $0x4e,%eax
  100518:	c3                   	ret    
	else if (data == 0x53)
  100519:	3c 53                	cmp    $0x53,%al
  10051b:	74 04                	je     100521 <console_read_digit+0x53>
  10051d:	83 c8 ff             	or     $0xffffffff,%eax
  100520:	c3                   	ret    
  100521:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100523:	c3                   	ret    

00100524 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100524:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100528:	a3 68 97 10 00       	mov    %eax,0x109768

	asm volatile("movl %0,%%esp\n\t"
  10052d:	83 c0 08             	add    $0x8,%eax
  100530:	89 c4                	mov    %eax,%esp
  100532:	61                   	popa   
  100533:	07                   	pop    %es
  100534:	1f                   	pop    %ds
  100535:	83 c4 08             	add    $0x8,%esp
  100538:	cf                   	iret   
  100539:	eb fe                	jmp    100539 <run+0x15>

0010053b <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10053b:	53                   	push   %ebx
  10053c:	83 ec 0c             	sub    $0xc,%esp
  10053f:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100543:	6a 44                	push   $0x44
  100545:	6a 00                	push   $0x0
  100547:	8d 43 08             	lea    0x8(%ebx),%eax
  10054a:	50                   	push   %eax
  10054b:	e8 10 01 00 00       	call   100660 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100550:	66 c7 43 3c 1b 00    	movw   $0x1b,0x3c(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100556:	66 c7 43 2c 23 00    	movw   $0x23,0x2c(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  10055c:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100562:	66 c7 43 48 23 00    	movw   $0x23,0x48(%ebx)
}
  100568:	83 c4 18             	add    $0x18,%esp
  10056b:	5b                   	pop    %ebx
  10056c:	c3                   	ret    
  10056d:	90                   	nop
  10056e:	90                   	nop
  10056f:	90                   	nop

00100570 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100570:	55                   	push   %ebp
  100571:	57                   	push   %edi
  100572:	56                   	push   %esi
  100573:	53                   	push   %ebx
  100574:	83 ec 1c             	sub    $0x1c,%esp
  100577:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10057b:	83 f8 01             	cmp    $0x1,%eax
  10057e:	7f 04                	jg     100584 <program_loader+0x14>
  100580:	85 c0                	test   %eax,%eax
  100582:	79 02                	jns    100586 <program_loader+0x16>
  100584:	eb fe                	jmp    100584 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100586:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10058d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100593:	74 02                	je     100597 <program_loader+0x27>
  100595:	eb fe                	jmp    100595 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100597:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10059a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10059e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005a0:	c1 e5 05             	shl    $0x5,%ebp
  1005a3:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1005a6:	eb 3f                	jmp    1005e7 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005a8:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005ab:	75 37                	jne    1005e4 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1005ad:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005b0:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005b3:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005b6:	01 c7                	add    %eax,%edi
	memsz += va;
  1005b8:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005bf:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005c3:	52                   	push   %edx
  1005c4:	89 fa                	mov    %edi,%edx
  1005c6:	29 c2                	sub    %eax,%edx
  1005c8:	52                   	push   %edx
  1005c9:	8b 53 04             	mov    0x4(%ebx),%edx
  1005cc:	01 f2                	add    %esi,%edx
  1005ce:	52                   	push   %edx
  1005cf:	50                   	push   %eax
  1005d0:	e8 27 00 00 00       	call   1005fc <memcpy>
  1005d5:	83 c4 10             	add    $0x10,%esp
  1005d8:	eb 04                	jmp    1005de <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005da:	c6 07 00             	movb   $0x0,(%edi)
  1005dd:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005de:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005e2:	72 f6                	jb     1005da <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005e4:	83 c3 20             	add    $0x20,%ebx
  1005e7:	39 eb                	cmp    %ebp,%ebx
  1005e9:	72 bd                	jb     1005a8 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005eb:	8b 56 18             	mov    0x18(%esi),%edx
  1005ee:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005f2:	89 10                	mov    %edx,(%eax)
}
  1005f4:	83 c4 1c             	add    $0x1c,%esp
  1005f7:	5b                   	pop    %ebx
  1005f8:	5e                   	pop    %esi
  1005f9:	5f                   	pop    %edi
  1005fa:	5d                   	pop    %ebp
  1005fb:	c3                   	ret    

001005fc <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005fc:	56                   	push   %esi
  1005fd:	31 d2                	xor    %edx,%edx
  1005ff:	53                   	push   %ebx
  100600:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100604:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100608:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10060c:	eb 08                	jmp    100616 <memcpy+0x1a>
		*d++ = *s++;
  10060e:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100611:	4e                   	dec    %esi
  100612:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100615:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100616:	85 f6                	test   %esi,%esi
  100618:	75 f4                	jne    10060e <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10061a:	5b                   	pop    %ebx
  10061b:	5e                   	pop    %esi
  10061c:	c3                   	ret    

0010061d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10061d:	57                   	push   %edi
  10061e:	56                   	push   %esi
  10061f:	53                   	push   %ebx
  100620:	8b 44 24 10          	mov    0x10(%esp),%eax
  100624:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100628:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10062c:	39 c7                	cmp    %eax,%edi
  10062e:	73 26                	jae    100656 <memmove+0x39>
  100630:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100633:	39 c6                	cmp    %eax,%esi
  100635:	76 1f                	jbe    100656 <memmove+0x39>
		s += n, d += n;
  100637:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10063a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10063c:	eb 07                	jmp    100645 <memmove+0x28>
			*--d = *--s;
  10063e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100641:	4a                   	dec    %edx
  100642:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100645:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100646:	85 d2                	test   %edx,%edx
  100648:	75 f4                	jne    10063e <memmove+0x21>
  10064a:	eb 10                	jmp    10065c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10064c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10064f:	4a                   	dec    %edx
  100650:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100653:	41                   	inc    %ecx
  100654:	eb 02                	jmp    100658 <memmove+0x3b>
  100656:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100658:	85 d2                	test   %edx,%edx
  10065a:	75 f0                	jne    10064c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10065c:	5b                   	pop    %ebx
  10065d:	5e                   	pop    %esi
  10065e:	5f                   	pop    %edi
  10065f:	c3                   	ret    

00100660 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100660:	53                   	push   %ebx
  100661:	8b 44 24 08          	mov    0x8(%esp),%eax
  100665:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100669:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10066d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10066f:	eb 04                	jmp    100675 <memset+0x15>
		*p++ = c;
  100671:	88 1a                	mov    %bl,(%edx)
  100673:	49                   	dec    %ecx
  100674:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100675:	85 c9                	test   %ecx,%ecx
  100677:	75 f8                	jne    100671 <memset+0x11>
		*p++ = c;
	return v;
}
  100679:	5b                   	pop    %ebx
  10067a:	c3                   	ret    

0010067b <strlen>:

size_t
strlen(const char *s)
{
  10067b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10067f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100681:	eb 01                	jmp    100684 <strlen+0x9>
		++n;
  100683:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100684:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100688:	75 f9                	jne    100683 <strlen+0x8>
		++n;
	return n;
}
  10068a:	c3                   	ret    

0010068b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10068b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10068f:	31 c0                	xor    %eax,%eax
  100691:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100695:	eb 01                	jmp    100698 <strnlen+0xd>
		++n;
  100697:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100698:	39 d0                	cmp    %edx,%eax
  10069a:	74 06                	je     1006a2 <strnlen+0x17>
  10069c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006a0:	75 f5                	jne    100697 <strnlen+0xc>
		++n;
	return n;
}
  1006a2:	c3                   	ret    

001006a3 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006a3:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1006a4:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006a9:	53                   	push   %ebx
  1006aa:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1006ac:	76 05                	jbe    1006b3 <console_putc+0x10>
  1006ae:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006b3:	80 fa 0a             	cmp    $0xa,%dl
  1006b6:	75 2c                	jne    1006e4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006b8:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006be:	be 50 00 00 00       	mov    $0x50,%esi
  1006c3:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006c5:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006c8:	99                   	cltd   
  1006c9:	f7 fe                	idiv   %esi
  1006cb:	89 de                	mov    %ebx,%esi
  1006cd:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006cf:	eb 07                	jmp    1006d8 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006d1:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006d4:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1006d5:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006d8:	83 f8 50             	cmp    $0x50,%eax
  1006db:	75 f4                	jne    1006d1 <console_putc+0x2e>
  1006dd:	29 d0                	sub    %edx,%eax
  1006df:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006e2:	eb 0b                	jmp    1006ef <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006e4:	0f b6 d2             	movzbl %dl,%edx
  1006e7:	09 ca                	or     %ecx,%edx
  1006e9:	66 89 13             	mov    %dx,(%ebx)
  1006ec:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006ef:	5b                   	pop    %ebx
  1006f0:	5e                   	pop    %esi
  1006f1:	c3                   	ret    

001006f2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006f2:	56                   	push   %esi
  1006f3:	53                   	push   %ebx
  1006f4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006f8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006fb:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006ff:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100704:	75 04                	jne    10070a <fill_numbuf+0x18>
  100706:	85 d2                	test   %edx,%edx
  100708:	74 10                	je     10071a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10070a:	89 d0                	mov    %edx,%eax
  10070c:	31 d2                	xor    %edx,%edx
  10070e:	f7 f1                	div    %ecx
  100710:	4b                   	dec    %ebx
  100711:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100714:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100716:	89 c2                	mov    %eax,%edx
  100718:	eb ec                	jmp    100706 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10071a:	89 d8                	mov    %ebx,%eax
  10071c:	5b                   	pop    %ebx
  10071d:	5e                   	pop    %esi
  10071e:	c3                   	ret    

0010071f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10071f:	55                   	push   %ebp
  100720:	57                   	push   %edi
  100721:	56                   	push   %esi
  100722:	53                   	push   %ebx
  100723:	83 ec 38             	sub    $0x38,%esp
  100726:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10072a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10072e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100732:	e9 60 03 00 00       	jmp    100a97 <console_vprintf+0x378>
		if (*format != '%') {
  100737:	80 fa 25             	cmp    $0x25,%dl
  10073a:	74 13                	je     10074f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10073c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100740:	0f b6 d2             	movzbl %dl,%edx
  100743:	89 f0                	mov    %esi,%eax
  100745:	e8 59 ff ff ff       	call   1006a3 <console_putc>
  10074a:	e9 45 03 00 00       	jmp    100a94 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10074f:	47                   	inc    %edi
  100750:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100757:	00 
  100758:	eb 12                	jmp    10076c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10075a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10075b:	8a 11                	mov    (%ecx),%dl
  10075d:	84 d2                	test   %dl,%dl
  10075f:	74 1a                	je     10077b <console_vprintf+0x5c>
  100761:	89 e8                	mov    %ebp,%eax
  100763:	38 c2                	cmp    %al,%dl
  100765:	75 f3                	jne    10075a <console_vprintf+0x3b>
  100767:	e9 3f 03 00 00       	jmp    100aab <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10076c:	8a 17                	mov    (%edi),%dl
  10076e:	84 d2                	test   %dl,%dl
  100770:	74 0b                	je     10077d <console_vprintf+0x5e>
  100772:	b9 44 0b 10 00       	mov    $0x100b44,%ecx
  100777:	89 d5                	mov    %edx,%ebp
  100779:	eb e0                	jmp    10075b <console_vprintf+0x3c>
  10077b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10077d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100780:	3c 08                	cmp    $0x8,%al
  100782:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100789:	00 
  10078a:	76 13                	jbe    10079f <console_vprintf+0x80>
  10078c:	eb 1d                	jmp    1007ab <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10078e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100793:	0f be c0             	movsbl %al,%eax
  100796:	47                   	inc    %edi
  100797:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10079b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10079f:	8a 07                	mov    (%edi),%al
  1007a1:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007a4:	80 fa 09             	cmp    $0x9,%dl
  1007a7:	76 e5                	jbe    10078e <console_vprintf+0x6f>
  1007a9:	eb 18                	jmp    1007c3 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007ab:	80 fa 2a             	cmp    $0x2a,%dl
  1007ae:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007b5:	ff 
  1007b6:	75 0b                	jne    1007c3 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007b8:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007bb:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007bc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007bf:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007c3:	83 cd ff             	or     $0xffffffff,%ebp
  1007c6:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007c9:	75 37                	jne    100802 <console_vprintf+0xe3>
			++format;
  1007cb:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007cc:	31 ed                	xor    %ebp,%ebp
  1007ce:	8a 07                	mov    (%edi),%al
  1007d0:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007d3:	80 fa 09             	cmp    $0x9,%dl
  1007d6:	76 0d                	jbe    1007e5 <console_vprintf+0xc6>
  1007d8:	eb 17                	jmp    1007f1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007da:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007dd:	0f be c0             	movsbl %al,%eax
  1007e0:	47                   	inc    %edi
  1007e1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007e5:	8a 07                	mov    (%edi),%al
  1007e7:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007ea:	80 fa 09             	cmp    $0x9,%dl
  1007ed:	76 eb                	jbe    1007da <console_vprintf+0xbb>
  1007ef:	eb 11                	jmp    100802 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007f1:	3c 2a                	cmp    $0x2a,%al
  1007f3:	75 0b                	jne    100800 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007f5:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007f8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007f9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007fc:	85 ed                	test   %ebp,%ebp
  1007fe:	79 02                	jns    100802 <console_vprintf+0xe3>
  100800:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100802:	8a 07                	mov    (%edi),%al
  100804:	3c 64                	cmp    $0x64,%al
  100806:	74 34                	je     10083c <console_vprintf+0x11d>
  100808:	7f 1d                	jg     100827 <console_vprintf+0x108>
  10080a:	3c 58                	cmp    $0x58,%al
  10080c:	0f 84 a2 00 00 00    	je     1008b4 <console_vprintf+0x195>
  100812:	3c 63                	cmp    $0x63,%al
  100814:	0f 84 bf 00 00 00    	je     1008d9 <console_vprintf+0x1ba>
  10081a:	3c 43                	cmp    $0x43,%al
  10081c:	0f 85 d0 00 00 00    	jne    1008f2 <console_vprintf+0x1d3>
  100822:	e9 a3 00 00 00       	jmp    1008ca <console_vprintf+0x1ab>
  100827:	3c 75                	cmp    $0x75,%al
  100829:	74 4d                	je     100878 <console_vprintf+0x159>
  10082b:	3c 78                	cmp    $0x78,%al
  10082d:	74 5c                	je     10088b <console_vprintf+0x16c>
  10082f:	3c 73                	cmp    $0x73,%al
  100831:	0f 85 bb 00 00 00    	jne    1008f2 <console_vprintf+0x1d3>
  100837:	e9 86 00 00 00       	jmp    1008c2 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  10083c:	83 c3 04             	add    $0x4,%ebx
  10083f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100842:	89 d1                	mov    %edx,%ecx
  100844:	c1 f9 1f             	sar    $0x1f,%ecx
  100847:	89 0c 24             	mov    %ecx,(%esp)
  10084a:	31 ca                	xor    %ecx,%edx
  10084c:	55                   	push   %ebp
  10084d:	29 ca                	sub    %ecx,%edx
  10084f:	68 4c 0b 10 00       	push   $0x100b4c
  100854:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100859:	8d 44 24 40          	lea    0x40(%esp),%eax
  10085d:	e8 90 fe ff ff       	call   1006f2 <fill_numbuf>
  100862:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100866:	58                   	pop    %eax
  100867:	5a                   	pop    %edx
  100868:	ba 01 00 00 00       	mov    $0x1,%edx
  10086d:	8b 04 24             	mov    (%esp),%eax
  100870:	83 e0 01             	and    $0x1,%eax
  100873:	e9 a5 00 00 00       	jmp    10091d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100878:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10087b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100880:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100883:	55                   	push   %ebp
  100884:	68 4c 0b 10 00       	push   $0x100b4c
  100889:	eb 11                	jmp    10089c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10088b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10088e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100891:	55                   	push   %ebp
  100892:	68 60 0b 10 00       	push   $0x100b60
  100897:	b9 10 00 00 00       	mov    $0x10,%ecx
  10089c:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008a0:	e8 4d fe ff ff       	call   1006f2 <fill_numbuf>
  1008a5:	ba 01 00 00 00       	mov    $0x1,%edx
  1008aa:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1008ae:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008b0:	59                   	pop    %ecx
  1008b1:	59                   	pop    %ecx
  1008b2:	eb 69                	jmp    10091d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008b4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008b7:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008ba:	55                   	push   %ebp
  1008bb:	68 4c 0b 10 00       	push   $0x100b4c
  1008c0:	eb d5                	jmp    100897 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008c2:	83 c3 04             	add    $0x4,%ebx
  1008c5:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008c8:	eb 40                	jmp    10090a <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008ca:	83 c3 04             	add    $0x4,%ebx
  1008cd:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008d0:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1008d4:	e9 bd 01 00 00       	jmp    100a96 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008d9:	83 c3 04             	add    $0x4,%ebx
  1008dc:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008df:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008e3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008e8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008ec:	88 44 24 24          	mov    %al,0x24(%esp)
  1008f0:	eb 27                	jmp    100919 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008f2:	84 c0                	test   %al,%al
  1008f4:	75 02                	jne    1008f8 <console_vprintf+0x1d9>
  1008f6:	b0 25                	mov    $0x25,%al
  1008f8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008fc:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100901:	80 3f 00             	cmpb   $0x0,(%edi)
  100904:	74 0a                	je     100910 <console_vprintf+0x1f1>
  100906:	8d 44 24 24          	lea    0x24(%esp),%eax
  10090a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10090e:	eb 09                	jmp    100919 <console_vprintf+0x1fa>
				format--;
  100910:	8d 54 24 24          	lea    0x24(%esp),%edx
  100914:	4f                   	dec    %edi
  100915:	89 54 24 04          	mov    %edx,0x4(%esp)
  100919:	31 d2                	xor    %edx,%edx
  10091b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10091d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10091f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100922:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100929:	74 1f                	je     10094a <console_vprintf+0x22b>
  10092b:	89 04 24             	mov    %eax,(%esp)
  10092e:	eb 01                	jmp    100931 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100930:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100931:	39 e9                	cmp    %ebp,%ecx
  100933:	74 0a                	je     10093f <console_vprintf+0x220>
  100935:	8b 44 24 04          	mov    0x4(%esp),%eax
  100939:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  10093d:	75 f1                	jne    100930 <console_vprintf+0x211>
  10093f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100942:	89 0c 24             	mov    %ecx,(%esp)
  100945:	eb 1f                	jmp    100966 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100947:	42                   	inc    %edx
  100948:	eb 09                	jmp    100953 <console_vprintf+0x234>
  10094a:	89 d1                	mov    %edx,%ecx
  10094c:	8b 14 24             	mov    (%esp),%edx
  10094f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100953:	8b 44 24 04          	mov    0x4(%esp),%eax
  100957:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  10095b:	75 ea                	jne    100947 <console_vprintf+0x228>
  10095d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100961:	89 14 24             	mov    %edx,(%esp)
  100964:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100966:	85 c0                	test   %eax,%eax
  100968:	74 0c                	je     100976 <console_vprintf+0x257>
  10096a:	84 d2                	test   %dl,%dl
  10096c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100973:	00 
  100974:	75 24                	jne    10099a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100976:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  10097b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100982:	00 
  100983:	75 15                	jne    10099a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100985:	8b 44 24 14          	mov    0x14(%esp),%eax
  100989:	83 e0 08             	and    $0x8,%eax
  10098c:	83 f8 01             	cmp    $0x1,%eax
  10098f:	19 c9                	sbb    %ecx,%ecx
  100991:	f7 d1                	not    %ecx
  100993:	83 e1 20             	and    $0x20,%ecx
  100996:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  10099a:	3b 2c 24             	cmp    (%esp),%ebp
  10099d:	7e 0d                	jle    1009ac <console_vprintf+0x28d>
  10099f:	84 d2                	test   %dl,%dl
  1009a1:	74 40                	je     1009e3 <console_vprintf+0x2c4>
			zeros = precision - len;
  1009a3:	2b 2c 24             	sub    (%esp),%ebp
  1009a6:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009aa:	eb 3f                	jmp    1009eb <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009ac:	84 d2                	test   %dl,%dl
  1009ae:	74 33                	je     1009e3 <console_vprintf+0x2c4>
  1009b0:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009b4:	83 e0 06             	and    $0x6,%eax
  1009b7:	83 f8 02             	cmp    $0x2,%eax
  1009ba:	75 27                	jne    1009e3 <console_vprintf+0x2c4>
  1009bc:	45                   	inc    %ebp
  1009bd:	75 24                	jne    1009e3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009bf:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009c1:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009c4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009c9:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009cc:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009cf:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009d3:	7d 0e                	jge    1009e3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1009d5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009d9:	29 ca                	sub    %ecx,%edx
  1009db:	29 c2                	sub    %eax,%edx
  1009dd:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009e1:	eb 08                	jmp    1009eb <console_vprintf+0x2cc>
  1009e3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009ea:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009eb:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009ef:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009f1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009f5:	2b 2c 24             	sub    (%esp),%ebp
  1009f8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009fd:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a00:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a03:	29 c5                	sub    %eax,%ebp
  100a05:	89 f0                	mov    %esi,%eax
  100a07:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a0b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a0f:	eb 0f                	jmp    100a20 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a11:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a15:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a1a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a1b:	e8 83 fc ff ff       	call   1006a3 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a20:	85 ed                	test   %ebp,%ebp
  100a22:	7e 07                	jle    100a2b <console_vprintf+0x30c>
  100a24:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a29:	74 e6                	je     100a11 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a2b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a30:	89 c6                	mov    %eax,%esi
  100a32:	74 23                	je     100a57 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a34:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a39:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a3d:	e8 61 fc ff ff       	call   1006a3 <console_putc>
  100a42:	89 c6                	mov    %eax,%esi
  100a44:	eb 11                	jmp    100a57 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a46:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a4a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a4f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a50:	e8 4e fc ff ff       	call   1006a3 <console_putc>
  100a55:	eb 06                	jmp    100a5d <console_vprintf+0x33e>
  100a57:	89 f0                	mov    %esi,%eax
  100a59:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a5d:	85 f6                	test   %esi,%esi
  100a5f:	7f e5                	jg     100a46 <console_vprintf+0x327>
  100a61:	8b 34 24             	mov    (%esp),%esi
  100a64:	eb 15                	jmp    100a7b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a66:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a6a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a6b:	0f b6 11             	movzbl (%ecx),%edx
  100a6e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a72:	e8 2c fc ff ff       	call   1006a3 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a77:	ff 44 24 04          	incl   0x4(%esp)
  100a7b:	85 f6                	test   %esi,%esi
  100a7d:	7f e7                	jg     100a66 <console_vprintf+0x347>
  100a7f:	eb 0f                	jmp    100a90 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a81:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a85:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a8a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a8b:	e8 13 fc ff ff       	call   1006a3 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a90:	85 ed                	test   %ebp,%ebp
  100a92:	7f ed                	jg     100a81 <console_vprintf+0x362>
  100a94:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a96:	47                   	inc    %edi
  100a97:	8a 17                	mov    (%edi),%dl
  100a99:	84 d2                	test   %dl,%dl
  100a9b:	0f 85 96 fc ff ff    	jne    100737 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100aa1:	83 c4 38             	add    $0x38,%esp
  100aa4:	89 f0                	mov    %esi,%eax
  100aa6:	5b                   	pop    %ebx
  100aa7:	5e                   	pop    %esi
  100aa8:	5f                   	pop    %edi
  100aa9:	5d                   	pop    %ebp
  100aaa:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100aab:	81 e9 44 0b 10 00    	sub    $0x100b44,%ecx
  100ab1:	b8 01 00 00 00       	mov    $0x1,%eax
  100ab6:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ab8:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ab9:	09 44 24 14          	or     %eax,0x14(%esp)
  100abd:	e9 aa fc ff ff       	jmp    10076c <console_vprintf+0x4d>

00100ac2 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100ac2:	8d 44 24 10          	lea    0x10(%esp),%eax
  100ac6:	50                   	push   %eax
  100ac7:	ff 74 24 10          	pushl  0x10(%esp)
  100acb:	ff 74 24 10          	pushl  0x10(%esp)
  100acf:	ff 74 24 10          	pushl  0x10(%esp)
  100ad3:	e8 47 fc ff ff       	call   10071f <console_vprintf>
  100ad8:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100adb:	c3                   	ret    
