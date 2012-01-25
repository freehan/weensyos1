
obj/mpos-app2:     file format elf32-i386

Disassembly of section .text:

00200000 <app_printf>:
static void app_printf(const char *format, ...) __attribute__((noinline));

static void
app_printf(const char *format, ...)
{
  200000:	53                   	push   %ebx
  200001:	83 ec 08             	sub    $0x8,%esp
  200004:	cd 30                	int    $0x30
	// set default color based on currently running process
	int color = sys_getpid();
	if (color < 0)
  200006:	85 c0                	test   %eax,%eax
  200008:	ba 00 07 00 00       	mov    $0x700,%edx
  20000d:	78 14                	js     200023 <app_printf+0x23>
		color = 0x0700;
	else {
		static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
		color = col[color % sizeof(col)] << 8;
  20000f:	66 ba 05 00          	mov    $0x5,%dx
  200013:	89 d3                	mov    %edx,%ebx
  200015:	31 d2                	xor    %edx,%edx
  200017:	f7 f3                	div    %ebx
  200019:	0f b6 92 8e 06 20 00 	movzbl 0x20068e(%edx),%edx
  200020:	c1 e2 08             	shl    $0x8,%edx
	}

	va_list val;
	va_start(val, format);
	cursorpos = console_vprintf(cursorpos, color, format, val);
  200023:	8d 44 24 14          	lea    0x14(%esp),%eax
  200027:	50                   	push   %eax
  200028:	ff 74 24 14          	pushl  0x14(%esp)
  20002c:	52                   	push   %edx
  20002d:	ff 35 00 00 06 00    	pushl  0x60000
  200033:	e8 ef 01 00 00       	call   200227 <console_vprintf>
  200038:	a3 00 00 06 00       	mov    %eax,0x60000
	va_end(val);
}
  20003d:	83 c4 18             	add    $0x18,%esp
  200040:	5b                   	pop    %ebx
  200041:	c3                   	ret    

00200042 <run_child>:
}

void
run_child(void)
{
  200042:	53                   	push   %ebx
  200043:	83 ec 0c             	sub    $0xc,%esp
	int input_counter = counter;
  200046:	8b 1d bc 16 20 00    	mov    0x2016bc,%ebx

	counter++;		/* Note that all "processes" share an address
  20004c:	a1 bc 16 20 00       	mov    0x2016bc,%eax
  200051:	40                   	inc    %eax
  200052:	a3 bc 16 20 00       	mov    %eax,0x2016bc
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200057:	cd 30                	int    $0x30
				   space, so this change to 'counter' will be
				   visible to all processes. */

	app_printf("Process %d lives, counter %d!\n",
  200059:	53                   	push   %ebx
  20005a:	50                   	push   %eax
  20005b:	68 34 06 20 00       	push   $0x200634
  200060:	e8 9b ff ff ff       	call   200000 <app_printf>
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  200065:	89 d8                	mov    %ebx,%eax
  200067:	cd 33                	int    $0x33
  200069:	83 c4 10             	add    $0x10,%esp
  20006c:	eb fe                	jmp    20006c <run_child+0x2a>

0020006e <start>:
  20006e:	53                   	push   %ebx
  20006f:	83 ec 08             	sub    $0x8,%esp
  200072:	c7 05 bc 16 20 00 00 	movl   $0x0,0x2016bc
  200079:	00 00 00 
  20007c:	eb 5a                	jmp    2000d8 <start+0x6a>
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  20007e:	cd 31                	int    $0x31
  200080:	83 f8 00             	cmp    $0x0,%eax
  200083:	75 07                	jne    20008c <start+0x1e>
  200085:	e8 b8 ff ff ff       	call   200042 <run_child>
  20008a:	eb 03                	jmp    20008f <start+0x21>
  20008c:	7e 10                	jle    20009e <start+0x30>
  20008e:	43                   	inc    %ebx
  20008f:	a1 bc 16 20 00       	mov    0x2016bc,%eax
  200094:	8d 04 03             	lea    (%ebx,%eax,1),%eax
  200097:	3d 00 04 00 00       	cmp    $0x400,%eax
  20009c:	7e e0                	jle    20007e <start+0x10>
  20009e:	85 db                	test   %ebx,%ebx
  2000a0:	74 46                	je     2000e8 <start+0x7a>
  2000a2:	bb 02 00 00 00       	mov    $0x2,%ebx
  2000a7:	a1 bc 16 20 00       	mov    0x2016bc,%eax
  2000ac:	52                   	push   %edx
  2000ad:	52                   	push   %edx
  2000ae:	50                   	push   %eax
  2000af:	68 53 06 20 00       	push   $0x200653
  2000b4:	e8 47 ff ff ff       	call   200000 <app_printf>
static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000b9:	89 d8                	mov    %ebx,%eax
  2000bb:	cd 34                	int    $0x34
  2000bd:	a1 bc 16 20 00       	mov    0x2016bc,%eax
  2000c2:	43                   	inc    %ebx
  2000c3:	5a                   	pop    %edx
  2000c4:	59                   	pop    %ecx
  2000c5:	50                   	push   %eax
  2000c6:	68 70 06 20 00       	push   $0x200670
  2000cb:	e8 30 ff ff ff       	call   200000 <app_printf>
  2000d0:	83 c4 10             	add    $0x10,%esp
  2000d3:	83 fb 10             	cmp    $0x10,%ebx
  2000d6:	75 cf                	jne    2000a7 <start+0x39>
  2000d8:	a1 bc 16 20 00       	mov    0x2016bc,%eax
  2000dd:	3d 00 04 00 00       	cmp    $0x400,%eax
  2000e2:	7f 04                	jg     2000e8 <start+0x7a>
  2000e4:	31 db                	xor    %ebx,%ebx
  2000e6:	eb a7                	jmp    20008f <start+0x21>
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  2000e8:	31 c0                	xor    %eax,%eax
  2000ea:	cd 33                	int    $0x33
  2000ec:	eb fe                	jmp    2000ec <start+0x7e>
  2000ee:	90                   	nop    
  2000ef:	90                   	nop    

002000f0 <memcpy>:
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  2000f0:	53                   	push   %ebx
  2000f1:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  2000f5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  2000f9:	8b 54 24 08          	mov    0x8(%esp),%edx
  2000fd:	eb 06                	jmp    200105 <memcpy+0x15>
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
		*d++ = *s++;
  2000ff:	8a 41 ff             	mov    0xffffffff(%ecx),%al
  200102:	88 42 ff             	mov    %al,0xffffffff(%edx)
  200105:	4b                   	dec    %ebx
  200106:	41                   	inc    %ecx
  200107:	42                   	inc    %edx
  200108:	83 fb ff             	cmp    $0xffffffff,%ebx
  20010b:	75 f2                	jne    2000ff <memcpy+0xf>
	return dst;
}
  20010d:	8b 44 24 08          	mov    0x8(%esp),%eax
  200111:	5b                   	pop    %ebx
  200112:	c3                   	ret    

00200113 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  200113:	56                   	push   %esi
  200114:	53                   	push   %ebx
  200115:	8b 74 24 0c          	mov    0xc(%esp),%esi
  200119:	8b 44 24 10          	mov    0x10(%esp),%eax
  20011d:	8b 54 24 14          	mov    0x14(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  200121:	39 f0                	cmp    %esi,%eax
  200123:	73 0a                	jae    20012f <memmove+0x1c>
  200125:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  200128:	39 f3                	cmp    %esi,%ebx
		s += n, d += n;
  20012a:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
  20012d:	77 0c                	ja     20013b <memmove+0x28>
  20012f:	89 c3                	mov    %eax,%ebx
  200131:	89 f1                	mov    %esi,%ecx
  200133:	eb 14                	jmp    200149 <memmove+0x36>
		while (n-- > 0)
			*--d = *--s;
  200135:	4b                   	dec    %ebx
  200136:	49                   	dec    %ecx
  200137:	8a 03                	mov    (%ebx),%al
  200139:	88 01                	mov    %al,(%ecx)
  20013b:	4a                   	dec    %edx
  20013c:	83 fa ff             	cmp    $0xffffffff,%edx
  20013f:	75 f4                	jne    200135 <memmove+0x22>
  200141:	eb 0e                	jmp    200151 <memmove+0x3e>
	} else
		while (n-- > 0)
			*d++ = *s++;
  200143:	8a 43 ff             	mov    0xffffffff(%ebx),%al
  200146:	88 41 ff             	mov    %al,0xffffffff(%ecx)
  200149:	4a                   	dec    %edx
  20014a:	43                   	inc    %ebx
  20014b:	41                   	inc    %ecx
  20014c:	83 fa ff             	cmp    $0xffffffff,%edx
  20014f:	75 f2                	jne    200143 <memmove+0x30>
	return dst;
}
  200151:	89 f0                	mov    %esi,%eax
  200153:	5b                   	pop    %ebx
  200154:	5e                   	pop    %esi
  200155:	c3                   	ret    

00200156 <memset>:

void *
memset(void *v, int c, size_t n)
{
  200156:	53                   	push   %ebx
  200157:	8b 44 24 08          	mov    0x8(%esp),%eax
  20015b:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  20015f:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  200163:	89 c2                	mov    %eax,%edx
  200165:	eb 03                	jmp    20016a <memset+0x14>
	char *p = (char *) v;
	while (n-- > 0)
		*p++ = c;
  200167:	88 5a ff             	mov    %bl,0xffffffff(%edx)
  20016a:	49                   	dec    %ecx
  20016b:	42                   	inc    %edx
  20016c:	83 f9 ff             	cmp    $0xffffffff,%ecx
  20016f:	75 f6                	jne    200167 <memset+0x11>
	return v;
}
  200171:	5b                   	pop    %ebx
  200172:	c3                   	ret    

00200173 <strlen>:

size_t
strlen(const char *s)
{
  200173:	8b 54 24 04          	mov    0x4(%esp),%edx
  200177:	31 c0                	xor    %eax,%eax
  200179:	eb 01                	jmp    20017c <strlen+0x9>
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  20017b:	40                   	inc    %eax
  20017c:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  200180:	75 f9                	jne    20017b <strlen+0x8>
	return n;
}
  200182:	c3                   	ret    

00200183 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  200183:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  200187:	31 c0                	xor    %eax,%eax
  200189:	8b 54 24 08          	mov    0x8(%esp),%edx
  20018d:	eb 01                	jmp    200190 <strnlen+0xd>
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  20018f:	40                   	inc    %eax
  200190:	39 d0                	cmp    %edx,%eax
  200192:	74 06                	je     20019a <strnlen+0x17>
  200194:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  200198:	75 f5                	jne    20018f <strnlen+0xc>
	return n;
}
  20019a:	c3                   	ret    

0020019b <console_putc>:


/*****************************************************************************
 * console_vprintf
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  20019b:	57                   	push   %edi
  20019c:	89 cf                	mov    %ecx,%edi
  20019e:	56                   	push   %esi
  20019f:	53                   	push   %ebx
  2001a0:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  2001a2:	81 fb 9f 8f 0b 00    	cmp    $0xb8f9f,%ebx
  2001a8:	88 d0                	mov    %dl,%al
  2001aa:	76 05                	jbe    2001b1 <console_putc+0x16>
  2001ac:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  2001b1:	3c 0a                	cmp    $0xa,%al
  2001b3:	75 2f                	jne    2001e4 <console_putc+0x49>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  2001b5:	8d 83 00 80 f4 ff    	lea    0xfff48000(%ebx),%eax
  2001bb:	be 50 00 00 00       	mov    $0x50,%esi
  2001c0:	d1 f8                	sar    %eax
  2001c2:	89 d9                	mov    %ebx,%ecx
  2001c4:	99                   	cltd   
  2001c5:	f7 fe                	idiv   %esi
  2001c7:	89 d6                	mov    %edx,%esi
  2001c9:	eb 0a                	jmp    2001d5 <console_putc+0x3a>
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  2001cb:	89 f8                	mov    %edi,%eax
  2001cd:	42                   	inc    %edx
  2001ce:	83 c8 20             	or     $0x20,%eax
  2001d1:	66 89 41 fe          	mov    %ax,0xfffffffe(%ecx)
  2001d5:	83 c1 02             	add    $0x2,%ecx
  2001d8:	83 fa 50             	cmp    $0x50,%edx
  2001db:	75 ee                	jne    2001cb <console_putc+0x30>
  2001dd:	29 f2                	sub    %esi,%edx
  2001df:	8d 04 53             	lea    (%ebx,%edx,2),%eax
  2001e2:	eb 0c                	jmp    2001f0 <console_putc+0x55>
	} else
		*cursor++ = c | color;
  2001e4:	66 0f b6 c0          	movzbw %al,%ax
  2001e8:	09 f8                	or     %edi,%eax
  2001ea:	66 89 03             	mov    %ax,(%ebx)
  2001ed:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  2001f0:	5b                   	pop    %ebx
  2001f1:	5e                   	pop    %esi
  2001f2:	5f                   	pop    %edi
  2001f3:	c3                   	ret    

002001f4 <fill_numbuf>:

static const char upper_digits[] = "0123456789ABCDEF";
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  2001f4:	57                   	push   %edi
  2001f5:	56                   	push   %esi
  2001f6:	89 ce                	mov    %ecx,%esi
  2001f8:	53                   	push   %ebx
  2001f9:	8b 7c 24 10          	mov    0x10(%esp),%edi
	*--numbuf_end = '\0';
  2001fd:	8d 58 ff             	lea    0xffffffff(%eax),%ebx
  200200:	c6 40 ff 00          	movb   $0x0,0xffffffff(%eax)
	if (precision != 0 || val != 0)
  200204:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  200209:	75 04                	jne    20020f <fill_numbuf+0x1b>
  20020b:	85 d2                	test   %edx,%edx
  20020d:	74 12                	je     200221 <fill_numbuf+0x2d>
		do {
			*--numbuf_end = digits[val % base];
  20020f:	89 d0                	mov    %edx,%eax
  200211:	31 d2                	xor    %edx,%edx
  200213:	f7 f6                	div    %esi
  200215:	4b                   	dec    %ebx
  200216:	89 c1                	mov    %eax,%ecx
  200218:	8a 04 17             	mov    (%edi,%edx,1),%al
			val /= base;
  20021b:	89 ca                	mov    %ecx,%edx
  20021d:	88 03                	mov    %al,(%ebx)
  20021f:	eb ea                	jmp    20020b <fill_numbuf+0x17>
		} while (val != 0);
	return numbuf_end;
}
  200221:	89 d8                	mov    %ebx,%eax
  200223:	5b                   	pop    %ebx
  200224:	5e                   	pop    %esi
  200225:	5f                   	pop    %edi
  200226:	c3                   	ret    

00200227 <console_vprintf>:

#define FLAG_ALT		(1<<0)
#define FLAG_ZERO		(1<<1)
#define FLAG_LEFTJUSTIFY	(1<<2)
#define FLAG_SPACEPOSITIVE	(1<<3)
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  200227:	55                   	push   %ebp
  200228:	57                   	push   %edi
  200229:	56                   	push   %esi
  20022a:	53                   	push   %ebx
  20022b:	83 ec 3c             	sub    $0x3c,%esp
  20022e:	8b 6c 24 58          	mov    0x58(%esp),%ebp
  200232:	8b 7c 24 5c          	mov    0x5c(%esp),%edi
  200236:	e9 b1 03 00 00       	jmp    2005ec <console_vprintf+0x3c5>
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
		if (*format != '%') {
  20023b:	3c 25                	cmp    $0x25,%al
  20023d:	74 19                	je     200258 <console_vprintf+0x31>
			cursor = console_putc(cursor, *format, color);
  20023f:	0f b6 d0             	movzbl %al,%edx
  200242:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  200246:	8b 44 24 50          	mov    0x50(%esp),%eax
  20024a:	e8 4c ff ff ff       	call   20019b <console_putc>
  20024f:	89 44 24 50          	mov    %eax,0x50(%esp)
  200253:	e9 93 03 00 00       	jmp    2005eb <console_vprintf+0x3c4>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  200258:	45                   	inc    %ebp
  200259:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  200260:	eb 1c                	jmp    20027e <console_vprintf+0x57>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  200262:	41                   	inc    %ecx
  200263:	8a 01                	mov    (%ecx),%al
  200265:	84 c0                	test   %al,%al
  200267:	74 27                	je     200290 <console_vprintf+0x69>
  200269:	38 d0                	cmp    %dl,%al
  20026b:	75 f5                	jne    200262 <console_vprintf+0x3b>
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  20026d:	81 e9 93 06 20 00    	sub    $0x200693,%ecx
  200273:	b8 01 00 00 00       	mov    $0x1,%eax
  200278:	d3 e0                	shl    %cl,%eax
  20027a:	45                   	inc    %ebp
  20027b:	09 04 24             	or     %eax,(%esp)
  20027e:	8a 55 00             	mov    0x0(%ebp),%dl
  200281:	84 d2                	test   %dl,%dl
  200283:	0f 84 70 03 00 00    	je     2005f9 <console_vprintf+0x3d2>
  200289:	b9 93 06 20 00       	mov    $0x200693,%ecx
  20028e:	eb d3                	jmp    200263 <console_vprintf+0x3c>
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  200290:	8d 42 cf             	lea    0xffffffcf(%edx),%eax
  200293:	3c 08                	cmp    $0x8,%al
  200295:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  20029c:	00 
  20029d:	76 13                	jbe    2002b2 <console_vprintf+0x8b>
  20029f:	eb 1d                	jmp    2002be <console_vprintf+0x97>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  2002a1:	6b 44 24 04 0a       	imul   $0xa,0x4(%esp),%eax
  2002a6:	0f be d2             	movsbl %dl,%edx
  2002a9:	45                   	inc    %ebp
  2002aa:	8d 54 02 d0          	lea    0xffffffd0(%edx,%eax,1),%edx
  2002ae:	89 54 24 04          	mov    %edx,0x4(%esp)
  2002b2:	8a 55 00             	mov    0x0(%ebp),%dl
  2002b5:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  2002b8:	3c 09                	cmp    $0x9,%al
  2002ba:	76 e5                	jbe    2002a1 <console_vprintf+0x7a>
  2002bc:	eb 18                	jmp    2002d6 <console_vprintf+0xaf>
		} else if (*format == '*') {
  2002be:	80 fa 2a             	cmp    $0x2a,%dl
  2002c1:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  2002c8:	ff 
  2002c9:	75 0b                	jne    2002d6 <console_vprintf+0xaf>
			width = va_arg(val, int);
  2002cb:	83 c7 04             	add    $0x4,%edi
			++format;
  2002ce:	45                   	inc    %ebp
  2002cf:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  2002d2:	89 44 24 04          	mov    %eax,0x4(%esp)
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  2002d6:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  2002dd:	ff 
  2002de:	80 7d 00 2e          	cmpb   $0x2e,0x0(%ebp)
  2002e2:	75 4f                	jne    200333 <console_vprintf+0x10c>
			++format;
  2002e4:	45                   	inc    %ebp
			if (*format >= '0' && *format <= '9') {
  2002e5:	8a 55 00             	mov    0x0(%ebp),%dl
  2002e8:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  2002eb:	3c 09                	cmp    $0x9,%al
  2002ed:	77 25                	ja     200314 <console_vprintf+0xed>
  2002ef:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  2002f6:	00 
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  2002f7:	6b 44 24 08 0a       	imul   $0xa,0x8(%esp),%eax
  2002fc:	0f be d2             	movsbl %dl,%edx
  2002ff:	45                   	inc    %ebp
  200300:	8d 54 10 d0          	lea    0xffffffd0(%eax,%edx,1),%edx
  200304:	89 54 24 08          	mov    %edx,0x8(%esp)
  200308:	8a 55 00             	mov    0x0(%ebp),%dl
  20030b:	8d 42 d0             	lea    0xffffffd0(%edx),%eax
  20030e:	3c 09                	cmp    $0x9,%al
  200310:	77 12                	ja     200324 <console_vprintf+0xfd>
  200312:	eb e3                	jmp    2002f7 <console_vprintf+0xd0>
			} else if (*format == '*') {
  200314:	80 fa 2a             	cmp    $0x2a,%dl
  200317:	75 12                	jne    20032b <console_vprintf+0x104>
				precision = va_arg(val, int);
  200319:	83 c7 04             	add    $0x4,%edi
				++format;
  20031c:	45                   	inc    %ebp
  20031d:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  200320:	89 54 24 08          	mov    %edx,0x8(%esp)
			}
			if (precision < 0)
  200324:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200329:	79 08                	jns    200333 <console_vprintf+0x10c>
  20032b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  200332:	00 
				precision = 0;
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  200333:	8a 45 00             	mov    0x0(%ebp),%al
  200336:	3c 64                	cmp    $0x64,%al
  200338:	74 34                	je     20036e <console_vprintf+0x147>
  20033a:	7f 1d                	jg     200359 <console_vprintf+0x132>
  20033c:	3c 58                	cmp    $0x58,%al
  20033e:	0f 84 bd 00 00 00    	je     200401 <console_vprintf+0x1da>
  200344:	3c 63                	cmp    $0x63,%al
  200346:	0f 84 eb 00 00 00    	je     200437 <console_vprintf+0x210>
  20034c:	3c 43                	cmp    $0x43,%al
  20034e:	0f 85 06 01 00 00    	jne    20045a <console_vprintf+0x233>
  200354:	e9 cf 00 00 00       	jmp    200428 <console_vprintf+0x201>
  200359:	3c 75                	cmp    $0x75,%al
  20035b:	74 5c                	je     2003b9 <console_vprintf+0x192>
  20035d:	3c 78                	cmp    $0x78,%al
  20035f:	74 6e                	je     2003cf <console_vprintf+0x1a8>
  200361:	3c 73                	cmp    $0x73,%al
  200363:	0f 85 f1 00 00 00    	jne    20045a <console_vprintf+0x233>
  200369:	e9 a4 00 00 00       	jmp    200412 <console_vprintf+0x1eb>
		case 'd': {
			int x = va_arg(val, int);
  20036e:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  200371:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200376:	8b 5f fc             	mov    0xfffffffc(%edi),%ebx
  200379:	ff 74 24 08          	pushl  0x8(%esp)
  20037d:	89 d8                	mov    %ebx,%eax
  20037f:	c1 f8 1f             	sar    $0x1f,%eax
  200382:	89 c2                	mov    %eax,%edx
  200384:	68 99 06 20 00       	push   $0x200699
  200389:	31 da                	xor    %ebx,%edx
  20038b:	29 c2                	sub    %eax,%edx
  20038d:	8d 44 24 44          	lea    0x44(%esp),%eax
  200391:	e8 5e fe ff ff       	call   2001f4 <fill_numbuf>
			if (x < 0)
  200396:	85 db                	test   %ebx,%ebx
  200398:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  20039c:	5e                   	pop    %esi
  20039d:	be 01 00 00 00       	mov    $0x1,%esi
  2003a2:	58                   	pop    %eax
  2003a3:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  2003aa:	00 
  2003ab:	0f 88 d1 00 00 00    	js     200482 <console_vprintf+0x25b>
  2003b1:	66 31 f6             	xor    %si,%si
  2003b4:	e9 c9 00 00 00       	jmp    200482 <console_vprintf+0x25b>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  2003b9:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  2003bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  2003c1:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  2003c4:	ff 74 24 08          	pushl  0x8(%esp)
  2003c8:	68 99 06 20 00       	push   $0x200699
  2003cd:	eb 14                	jmp    2003e3 <console_vprintf+0x1bc>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  2003cf:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  2003d2:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  2003d5:	ff 74 24 08          	pushl  0x8(%esp)
  2003d9:	68 aa 06 20 00       	push   $0x2006aa
  2003de:	b9 10 00 00 00       	mov    $0x10,%ecx
  2003e3:	8d 44 24 44          	lea    0x44(%esp),%eax
  2003e7:	31 f6                	xor    %esi,%esi
  2003e9:	e8 06 fe ff ff       	call   2001f4 <fill_numbuf>
  2003ee:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  2003f5:	00 
  2003f6:	89 44 24 1c          	mov    %eax,0x1c(%esp)
			numeric = 1;
			break;
  2003fa:	59                   	pop    %ecx
  2003fb:	5b                   	pop    %ebx
  2003fc:	e9 81 00 00 00       	jmp    200482 <console_vprintf+0x25b>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  200401:	83 c7 04             	add    $0x4,%edi
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  200404:	8b 57 fc             	mov    0xfffffffc(%edi),%edx
  200407:	ff 74 24 08          	pushl  0x8(%esp)
  20040b:	68 99 06 20 00       	push   $0x200699
  200410:	eb cc                	jmp    2003de <console_vprintf+0x1b7>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  200412:	83 c7 04             	add    $0x4,%edi
  200415:	31 f6                	xor    %esi,%esi
  200417:	8b 4f fc             	mov    0xfffffffc(%edi),%ecx
  20041a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200421:	00 
  200422:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  200426:	eb 5a                	jmp    200482 <console_vprintf+0x25b>
			break;
		case 'C':
			color = va_arg(val, int);
  200428:	83 c7 04             	add    $0x4,%edi
  20042b:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  20042e:	89 44 24 54          	mov    %eax,0x54(%esp)
  200432:	e9 b4 01 00 00       	jmp    2005eb <console_vprintf+0x3c4>
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  200437:	83 c7 04             	add    $0x4,%edi
			numbuf[1] = '\0';
  20043a:	31 f6                	xor    %esi,%esi
  20043c:	8b 47 fc             	mov    0xfffffffc(%edi),%eax
  20043f:	8d 54 24 28          	lea    0x28(%esp),%edx
  200443:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
  200448:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  20044f:	00 
  200450:	89 54 24 14          	mov    %edx,0x14(%esp)
  200454:	88 44 24 28          	mov    %al,0x28(%esp)
  200458:	eb 28                	jmp    200482 <console_vprintf+0x25b>
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  20045a:	84 c0                	test   %al,%al
  20045c:	75 02                	jne    200460 <console_vprintf+0x239>
  20045e:	b0 25                	mov    $0x25,%al
  200460:	88 44 24 28          	mov    %al,0x28(%esp)
  200464:	8d 44 24 28          	lea    0x28(%esp),%eax
			numbuf[1] = '\0';
  200468:	c6 44 24 29 00       	movb   $0x0,0x29(%esp)
			if (!*format)
  20046d:	80 7d 00 00          	cmpb   $0x0,0x0(%ebp)
  200471:	75 01                	jne    200474 <console_vprintf+0x24d>
				format--;
  200473:	4d                   	dec    %ebp
  200474:	31 f6                	xor    %esi,%esi
  200476:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  20047d:	00 
  20047e:	89 44 24 14          	mov    %eax,0x14(%esp)
			break;
		}

		if (precision >= 0)
  200482:	31 c0                	xor    %eax,%eax
  200484:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200489:	78 16                	js     2004a1 <console_vprintf+0x27a>
			len = strnlen(data, precision);
  20048b:	ff 74 24 08          	pushl  0x8(%esp)
  20048f:	ff 74 24 18          	pushl  0x18(%esp)
  200493:	e8 eb fc ff ff       	call   200183 <strnlen>
  200498:	89 44 24 18          	mov    %eax,0x18(%esp)
  20049c:	58                   	pop    %eax
  20049d:	5a                   	pop    %edx
  20049e:	eb 0f                	jmp    2004af <console_vprintf+0x288>
  2004a0:	40                   	inc    %eax
  2004a1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  2004a5:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  2004a9:	75 f5                	jne    2004a0 <console_vprintf+0x279>
		else
			len = strlen(data);
  2004ab:	89 44 24 10          	mov    %eax,0x10(%esp)
		if (numeric && negative)
  2004af:	8a 54 24 0c          	mov    0xc(%esp),%dl
  2004b3:	84 d2                	test   %dl,%dl
  2004b5:	74 0c                	je     2004c3 <console_vprintf+0x29c>
  2004b7:	85 f6                	test   %esi,%esi
  2004b9:	c7 44 24 18 2d 00 00 	movl   $0x2d,0x18(%esp)
  2004c0:	00 
  2004c1:	75 22                	jne    2004e5 <console_vprintf+0x2be>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  2004c3:	f6 04 24 10          	testb  $0x10,(%esp)
  2004c7:	c7 44 24 18 2b 00 00 	movl   $0x2b,0x18(%esp)
  2004ce:	00 
  2004cf:	75 14                	jne    2004e5 <console_vprintf+0x2be>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  2004d1:	8b 04 24             	mov    (%esp),%eax
  2004d4:	83 e0 08             	and    $0x8,%eax
  2004d7:	83 f8 01             	cmp    $0x1,%eax
  2004da:	19 c0                	sbb    %eax,%eax
  2004dc:	f7 d0                	not    %eax
  2004de:	83 e0 20             	and    $0x20,%eax
  2004e1:	89 44 24 18          	mov    %eax,0x18(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  2004e5:	84 d2                	test   %dl,%dl
  2004e7:	74 12                	je     2004fb <console_vprintf+0x2d4>
  2004e9:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  2004ed:	39 4c 24 08          	cmp    %ecx,0x8(%esp)
  2004f1:	7e 08                	jle    2004fb <console_vprintf+0x2d4>
			zeros = precision - len;
  2004f3:	8b 5c 24 08          	mov    0x8(%esp),%ebx
  2004f7:	29 cb                	sub    %ecx,%ebx
  2004f9:	eb 39                	jmp    200534 <console_vprintf+0x30d>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004fb:	8b 04 24             	mov    (%esp),%eax
  2004fe:	83 e0 06             	and    $0x6,%eax
  200501:	83 f8 02             	cmp    $0x2,%eax
  200504:	75 2c                	jne    200532 <console_vprintf+0x30b>
  200506:	84 d2                	test   %dl,%dl
  200508:	74 28                	je     200532 <console_vprintf+0x30b>
  20050a:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  20050f:	79 21                	jns    200532 <console_vprintf+0x30b>
  200511:	31 d2                	xor    %edx,%edx
  200513:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  200517:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  20051c:	0f 95 c2             	setne  %dl
  20051f:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  200522:	3b 44 24 04          	cmp    0x4(%esp),%eax
  200526:	7d 0a                	jge    200532 <console_vprintf+0x30b>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  200528:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  20052c:	29 cb                	sub    %ecx,%ebx
  20052e:	29 d3                	sub    %edx,%ebx
  200530:	eb 02                	jmp    200534 <console_vprintf+0x30d>
  200532:	31 db                	xor    %ebx,%ebx
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  200534:	8b 74 24 04          	mov    0x4(%esp),%esi
  200538:	31 c0                	xor    %eax,%eax
  20053a:	2b 74 24 10          	sub    0x10(%esp),%esi
  20053e:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  200543:	0f 95 c0             	setne  %al
  200546:	29 c6                	sub    %eax,%esi
  200548:	29 de                	sub    %ebx,%esi
  20054a:	eb 17                	jmp    200563 <console_vprintf+0x33c>
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  20054c:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  200550:	ba 20 00 00 00       	mov    $0x20,%edx
  200555:	4e                   	dec    %esi
  200556:	8b 44 24 50          	mov    0x50(%esp),%eax
  20055a:	e8 3c fc ff ff       	call   20019b <console_putc>
  20055f:	89 44 24 50          	mov    %eax,0x50(%esp)
  200563:	f6 04 24 04          	testb  $0x4,(%esp)
  200567:	75 04                	jne    20056d <console_vprintf+0x346>
  200569:	85 f6                	test   %esi,%esi
  20056b:	7f df                	jg     20054c <console_vprintf+0x325>
		if (negative)
  20056d:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  200572:	74 2f                	je     2005a3 <console_vprintf+0x37c>
			cursor = console_putc(cursor, negative, color);
  200574:	0f b6 54 24 18       	movzbl 0x18(%esp),%edx
  200579:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  20057d:	8b 44 24 50          	mov    0x50(%esp),%eax
  200581:	e8 15 fc ff ff       	call   20019b <console_putc>
  200586:	89 44 24 50          	mov    %eax,0x50(%esp)
  20058a:	eb 17                	jmp    2005a3 <console_vprintf+0x37c>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  20058c:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  200590:	ba 30 00 00 00       	mov    $0x30,%edx
  200595:	4b                   	dec    %ebx
  200596:	8b 44 24 50          	mov    0x50(%esp),%eax
  20059a:	e8 fc fb ff ff       	call   20019b <console_putc>
  20059f:	89 44 24 50          	mov    %eax,0x50(%esp)
  2005a3:	85 db                	test   %ebx,%ebx
  2005a5:	7f e5                	jg     20058c <console_vprintf+0x365>
  2005a7:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  2005ab:	eb 19                	jmp    2005c6 <console_vprintf+0x39f>
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  2005ad:	0f b6 53 ff          	movzbl 0xffffffff(%ebx),%edx
  2005b1:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  2005b5:	8b 44 24 50          	mov    0x50(%esp),%eax
  2005b9:	e8 dd fb ff ff       	call   20019b <console_putc>
  2005be:	ff 4c 24 10          	decl   0x10(%esp)
  2005c2:	89 44 24 50          	mov    %eax,0x50(%esp)
  2005c6:	43                   	inc    %ebx
  2005c7:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  2005cc:	7f df                	jg     2005ad <console_vprintf+0x386>
  2005ce:	eb 17                	jmp    2005e7 <console_vprintf+0x3c0>
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  2005d0:	8b 4c 24 54          	mov    0x54(%esp),%ecx
  2005d4:	ba 20 00 00 00       	mov    $0x20,%edx
  2005d9:	4e                   	dec    %esi
  2005da:	8b 44 24 50          	mov    0x50(%esp),%eax
  2005de:	e8 b8 fb ff ff       	call   20019b <console_putc>
  2005e3:	89 44 24 50          	mov    %eax,0x50(%esp)
  2005e7:	85 f6                	test   %esi,%esi
  2005e9:	7f e5                	jg     2005d0 <console_vprintf+0x3a9>
  2005eb:	45                   	inc    %ebp
  2005ec:	8a 45 00             	mov    0x0(%ebp),%al
  2005ef:	84 c0                	test   %al,%al
  2005f1:	0f 85 44 fc ff ff    	jne    20023b <console_vprintf+0x14>
  2005f7:	eb 15                	jmp    20060e <console_vprintf+0x3e7>
  2005f9:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  200600:	ff 
  200601:	c7 44 24 04 ff ff ff 	movl   $0xffffffff,0x4(%esp)
  200608:	ff 
  200609:	e9 50 fe ff ff       	jmp    20045e <console_vprintf+0x237>
	done: ;
	}

	return cursor;
}
  20060e:	8b 44 24 50          	mov    0x50(%esp),%eax
  200612:	83 c4 3c             	add    $0x3c,%esp
  200615:	5b                   	pop    %ebx
  200616:	5e                   	pop    %esi
  200617:	5f                   	pop    %edi
  200618:	5d                   	pop    %ebp
  200619:	c3                   	ret    

0020061a <console_printf>:

uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  20061a:	8d 44 24 10          	lea    0x10(%esp),%eax
  20061e:	50                   	push   %eax
  20061f:	ff 74 24 10          	pushl  0x10(%esp)
  200623:	ff 74 24 10          	pushl  0x10(%esp)
  200627:	ff 74 24 10          	pushl  0x10(%esp)
  20062b:	e8 f7 fb ff ff       	call   200227 <console_vprintf>
  200630:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  200633:	c3                   	ret    
