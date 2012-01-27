
obj/mpos-kern:     file format elf32-i386

Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
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
  100014:	e8 96 02 00 00       	call   1002af <start>
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

_generic_int_handler:
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
  10005e:	e8 9e 00 00 00       	call   100101 <interrupt>

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
  10008a:	00 90 56 53 83 ec    	add    %dl,0xec835356(%eax)

0010008c <schedule>:
 *****************************************************************************/

void
schedule(void)
{
  10008c:	56                   	push   %esi
  10008d:	53                   	push   %ebx
  10008e:	83 ec 04             	sub    $0x4,%esp
	pid_t pid = current->p_pid;
  100091:	a1 80 97 10 00       	mov    0x109780,%eax
  100096:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  100098:	8d 42 01             	lea    0x1(%edx),%eax
  10009b:	ba 10 00 00 00       	mov    $0x10,%edx
  1000a0:	89 d1                	mov    %edx,%ecx
  1000a2:	99                   	cltd   
  1000a3:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a5:	6b ca 54             	imul   $0x54,%edx,%ecx
  1000a8:	8d b1 cc 89 10 00    	lea    0x1089cc(%ecx),%esi
  1000ae:	8b 46 40             	mov    0x40(%esi),%eax
  1000b1:	83 f8 01             	cmp    $0x1,%eax
  1000b4:	74 3c                	je     1000f2 <schedule+0x66>
			run(&proc_array[pid]);
        else if(proc_array[pid].p_state == P_BLOCKED)   //XIA: the process it is waiting have EXIT
  1000b6:	83 f8 02             	cmp    $0x2,%eax
  1000b9:	75 dd                	jne    100098 <schedule+0xc>
        {
            if(proc_array[(proc_array[pid].wait_pid)].p_state == P_ZOMBIE)
  1000bb:	6b 81 c4 89 10 00 54 	imul   $0x54,0x1089c4(%ecx),%eax
  1000c2:	8d 98 cc 89 10 00    	lea    0x1089cc(%eax),%ebx
  1000c8:	83 7b 40 03          	cmpl   $0x3,0x40(%ebx)
  1000cc:	75 ca                	jne    100098 <schedule+0xc>
            {
                proc_array[pid].p_registers.reg_eax = proc_array[proc_array[pid].wait_pid].p_exit_status;
  1000ce:	8b 80 10 8a 10 00    	mov    0x108a10(%eax),%eax
		proc_array[proc_array[pid].wait_pid].p_state = P_EMPTY; //SK:set the zombie process's status as empty
  1000d4:	c7 43 40 00 00 00 00 	movl   $0x0,0x40(%ebx)
		proc_array[pid].p_state = P_RUNNABLE;
		proc_array[pid].wait_pid = -1;
  1000db:	c7 81 c4 89 10 00 ff 	movl   $0xffffffff,0x1089c4(%ecx)
  1000e2:	ff ff ff 
  1000e5:	c7 46 40 01 00 00 00 	movl   $0x1,0x40(%esi)
  1000ec:	89 81 e4 89 10 00    	mov    %eax,0x1089e4(%ecx)
                run(&proc_array[pid]);
  1000f2:	83 ec 0c             	sub    $0xc,%esp
  1000f5:	8d 81 c0 89 10 00    	lea    0x1089c0(%ecx),%eax
  1000fb:	50                   	push   %eax
  1000fc:	e8 46 03 00 00       	call   100447 <run>

00100101 <interrupt>:
  100101:	55                   	push   %ebp
  100102:	89 e5                	mov    %esp,%ebp
  100104:	57                   	push   %edi
  100105:	56                   	push   %esi
  100106:	53                   	push   %ebx
  100107:	83 ec 10             	sub    $0x10,%esp
  10010a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10010d:	8b 3d 80 97 10 00    	mov    0x109780,%edi
  100113:	6a 44                	push   $0x44
  100115:	53                   	push   %ebx
  100116:	8d 47 08             	lea    0x8(%edi),%eax
  100119:	50                   	push   %eax
  10011a:	e8 ad 04 00 00       	call   1005cc <memcpy>
  10011f:	8b 43 28             	mov    0x28(%ebx),%eax
  100122:	83 c4 10             	add    $0x10,%esp
  100125:	83 e8 30             	sub    $0x30,%eax
  100128:	83 f8 05             	cmp    $0x5,%eax
  10012b:	0f 87 7c 01 00 00    	ja     1002ad <interrupt+0x1ac>
  100131:	ff 24 85 10 0b 10 00 	jmp    *0x100b10(,%eax,4)
  100138:	b8 01 00 00 00       	mov    $0x1,%eax
  10013d:	eb 1e                	jmp    10015d <interrupt+0x5c>
  10013f:	8b 07                	mov    (%edi),%eax
  100141:	83 ec 0c             	sub    $0xc,%esp
  100144:	89 47 24             	mov    %eax,0x24(%edi)
  100147:	57                   	push   %edi
  100148:	e9 97 00 00 00       	jmp    1001e4 <interrupt+0xe3>
  10014d:	6b d0 54             	imul   $0x54,%eax,%edx
  100150:	83 ba 0c 8a 10 00 00 	cmpl   $0x0,0x108a0c(%edx)
  100157:	89 55 ec             	mov    %edx,0xffffffec(%ebp)
  10015a:	74 0f                	je     10016b <interrupt+0x6a>
  10015c:	40                   	inc    %eax
  10015d:	83 f8 10             	cmp    $0x10,%eax
  100160:	75 eb                	jne    10014d <interrupt+0x4c>
  100162:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,0xfffffff0(%ebp)
  100169:	eb 6a                	jmp    1001d5 <interrupt+0xd4>
  10016b:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
  10016e:	40                   	inc    %eax
  10016f:	74 64                	je     1001d5 <interrupt+0xd4>
  100171:	8b 75 ec             	mov    0xffffffec(%ebp),%esi
  100174:	8d 47 08             	lea    0x8(%edi),%eax
  100177:	51                   	push   %ecx
  100178:	6a 44                	push   $0x44
  10017a:	50                   	push   %eax
  10017b:	81 c6 c0 89 10 00    	add    $0x1089c0,%esi
  100181:	8d 56 08             	lea    0x8(%esi),%edx
  100184:	52                   	push   %edx
  100185:	e8 42 04 00 00       	call   1005cc <memcpy>
  10018a:	8b 4d ec             	mov    0xffffffec(%ebp),%ecx
  10018d:	83 c4 0c             	add    $0xc,%esp
  100190:	8b 07                	mov    (%edi),%eax
  100192:	8b 57 44             	mov    0x44(%edi),%edx
  100195:	8b 99 c0 89 10 00    	mov    0x1089c0(%ecx),%ebx
  10019b:	c1 e0 12             	shl    $0x12,%eax
  10019e:	05 00 00 28 00       	add    $0x280000,%eax
  1001a3:	29 d0                	sub    %edx,%eax
  1001a5:	c1 e3 12             	shl    $0x12,%ebx
  1001a8:	50                   	push   %eax
  1001a9:	81 c3 00 00 28 00    	add    $0x280000,%ebx
  1001af:	29 c3                	sub    %eax,%ebx
  1001b1:	52                   	push   %edx
  1001b2:	53                   	push   %ebx
  1001b3:	e8 14 04 00 00       	call   1005cc <memcpy>
  1001b8:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
  1001bb:	83 c4 10             	add    $0x10,%esp
  1001be:	89 5e 44             	mov    %ebx,0x44(%esi)
  1001c1:	c7 80 0c 8a 10 00 01 	movl   $0x1,0x108a0c(%eax)
  1001c8:	00 00 00 
  1001cb:	c7 80 e4 89 10 00 00 	movl   $0x0,0x1089e4(%eax)
  1001d2:	00 00 00 
  1001d5:	8b 55 f0             	mov    0xfffffff0(%ebp),%edx
  1001d8:	83 ec 0c             	sub    $0xc,%esp
  1001db:	89 57 24             	mov    %edx,0x24(%edi)
  1001de:	ff 35 80 97 10 00    	pushl  0x109780
  1001e4:	e8 5e 02 00 00       	call   100447 <run>
  1001e9:	e8 9e fe ff ff       	call   10008c <schedule>
  1001ee:	a1 80 97 10 00       	mov    0x109780,%eax
  1001f3:	8b 50 24             	mov    0x24(%eax),%edx
  1001f6:	c7 40 4c 03 00 00 00 	movl   $0x3,0x4c(%eax)
  1001fd:	89 50 50             	mov    %edx,0x50(%eax)
  100200:	e8 87 fe ff ff       	call   10008c <schedule>
  100205:	8b 15 80 97 10 00    	mov    0x109780,%edx
  10020b:	8b 4a 24             	mov    0x24(%edx),%ecx
  10020e:	8d 41 ff             	lea    0xffffffff(%ecx),%eax
  100211:	83 f8 0e             	cmp    $0xe,%eax
  100214:	77 14                	ja     10022a <interrupt+0x129>
  100216:	3b 0a                	cmp    (%edx),%ecx
  100218:	74 10                	je     10022a <interrupt+0x129>
  10021a:	6b d9 54             	imul   $0x54,%ecx,%ebx
  10021d:	8d b3 cc 89 10 00    	lea    0x1089cc(%ebx),%esi
  100223:	8b 46 40             	mov    0x40(%esi),%eax
  100226:	85 c0                	test   %eax,%eax
  100228:	75 09                	jne    100233 <interrupt+0x132>
  10022a:	c7 42 24 ff ff ff ff 	movl   $0xffffffff,0x24(%edx)
  100231:	eb 21                	jmp    100254 <interrupt+0x153>
  100233:	83 f8 03             	cmp    $0x3,%eax
  100236:	75 12                	jne    10024a <interrupt+0x149>
  100238:	8b 83 10 8a 10 00    	mov    0x108a10(%ebx),%eax
  10023e:	c7 46 40 00 00 00 00 	movl   $0x0,0x40(%esi)
  100245:	89 42 24             	mov    %eax,0x24(%edx)
  100248:	eb 0a                	jmp    100254 <interrupt+0x153>
  10024a:	c7 42 4c 02 00 00 00 	movl   $0x2,0x4c(%edx)
  100251:	89 4a 04             	mov    %ecx,0x4(%edx)
  100254:	e8 33 fe ff ff       	call   10008c <schedule>
  100259:	8b 0d 80 97 10 00    	mov    0x109780,%ecx
  10025f:	8b 51 24             	mov    0x24(%ecx),%edx
  100262:	8d 42 ff             	lea    0xffffffff(%edx),%eax
  100265:	83 f8 0e             	cmp    $0xe,%eax
  100268:	77 14                	ja     10027e <interrupt+0x17d>
  10026a:	3b 11                	cmp    (%ecx),%edx
  10026c:	74 10                	je     10027e <interrupt+0x17d>
  10026e:	6b c2 54             	imul   $0x54,%edx,%eax
  100271:	8d 98 cc 89 10 00    	lea    0x1089cc(%eax),%ebx
  100277:	8b 53 40             	mov    0x40(%ebx),%edx
  10027a:	85 d2                	test   %edx,%edx
  10027c:	75 09                	jne    100287 <interrupt+0x186>
  10027e:	c7 41 24 ff ff ff ff 	movl   $0xffffffff,0x24(%ecx)
  100285:	eb 1d                	jmp    1002a4 <interrupt+0x1a3>
  100287:	83 fa 03             	cmp    $0x3,%edx
  10028a:	74 11                	je     10029d <interrupt+0x19c>
  10028c:	c7 43 40 03 00 00 00 	movl   $0x3,0x40(%ebx)
  100293:	c7 80 10 8a 10 00 ff 	movl   $0xffffffff,0x108a10(%eax)
  10029a:	ff ff ff 
  10029d:	c7 41 24 01 00 00 00 	movl   $0x1,0x24(%ecx)
  1002a4:	83 ec 0c             	sub    $0xc,%esp
  1002a7:	51                   	push   %ecx
  1002a8:	e9 37 ff ff ff       	jmp    1001e4 <interrupt+0xe3>
  1002ad:	eb fe                	jmp    1002ad <interrupt+0x1ac>

001002af <start>:
  1002af:	53                   	push   %ebx
  1002b0:	83 ec 0c             	sub    $0xc,%esp
  1002b3:	68 40 05 00 00       	push   $0x540
  1002b8:	6a 00                	push   $0x0
  1002ba:	68 c0 89 10 00       	push   $0x1089c0
  1002bf:	e8 6e 03 00 00       	call   100632 <memset>
  1002c4:	31 d2                	xor    %edx,%edx
  1002c6:	31 c0                	xor    %eax,%eax
  1002c8:	83 c4 10             	add    $0x10,%esp
  1002cb:	89 90 c0 89 10 00    	mov    %edx,0x1089c0(%eax)
  1002d1:	42                   	inc    %edx
  1002d2:	c7 80 0c 8a 10 00 00 	movl   $0x0,0x108a0c(%eax)
  1002d9:	00 00 00 
  1002dc:	c7 80 c4 89 10 00 ff 	movl   $0xffffffff,0x1089c4(%eax)
  1002e3:	ff ff ff 
  1002e6:	83 c0 54             	add    $0x54,%eax
  1002e9:	83 fa 10             	cmp    $0x10,%edx
  1002ec:	75 dd                	jne    1002cb <start+0x1c>
  1002ee:	c7 05 80 97 10 00 14 	movl   $0x108a14,0x109780
  1002f5:	8a 10 00 
  1002f8:	e8 73 00 00 00       	call   100370 <segments_init>
  1002fd:	83 ec 0c             	sub    $0xc,%esp
  100300:	ff 35 80 97 10 00    	pushl  0x109780
  100306:	e8 53 01 00 00       	call   10045e <special_registers_init>
  10030b:	e8 d6 01 00 00       	call   1004e6 <console_clear>
  100310:	83 c4 0c             	add    $0xc,%esp
  100313:	68 28 0b 10 00       	push   $0x100b28
  100318:	68 00 07 00 00       	push   $0x700
  10031d:	ff 35 00 00 06 00    	pushl  0x60000
  100323:	e8 ce 07 00 00       	call   100af6 <console_printf>
  100328:	83 c4 10             	add    $0x10,%esp
  10032b:	a3 00 00 06 00       	mov    %eax,0x60000
  100330:	e8 5b 01 00 00       	call   100490 <console_read_digit>
  100335:	8d 58 ff             	lea    0xffffffff(%eax),%ebx
  100338:	83 fb 01             	cmp    $0x1,%ebx
  10033b:	77 f3                	ja     100330 <start+0x81>
  10033d:	e8 a4 01 00 00       	call   1004e6 <console_clear>
  100342:	50                   	push   %eax
  100343:	50                   	push   %eax
  100344:	a1 80 97 10 00       	mov    0x109780,%eax
  100349:	83 c0 38             	add    $0x38,%eax
  10034c:	50                   	push   %eax
  10034d:	53                   	push   %ebx
  10034e:	e8 d9 01 00 00       	call   10052c <program_loader>
  100353:	a1 80 97 10 00       	mov    0x109780,%eax
  100358:	c7 40 44 00 00 2c 00 	movl   $0x2c0000,0x44(%eax)
  10035f:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
  100366:	89 04 24             	mov    %eax,(%esp)
  100369:	e8 d9 00 00 00       	call   100447 <run>
  10036e:	90                   	nop    
  10036f:	90                   	nop    

00100370 <segments_init>:
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100370:	b8 00 8f 10 00       	mov    $0x108f00,%eax
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100375:	31 d2                	xor    %edx,%edx
  100377:	66 a3 4a 10 10 00    	mov    %ax,0x10104a
  10037d:	c1 e8 10             	shr    $0x10,%eax
  100380:	a2 4c 10 10 00       	mov    %al,0x10104c
  100385:	c1 e8 08             	shr    $0x8,%eax
  100388:	66 c7 05 48 10 10 00 	movw   $0x68,0x101048
  10038f:	68 00 
  100391:	c6 05 4e 10 10 00 40 	movb   $0x40,0x10104e
  100398:	a2 4f 10 10 00       	mov    %al,0x10104f
  10039d:	c6 05 4d 10 10 00 89 	movb   $0x89,0x10104d
  1003a4:	c7 05 04 8f 10 00 00 	movl   $0x80000,0x108f04
  1003ab:	00 08 00 
  1003ae:	66 c7 05 08 8f 10 00 	movw   $0x10,0x108f08
  1003b5:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003b7:	b8 56 00 10 00       	mov    $0x100056,%eax
  1003bc:	66 89 04 d5 80 8f 10 	mov    %ax,0x108f80(,%edx,8)
  1003c3:	00 
  1003c4:	c1 e8 10             	shr    $0x10,%eax
  1003c7:	66 c7 04 d5 82 8f 10 	movw   $0x8,0x108f82(,%edx,8)
  1003ce:	00 08 00 
  1003d1:	c6 04 d5 84 8f 10 00 	movb   $0x0,0x108f84(,%edx,8)
  1003d8:	00 
  1003d9:	c6 04 d5 85 8f 10 00 	movb   $0x8e,0x108f85(,%edx,8)
  1003e0:	8e 
  1003e1:	66 89 04 d5 86 8f 10 	mov    %ax,0x108f86(,%edx,8)
  1003e8:	00 
  1003e9:	42                   	inc    %edx
  1003ea:	81 fa 00 01 00 00    	cmp    $0x100,%edx
  1003f0:	75 c5                	jne    1003b7 <segments_init+0x47>
  1003f2:	66 ba 30 00          	mov    $0x30,%dx
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003f6:	8b 04 95 a3 ff 0f 00 	mov    0xfffa3(,%edx,4),%eax
  1003fd:	66 c7 04 d5 82 8f 10 	movw   $0x8,0x108f82(,%edx,8)
  100404:	00 08 00 
  100407:	c6 04 d5 84 8f 10 00 	movb   $0x0,0x108f84(,%edx,8)
  10040e:	00 
  10040f:	c6 04 d5 85 8f 10 00 	movb   $0xee,0x108f85(,%edx,8)
  100416:	ee 
  100417:	66 89 04 d5 80 8f 10 	mov    %ax,0x108f80(,%edx,8)
  10041e:	00 
  10041f:	c1 e8 10             	shr    $0x10,%eax
  100422:	66 89 04 d5 86 8f 10 	mov    %ax,0x108f86(,%edx,8)
  100429:	00 
  10042a:	42                   	inc    %edx
  10042b:	83 fa 3a             	cmp    $0x3a,%edx
  10042e:	75 c6                	jne    1003f6 <segments_init+0x86>
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100430:	b8 28 00 00 00       	mov    $0x28,%eax
  100435:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10043c:	0f 00 d8             	ltr    %ax
  10043f:	0f 01 1d 06 10 10 00 	lidtl  0x101006
		     "ltr %0\n\t"
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100446:	c3                   	ret    

00100447 <run>:



/*****************************************************************************
 * special_registers_init
 *
 *   Set up the first process's registers to required values.  In particular,
 *   tell the first process to use the memory information set up by
 *   segments_init().
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
	memset(&proc->p_registers, 0, sizeof(registers_t));
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
}



/*****************************************************************************
 * console_clear
 *
 *   Clear the console by writing spaces to it, and move the cursor to the
 *   upper left (row 0, column 0).
 *
 *****************************************************************************/

void
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}



/*****************************************************************************
 * console_read_digit
 *
 *   Read a single digit from the keyboard and return it.
 *
 *****************************************************************************/

#define KBSTATP 0x64
#define KBS_DIB 0x01
#define KBDATAP 0x60

int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
		return data - 0x02 + 1;
	else if (data == 0x0B)
		return 0;
	else if (data >= 0x47 && data <= 0x49)
		return data - 0x47 + 7;
	else if (data >= 0x4B && data <= 0x4D)
		return data - 0x4B + 4;
	else if (data >= 0x4F && data <= 0x51)
		return data - 0x4F + 1;
	else if (data == 0x53)
		return 0;
	else
		return -1;
}


/*****************************************************************************
 * run
 *
 *   Run the process with the supplied process descriptor.
 *   This means reloading all the relevant registers from the descriptor's
 *   p_registers member, using the 'popal', 'popl', and 'iret'
 *   instructions.
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100447:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  10044b:	a3 80 97 10 00       	mov    %eax,0x109780

	asm volatile("movl %0,%%esp\n\t"
  100450:	83 c0 08             	add    $0x8,%eax
  100453:	89 c4                	mov    %eax,%esp
  100455:	61                   	popa   
  100456:	07                   	pop    %es
  100457:	1f                   	pop    %ds
  100458:	83 c4 08             	add    $0x8,%esp
  10045b:	cf                   	iret   
  10045c:	eb fe                	jmp    10045c <run+0x15>

0010045e <special_registers_init>:
  10045e:	53                   	push   %ebx
  10045f:	83 ec 0c             	sub    $0xc,%esp
  100462:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  100466:	6a 44                	push   $0x44
  100468:	6a 00                	push   $0x0
  10046a:	8d 43 08             	lea    0x8(%ebx),%eax
  10046d:	50                   	push   %eax
  10046e:	e8 bf 01 00 00       	call   100632 <memset>
  100473:	66 c7 43 3c 1b 00    	movw   $0x1b,0x3c(%ebx)
  100479:	66 c7 43 2c 23 00    	movw   $0x23,0x2c(%ebx)
  10047f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
  100485:	66 c7 43 48 23 00    	movw   $0x23,0x48(%ebx)
  10048b:	83 c4 18             	add    $0x18,%esp
  10048e:	5b                   	pop    %ebx
  10048f:	c3                   	ret    

00100490 <console_read_digit>:
static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100490:	ba 64 00 00 00       	mov    $0x64,%edx
  100495:	ec                   	in     (%dx),%al
  100496:	a8 01                	test   $0x1,%al
  100498:	74 45                	je     1004df <console_read_digit+0x4f>
static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10049a:	b2 60                	mov    $0x60,%dl
  10049c:	ec                   	in     (%dx),%al
  10049d:	88 c2                	mov    %al,%dl
  10049f:	8d 42 fe             	lea    0xfffffffe(%edx),%eax
  1004a2:	3c 08                	cmp    $0x8,%al
  1004a4:	77 05                	ja     1004ab <console_read_digit+0x1b>
  1004a6:	0f b6 c2             	movzbl %dl,%eax
  1004a9:	48                   	dec    %eax
  1004aa:	c3                   	ret    
  1004ab:	80 fa 0b             	cmp    $0xb,%dl
  1004ae:	74 33                	je     1004e3 <console_read_digit+0x53>
  1004b0:	8d 42 b9             	lea    0xffffffb9(%edx),%eax
  1004b3:	3c 02                	cmp    $0x2,%al
  1004b5:	77 07                	ja     1004be <console_read_digit+0x2e>
  1004b7:	0f b6 c2             	movzbl %dl,%eax
  1004ba:	83 e8 40             	sub    $0x40,%eax
  1004bd:	c3                   	ret    
  1004be:	8d 42 b5             	lea    0xffffffb5(%edx),%eax
  1004c1:	3c 02                	cmp    $0x2,%al
  1004c3:	77 07                	ja     1004cc <console_read_digit+0x3c>
  1004c5:	0f b6 c2             	movzbl %dl,%eax
  1004c8:	83 e8 47             	sub    $0x47,%eax
  1004cb:	c3                   	ret    
  1004cc:	8d 42 b1             	lea    0xffffffb1(%edx),%eax
  1004cf:	3c 02                	cmp    $0x2,%al
  1004d1:	77 07                	ja     1004da <console_read_digit+0x4a>
  1004d3:	0f b6 c2             	movzbl %dl,%eax
  1004d6:	83 e8 4e             	sub    $0x4e,%eax
  1004d9:	c3                   	ret    
  1004da:	80 fa 53             	cmp    $0x53,%dl
  1004dd:	74 04                	je     1004e3 <console_read_digit+0x53>
  1004df:	83 c8 ff             	or     $0xffffffff,%eax
  1004e2:	c3                   	ret    
  1004e3:	31 c0                	xor    %eax,%eax
  1004e5:	c3                   	ret    

001004e6 <console_clear>:
  1004e6:	56                   	push   %esi
  1004e7:	31 c0                	xor    %eax,%eax
  1004e9:	53                   	push   %ebx
  1004ea:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  1004f1:	80 0b 00 
  1004f4:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  1004fb:	00 20 07 
  1004fe:	40                   	inc    %eax
  1004ff:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100504:	75 ee                	jne    1004f4 <console_clear+0xe>

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100506:	bb d4 03 00 00       	mov    $0x3d4,%ebx
  10050b:	b0 0e                	mov    $0xe,%al
  10050d:	89 da                	mov    %ebx,%edx
  10050f:	ee                   	out    %al,(%dx)
  100510:	31 c9                	xor    %ecx,%ecx
  100512:	be d5 03 00 00       	mov    $0x3d5,%esi
  100517:	88 c8                	mov    %cl,%al
  100519:	89 f2                	mov    %esi,%edx
  10051b:	ee                   	out    %al,(%dx)
  10051c:	b0 0f                	mov    $0xf,%al
  10051e:	89 da                	mov    %ebx,%edx
  100520:	ee                   	out    %al,(%dx)
  100521:	88 c8                	mov    %cl,%al
  100523:	89 f2                	mov    %esi,%edx
  100525:	ee                   	out    %al,(%dx)
  100526:	5b                   	pop    %ebx
  100527:	5e                   	pop    %esi
  100528:	c3                   	ret    
  100529:	90                   	nop    
  10052a:	90                   	nop    
  10052b:	90                   	nop    

0010052c <program_loader>:
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10052c:	55                   	push   %ebp
  10052d:	57                   	push   %edi
  10052e:	56                   	push   %esi
  10052f:	53                   	push   %ebx
  100530:	83 ec 0c             	sub    $0xc,%esp
  100533:	8b 44 24 20          	mov    0x20(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100537:	85 c0                	test   %eax,%eax
  100539:	78 05                	js     100540 <program_loader+0x14>
  10053b:	83 f8 01             	cmp    $0x1,%eax
  10053e:	7e 0b                	jle    10054b <program_loader+0x1f>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
		if (ph->p_type == ELF_PROG_LOAD)
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
}

// Copy 'filesz' bytes starting at address 'data' into virtual address 'dst',
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
}

static void
loader_panic(void)
{
	*((uint16_t *) 0xB8000) = '!' | 0x700;
  100540:	66 c7 05 00 80 0b 00 	movw   $0x721,0xb8000
  100547:	21 07 
  100549:	eb fe                	jmp    100549 <program_loader+0x1d>
  10054b:	8b 3c c5 50 10 10 00 	mov    0x101050(,%eax,8),%edi
  100552:	81 3f 7f 45 4c 46    	cmpl   $0x464c457f,(%edi)
  100558:	74 0b                	je     100565 <program_loader+0x39>
  10055a:	66 c7 05 00 80 0b 00 	movw   $0x721,0xb8000
  100561:	21 07 
  100563:	eb fe                	jmp    100563 <program_loader+0x37>
  100565:	0f b7 47 2c          	movzwl 0x2c(%edi),%eax
  100569:	89 fb                	mov    %edi,%ebx
  10056b:	03 5f 1c             	add    0x1c(%edi),%ebx
  10056e:	c1 e0 05             	shl    $0x5,%eax
  100571:	8d 04 03             	lea    (%ebx,%eax,1),%eax
  100574:	89 44 24 08          	mov    %eax,0x8(%esp)
  100578:	eb 39                	jmp    1005b3 <program_loader+0x87>
  10057a:	83 3b 01             	cmpl   $0x1,(%ebx)
  10057d:	75 31                	jne    1005b0 <program_loader+0x84>
  10057f:	8b 43 08             	mov    0x8(%ebx),%eax
  100582:	89 c6                	mov    %eax,%esi
  100584:	89 c5                	mov    %eax,%ebp
  100586:	03 73 10             	add    0x10(%ebx),%esi
  100589:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10058e:	03 6b 14             	add    0x14(%ebx),%ebp
  100591:	52                   	push   %edx
  100592:	89 f2                	mov    %esi,%edx
  100594:	29 c2                	sub    %eax,%edx
  100596:	52                   	push   %edx
  100597:	89 fa                	mov    %edi,%edx
  100599:	03 53 04             	add    0x4(%ebx),%edx
  10059c:	52                   	push   %edx
  10059d:	50                   	push   %eax
  10059e:	e8 29 00 00 00       	call   1005cc <memcpy>
  1005a3:	83 c4 10             	add    $0x10,%esp
  1005a6:	eb 04                	jmp    1005ac <program_loader+0x80>
  1005a8:	c6 06 00             	movb   $0x0,(%esi)
  1005ab:	46                   	inc    %esi
  1005ac:	39 ee                	cmp    %ebp,%esi
  1005ae:	72 f8                	jb     1005a8 <program_loader+0x7c>
  1005b0:	83 c3 20             	add    $0x20,%ebx
  1005b3:	3b 5c 24 08          	cmp    0x8(%esp),%ebx
  1005b7:	72 c1                	jb     10057a <program_loader+0x4e>
  1005b9:	8b 57 18             	mov    0x18(%edi),%edx
  1005bc:	8b 44 24 24          	mov    0x24(%esp),%eax
  1005c0:	89 10                	mov    %edx,(%eax)
  1005c2:	83 c4 0c             	add    $0xc,%esp
  1005c5:	5b                   	pop    %ebx
  1005c6:	5e                   	pop    %esi
  1005c7:	5f                   	pop    %edi
  1005c8:	5d                   	pop    %ebp
  1005c9:	c3                   	ret    
  1005ca:	90                   	nop    
  1005cb:	90                   	nop    

001005cc <memcpy>:
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005cc:	53                   	push   %ebx
  1005cd:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005d1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  1005d5:	8b 54 24 08          	mov    0x8(%esp),%edx
  1005d9:	eb 06                	jmp    1005e1 <memcpy+0x15>
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
		*d++ = *s++;
  1005db:	8a 41 ff             	mov    0xffffffff(%ecx),%al
  1005de:	88 42 ff             	mov    %al,0xffffffff(%edx)
  1005e1:	4b                   	dec    %ebx
  1005e2:	41                   	inc    %ecx
  1005e3:	42                   	inc    %edx
  1005e4:	83 fb ff             	cmp    $0xffffffff,%ebx
  1005e7:	75 f2                	jne    1005db <memcpy+0xf>
	return dst;
}
  1005e9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005ed:	5b                   	pop    %ebx
  1005ee:	c3                   	ret    

001005ef <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005ef:	56                   	push   %esi
  1005f0:	53                   	push   %ebx
  1005f1:	8b 74 24 0c          	mov    0xc(%esp),%esi
  1005f5:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005f9:	8b 54 24 14          	mov    0x14(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005fd:	39 f0                	cmp    %esi,%eax
  1005ff:	73 0a                	jae    10060b <memmove+0x1c>
  100601:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  100604:	39 f3                	cmp    %esi,%ebx
		s += n, d += n;
  100606:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
  100609:	77 0c                	ja     100617 <memmove+0x28>
  10060b:	89 c3                	mov    %eax,%ebx
  10060d:	89 f1                	mov    %esi,%ecx
  10060f:	eb 14                	jmp    100625 <memmove+0x36>
		while (n-- > 0)
			*--d = *--s;
  100611:	4b                   	dec    %ebx
  100612:	49                   	dec    %ecx
  100613:	8a 03                	mov    (%ebx),%al
  100615:	88 01                	mov    %al,(%ecx)
  100617:	4a                   	dec    %edx
  100618:	83 fa ff             	cmp    $0xffffffff,%edx
  10061b:	75 f4                	jne    100611 <memmove+0x22>
  10061d:	eb 0e                	jmp    10062d <memmove+0x3e>
	} else
		while (n-- > 0)
			*d++ = *s++;
  10061f:	8a 43 ff             	mov    0xffffffff(%ebx),%al
  100622:	88 41 ff             	mov    %al,0xffffffff(%ecx)
  100625:	4a                   	dec    %edx
  100626:	43                   	inc    %ebx
  100627:	41                   	inc    %ecx
  100628:	83 fa ff             	cmp    $0xffffffff,%edx
  10062b:	75 f2                	jne    10061f <memmove+0x30>
	return dst;
}
  10062d:	89 f0                	mov    %esi,%eax
  10062f:	5b                   	pop    %ebx
  100630:	5e                   	pop    %esi
  100631:	c3                   	ret    

00100632 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100632:	53                   	push   %ebx
  100633:	8b 44 24 08          	mov    0x8(%esp),%eax
  100637:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  10063b:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  10063f:	89 c2                	mov    %eax,%edx
  100641:	eb 03                	jmp    100646 <memset+0x14>
	char *p = (char *) v;
	while (n-- > 0)
		*p++ = c;
  100643:	88 5a ff             	mov    %bl,0xffffffff(%edx)
  100646:	49                   	dec    %ecx
  100647:	42                   	inc    %edx
  100648:	83 f9 ff             	cmp    $0xffffffff,%ecx
  10064b:	75 f6                	jne    100643 <memset+0x11>
	return v;
}
  10064d:	5b                   	pop    %ebx
  10064e:	c3                   	ret    

0010064f <strlen>:

size_t
strlen(const char *s)
{
  10064f:	8b 54 24 04          	mov    0x4(%esp),%edx
  100653:	31 c0                	xor    %eax,%eax
  100655:	eb 01                	jmp    100658 <strlen+0x9>
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100657:	40                   	inc    %eax
  100658:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  10065c:	75 f9                	jne    100657 <strlen+0x8>
	return n;
}
  10065e:	c3                   	ret    

0010065f <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10065f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100663:	31 c0                	xor    %eax,%eax
  100665:	8b 54 24 08          	mov    0x8(%esp),%edx
  100669:	eb 01                	jmp    10066c <strnlen+0xd>
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10066b:	40                   	inc    %eax
  10066c:	39 d0                	cmp    %edx,%eax
  10066e:	74 06                	je     100676 <strnlen+0x17>
  100670:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100674:	75 f5                	jne    10066b <strnlen+0xc>
	return n;
}
  100676:	c3                   	ret    

00100677 <console_putc>:


/*****************************************************************************
 * console_vprintf
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100677:	57                   	push   %edi
  100678:	89 cf                	mov    %ecx,%edi
  10067a:	56                   	push   %esi
  10067b:	53                   	push   %ebx
  10067c:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10067e:	81 fb 9f 8f 0b 00    	cmp    $0xb8f9f,%ebx
  100684:	88 d0                	mov    %dl,%al
  100686:	76 05                	jbe    10068d <console_putc+0x16>
  100688:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10068d:	3c 0a                	cmp    $0xa,%al
  10068f:	75 2f                	jne    1006c0 <console_putc+0x49>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100691:	8d 83 00 80 f4 ff    	lea    0xfff48000(%ebx),%eax
  100697:	be 50 00 00 00       	mov    $0x50,%esi
  10069c:	d1 f8                	sar    %eax
  10069e:	89 d9                	mov    %ebx,%ecx
  1006a0:	99                   	cltd   
  1006a1:	f7 fe                	idiv   %esi
  1006a3:	89 d6                	mov    %edx,%esi
  1006a5:	eb 0a                	jmp    1006b1 <console_putc+0x3a>
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006a7:	89 f8                	mov    %edi,%eax
  1006a9:	42                   	inc    %edx
  1006aa:	83 c8 20             	or     $0x20,%eax
  1006ad:	66 89 41 fe          	mov    %ax,0xfffffffe(%ecx)
  1006b1:	83 c1 02             	add    $0x2,%ecx
  1006b4:	83 fa 50             	cmp    $0x50,%edx
  1006b7:	75 ee                	jne    1006a7 <console_putc+0x30>
  1006b9:	29 f2                	sub    %esi,%edx
  1006bb:	8d 04 53             	lea    (%ebx,%edx,2),%eax
  1006be:	eb 0c                	jmp    1006cc <console_putc+0x55>
	} else
		*cursor++ = c | color;
  1006c0:	66 0f b6 c0          	movzbw %al,%ax
  1006c4:	09 f8                	or     %edi,%eax
  1006c6:	66 89 03             	mov    %ax,(%ebx)
  1006c9:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006cc:	5b                   	pop    %ebx
  1006cd:	5e                   	pop    %esi
  1006ce:	5f                   	pop    %edi
  1006cf:	c3                   	ret    

001006d0 <fill_numbuf>:

static const char upper_digits[] = "0123456789ABCDEF";
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006d0:	57                   	push   %edi
  1006d1:	56                   	push   %esi
  1006d2:	89 ce                	mov    %ecx,%esi
  1006d4:	53                   	push   %ebx
  1006d5:	8b 7c 24 10          	mov    0x10(%esp),%edi
	*--numbuf_end = '\0';
  1006d9:	8d 58 ff             	lea    0xffffffff(%eax),%ebx
  1006dc:	c6 40 ff 00          	movb   $0x0,0xffffffff(%eax)
	if (precision != 0 || val != 0)
  1006e0:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1006e5:	75 04                	jne    1006eb <fill_numbuf+0x1b>
  1006e7:	85 d2                	test   %edx,%edx
  1006e9:	74 12                	je     1006fd <fill_numbuf+0x2d>
		do {
			*--numbuf_end = digits[val % base];
  1006eb:	89 d0                	mov    %edx,%eax
  1006ed:	31 d2                	xor    %edx,%edx
  1006ef:	f7 f6                	div    %esi
  1006f1:	4b                   	dec    %ebx
  1006f2:	89 c1                	mov    %eax,%ecx
  1006f4:	8a 04 17             	mov    (%edi,%edx,1),%al
			val /= base;
  1006f7:	89 ca                	mov    %ecx,%edx
  1006f9:	88 03                	mov    %al,(%ebx)
  1006fb:	eb ea                	jmp    1006e7 <fill_numbuf+0x17>
		} while (val != 0);
	return numbuf_end;
}
  1006fd:	89 d8                	mov    %ebx,%eax
  1006ff:	5b                   	pop    %ebx
  100700:	5e                   	pop    %esi
  100701:	5f                   	pop    %edi
  100702:	c3                   	ret    

00100703 <console_vprintf>:

#define FLAG_ALT		(1<<0)
#define FLAG_ZERO		(1<<1)
#define FLAG_LEFTJUSTIFY	(1<<2)
#define FLAG_SPACEPOSITIVE	(1<<3)
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100703:	55                   	push   %ebp
  100704:	57                   	push   %edi
  100705:	56                   	push   %esi
  100706:	53                   	push   %ebx
  100707:	83 ec 3c             	sub    $0x3c,%esp
  10070a:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  10070e:	8b 7c 24 5c          	mov    0x5c(%esp),%edi
  100712:	e9 b1 03 00 00       	jmp    100ac8 <console_vprintf+0x3c5>
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
		if (*format != '%') {
  100717:	3c 25                	cmp    $0x25,%al
  100719:	74 19                	je     100734 <console_vprintf+0x31>
			cursor = console_putc(cursor, *format, color);
  10071b:	0f b6 d0             	movzbl %al,%edx
  10071e:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100722:	8b 44 24 50          	mov    0x50(%esp),%eax
  100726:	e8 4c ff ff ff       	call   100677 <console_putc>
  10072b:	89 44 24 50          	mov    %eax,0x50(%esp)
  10072f:	e9 93 03 00 00       	jmp    100ac7 <console_vprintf+0x3c4>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100734:	45                   	inc    %ebp
  100735:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10073c:	eb 1c                	jmp    10075a <console_vprintf+0x57>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10073e:	41                   	inc    %ecx
  10073f:	8a 01                	mov    (%ecx),%al
  100741:	84 c0                	test   %al,%al
  100743:	74 27                	je     10076c <console_vprintf+0x69>
  100745:	38 d0                	cmp    %dl,%al
  100747:	75 f5                	jne    10073e <console_vprintf+0x3b>
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100749:	81 e9 5b 0b 10 00    	sub    $0x100b5b,%ecx
  10074f:	b8 01 00 00 00       	mov    $0x1,%eax
  100754:	d3 e0                	shl    %cl,%eax
  100756:	45                   	inc    %ebp
  100757:	09 04 24             	or     %eax,(%esp)
  10075a:	8a 55 00             	mov    0x0(%ebp),%dl
  10075d:	84 d2                	test   %dl,%dl
  10075f:	0f 84 70 03 00 00    	je     100ad5 <console_vprintf+0x3d2>
  100765:	b9 5b 0b 10 00       	mov    $0x100b5b,%ecx
  10076a:	eb d3                	jmp    10073f <console_vprintf+0x3c>
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10076c:	8d 42 cf             	lea    0xffffffcf(%edx),%eax
  10076f:	3c 08                	cmp    $0x8,%al
  100771:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100778:	00 
  100779:	76 13                	jbe    10078e <console_vprintf+0x8b>
  10077b:	eb 1d                	jmp    10079a <console_vprintf+0x97>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10077d:	6b 44 24 04 0a       	imul   $0xa,0x4(%esp),%eax
  100782:	0f be d2             	movsbl %dl,%edx
  100785:	45                   	inc    %ebp
  100786:	8d 54 02 d0          	lea    0xffffffd0(%edx,%eax,1),%edx
  10078a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10078e:	8a 55 00             	mov    0x0(%ebp),%dl
  100791:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  100794:	3c 09                	cmp    $0x9,%al
  100796:	76 e5                	jbe    10077d <console_vprintf+0x7a>
  100798:	eb 18                	jmp    1007b2 <console_vprintf+0xaf>
		} else if (*format == '*') {
  10079a:	80 fa 2a             	cmp    $0x2a,%dl
  10079d:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  1007a4:	ff 
  1007a5:	75 0b                	jne    1007b2 <console_vprintf+0xaf>
			width = va_arg(val, int);
  1007a7:	83 c7 04             	add    $0x4,%edi
			++format;
  1007aa:	45                   	inc    %ebp
  1007ab:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  1007ae:	89 44 24 04          	mov    %eax,0x4(%esp)
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007b2:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  1007b9:	ff 
  1007ba:	80 7d 00 2e          	cmpb   $0x2e,0x0(%ebp)
  1007be:	75 4f                	jne    10080f <console_vprintf+0x10c>
			++format;
  1007c0:	45                   	inc    %ebp
			if (*format >= '0' && *format <= '9') {
  1007c1:	8a 55 00             	mov    0x0(%ebp),%dl
  1007c4:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  1007c7:	3c 09                	cmp    $0x9,%al
  1007c9:	77 25                	ja     1007f0 <console_vprintf+0xed>
  1007cb:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1007d2:	00 
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007d3:	6b 44 24 08 0a       	imul   $0xa,0x8(%esp),%eax
  1007d8:	0f be d2             	movsbl %dl,%edx
  1007db:	45                   	inc    %ebp
  1007dc:	8d 54 10 d0          	lea    0xffffffd0(%eax,%edx,1),%edx
  1007e0:	89 54 24 08          	mov    %edx,0x8(%esp)
  1007e4:	8a 55 00             	mov    0x0(%ebp),%dl
  1007e7:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  1007ea:	3c 09                	cmp    $0x9,%al
  1007ec:	77 12                	ja     100800 <console_vprintf+0xfd>
  1007ee:	eb e3                	jmp    1007d3 <console_vprintf+0xd0>
			} else if (*format == '*') {
  1007f0:	80 fa 2a             	cmp    $0x2a,%dl
  1007f3:	75 12                	jne    100807 <console_vprintf+0x104>
				precision = va_arg(val, int);
  1007f5:	83 c7 04             	add    $0x4,%edi
				++format;
  1007f8:	45                   	inc    %ebp
  1007f9:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  1007fc:	89 54 24 08          	mov    %edx,0x8(%esp)
			}
			if (precision < 0)
  100800:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100805:	79 08                	jns    10080f <console_vprintf+0x10c>
  100807:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10080e:	00 
				precision = 0;
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10080f:	8a 45 00             	mov    0x0(%ebp),%al
  100812:	3c 64                	cmp    $0x64,%al
  100814:	74 34                	je     10084a <console_vprintf+0x147>
  100816:	7f 1d                	jg     100835 <console_vprintf+0x132>
  100818:	3c 58                	cmp    $0x58,%al
  10081a:	0f 84 bd 00 00 00    	je     1008dd <console_vprintf+0x1da>
  100820:	3c 63                	cmp    $0x63,%al
  100822:	0f 84 eb 00 00 00    	je     100913 <console_vprintf+0x210>
  100828:	3c 43                	cmp    $0x43,%al
  10082a:	0f 85 06 01 00 00    	jne    100936 <console_vprintf+0x233>
  100830:	e9 cf 00 00 00       	jmp    100904 <console_vprintf+0x201>
  100835:	3c 75                	cmp    $0x75,%al
  100837:	74 5c                	je     100895 <console_vprintf+0x192>
  100839:	3c 78                	cmp    $0x78,%al
  10083b:	74 6e                	je     1008ab <console_vprintf+0x1a8>
  10083d:	3c 73                	cmp    $0x73,%al
  10083f:	0f 85 f1 00 00 00    	jne    100936 <console_vprintf+0x233>
  100845:	e9 a4 00 00 00       	jmp    1008ee <console_vprintf+0x1eb>
		case 'd': {
			int x = va_arg(val, int);
  10084a:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10084d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100852:	8b 5f fc             	mov    0xfffffffc(%edi),%ebx
  100855:	ff 74 24 08          	pushl  0x8(%esp)
  100859:	89 d8                	mov    %ebx,%eax
  10085b:	c1 f8 1f             	sar    $0x1f,%eax
  10085e:	89 c2                	mov    %eax,%edx
  100860:	68 61 0b 10 00       	push   $0x100b61
  100865:	31 da                	xor    %ebx,%edx
  100867:	29 c2                	sub    %eax,%edx
  100869:	8d 44 24 44          	lea    0x44(%esp),%eax
  10086d:	e8 5e fe ff ff       	call   1006d0 <fill_numbuf>
			if (x < 0)
  100872:	85 db                	test   %ebx,%ebx
  100874:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  100878:	5e                   	pop    %esi
  100879:	be 01 00 00 00       	mov    $0x1,%esi
  10087e:	58                   	pop    %eax
  10087f:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  100886:	00 
  100887:	0f 88 d1 00 00 00    	js     10095e <console_vprintf+0x25b>
  10088d:	66 31 f6             	xor    %si,%si
  100890:	e9 c9 00 00 00       	jmp    10095e <console_vprintf+0x25b>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100895:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100898:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10089d:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  1008a0:	ff 74 24 08          	pushl  0x8(%esp)
  1008a4:	68 61 0b 10 00       	push   $0x100b61
  1008a9:	eb 14                	jmp    1008bf <console_vprintf+0x1bc>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1008ab:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1008ae:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  1008b1:	ff 74 24 08          	pushl  0x8(%esp)
  1008b5:	68 72 0b 10 00       	push   $0x100b72
  1008ba:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008bf:	8d 44 24 44          	lea    0x44(%esp),%eax
  1008c3:	31 f6                	xor    %esi,%esi
  1008c5:	e8 06 fe ff ff       	call   1006d0 <fill_numbuf>
  1008ca:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  1008d1:	00 
  1008d2:	89 44 24 1c          	mov    %eax,0x1c(%esp)
			numeric = 1;
			break;
  1008d6:	59                   	pop    %ecx
  1008d7:	5b                   	pop    %ebx
  1008d8:	e9 81 00 00 00       	jmp    10095e <console_vprintf+0x25b>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008dd:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008e0:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  1008e3:	ff 74 24 08          	pushl  0x8(%esp)
  1008e7:	68 61 0b 10 00       	push   $0x100b61
  1008ec:	eb cc                	jmp    1008ba <console_vprintf+0x1b7>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008ee:	83 c7 04             	add    $0x4,%edi
  1008f1:	31 f6                	xor    %esi,%esi
  1008f3:	8b 4f fc             	mov    0xfffffffc(%edi),%ecx
  1008f6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1008fd:	00 
  1008fe:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  100902:	eb 5a                	jmp    10095e <console_vprintf+0x25b>
			break;
		case 'C':
			color = va_arg(val, int);
  100904:	83 c7 04             	add    $0x4,%edi
  100907:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  10090a:	89 44 24 54          	mov    %eax,0x54(%esp)
  10090e:	e9 b4 01 00 00       	jmp    100ac7 <console_vprintf+0x3c4>
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100913:	83 c7 04             	add    $0x4,%edi
			numbuf[1] = '\0';
  100916:	31 f6                	xor    %esi,%esi
  100918:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  10091b:	8d 54 24 28          	lea    0x28(%esp),%edx
  10091f:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
  100924:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10092b:	00 
  10092c:	89 54 24 14          	mov    %edx,0x14(%esp)
  100930:	88 44 24 28          	mov    %al,0x28(%esp)
  100934:	eb 28                	jmp    10095e <console_vprintf+0x25b>
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100936:	84 c0                	test   %al,%al
  100938:	75 02                	jne    10093c <console_vprintf+0x239>
  10093a:	b0 25                	mov    $0x25,%al
  10093c:	88 44 24 28          	mov    %al,0x28(%esp)
  100940:	8d 44 24 28          	lea    0x28(%esp),%eax
			numbuf[1] = '\0';
  100944:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
			if (!*format)
  100949:	80 7d 00 00          	cmpb   $0x0,0x0(%ebp)
  10094d:	75 01                	jne    100950 <console_vprintf+0x24d>
				format--;
  10094f:	4d                   	dec    %ebp
  100950:	31 f6                	xor    %esi,%esi
  100952:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100959:	00 
  10095a:	89 44 24 14          	mov    %eax,0x14(%esp)
			break;
		}

		if (precision >= 0)
  10095e:	31 c0                	xor    %eax,%eax
  100960:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100965:	78 16                	js     10097d <console_vprintf+0x27a>
			len = strnlen(data, precision);
  100967:	ff 74 24 08          	pushl  0x8(%esp)
  10096b:	ff 74 24 18          	pushl  0x18(%esp)
  10096f:	e8 eb fc ff ff       	call   10065f <strnlen>
  100974:	89 44 24 18          	mov    %eax,0x18(%esp)
  100978:	58                   	pop    %eax
  100979:	5a                   	pop    %edx
  10097a:	eb 0f                	jmp    10098b <console_vprintf+0x288>
  10097c:	40                   	inc    %eax
  10097d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  100981:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100985:	75 f5                	jne    10097c <console_vprintf+0x279>
		else
			len = strlen(data);
  100987:	89 44 24 10          	mov    %eax,0x10(%esp)
		if (numeric && negative)
  10098b:	8a 54 24 0c          	mov    0xc(%esp),%dl
  10098f:	84 d2                	test   %dl,%dl
  100991:	74 0c                	je     10099f <console_vprintf+0x29c>
  100993:	85 f6                	test   %esi,%esi
  100995:	c7 44 24 18 2d 00 00 	movl   $0x2d,0x18(%esp)
  10099c:	00 
  10099d:	75 22                	jne    1009c1 <console_vprintf+0x2be>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10099f:	f6 04 24 10          	testb  $0x10,(%esp)
  1009a3:	c7 44 24 18 2b 00 00 	movl   $0x2b,0x18(%esp)
  1009aa:	00 
  1009ab:	75 14                	jne    1009c1 <console_vprintf+0x2be>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1009ad:	8b 04 24             	mov    (%esp),%eax
  1009b0:	83 e0 08             	and    $0x8,%eax
  1009b3:	83 f8 01             	cmp    $0x1,%eax
  1009b6:	19 c0                	sbb    %eax,%eax
  1009b8:	f7 d0                	not    %eax
  1009ba:	83 e0 20             	and    $0x20,%eax
  1009bd:	89 44 24 18          	mov    %eax,0x18(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009c1:	84 d2                	test   %dl,%dl
  1009c3:	74 12                	je     1009d7 <console_vprintf+0x2d4>
  1009c5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  1009c9:	39 4c 24 08          	cmp    %ecx,0x8(%esp)
  1009cd:	7e 08                	jle    1009d7 <console_vprintf+0x2d4>
			zeros = precision - len;
  1009cf:	8b 5c 24 08          	mov    0x8(%esp),%ebx
  1009d3:	29 cb                	sub    %ecx,%ebx
  1009d5:	eb 39                	jmp    100a10 <console_vprintf+0x30d>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009d7:	8b 04 24             	mov    (%esp),%eax
  1009da:	83 e0 06             	and    $0x6,%eax
  1009dd:	83 f8 02             	cmp    $0x2,%eax
  1009e0:	75 2c                	jne    100a0e <console_vprintf+0x30b>
  1009e2:	84 d2                	test   %dl,%dl
  1009e4:	74 28                	je     100a0e <console_vprintf+0x30b>
  1009e6:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009eb:	79 21                	jns    100a0e <console_vprintf+0x30b>
  1009ed:	31 d2                	xor    %edx,%edx
  1009ef:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  1009f3:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  1009f8:	0f 95 c2             	setne  %dl
  1009fb:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  1009fe:	3b 44 24 04          	cmp    0x4(%esp),%eax
  100a02:	7d 0a                	jge    100a0e <console_vprintf+0x30b>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a04:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  100a08:	29 cb                	sub    %ecx,%ebx
  100a0a:	29 d3                	sub    %edx,%ebx
  100a0c:	eb 02                	jmp    100a10 <console_vprintf+0x30d>
  100a0e:	31 db                	xor    %ebx,%ebx
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a10:	8b 74 24 04          	mov    0x4(%esp),%esi
  100a14:	31 c0                	xor    %eax,%eax
  100a16:	2b 74 24 10          	sub    0x10(%esp),%esi
  100a1a:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  100a1f:	0f 95 c0             	setne  %al
  100a22:	29 c6                	sub    %eax,%esi
  100a24:	29 de                	sub    %ebx,%esi
  100a26:	eb 17                	jmp    100a3f <console_vprintf+0x33c>
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a28:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100a2c:	ba 20 00 00 00       	mov    $0x20,%edx
  100a31:	4e                   	dec    %esi
  100a32:	8b 44 24 50          	mov    0x50(%esp),%eax
  100a36:	e8 3c fc ff ff       	call   100677 <console_putc>
  100a3b:	89 44 24 50          	mov    %eax,0x50(%esp)
  100a3f:	f6 04 24 04          	testb  $0x4,(%esp)
  100a43:	75 04                	jne    100a49 <console_vprintf+0x346>
  100a45:	85 f6                	test   %esi,%esi
  100a47:	7f df                	jg     100a28 <console_vprintf+0x325>
		if (negative)
  100a49:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  100a4e:	74 2f                	je     100a7f <console_vprintf+0x37c>
			cursor = console_putc(cursor, negative, color);
  100a50:	0f b6 54 24 18       	movzbl 0x18(%esp),%edx
  100a55:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100a59:	8b 44 24 50          	mov    0x50(%esp),%eax
  100a5d:	e8 15 fc ff ff       	call   100677 <console_putc>
  100a62:	89 44 24 50          	mov    %eax,0x50(%esp)
  100a66:	eb 17                	jmp    100a7f <console_vprintf+0x37c>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a68:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100a6c:	ba 30 00 00 00       	mov    $0x30,%edx
  100a71:	4b                   	dec    %ebx
  100a72:	8b 44 24 50          	mov    0x50(%esp),%eax
  100a76:	e8 fc fb ff ff       	call   100677 <console_putc>
  100a7b:	89 44 24 50          	mov    %eax,0x50(%esp)
  100a7f:	85 db                	test   %ebx,%ebx
  100a81:	7f e5                	jg     100a68 <console_vprintf+0x365>
  100a83:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  100a87:	eb 19                	jmp    100aa2 <console_vprintf+0x39f>
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a89:	0f b6 53 ff          	movzbl 0xffffffff(%ebx),%edx
  100a8d:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100a91:	8b 44 24 50          	mov    0x50(%esp),%eax
  100a95:	e8 dd fb ff ff       	call   100677 <console_putc>
  100a9a:	ff 4c 24 10          	decl   0x10(%esp)
  100a9e:	89 44 24 50          	mov    %eax,0x50(%esp)
  100aa2:	43                   	inc    %ebx
  100aa3:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100aa8:	7f df                	jg     100a89 <console_vprintf+0x386>
  100aaa:	eb 17                	jmp    100ac3 <console_vprintf+0x3c0>
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100aac:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  100ab0:	ba 20 00 00 00       	mov    $0x20,%edx
  100ab5:	4e                   	dec    %esi
  100ab6:	8b 44 24 50          	mov    0x50(%esp),%eax
  100aba:	e8 b8 fb ff ff       	call   100677 <console_putc>
  100abf:	89 44 24 50          	mov    %eax,0x50(%esp)
  100ac3:	85 f6                	test   %esi,%esi
  100ac5:	7f e5                	jg     100aac <console_vprintf+0x3a9>
  100ac7:	45                   	inc    %ebp
  100ac8:	8a 45 00             	mov    0x0(%ebp),%al
  100acb:	84 c0                	test   %al,%al
  100acd:	0f 85 44 fc ff ff    	jne    100717 <console_vprintf+0x14>
  100ad3:	eb 15                	jmp    100aea <console_vprintf+0x3e7>
  100ad5:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  100adc:	ff 
  100add:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  100ae4:	ff 
  100ae5:	e9 50 fe ff ff       	jmp    10093a <console_vprintf+0x237>
	done: ;
	}

	return cursor;
}
  100aea:	8b 44 24 50          	mov    0x50(%esp),%eax
  100aee:	83 c4 3c             	add    $0x3c,%esp
  100af1:	5b                   	pop    %ebx
  100af2:	5e                   	pop    %esi
  100af3:	5f                   	pop    %edi
  100af4:	5d                   	pop    %ebp
  100af5:	c3                   	ret    

00100af6 <console_printf>:

uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100af6:	8d 44 24 10          	lea    0x10(%esp),%eax
  100afa:	50                   	push   %eax
  100afb:	ff 74 24 10          	pushl  0x10(%esp)
  100aff:	ff 74 24 10          	pushl  0x10(%esp)
  100b03:	ff 74 24 10          	pushl  0x10(%esp)
  100b07:	e8 f7 fb ff ff       	call   100703 <console_vprintf>
  100b0c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b0f:	c3                   	ret    
