
obj/mpos-app:     file format elf32-i386


Disassembly of section .text:

00200000 <app_printf>:

static void app_printf(const char *format, ...) __attribute__((noinline));

static void
app_printf(const char *format, ...)
{
  200000:	83 ec 0c             	sub    $0xc,%esp
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200003:	cd 30                	int    $0x30
static void
app_printf(const char *format, ...)
{
	// set default color based on currently running process
	int color = sys_getpid();
	if (color < 0)
  200005:	85 c0                	test   %eax,%eax
  200007:	ba 00 07 00 00       	mov    $0x700,%edx
  20000c:	78 13                	js     200021 <app_printf+0x21>
		color = 0x0700;
	else {
		static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
		color = col[color % sizeof(col)] << 8;
  20000e:	b9 05 00 00 00       	mov    $0x5,%ecx
  200013:	31 d2                	xor    %edx,%edx
  200015:	f7 f1                	div    %ecx
  200017:	0f b6 92 b0 06 20 00 	movzbl 0x2006b0(%edx),%edx
  20001e:	c1 e2 08             	shl    $0x8,%edx
	}

	va_list val;
	va_start(val, format);
	cursorpos = console_vprintf(cursorpos, color, format, val);
  200021:	8d 44 24 14          	lea    0x14(%esp),%eax
  200025:	50                   	push   %eax
  200026:	ff 74 24 14          	pushl  0x14(%esp)
  20002a:	52                   	push   %edx
  20002b:	ff 35 00 00 06 00    	pushl  0x60000
  200031:	e8 1d 02 00 00       	call   200253 <console_vprintf>
  200036:	a3 00 00 06 00       	mov    %eax,0x60000
	va_end(val);
}
  20003b:	83 c4 1c             	add    $0x1c,%esp
  20003e:	c3                   	ret    

0020003f <newThread>:
	sys_exit(1000);
}

// XIA: new thread
void newThread()
{
  20003f:	83 ec 14             	sub    $0x14,%esp
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200042:	cd 30                	int    $0x30
    app_printf("newThread pid = %d\n",sys_getpid());
  200044:	50                   	push   %eax
  200045:	68 10 06 20 00       	push   $0x200610
  20004a:	e8 b1 ff ff ff       	call   200000 <app_printf>

static inline void
sys_yield(void)
{
	// This system call has no return values, so there's no '=a' clause.
	asm volatile("int %0\n"
  20004f:	cd 32                	int    $0x32
    sys_yield();
}
  200051:	83 c4 1c             	add    $0x1c,%esp
  200054:	c3                   	ret    

00200055 <run_child>:
	}
}

void
run_child(void)
{
  200055:	83 ec 24             	sub    $0x24,%esp
	int i;
	volatile int checker = 1; /* This variable checks that you correctly
  200058:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  20005f:	00 
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200060:	cd 30                	int    $0x30
				     gave this process a new stack.
				     If the parent's 'checker' changed value
				     after the child ran, there's a problem! */

	app_printf("Child process %d!\n", sys_getpid());
  200062:	50                   	push   %eax
  200063:	68 24 06 20 00       	push   $0x200624
  200068:	e8 93 ff ff ff       	call   200000 <app_printf>
  20006d:	31 c0                	xor    %eax,%eax
  20006f:	83 c4 10             	add    $0x10,%esp

static inline void
sys_yield(void)
{
	// This system call has no return values, so there's no '=a' clause.
	asm volatile("int %0\n"
  200072:	cd 32                	int    $0x32

	// Yield a couple times to help people test Exercise 3
	for (i = 0; i < 20; i++)
  200074:	40                   	inc    %eax
  200075:	83 f8 14             	cmp    $0x14,%eax
  200078:	75 f8                	jne    200072 <run_child+0x1d>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  20007a:	66 b8 e8 03          	mov    $0x3e8,%ax
  20007e:	cd 33                	int    $0x33
  200080:	eb fe                	jmp    200080 <run_child+0x2b>

00200082 <start>:
void run_child(void);
void newThread(void);//XIA: new thread

void
start(void)
{
  200082:	56                   	push   %esi
  200083:	53                   	push   %ebx
  200084:	83 ec 20             	sub    $0x20,%esp
	volatile int checker = 0; /* This variable checks that you correctly
  200087:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  20008e:	00 
				     gave the child process a new stack. */
	pid_t p;
	int status;

	app_printf("About to start a new process...\n");
  20008f:	68 37 06 20 00       	push   $0x200637
  200094:	e8 67 ff ff ff       	call   200000 <app_printf>
sys_fork(void)
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  200099:	cd 31                	int    $0x31

	p = sys_fork();
	if (p == 0)
  20009b:	83 c4 10             	add    $0x10,%esp
  20009e:	83 f8 00             	cmp    $0x0,%eax
  2000a1:	89 c3                	mov    %eax,%ebx
  2000a3:	75 0a                	jne    2000af <start+0x2d>

	} else {
		app_printf("Error!\n");
		sys_exit(1);
	}
}
  2000a5:	83 c4 14             	add    $0x14,%esp
  2000a8:	5b                   	pop    %ebx
  2000a9:	5e                   	pop    %esi

	app_printf("About to start a new process...\n");

	p = sys_fork();
	if (p == 0)
		run_child();
  2000aa:	e9 a6 ff ff ff       	jmp    200055 <run_child>
	else if (p > 0) {
  2000af:	7e 64                	jle    200115 <start+0x93>
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  2000b1:	cd 30                	int    $0x30
		app_printf("Main process %d!\n", sys_getpid());
  2000b3:	52                   	push   %edx
  2000b4:	52                   	push   %edx
  2000b5:	50                   	push   %eax
  2000b6:	68 58 06 20 00       	push   $0x200658
  2000bb:	e8 40 ff ff ff       	call   200000 <app_printf>
  2000c0:	83 c4 10             	add    $0x10,%esp

static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000c3:	89 d8                	mov    %ebx,%eax
  2000c5:	cd 34                	int    $0x34
		
        
        do {
			status = sys_wait(p);
			app_printf("W");
  2000c7:	83 ec 0c             	sub    $0xc,%esp
  2000ca:	89 c6                	mov    %eax,%esi
  2000cc:	68 6a 06 20 00       	push   $0x20066a
  2000d1:	e8 2a ff ff ff       	call   200000 <app_printf>
		} while (status == WAIT_TRYAGAIN);
  2000d6:	83 c4 10             	add    $0x10,%esp
  2000d9:	83 fe fe             	cmp    $0xfffffffe,%esi
  2000dc:	74 e5                	je     2000c3 <start+0x41>
        app_printf("newThread address: %d",newThread);
        new = sys_newthread((void(*)(void))newThread);
        */
         
        //status = sys_wait(p);               
		app_printf("Child %d exited with status %d!\n", p, status);
  2000de:	50                   	push   %eax
  2000df:	56                   	push   %esi
  2000e0:	53                   	push   %ebx
  2000e1:	68 6c 06 20 00       	push   $0x20066c
  2000e6:	e8 15 ff ff ff       	call   200000 <app_printf>

		// Check whether the child process corrupted our stack.
		// (This check doesn't find all errors, but it helps.)
		if (checker != 0) {
  2000eb:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  2000ef:	83 c4 10             	add    $0x10,%esp
  2000f2:	85 c0                	test   %eax,%eax
  2000f4:	74 19                	je     20010f <start+0x8d>
			app_printf("Error: stack collision!\n");
  2000f6:	83 ec 0c             	sub    $0xc,%esp
  2000f9:	68 8d 06 20 00       	push   $0x20068d
  2000fe:	e8 fd fe ff ff       	call   200000 <app_printf>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  200103:	b8 01 00 00 00       	mov    $0x1,%eax
  200108:	cd 33                	int    $0x33
  20010a:	83 c4 10             	add    $0x10,%esp
  20010d:	eb fe                	jmp    20010d <start+0x8b>
  20010f:	31 c0                	xor    %eax,%eax
  200111:	cd 33                	int    $0x33
  200113:	eb fe                	jmp    200113 <start+0x91>
			sys_exit(1);
		} else
			sys_exit(0);

	} else {
		app_printf("Error!\n");
  200115:	83 ec 0c             	sub    $0xc,%esp
  200118:	68 a6 06 20 00       	push   $0x2006a6
  20011d:	e8 de fe ff ff       	call   200000 <app_printf>
  200122:	b8 01 00 00 00       	mov    $0x1,%eax
  200127:	cd 33                	int    $0x33
  200129:	83 c4 10             	add    $0x10,%esp
  20012c:	eb fe                	jmp    20012c <start+0xaa>
  20012e:	90                   	nop
  20012f:	90                   	nop

00200130 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  200130:	56                   	push   %esi
  200131:	31 d2                	xor    %edx,%edx
  200133:	53                   	push   %ebx
  200134:	8b 44 24 0c          	mov    0xc(%esp),%eax
  200138:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  20013c:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  200140:	eb 08                	jmp    20014a <memcpy+0x1a>
		*d++ = *s++;
  200142:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  200145:	4e                   	dec    %esi
  200146:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  200149:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  20014a:	85 f6                	test   %esi,%esi
  20014c:	75 f4                	jne    200142 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  20014e:	5b                   	pop    %ebx
  20014f:	5e                   	pop    %esi
  200150:	c3                   	ret    

00200151 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  200151:	57                   	push   %edi
  200152:	56                   	push   %esi
  200153:	53                   	push   %ebx
  200154:	8b 44 24 10          	mov    0x10(%esp),%eax
  200158:	8b 7c 24 14          	mov    0x14(%esp),%edi
  20015c:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  200160:	39 c7                	cmp    %eax,%edi
  200162:	73 26                	jae    20018a <memmove+0x39>
  200164:	8d 34 17             	lea    (%edi,%edx,1),%esi
  200167:	39 c6                	cmp    %eax,%esi
  200169:	76 1f                	jbe    20018a <memmove+0x39>
		s += n, d += n;
  20016b:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  20016e:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  200170:	eb 07                	jmp    200179 <memmove+0x28>
			*--d = *--s;
  200172:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  200175:	4a                   	dec    %edx
  200176:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  200179:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  20017a:	85 d2                	test   %edx,%edx
  20017c:	75 f4                	jne    200172 <memmove+0x21>
  20017e:	eb 10                	jmp    200190 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  200180:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  200183:	4a                   	dec    %edx
  200184:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  200187:	41                   	inc    %ecx
  200188:	eb 02                	jmp    20018c <memmove+0x3b>
  20018a:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  20018c:	85 d2                	test   %edx,%edx
  20018e:	75 f0                	jne    200180 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  200190:	5b                   	pop    %ebx
  200191:	5e                   	pop    %esi
  200192:	5f                   	pop    %edi
  200193:	c3                   	ret    

00200194 <memset>:

void *
memset(void *v, int c, size_t n)
{
  200194:	53                   	push   %ebx
  200195:	8b 44 24 08          	mov    0x8(%esp),%eax
  200199:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  20019d:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  2001a1:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  2001a3:	eb 04                	jmp    2001a9 <memset+0x15>
		*p++ = c;
  2001a5:	88 1a                	mov    %bl,(%edx)
  2001a7:	49                   	dec    %ecx
  2001a8:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  2001a9:	85 c9                	test   %ecx,%ecx
  2001ab:	75 f8                	jne    2001a5 <memset+0x11>
		*p++ = c;
	return v;
}
  2001ad:	5b                   	pop    %ebx
  2001ae:	c3                   	ret    

002001af <strlen>:

size_t
strlen(const char *s)
{
  2001af:	8b 54 24 04          	mov    0x4(%esp),%edx
  2001b3:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  2001b5:	eb 01                	jmp    2001b8 <strlen+0x9>
		++n;
  2001b7:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  2001b8:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  2001bc:	75 f9                	jne    2001b7 <strlen+0x8>
		++n;
	return n;
}
  2001be:	c3                   	ret    

002001bf <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  2001bf:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  2001c3:	31 c0                	xor    %eax,%eax
  2001c5:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2001c9:	eb 01                	jmp    2001cc <strnlen+0xd>
		++n;
  2001cb:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2001cc:	39 d0                	cmp    %edx,%eax
  2001ce:	74 06                	je     2001d6 <strnlen+0x17>
  2001d0:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  2001d4:	75 f5                	jne    2001cb <strnlen+0xc>
		++n;
	return n;
}
  2001d6:	c3                   	ret    

002001d7 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001d7:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  2001d8:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  2001dd:	53                   	push   %ebx
  2001de:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  2001e0:	76 05                	jbe    2001e7 <console_putc+0x10>
  2001e2:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  2001e7:	80 fa 0a             	cmp    $0xa,%dl
  2001ea:	75 2c                	jne    200218 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001ec:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  2001f2:	be 50 00 00 00       	mov    $0x50,%esi
  2001f7:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  2001f9:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001fc:	99                   	cltd   
  2001fd:	f7 fe                	idiv   %esi
  2001ff:	89 de                	mov    %ebx,%esi
  200201:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  200203:	eb 07                	jmp    20020c <console_putc+0x35>
			*cursor++ = ' ' | color;
  200205:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  200208:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  200209:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  20020c:	83 f8 50             	cmp    $0x50,%eax
  20020f:	75 f4                	jne    200205 <console_putc+0x2e>
  200211:	29 d0                	sub    %edx,%eax
  200213:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  200216:	eb 0b                	jmp    200223 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  200218:	0f b6 d2             	movzbl %dl,%edx
  20021b:	09 ca                	or     %ecx,%edx
  20021d:	66 89 13             	mov    %dx,(%ebx)
  200220:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  200223:	5b                   	pop    %ebx
  200224:	5e                   	pop    %esi
  200225:	c3                   	ret    

00200226 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  200226:	56                   	push   %esi
  200227:	53                   	push   %ebx
  200228:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  20022c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  20022f:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  200233:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  200238:	75 04                	jne    20023e <fill_numbuf+0x18>
  20023a:	85 d2                	test   %edx,%edx
  20023c:	74 10                	je     20024e <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  20023e:	89 d0                	mov    %edx,%eax
  200240:	31 d2                	xor    %edx,%edx
  200242:	f7 f1                	div    %ecx
  200244:	4b                   	dec    %ebx
  200245:	8a 14 16             	mov    (%esi,%edx,1),%dl
  200248:	88 13                	mov    %dl,(%ebx)
			val /= base;
  20024a:	89 c2                	mov    %eax,%edx
  20024c:	eb ec                	jmp    20023a <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  20024e:	89 d8                	mov    %ebx,%eax
  200250:	5b                   	pop    %ebx
  200251:	5e                   	pop    %esi
  200252:	c3                   	ret    

00200253 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  200253:	55                   	push   %ebp
  200254:	57                   	push   %edi
  200255:	56                   	push   %esi
  200256:	53                   	push   %ebx
  200257:	83 ec 38             	sub    $0x38,%esp
  20025a:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  20025e:	8b 7c 24 54          	mov    0x54(%esp),%edi
  200262:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  200266:	e9 60 03 00 00       	jmp    2005cb <console_vprintf+0x378>
		if (*format != '%') {
  20026b:	80 fa 25             	cmp    $0x25,%dl
  20026e:	74 13                	je     200283 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  200270:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200274:	0f b6 d2             	movzbl %dl,%edx
  200277:	89 f0                	mov    %esi,%eax
  200279:	e8 59 ff ff ff       	call   2001d7 <console_putc>
  20027e:	e9 45 03 00 00       	jmp    2005c8 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  200283:	47                   	inc    %edi
  200284:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  20028b:	00 
  20028c:	eb 12                	jmp    2002a0 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  20028e:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  20028f:	8a 11                	mov    (%ecx),%dl
  200291:	84 d2                	test   %dl,%dl
  200293:	74 1a                	je     2002af <console_vprintf+0x5c>
  200295:	89 e8                	mov    %ebp,%eax
  200297:	38 c2                	cmp    %al,%dl
  200299:	75 f3                	jne    20028e <console_vprintf+0x3b>
  20029b:	e9 3f 03 00 00       	jmp    2005df <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  2002a0:	8a 17                	mov    (%edi),%dl
  2002a2:	84 d2                	test   %dl,%dl
  2002a4:	74 0b                	je     2002b1 <console_vprintf+0x5e>
  2002a6:	b9 b8 06 20 00       	mov    $0x2006b8,%ecx
  2002ab:	89 d5                	mov    %edx,%ebp
  2002ad:	eb e0                	jmp    20028f <console_vprintf+0x3c>
  2002af:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  2002b1:	8d 42 cf             	lea    -0x31(%edx),%eax
  2002b4:	3c 08                	cmp    $0x8,%al
  2002b6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  2002bd:	00 
  2002be:	76 13                	jbe    2002d3 <console_vprintf+0x80>
  2002c0:	eb 1d                	jmp    2002df <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  2002c2:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  2002c7:	0f be c0             	movsbl %al,%eax
  2002ca:	47                   	inc    %edi
  2002cb:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  2002cf:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  2002d3:	8a 07                	mov    (%edi),%al
  2002d5:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002d8:	80 fa 09             	cmp    $0x9,%dl
  2002db:	76 e5                	jbe    2002c2 <console_vprintf+0x6f>
  2002dd:	eb 18                	jmp    2002f7 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  2002df:	80 fa 2a             	cmp    $0x2a,%dl
  2002e2:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  2002e9:	ff 
  2002ea:	75 0b                	jne    2002f7 <console_vprintf+0xa4>
			width = va_arg(val, int);
  2002ec:	83 c3 04             	add    $0x4,%ebx
			++format;
  2002ef:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  2002f0:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2002f3:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  2002f7:	83 cd ff             	or     $0xffffffff,%ebp
  2002fa:	80 3f 2e             	cmpb   $0x2e,(%edi)
  2002fd:	75 37                	jne    200336 <console_vprintf+0xe3>
			++format;
  2002ff:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  200300:	31 ed                	xor    %ebp,%ebp
  200302:	8a 07                	mov    (%edi),%al
  200304:	8d 50 d0             	lea    -0x30(%eax),%edx
  200307:	80 fa 09             	cmp    $0x9,%dl
  20030a:	76 0d                	jbe    200319 <console_vprintf+0xc6>
  20030c:	eb 17                	jmp    200325 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  20030e:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  200311:	0f be c0             	movsbl %al,%eax
  200314:	47                   	inc    %edi
  200315:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  200319:	8a 07                	mov    (%edi),%al
  20031b:	8d 50 d0             	lea    -0x30(%eax),%edx
  20031e:	80 fa 09             	cmp    $0x9,%dl
  200321:	76 eb                	jbe    20030e <console_vprintf+0xbb>
  200323:	eb 11                	jmp    200336 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  200325:	3c 2a                	cmp    $0x2a,%al
  200327:	75 0b                	jne    200334 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  200329:	83 c3 04             	add    $0x4,%ebx
				++format;
  20032c:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  20032d:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  200330:	85 ed                	test   %ebp,%ebp
  200332:	79 02                	jns    200336 <console_vprintf+0xe3>
  200334:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  200336:	8a 07                	mov    (%edi),%al
  200338:	3c 64                	cmp    $0x64,%al
  20033a:	74 34                	je     200370 <console_vprintf+0x11d>
  20033c:	7f 1d                	jg     20035b <console_vprintf+0x108>
  20033e:	3c 58                	cmp    $0x58,%al
  200340:	0f 84 a2 00 00 00    	je     2003e8 <console_vprintf+0x195>
  200346:	3c 63                	cmp    $0x63,%al
  200348:	0f 84 bf 00 00 00    	je     20040d <console_vprintf+0x1ba>
  20034e:	3c 43                	cmp    $0x43,%al
  200350:	0f 85 d0 00 00 00    	jne    200426 <console_vprintf+0x1d3>
  200356:	e9 a3 00 00 00       	jmp    2003fe <console_vprintf+0x1ab>
  20035b:	3c 75                	cmp    $0x75,%al
  20035d:	74 4d                	je     2003ac <console_vprintf+0x159>
  20035f:	3c 78                	cmp    $0x78,%al
  200361:	74 5c                	je     2003bf <console_vprintf+0x16c>
  200363:	3c 73                	cmp    $0x73,%al
  200365:	0f 85 bb 00 00 00    	jne    200426 <console_vprintf+0x1d3>
  20036b:	e9 86 00 00 00       	jmp    2003f6 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  200370:	83 c3 04             	add    $0x4,%ebx
  200373:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  200376:	89 d1                	mov    %edx,%ecx
  200378:	c1 f9 1f             	sar    $0x1f,%ecx
  20037b:	89 0c 24             	mov    %ecx,(%esp)
  20037e:	31 ca                	xor    %ecx,%edx
  200380:	55                   	push   %ebp
  200381:	29 ca                	sub    %ecx,%edx
  200383:	68 c0 06 20 00       	push   $0x2006c0
  200388:	b9 0a 00 00 00       	mov    $0xa,%ecx
  20038d:	8d 44 24 40          	lea    0x40(%esp),%eax
  200391:	e8 90 fe ff ff       	call   200226 <fill_numbuf>
  200396:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  20039a:	58                   	pop    %eax
  20039b:	5a                   	pop    %edx
  20039c:	ba 01 00 00 00       	mov    $0x1,%edx
  2003a1:	8b 04 24             	mov    (%esp),%eax
  2003a4:	83 e0 01             	and    $0x1,%eax
  2003a7:	e9 a5 00 00 00       	jmp    200451 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  2003ac:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  2003af:	b9 0a 00 00 00       	mov    $0xa,%ecx
  2003b4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003b7:	55                   	push   %ebp
  2003b8:	68 c0 06 20 00       	push   $0x2006c0
  2003bd:	eb 11                	jmp    2003d0 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  2003bf:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  2003c2:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003c5:	55                   	push   %ebp
  2003c6:	68 d4 06 20 00       	push   $0x2006d4
  2003cb:	b9 10 00 00 00       	mov    $0x10,%ecx
  2003d0:	8d 44 24 40          	lea    0x40(%esp),%eax
  2003d4:	e8 4d fe ff ff       	call   200226 <fill_numbuf>
  2003d9:	ba 01 00 00 00       	mov    $0x1,%edx
  2003de:	89 44 24 0c          	mov    %eax,0xc(%esp)
  2003e2:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  2003e4:	59                   	pop    %ecx
  2003e5:	59                   	pop    %ecx
  2003e6:	eb 69                	jmp    200451 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  2003e8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  2003eb:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003ee:	55                   	push   %ebp
  2003ef:	68 c0 06 20 00       	push   $0x2006c0
  2003f4:	eb d5                	jmp    2003cb <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  2003f6:	83 c3 04             	add    $0x4,%ebx
  2003f9:	8b 43 fc             	mov    -0x4(%ebx),%eax
  2003fc:	eb 40                	jmp    20043e <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  2003fe:	83 c3 04             	add    $0x4,%ebx
  200401:	8b 53 fc             	mov    -0x4(%ebx),%edx
  200404:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  200408:	e9 bd 01 00 00       	jmp    2005ca <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  20040d:	83 c3 04             	add    $0x4,%ebx
  200410:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  200413:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  200417:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  20041c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  200420:	88 44 24 24          	mov    %al,0x24(%esp)
  200424:	eb 27                	jmp    20044d <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  200426:	84 c0                	test   %al,%al
  200428:	75 02                	jne    20042c <console_vprintf+0x1d9>
  20042a:	b0 25                	mov    $0x25,%al
  20042c:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  200430:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  200435:	80 3f 00             	cmpb   $0x0,(%edi)
  200438:	74 0a                	je     200444 <console_vprintf+0x1f1>
  20043a:	8d 44 24 24          	lea    0x24(%esp),%eax
  20043e:	89 44 24 04          	mov    %eax,0x4(%esp)
  200442:	eb 09                	jmp    20044d <console_vprintf+0x1fa>
				format--;
  200444:	8d 54 24 24          	lea    0x24(%esp),%edx
  200448:	4f                   	dec    %edi
  200449:	89 54 24 04          	mov    %edx,0x4(%esp)
  20044d:	31 d2                	xor    %edx,%edx
  20044f:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  200451:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  200453:	83 fd ff             	cmp    $0xffffffff,%ebp
  200456:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  20045d:	74 1f                	je     20047e <console_vprintf+0x22b>
  20045f:	89 04 24             	mov    %eax,(%esp)
  200462:	eb 01                	jmp    200465 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  200464:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  200465:	39 e9                	cmp    %ebp,%ecx
  200467:	74 0a                	je     200473 <console_vprintf+0x220>
  200469:	8b 44 24 04          	mov    0x4(%esp),%eax
  20046d:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  200471:	75 f1                	jne    200464 <console_vprintf+0x211>
  200473:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  200476:	89 0c 24             	mov    %ecx,(%esp)
  200479:	eb 1f                	jmp    20049a <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  20047b:	42                   	inc    %edx
  20047c:	eb 09                	jmp    200487 <console_vprintf+0x234>
  20047e:	89 d1                	mov    %edx,%ecx
  200480:	8b 14 24             	mov    (%esp),%edx
  200483:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200487:	8b 44 24 04          	mov    0x4(%esp),%eax
  20048b:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  20048f:	75 ea                	jne    20047b <console_vprintf+0x228>
  200491:	8b 44 24 08          	mov    0x8(%esp),%eax
  200495:	89 14 24             	mov    %edx,(%esp)
  200498:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  20049a:	85 c0                	test   %eax,%eax
  20049c:	74 0c                	je     2004aa <console_vprintf+0x257>
  20049e:	84 d2                	test   %dl,%dl
  2004a0:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  2004a7:	00 
  2004a8:	75 24                	jne    2004ce <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  2004aa:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  2004af:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  2004b6:	00 
  2004b7:	75 15                	jne    2004ce <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  2004b9:	8b 44 24 14          	mov    0x14(%esp),%eax
  2004bd:	83 e0 08             	and    $0x8,%eax
  2004c0:	83 f8 01             	cmp    $0x1,%eax
  2004c3:	19 c9                	sbb    %ecx,%ecx
  2004c5:	f7 d1                	not    %ecx
  2004c7:	83 e1 20             	and    $0x20,%ecx
  2004ca:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  2004ce:	3b 2c 24             	cmp    (%esp),%ebp
  2004d1:	7e 0d                	jle    2004e0 <console_vprintf+0x28d>
  2004d3:	84 d2                	test   %dl,%dl
  2004d5:	74 40                	je     200517 <console_vprintf+0x2c4>
			zeros = precision - len;
  2004d7:	2b 2c 24             	sub    (%esp),%ebp
  2004da:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  2004de:	eb 3f                	jmp    20051f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004e0:	84 d2                	test   %dl,%dl
  2004e2:	74 33                	je     200517 <console_vprintf+0x2c4>
  2004e4:	8b 44 24 14          	mov    0x14(%esp),%eax
  2004e8:	83 e0 06             	and    $0x6,%eax
  2004eb:	83 f8 02             	cmp    $0x2,%eax
  2004ee:	75 27                	jne    200517 <console_vprintf+0x2c4>
  2004f0:	45                   	inc    %ebp
  2004f1:	75 24                	jne    200517 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  2004f3:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004f5:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  2004f8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004fd:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  200500:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  200503:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  200507:	7d 0e                	jge    200517 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  200509:	8b 54 24 0c          	mov    0xc(%esp),%edx
  20050d:	29 ca                	sub    %ecx,%edx
  20050f:	29 c2                	sub    %eax,%edx
  200511:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  200515:	eb 08                	jmp    20051f <console_vprintf+0x2cc>
  200517:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  20051e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  20051f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  200523:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200525:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200529:	2b 2c 24             	sub    (%esp),%ebp
  20052c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200531:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200534:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200537:	29 c5                	sub    %eax,%ebp
  200539:	89 f0                	mov    %esi,%eax
  20053b:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20053f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  200543:	eb 0f                	jmp    200554 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  200545:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200549:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  20054e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  20054f:	e8 83 fc ff ff       	call   2001d7 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200554:	85 ed                	test   %ebp,%ebp
  200556:	7e 07                	jle    20055f <console_vprintf+0x30c>
  200558:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  20055d:	74 e6                	je     200545 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  20055f:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200564:	89 c6                	mov    %eax,%esi
  200566:	74 23                	je     20058b <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  200568:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  20056d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200571:	e8 61 fc ff ff       	call   2001d7 <console_putc>
  200576:	89 c6                	mov    %eax,%esi
  200578:	eb 11                	jmp    20058b <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  20057a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20057e:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  200583:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  200584:	e8 4e fc ff ff       	call   2001d7 <console_putc>
  200589:	eb 06                	jmp    200591 <console_vprintf+0x33e>
  20058b:	89 f0                	mov    %esi,%eax
  20058d:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  200591:	85 f6                	test   %esi,%esi
  200593:	7f e5                	jg     20057a <console_vprintf+0x327>
  200595:	8b 34 24             	mov    (%esp),%esi
  200598:	eb 15                	jmp    2005af <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  20059a:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  20059e:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  20059f:	0f b6 11             	movzbl (%ecx),%edx
  2005a2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  2005a6:	e8 2c fc ff ff       	call   2001d7 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  2005ab:	ff 44 24 04          	incl   0x4(%esp)
  2005af:	85 f6                	test   %esi,%esi
  2005b1:	7f e7                	jg     20059a <console_vprintf+0x347>
  2005b3:	eb 0f                	jmp    2005c4 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  2005b5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  2005b9:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  2005be:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  2005bf:	e8 13 fc ff ff       	call   2001d7 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  2005c4:	85 ed                	test   %ebp,%ebp
  2005c6:	7f ed                	jg     2005b5 <console_vprintf+0x362>
  2005c8:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  2005ca:	47                   	inc    %edi
  2005cb:	8a 17                	mov    (%edi),%dl
  2005cd:	84 d2                	test   %dl,%dl
  2005cf:	0f 85 96 fc ff ff    	jne    20026b <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  2005d5:	83 c4 38             	add    $0x38,%esp
  2005d8:	89 f0                	mov    %esi,%eax
  2005da:	5b                   	pop    %ebx
  2005db:	5e                   	pop    %esi
  2005dc:	5f                   	pop    %edi
  2005dd:	5d                   	pop    %ebp
  2005de:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2005df:	81 e9 b8 06 20 00    	sub    $0x2006b8,%ecx
  2005e5:	b8 01 00 00 00       	mov    $0x1,%eax
  2005ea:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  2005ec:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  2005ed:	09 44 24 14          	or     %eax,0x14(%esp)
  2005f1:	e9 aa fc ff ff       	jmp    2002a0 <console_vprintf+0x4d>

002005f6 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  2005f6:	8d 44 24 10          	lea    0x10(%esp),%eax
  2005fa:	50                   	push   %eax
  2005fb:	ff 74 24 10          	pushl  0x10(%esp)
  2005ff:	ff 74 24 10          	pushl  0x10(%esp)
  200603:	ff 74 24 10          	pushl  0x10(%esp)
  200607:	e8 47 fc ff ff       	call   200253 <console_vprintf>
  20060c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  20060f:	c3                   	ret    
