
obj/mpos-app2:     file format elf32-i386


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
  200017:	0f b6 92 dc 05 20 00 	movzbl 0x2005dc(%edx),%edx
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
  200031:	e8 c9 01 00 00       	call   2001ff <console_vprintf>
  200036:	a3 00 00 06 00       	mov    %eax,0x60000
	va_end(val);
}
  20003b:	83 c4 1c             	add    $0x1c,%esp
  20003e:	c3                   	ret    

0020003f <run_child>:
	sys_exit(0);
}

void
run_child(void)
{
  20003f:	53                   	push   %ebx
  200040:	83 ec 08             	sub    $0x8,%esp
	int input_counter = counter;
  200043:	8b 1d 14 16 20 00    	mov    0x201614,%ebx

	counter++;		/* Note that all "processes" share an address
  200049:	a1 14 16 20 00       	mov    0x201614,%eax
  20004e:	40                   	inc    %eax
  20004f:	a3 14 16 20 00       	mov    %eax,0x201614
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200054:	cd 30                	int    $0x30
				   space, so this change to 'counter' will be
				   visible to all processes. */
#ifdef EXTRA
	int pid = sys_getpid();
	if(!(pid&1)){			//even number
  200056:	a8 01                	test   $0x1,%al
  200058:	75 11                	jne    20006b <run_child+0x2c>
  20005a:	ba 03 00 00 00       	mov    $0x3,%edx

static inline int
sys_kill(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  20005f:	89 d0                	mov    %edx,%eax
  200061:	cd 35                	int    $0x35
		int i;
		for( i = 3; i< NPROCS; i+=2)
  200063:	83 c2 02             	add    $0x2,%edx
  200066:	83 fa 11             	cmp    $0x11,%edx
  200069:	75 f4                	jne    20005f <run_child+0x20>
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  20006b:	cd 30                	int    $0x30
		{
			int result = sys_kill(i);
		}
	}
#endif
	app_printf("Process %d lives, counter %d!\n",
  20006d:	52                   	push   %edx
  20006e:	53                   	push   %ebx
  20006f:	50                   	push   %eax
  200070:	68 bc 05 20 00       	push   $0x2005bc
  200075:	e8 86 ff ff ff       	call   200000 <app_printf>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  20007a:	89 d8                	mov    %ebx,%eax
  20007c:	cd 33                	int    $0x33
  20007e:	83 c4 10             	add    $0x10,%esp
  200081:	eb fe                	jmp    200081 <run_child+0x42>

00200083 <start>:

void run_child(void);

void
start(void)
{
  200083:	53                   	push   %ebx
  200084:	83 ec 08             	sub    $0x8,%esp
	pid_t p;
	int status;

	counter = 0;
  200087:	c7 05 14 16 20 00 00 	movl   $0x0,0x201614
  20008e:	00 00 00 

	while (counter < 1025) {
  200091:	eb 33                	jmp    2000c6 <start+0x43>
sys_fork(void)
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  200093:	cd 31                	int    $0x31

		// Start as many processes as possible, until we fail to start
		// a process or we have started 1025 processes total.
		while (counter + n_started < 1025) {
			p = sys_fork();
			if (p == 0)
  200095:	83 f8 00             	cmp    $0x0,%eax
  200098:	75 07                	jne    2000a1 <start+0x1e>
				run_child();
  20009a:	e8 a0 ff ff ff       	call   20003f <run_child>
  20009f:	eb 03                	jmp    2000a4 <start+0x21>
			else if (p > 0)
  2000a1:	7e 10                	jle    2000b3 <start+0x30>
				n_started++;
  2000a3:	43                   	inc    %ebx
	while (counter < 1025) {
		int n_started = 0;

		// Start as many processes as possible, until we fail to start
		// a process or we have started 1025 processes total.
		while (counter + n_started < 1025) {
  2000a4:	a1 14 16 20 00       	mov    0x201614,%eax
  2000a9:	8d 04 03             	lea    (%ebx,%eax,1),%eax
  2000ac:	3d 00 04 00 00       	cmp    $0x400,%eax
  2000b1:	7e e0                	jle    200093 <start+0x10>
			else
				break;
		}

		// If we could not start any new processes, give up!
		if (n_started == 0)
  2000b3:	85 db                	test   %ebx,%ebx
  2000b5:	74 1f                	je     2000d6 <start+0x53>
  2000b7:	ba 02 00 00 00       	mov    $0x2,%edx

static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000bc:	89 d0                	mov    %edx,%eax
  2000be:	cd 34                	int    $0x34
		// We started at least one process, but then could not start
		// any more.
		// That means we ran out of room to start processes.
		// Retrieve old processes' exit status with sys_wait(),
		// to make room for new processes.
		for (p = 2; p < NPROCS; p++){
  2000c0:	42                   	inc    %edx
  2000c1:	83 fa 10             	cmp    $0x10,%edx
  2000c4:	75 f6                	jne    2000bc <start+0x39>
	pid_t p;
	int status;

	counter = 0;

	while (counter < 1025) {
  2000c6:	a1 14 16 20 00       	mov    0x201614,%eax
  2000cb:	3d 00 04 00 00       	cmp    $0x400,%eax
  2000d0:	7f 04                	jg     2000d6 <start+0x53>
  2000d2:	31 db                	xor    %ebx,%ebx
  2000d4:	eb ce                	jmp    2000a4 <start+0x21>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  2000d6:	31 c0                	xor    %eax,%eax
  2000d8:	cd 33                	int    $0x33
  2000da:	eb fe                	jmp    2000da <start+0x57>

002000dc <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  2000dc:	56                   	push   %esi
  2000dd:	31 d2                	xor    %edx,%edx
  2000df:	53                   	push   %ebx
  2000e0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2000e4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  2000e8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  2000ec:	eb 08                	jmp    2000f6 <memcpy+0x1a>
		*d++ = *s++;
  2000ee:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  2000f1:	4e                   	dec    %esi
  2000f2:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  2000f5:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  2000f6:	85 f6                	test   %esi,%esi
  2000f8:	75 f4                	jne    2000ee <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  2000fa:	5b                   	pop    %ebx
  2000fb:	5e                   	pop    %esi
  2000fc:	c3                   	ret    

002000fd <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  2000fd:	57                   	push   %edi
  2000fe:	56                   	push   %esi
  2000ff:	53                   	push   %ebx
  200100:	8b 44 24 10          	mov    0x10(%esp),%eax
  200104:	8b 7c 24 14          	mov    0x14(%esp),%edi
  200108:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  20010c:	39 c7                	cmp    %eax,%edi
  20010e:	73 26                	jae    200136 <memmove+0x39>
  200110:	8d 34 17             	lea    (%edi,%edx,1),%esi
  200113:	39 c6                	cmp    %eax,%esi
  200115:	76 1f                	jbe    200136 <memmove+0x39>
		s += n, d += n;
  200117:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  20011a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  20011c:	eb 07                	jmp    200125 <memmove+0x28>
			*--d = *--s;
  20011e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  200121:	4a                   	dec    %edx
  200122:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  200125:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  200126:	85 d2                	test   %edx,%edx
  200128:	75 f4                	jne    20011e <memmove+0x21>
  20012a:	eb 10                	jmp    20013c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  20012c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  20012f:	4a                   	dec    %edx
  200130:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  200133:	41                   	inc    %ecx
  200134:	eb 02                	jmp    200138 <memmove+0x3b>
  200136:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  200138:	85 d2                	test   %edx,%edx
  20013a:	75 f0                	jne    20012c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  20013c:	5b                   	pop    %ebx
  20013d:	5e                   	pop    %esi
  20013e:	5f                   	pop    %edi
  20013f:	c3                   	ret    

00200140 <memset>:

void *
memset(void *v, int c, size_t n)
{
  200140:	53                   	push   %ebx
  200141:	8b 44 24 08          	mov    0x8(%esp),%eax
  200145:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  200149:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  20014d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  20014f:	eb 04                	jmp    200155 <memset+0x15>
		*p++ = c;
  200151:	88 1a                	mov    %bl,(%edx)
  200153:	49                   	dec    %ecx
  200154:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  200155:	85 c9                	test   %ecx,%ecx
  200157:	75 f8                	jne    200151 <memset+0x11>
		*p++ = c;
	return v;
}
  200159:	5b                   	pop    %ebx
  20015a:	c3                   	ret    

0020015b <strlen>:

size_t
strlen(const char *s)
{
  20015b:	8b 54 24 04          	mov    0x4(%esp),%edx
  20015f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200161:	eb 01                	jmp    200164 <strlen+0x9>
		++n;
  200163:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200164:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  200168:	75 f9                	jne    200163 <strlen+0x8>
		++n;
	return n;
}
  20016a:	c3                   	ret    

0020016b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  20016b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  20016f:	31 c0                	xor    %eax,%eax
  200171:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  200175:	eb 01                	jmp    200178 <strnlen+0xd>
		++n;
  200177:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  200178:	39 d0                	cmp    %edx,%eax
  20017a:	74 06                	je     200182 <strnlen+0x17>
  20017c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  200180:	75 f5                	jne    200177 <strnlen+0xc>
		++n;
	return n;
}
  200182:	c3                   	ret    

00200183 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  200183:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  200184:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  200189:	53                   	push   %ebx
  20018a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  20018c:	76 05                	jbe    200193 <console_putc+0x10>
  20018e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  200193:	80 fa 0a             	cmp    $0xa,%dl
  200196:	75 2c                	jne    2001c4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  200198:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  20019e:	be 50 00 00 00       	mov    $0x50,%esi
  2001a3:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  2001a5:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001a8:	99                   	cltd   
  2001a9:	f7 fe                	idiv   %esi
  2001ab:	89 de                	mov    %ebx,%esi
  2001ad:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  2001af:	eb 07                	jmp    2001b8 <console_putc+0x35>
			*cursor++ = ' ' | color;
  2001b1:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  2001b4:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  2001b5:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  2001b8:	83 f8 50             	cmp    $0x50,%eax
  2001bb:	75 f4                	jne    2001b1 <console_putc+0x2e>
  2001bd:	29 d0                	sub    %edx,%eax
  2001bf:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  2001c2:	eb 0b                	jmp    2001cf <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  2001c4:	0f b6 d2             	movzbl %dl,%edx
  2001c7:	09 ca                	or     %ecx,%edx
  2001c9:	66 89 13             	mov    %dx,(%ebx)
  2001cc:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  2001cf:	5b                   	pop    %ebx
  2001d0:	5e                   	pop    %esi
  2001d1:	c3                   	ret    

002001d2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  2001d2:	56                   	push   %esi
  2001d3:	53                   	push   %ebx
  2001d4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  2001d8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  2001db:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  2001df:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  2001e4:	75 04                	jne    2001ea <fill_numbuf+0x18>
  2001e6:	85 d2                	test   %edx,%edx
  2001e8:	74 10                	je     2001fa <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  2001ea:	89 d0                	mov    %edx,%eax
  2001ec:	31 d2                	xor    %edx,%edx
  2001ee:	f7 f1                	div    %ecx
  2001f0:	4b                   	dec    %ebx
  2001f1:	8a 14 16             	mov    (%esi,%edx,1),%dl
  2001f4:	88 13                	mov    %dl,(%ebx)
			val /= base;
  2001f6:	89 c2                	mov    %eax,%edx
  2001f8:	eb ec                	jmp    2001e6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  2001fa:	89 d8                	mov    %ebx,%eax
  2001fc:	5b                   	pop    %ebx
  2001fd:	5e                   	pop    %esi
  2001fe:	c3                   	ret    

002001ff <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  2001ff:	55                   	push   %ebp
  200200:	57                   	push   %edi
  200201:	56                   	push   %esi
  200202:	53                   	push   %ebx
  200203:	83 ec 38             	sub    $0x38,%esp
  200206:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  20020a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  20020e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  200212:	e9 60 03 00 00       	jmp    200577 <console_vprintf+0x378>
		if (*format != '%') {
  200217:	80 fa 25             	cmp    $0x25,%dl
  20021a:	74 13                	je     20022f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  20021c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200220:	0f b6 d2             	movzbl %dl,%edx
  200223:	89 f0                	mov    %esi,%eax
  200225:	e8 59 ff ff ff       	call   200183 <console_putc>
  20022a:	e9 45 03 00 00       	jmp    200574 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  20022f:	47                   	inc    %edi
  200230:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  200237:	00 
  200238:	eb 12                	jmp    20024c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  20023a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  20023b:	8a 11                	mov    (%ecx),%dl
  20023d:	84 d2                	test   %dl,%dl
  20023f:	74 1a                	je     20025b <console_vprintf+0x5c>
  200241:	89 e8                	mov    %ebp,%eax
  200243:	38 c2                	cmp    %al,%dl
  200245:	75 f3                	jne    20023a <console_vprintf+0x3b>
  200247:	e9 3f 03 00 00       	jmp    20058b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  20024c:	8a 17                	mov    (%edi),%dl
  20024e:	84 d2                	test   %dl,%dl
  200250:	74 0b                	je     20025d <console_vprintf+0x5e>
  200252:	b9 e4 05 20 00       	mov    $0x2005e4,%ecx
  200257:	89 d5                	mov    %edx,%ebp
  200259:	eb e0                	jmp    20023b <console_vprintf+0x3c>
  20025b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  20025d:	8d 42 cf             	lea    -0x31(%edx),%eax
  200260:	3c 08                	cmp    $0x8,%al
  200262:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200269:	00 
  20026a:	76 13                	jbe    20027f <console_vprintf+0x80>
  20026c:	eb 1d                	jmp    20028b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  20026e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  200273:	0f be c0             	movsbl %al,%eax
  200276:	47                   	inc    %edi
  200277:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  20027b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  20027f:	8a 07                	mov    (%edi),%al
  200281:	8d 50 d0             	lea    -0x30(%eax),%edx
  200284:	80 fa 09             	cmp    $0x9,%dl
  200287:	76 e5                	jbe    20026e <console_vprintf+0x6f>
  200289:	eb 18                	jmp    2002a3 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  20028b:	80 fa 2a             	cmp    $0x2a,%dl
  20028e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  200295:	ff 
  200296:	75 0b                	jne    2002a3 <console_vprintf+0xa4>
			width = va_arg(val, int);
  200298:	83 c3 04             	add    $0x4,%ebx
			++format;
  20029b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  20029c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  20029f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  2002a3:	83 cd ff             	or     $0xffffffff,%ebp
  2002a6:	80 3f 2e             	cmpb   $0x2e,(%edi)
  2002a9:	75 37                	jne    2002e2 <console_vprintf+0xe3>
			++format;
  2002ab:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  2002ac:	31 ed                	xor    %ebp,%ebp
  2002ae:	8a 07                	mov    (%edi),%al
  2002b0:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002b3:	80 fa 09             	cmp    $0x9,%dl
  2002b6:	76 0d                	jbe    2002c5 <console_vprintf+0xc6>
  2002b8:	eb 17                	jmp    2002d1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  2002ba:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  2002bd:	0f be c0             	movsbl %al,%eax
  2002c0:	47                   	inc    %edi
  2002c1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  2002c5:	8a 07                	mov    (%edi),%al
  2002c7:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002ca:	80 fa 09             	cmp    $0x9,%dl
  2002cd:	76 eb                	jbe    2002ba <console_vprintf+0xbb>
  2002cf:	eb 11                	jmp    2002e2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  2002d1:	3c 2a                	cmp    $0x2a,%al
  2002d3:	75 0b                	jne    2002e0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  2002d5:	83 c3 04             	add    $0x4,%ebx
				++format;
  2002d8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  2002d9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  2002dc:	85 ed                	test   %ebp,%ebp
  2002de:	79 02                	jns    2002e2 <console_vprintf+0xe3>
  2002e0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  2002e2:	8a 07                	mov    (%edi),%al
  2002e4:	3c 64                	cmp    $0x64,%al
  2002e6:	74 34                	je     20031c <console_vprintf+0x11d>
  2002e8:	7f 1d                	jg     200307 <console_vprintf+0x108>
  2002ea:	3c 58                	cmp    $0x58,%al
  2002ec:	0f 84 a2 00 00 00    	je     200394 <console_vprintf+0x195>
  2002f2:	3c 63                	cmp    $0x63,%al
  2002f4:	0f 84 bf 00 00 00    	je     2003b9 <console_vprintf+0x1ba>
  2002fa:	3c 43                	cmp    $0x43,%al
  2002fc:	0f 85 d0 00 00 00    	jne    2003d2 <console_vprintf+0x1d3>
  200302:	e9 a3 00 00 00       	jmp    2003aa <console_vprintf+0x1ab>
  200307:	3c 75                	cmp    $0x75,%al
  200309:	74 4d                	je     200358 <console_vprintf+0x159>
  20030b:	3c 78                	cmp    $0x78,%al
  20030d:	74 5c                	je     20036b <console_vprintf+0x16c>
  20030f:	3c 73                	cmp    $0x73,%al
  200311:	0f 85 bb 00 00 00    	jne    2003d2 <console_vprintf+0x1d3>
  200317:	e9 86 00 00 00       	jmp    2003a2 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  20031c:	83 c3 04             	add    $0x4,%ebx
  20031f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  200322:	89 d1                	mov    %edx,%ecx
  200324:	c1 f9 1f             	sar    $0x1f,%ecx
  200327:	89 0c 24             	mov    %ecx,(%esp)
  20032a:	31 ca                	xor    %ecx,%edx
  20032c:	55                   	push   %ebp
  20032d:	29 ca                	sub    %ecx,%edx
  20032f:	68 ec 05 20 00       	push   $0x2005ec
  200334:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200339:	8d 44 24 40          	lea    0x40(%esp),%eax
  20033d:	e8 90 fe ff ff       	call   2001d2 <fill_numbuf>
  200342:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  200346:	58                   	pop    %eax
  200347:	5a                   	pop    %edx
  200348:	ba 01 00 00 00       	mov    $0x1,%edx
  20034d:	8b 04 24             	mov    (%esp),%eax
  200350:	83 e0 01             	and    $0x1,%eax
  200353:	e9 a5 00 00 00       	jmp    2003fd <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  200358:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  20035b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200360:	8b 53 fc             	mov    -0x4(%ebx),%edx
  200363:	55                   	push   %ebp
  200364:	68 ec 05 20 00       	push   $0x2005ec
  200369:	eb 11                	jmp    20037c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  20036b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  20036e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  200371:	55                   	push   %ebp
  200372:	68 00 06 20 00       	push   $0x200600
  200377:	b9 10 00 00 00       	mov    $0x10,%ecx
  20037c:	8d 44 24 40          	lea    0x40(%esp),%eax
  200380:	e8 4d fe ff ff       	call   2001d2 <fill_numbuf>
  200385:	ba 01 00 00 00       	mov    $0x1,%edx
  20038a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20038e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  200390:	59                   	pop    %ecx
  200391:	59                   	pop    %ecx
  200392:	eb 69                	jmp    2003fd <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  200394:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  200397:	8b 53 fc             	mov    -0x4(%ebx),%edx
  20039a:	55                   	push   %ebp
  20039b:	68 ec 05 20 00       	push   $0x2005ec
  2003a0:	eb d5                	jmp    200377 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  2003a2:	83 c3 04             	add    $0x4,%ebx
  2003a5:	8b 43 fc             	mov    -0x4(%ebx),%eax
  2003a8:	eb 40                	jmp    2003ea <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  2003aa:	83 c3 04             	add    $0x4,%ebx
  2003ad:	8b 53 fc             	mov    -0x4(%ebx),%edx
  2003b0:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  2003b4:	e9 bd 01 00 00       	jmp    200576 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  2003b9:	83 c3 04             	add    $0x4,%ebx
  2003bc:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  2003bf:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  2003c3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  2003c8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  2003cc:	88 44 24 24          	mov    %al,0x24(%esp)
  2003d0:	eb 27                	jmp    2003f9 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  2003d2:	84 c0                	test   %al,%al
  2003d4:	75 02                	jne    2003d8 <console_vprintf+0x1d9>
  2003d6:	b0 25                	mov    $0x25,%al
  2003d8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  2003dc:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  2003e1:	80 3f 00             	cmpb   $0x0,(%edi)
  2003e4:	74 0a                	je     2003f0 <console_vprintf+0x1f1>
  2003e6:	8d 44 24 24          	lea    0x24(%esp),%eax
  2003ea:	89 44 24 04          	mov    %eax,0x4(%esp)
  2003ee:	eb 09                	jmp    2003f9 <console_vprintf+0x1fa>
				format--;
  2003f0:	8d 54 24 24          	lea    0x24(%esp),%edx
  2003f4:	4f                   	dec    %edi
  2003f5:	89 54 24 04          	mov    %edx,0x4(%esp)
  2003f9:	31 d2                	xor    %edx,%edx
  2003fb:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  2003fd:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  2003ff:	83 fd ff             	cmp    $0xffffffff,%ebp
  200402:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  200409:	74 1f                	je     20042a <console_vprintf+0x22b>
  20040b:	89 04 24             	mov    %eax,(%esp)
  20040e:	eb 01                	jmp    200411 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  200410:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  200411:	39 e9                	cmp    %ebp,%ecx
  200413:	74 0a                	je     20041f <console_vprintf+0x220>
  200415:	8b 44 24 04          	mov    0x4(%esp),%eax
  200419:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  20041d:	75 f1                	jne    200410 <console_vprintf+0x211>
  20041f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  200422:	89 0c 24             	mov    %ecx,(%esp)
  200425:	eb 1f                	jmp    200446 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  200427:	42                   	inc    %edx
  200428:	eb 09                	jmp    200433 <console_vprintf+0x234>
  20042a:	89 d1                	mov    %edx,%ecx
  20042c:	8b 14 24             	mov    (%esp),%edx
  20042f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200433:	8b 44 24 04          	mov    0x4(%esp),%eax
  200437:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  20043b:	75 ea                	jne    200427 <console_vprintf+0x228>
  20043d:	8b 44 24 08          	mov    0x8(%esp),%eax
  200441:	89 14 24             	mov    %edx,(%esp)
  200444:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  200446:	85 c0                	test   %eax,%eax
  200448:	74 0c                	je     200456 <console_vprintf+0x257>
  20044a:	84 d2                	test   %dl,%dl
  20044c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  200453:	00 
  200454:	75 24                	jne    20047a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  200456:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  20045b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  200462:	00 
  200463:	75 15                	jne    20047a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  200465:	8b 44 24 14          	mov    0x14(%esp),%eax
  200469:	83 e0 08             	and    $0x8,%eax
  20046c:	83 f8 01             	cmp    $0x1,%eax
  20046f:	19 c9                	sbb    %ecx,%ecx
  200471:	f7 d1                	not    %ecx
  200473:	83 e1 20             	and    $0x20,%ecx
  200476:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  20047a:	3b 2c 24             	cmp    (%esp),%ebp
  20047d:	7e 0d                	jle    20048c <console_vprintf+0x28d>
  20047f:	84 d2                	test   %dl,%dl
  200481:	74 40                	je     2004c3 <console_vprintf+0x2c4>
			zeros = precision - len;
  200483:	2b 2c 24             	sub    (%esp),%ebp
  200486:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  20048a:	eb 3f                	jmp    2004cb <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  20048c:	84 d2                	test   %dl,%dl
  20048e:	74 33                	je     2004c3 <console_vprintf+0x2c4>
  200490:	8b 44 24 14          	mov    0x14(%esp),%eax
  200494:	83 e0 06             	and    $0x6,%eax
  200497:	83 f8 02             	cmp    $0x2,%eax
  20049a:	75 27                	jne    2004c3 <console_vprintf+0x2c4>
  20049c:	45                   	inc    %ebp
  20049d:	75 24                	jne    2004c3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  20049f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004a1:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  2004a4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004a9:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004ac:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  2004af:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  2004b3:	7d 0e                	jge    2004c3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  2004b5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  2004b9:	29 ca                	sub    %ecx,%edx
  2004bb:	29 c2                	sub    %eax,%edx
  2004bd:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004c1:	eb 08                	jmp    2004cb <console_vprintf+0x2cc>
  2004c3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  2004ca:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  2004cb:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  2004cf:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004d1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  2004d5:	2b 2c 24             	sub    (%esp),%ebp
  2004d8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004dd:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004e0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  2004e3:	29 c5                	sub    %eax,%ebp
  2004e5:	89 f0                	mov    %esi,%eax
  2004e7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004eb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  2004ef:	eb 0f                	jmp    200500 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  2004f1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  2004f5:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004fa:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  2004fb:	e8 83 fc ff ff       	call   200183 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  200500:	85 ed                	test   %ebp,%ebp
  200502:	7e 07                	jle    20050b <console_vprintf+0x30c>
  200504:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  200509:	74 e6                	je     2004f1 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  20050b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200510:	89 c6                	mov    %eax,%esi
  200512:	74 23                	je     200537 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  200514:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  200519:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20051d:	e8 61 fc ff ff       	call   200183 <console_putc>
  200522:	89 c6                	mov    %eax,%esi
  200524:	eb 11                	jmp    200537 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  200526:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20052a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20052f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  200530:	e8 4e fc ff ff       	call   200183 <console_putc>
  200535:	eb 06                	jmp    20053d <console_vprintf+0x33e>
  200537:	89 f0                	mov    %esi,%eax
  200539:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20053d:	85 f6                	test   %esi,%esi
  20053f:	7f e5                	jg     200526 <console_vprintf+0x327>
  200541:	8b 34 24             	mov    (%esp),%esi
  200544:	eb 15                	jmp    20055b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  200546:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  20054a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  20054b:	0f b6 11             	movzbl (%ecx),%edx
  20054e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200552:	e8 2c fc ff ff       	call   200183 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  200557:	ff 44 24 04          	incl   0x4(%esp)
  20055b:	85 f6                	test   %esi,%esi
  20055d:	7f e7                	jg     200546 <console_vprintf+0x347>
  20055f:	eb 0f                	jmp    200570 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  200561:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200565:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  20056a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  20056b:	e8 13 fc ff ff       	call   200183 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  200570:	85 ed                	test   %ebp,%ebp
  200572:	7f ed                	jg     200561 <console_vprintf+0x362>
  200574:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  200576:	47                   	inc    %edi
  200577:	8a 17                	mov    (%edi),%dl
  200579:	84 d2                	test   %dl,%dl
  20057b:	0f 85 96 fc ff ff    	jne    200217 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  200581:	83 c4 38             	add    $0x38,%esp
  200584:	89 f0                	mov    %esi,%eax
  200586:	5b                   	pop    %ebx
  200587:	5e                   	pop    %esi
  200588:	5f                   	pop    %edi
  200589:	5d                   	pop    %ebp
  20058a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  20058b:	81 e9 e4 05 20 00    	sub    $0x2005e4,%ecx
  200591:	b8 01 00 00 00       	mov    $0x1,%eax
  200596:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  200598:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  200599:	09 44 24 14          	or     %eax,0x14(%esp)
  20059d:	e9 aa fc ff ff       	jmp    20024c <console_vprintf+0x4d>

002005a2 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  2005a2:	8d 44 24 10          	lea    0x10(%esp),%eax
  2005a6:	50                   	push   %eax
  2005a7:	ff 74 24 10          	pushl  0x10(%esp)
  2005ab:	ff 74 24 10          	pushl  0x10(%esp)
  2005af:	ff 74 24 10          	pushl  0x10(%esp)
  2005b3:	e8 47 fc ff ff       	call   2001ff <console_vprintf>
  2005b8:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  2005bb:	c3                   	ret    
