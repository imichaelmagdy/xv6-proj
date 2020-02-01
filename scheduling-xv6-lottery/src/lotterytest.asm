
_lotterytest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if (argc == 2){
  11:	83 39 02             	cmpl   $0x2,(%ecx)
{
  14:	8b 41 04             	mov    0x4(%ecx),%eax
  if (argc == 2){
  17:	74 05                	je     1e <main+0x1e>
    int t = atoi(argv[1]);
    settickets(t);
    while(1)
      ;
  }
  exit();
  19:	e8 74 02 00 00       	call   292 <exit>
    int t = atoi(argv[1]);
  1e:	83 ec 0c             	sub    $0xc,%esp
  21:	ff 70 04             	pushl  0x4(%eax)
  24:	e8 f7 01 00 00       	call   220 <atoi>
    settickets(t);
  29:	89 04 24             	mov    %eax,(%esp)
  2c:	e8 01 03 00 00       	call   332 <settickets>
  31:	83 c4 10             	add    $0x10,%esp
  34:	eb fe                	jmp    34 <main+0x34>
  36:	66 90                	xchg   %ax,%ax
  38:	66 90                	xchg   %ax,%ax
  3a:	66 90                	xchg   %ax,%ax
  3c:	66 90                	xchg   %ax,%ax
  3e:	66 90                	xchg   %ax,%ax

00000040 <strcpy>:
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  44:	8b 45 08             	mov    0x8(%ebp),%eax
  47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  4a:	89 c2                	mov    %eax,%edx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  50:	83 c1 01             	add    $0x1,%ecx
  53:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  57:	83 c2 01             	add    $0x1,%edx
  5a:	84 db                	test   %bl,%bl
  5c:	88 5a ff             	mov    %bl,-0x1(%edx)
  5f:	75 ef                	jne    50 <strcpy+0x10>
  61:	5b                   	pop    %ebx
  62:	5d                   	pop    %ebp
  63:	c3                   	ret    
  64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000070 <strcmp>:
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 55 08             	mov    0x8(%ebp),%edx
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  7a:	0f b6 02             	movzbl (%edx),%eax
  7d:	0f b6 19             	movzbl (%ecx),%ebx
  80:	84 c0                	test   %al,%al
  82:	75 1c                	jne    a0 <strcmp+0x30>
  84:	eb 2a                	jmp    b0 <strcmp+0x40>
  86:	8d 76 00             	lea    0x0(%esi),%esi
  89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  90:	83 c2 01             	add    $0x1,%edx
  93:	0f b6 02             	movzbl (%edx),%eax
  96:	83 c1 01             	add    $0x1,%ecx
  99:	0f b6 19             	movzbl (%ecx),%ebx
  9c:	84 c0                	test   %al,%al
  9e:	74 10                	je     b0 <strcmp+0x40>
  a0:	38 d8                	cmp    %bl,%al
  a2:	74 ec                	je     90 <strcmp+0x20>
  a4:	29 d8                	sub    %ebx,%eax
  a6:	5b                   	pop    %ebx
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  b0:	31 c0                	xor    %eax,%eax
  b2:	29 d8                	sub    %ebx,%eax
  b4:	5b                   	pop    %ebx
  b5:	5d                   	pop    %ebp
  b6:	c3                   	ret    
  b7:	89 f6                	mov    %esi,%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000c0 <strlen>:
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c6:	80 39 00             	cmpb   $0x0,(%ecx)
  c9:	74 15                	je     e0 <strlen+0x20>
  cb:	31 d2                	xor    %edx,%edx
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	83 c2 01             	add    $0x1,%edx
  d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  d7:	89 d0                	mov    %edx,%eax
  d9:	75 f5                	jne    d0 <strlen+0x10>
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	31 c0                	xor    %eax,%eax
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    
  e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000f0 <memset>:
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	89 d7                	mov    %edx,%edi
  ff:	fc                   	cld    
 100:	f3 aa                	rep stos %al,%es:(%edi)
 102:	89 d0                	mov    %edx,%eax
 104:	5f                   	pop    %edi
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	89 f6                	mov    %esi,%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <strchr>:
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 11a:	0f b6 10             	movzbl (%eax),%edx
 11d:	84 d2                	test   %dl,%dl
 11f:	74 1d                	je     13e <strchr+0x2e>
 121:	38 d3                	cmp    %dl,%bl
 123:	89 d9                	mov    %ebx,%ecx
 125:	75 0d                	jne    134 <strchr+0x24>
 127:	eb 17                	jmp    140 <strchr+0x30>
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 130:	38 ca                	cmp    %cl,%dl
 132:	74 0c                	je     140 <strchr+0x30>
 134:	83 c0 01             	add    $0x1,%eax
 137:	0f b6 10             	movzbl (%eax),%edx
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strchr+0x20>
 13e:	31 c0                	xor    %eax,%eax
 140:	5b                   	pop    %ebx
 141:	5d                   	pop    %ebp
 142:	c3                   	ret    
 143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <gets>:
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	56                   	push   %esi
 155:	53                   	push   %ebx
 156:	31 f6                	xor    %esi,%esi
 158:	89 f3                	mov    %esi,%ebx
 15a:	83 ec 1c             	sub    $0x1c,%esp
 15d:	8b 7d 08             	mov    0x8(%ebp),%edi
 160:	eb 2f                	jmp    191 <gets+0x41>
 162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 168:	8d 45 e7             	lea    -0x19(%ebp),%eax
 16b:	83 ec 04             	sub    $0x4,%esp
 16e:	6a 01                	push   $0x1
 170:	50                   	push   %eax
 171:	6a 00                	push   $0x0
 173:	e8 32 01 00 00       	call   2aa <read>
 178:	83 c4 10             	add    $0x10,%esp
 17b:	85 c0                	test   %eax,%eax
 17d:	7e 1c                	jle    19b <gets+0x4b>
 17f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 183:	83 c7 01             	add    $0x1,%edi
 186:	88 47 ff             	mov    %al,-0x1(%edi)
 189:	3c 0a                	cmp    $0xa,%al
 18b:	74 23                	je     1b0 <gets+0x60>
 18d:	3c 0d                	cmp    $0xd,%al
 18f:	74 1f                	je     1b0 <gets+0x60>
 191:	83 c3 01             	add    $0x1,%ebx
 194:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 197:	89 fe                	mov    %edi,%esi
 199:	7c cd                	jl     168 <gets+0x18>
 19b:	89 f3                	mov    %esi,%ebx
 19d:	8b 45 08             	mov    0x8(%ebp),%eax
 1a0:	c6 03 00             	movb   $0x0,(%ebx)
 1a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1a6:	5b                   	pop    %ebx
 1a7:	5e                   	pop    %esi
 1a8:	5f                   	pop    %edi
 1a9:	5d                   	pop    %ebp
 1aa:	c3                   	ret    
 1ab:	90                   	nop
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b0:	8b 75 08             	mov    0x8(%ebp),%esi
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	01 de                	add    %ebx,%esi
 1b8:	89 f3                	mov    %esi,%ebx
 1ba:	c6 03 00             	movb   $0x0,(%ebx)
 1bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c0:	5b                   	pop    %ebx
 1c1:	5e                   	pop    %esi
 1c2:	5f                   	pop    %edi
 1c3:	5d                   	pop    %ebp
 1c4:	c3                   	ret    
 1c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <stat>:
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	83 ec 08             	sub    $0x8,%esp
 1d8:	6a 00                	push   $0x0
 1da:	ff 75 08             	pushl  0x8(%ebp)
 1dd:	e8 f0 00 00 00       	call   2d2 <open>
 1e2:	83 c4 10             	add    $0x10,%esp
 1e5:	85 c0                	test   %eax,%eax
 1e7:	78 27                	js     210 <stat+0x40>
 1e9:	83 ec 08             	sub    $0x8,%esp
 1ec:	ff 75 0c             	pushl  0xc(%ebp)
 1ef:	89 c3                	mov    %eax,%ebx
 1f1:	50                   	push   %eax
 1f2:	e8 f3 00 00 00       	call   2ea <fstat>
 1f7:	89 1c 24             	mov    %ebx,(%esp)
 1fa:	89 c6                	mov    %eax,%esi
 1fc:	e8 b9 00 00 00       	call   2ba <close>
 201:	83 c4 10             	add    $0x10,%esp
 204:	8d 65 f8             	lea    -0x8(%ebp),%esp
 207:	89 f0                	mov    %esi,%eax
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret    
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	be ff ff ff ff       	mov    $0xffffffff,%esi
 215:	eb ed                	jmp    204 <stat+0x34>
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <atoi>:
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 4d 08             	mov    0x8(%ebp),%ecx
 227:	0f be 11             	movsbl (%ecx),%edx
 22a:	8d 42 d0             	lea    -0x30(%edx),%eax
 22d:	3c 09                	cmp    $0x9,%al
 22f:	b8 00 00 00 00       	mov    $0x0,%eax
 234:	77 1f                	ja     255 <atoi+0x35>
 236:	8d 76 00             	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 240:	8d 04 80             	lea    (%eax,%eax,4),%eax
 243:	83 c1 01             	add    $0x1,%ecx
 246:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 24a:	0f be 11             	movsbl (%ecx),%edx
 24d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
 255:	5b                   	pop    %ebx
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    
 258:	90                   	nop
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <memmove>:
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
 265:	8b 5d 10             	mov    0x10(%ebp),%ebx
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	8b 75 0c             	mov    0xc(%ebp),%esi
 26e:	85 db                	test   %ebx,%ebx
 270:	7e 14                	jle    286 <memmove+0x26>
 272:	31 d2                	xor    %edx,%edx
 274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 278:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 27c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 27f:	83 c2 01             	add    $0x1,%edx
 282:	39 d3                	cmp    %edx,%ebx
 284:	75 f2                	jne    278 <memmove+0x18>
 286:	5b                   	pop    %ebx
 287:	5e                   	pop    %esi
 288:	5d                   	pop    %ebp
 289:	c3                   	ret    

0000028a <fork>:
 28a:	b8 01 00 00 00       	mov    $0x1,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <exit>:
 292:	b8 02 00 00 00       	mov    $0x2,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <wait>:
 29a:	b8 03 00 00 00       	mov    $0x3,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <pipe>:
 2a2:	b8 04 00 00 00       	mov    $0x4,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <read>:
 2aa:	b8 05 00 00 00       	mov    $0x5,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <write>:
 2b2:	b8 10 00 00 00       	mov    $0x10,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <close>:
 2ba:	b8 15 00 00 00       	mov    $0x15,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <kill>:
 2c2:	b8 06 00 00 00       	mov    $0x6,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <exec>:
 2ca:	b8 07 00 00 00       	mov    $0x7,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <open>:
 2d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <mknod>:
 2da:	b8 11 00 00 00       	mov    $0x11,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <unlink>:
 2e2:	b8 12 00 00 00       	mov    $0x12,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <fstat>:
 2ea:	b8 08 00 00 00       	mov    $0x8,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <link>:
 2f2:	b8 13 00 00 00       	mov    $0x13,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mkdir>:
 2fa:	b8 14 00 00 00       	mov    $0x14,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <chdir>:
 302:	b8 09 00 00 00       	mov    $0x9,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <dup>:
 30a:	b8 0a 00 00 00       	mov    $0xa,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <getpid>:
 312:	b8 0b 00 00 00       	mov    $0xb,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <sbrk>:
 31a:	b8 0c 00 00 00       	mov    $0xc,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <sleep>:
 322:	b8 0d 00 00 00       	mov    $0xd,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <uptime>:
 32a:	b8 0e 00 00 00       	mov    $0xe,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <settickets>:
 332:	b8 16 00 00 00       	mov    $0x16,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <getpinfo>:
 33a:	b8 17 00 00 00       	mov    $0x17,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    
 342:	66 90                	xchg   %ax,%ax
 344:	66 90                	xchg   %ax,%ax
 346:	66 90                	xchg   %ax,%ax
 348:	66 90                	xchg   %ax,%ax
 34a:	66 90                	xchg   %ax,%ax
 34c:	66 90                	xchg   %ax,%ax
 34e:	66 90                	xchg   %ax,%ax

00000350 <printint>:
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 3c             	sub    $0x3c,%esp
 359:	85 d2                	test   %edx,%edx
 35b:	89 45 c0             	mov    %eax,-0x40(%ebp)
 35e:	89 d0                	mov    %edx,%eax
 360:	79 76                	jns    3d8 <printint+0x88>
 362:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 366:	74 70                	je     3d8 <printint+0x88>
 368:	f7 d8                	neg    %eax
 36a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 371:	31 f6                	xor    %esi,%esi
 373:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 376:	eb 0a                	jmp    382 <printint+0x32>
 378:	90                   	nop
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 380:	89 fe                	mov    %edi,%esi
 382:	31 d2                	xor    %edx,%edx
 384:	8d 7e 01             	lea    0x1(%esi),%edi
 387:	f7 f1                	div    %ecx
 389:	0f b6 92 50 07 00 00 	movzbl 0x750(%edx),%edx
 390:	85 c0                	test   %eax,%eax
 392:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
 395:	75 e9                	jne    380 <printint+0x30>
 397:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 39a:	85 c0                	test   %eax,%eax
 39c:	74 08                	je     3a6 <printint+0x56>
 39e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3a3:	8d 7e 02             	lea    0x2(%esi),%edi
 3a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	0f b6 06             	movzbl (%esi),%eax
 3b3:	83 ec 04             	sub    $0x4,%esp
 3b6:	83 ee 01             	sub    $0x1,%esi
 3b9:	6a 01                	push   $0x1
 3bb:	53                   	push   %ebx
 3bc:	57                   	push   %edi
 3bd:	88 45 d7             	mov    %al,-0x29(%ebp)
 3c0:	e8 ed fe ff ff       	call   2b2 <write>
 3c5:	83 c4 10             	add    $0x10,%esp
 3c8:	39 de                	cmp    %ebx,%esi
 3ca:	75 e4                	jne    3b0 <printint+0x60>
 3cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3cf:	5b                   	pop    %ebx
 3d0:	5e                   	pop    %esi
 3d1:	5f                   	pop    %edi
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3df:	eb 90                	jmp    371 <printint+0x21>
 3e1:	eb 0d                	jmp    3f0 <printf>
 3e3:	90                   	nop
 3e4:	90                   	nop
 3e5:	90                   	nop
 3e6:	90                   	nop
 3e7:	90                   	nop
 3e8:	90                   	nop
 3e9:	90                   	nop
 3ea:	90                   	nop
 3eb:	90                   	nop
 3ec:	90                   	nop
 3ed:	90                   	nop
 3ee:	90                   	nop
 3ef:	90                   	nop

000003f0 <printf>:
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	83 ec 2c             	sub    $0x2c,%esp
 3f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3fc:	0f b6 1e             	movzbl (%esi),%ebx
 3ff:	84 db                	test   %bl,%bl
 401:	0f 84 b3 00 00 00    	je     4ba <printf+0xca>
 407:	8d 45 10             	lea    0x10(%ebp),%eax
 40a:	83 c6 01             	add    $0x1,%esi
 40d:	31 ff                	xor    %edi,%edi
 40f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 412:	eb 2f                	jmp    443 <printf+0x53>
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 418:	83 f8 25             	cmp    $0x25,%eax
 41b:	0f 84 a7 00 00 00    	je     4c8 <printf+0xd8>
 421:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 424:	83 ec 04             	sub    $0x4,%esp
 427:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 42a:	6a 01                	push   $0x1
 42c:	50                   	push   %eax
 42d:	ff 75 08             	pushl  0x8(%ebp)
 430:	e8 7d fe ff ff       	call   2b2 <write>
 435:	83 c4 10             	add    $0x10,%esp
 438:	83 c6 01             	add    $0x1,%esi
 43b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 43f:	84 db                	test   %bl,%bl
 441:	74 77                	je     4ba <printf+0xca>
 443:	85 ff                	test   %edi,%edi
 445:	0f be cb             	movsbl %bl,%ecx
 448:	0f b6 c3             	movzbl %bl,%eax
 44b:	74 cb                	je     418 <printf+0x28>
 44d:	83 ff 25             	cmp    $0x25,%edi
 450:	75 e6                	jne    438 <printf+0x48>
 452:	83 f8 64             	cmp    $0x64,%eax
 455:	0f 84 05 01 00 00    	je     560 <printf+0x170>
 45b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 461:	83 f9 70             	cmp    $0x70,%ecx
 464:	74 72                	je     4d8 <printf+0xe8>
 466:	83 f8 73             	cmp    $0x73,%eax
 469:	0f 84 99 00 00 00    	je     508 <printf+0x118>
 46f:	83 f8 63             	cmp    $0x63,%eax
 472:	0f 84 08 01 00 00    	je     580 <printf+0x190>
 478:	83 f8 25             	cmp    $0x25,%eax
 47b:	0f 84 ef 00 00 00    	je     570 <printf+0x180>
 481:	8d 45 e7             	lea    -0x19(%ebp),%eax
 484:	83 ec 04             	sub    $0x4,%esp
 487:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 48b:	6a 01                	push   $0x1
 48d:	50                   	push   %eax
 48e:	ff 75 08             	pushl  0x8(%ebp)
 491:	e8 1c fe ff ff       	call   2b2 <write>
 496:	83 c4 0c             	add    $0xc,%esp
 499:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 49c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 49f:	6a 01                	push   $0x1
 4a1:	50                   	push   %eax
 4a2:	ff 75 08             	pushl  0x8(%ebp)
 4a5:	83 c6 01             	add    $0x1,%esi
 4a8:	31 ff                	xor    %edi,%edi
 4aa:	e8 03 fe ff ff       	call   2b2 <write>
 4af:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4b3:	83 c4 10             	add    $0x10,%esp
 4b6:	84 db                	test   %bl,%bl
 4b8:	75 89                	jne    443 <printf+0x53>
 4ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4bd:	5b                   	pop    %ebx
 4be:	5e                   	pop    %esi
 4bf:	5f                   	pop    %edi
 4c0:	5d                   	pop    %ebp
 4c1:	c3                   	ret    
 4c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4c8:	bf 25 00 00 00       	mov    $0x25,%edi
 4cd:	e9 66 ff ff ff       	jmp    438 <printf+0x48>
 4d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4d8:	83 ec 0c             	sub    $0xc,%esp
 4db:	b9 10 00 00 00       	mov    $0x10,%ecx
 4e0:	6a 00                	push   $0x0
 4e2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4e5:	8b 45 08             	mov    0x8(%ebp),%eax
 4e8:	8b 17                	mov    (%edi),%edx
 4ea:	e8 61 fe ff ff       	call   350 <printint>
 4ef:	89 f8                	mov    %edi,%eax
 4f1:	83 c4 10             	add    $0x10,%esp
 4f4:	31 ff                	xor    %edi,%edi
 4f6:	83 c0 04             	add    $0x4,%eax
 4f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4fc:	e9 37 ff ff ff       	jmp    438 <printf+0x48>
 501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 508:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 50b:	8b 08                	mov    (%eax),%ecx
 50d:	83 c0 04             	add    $0x4,%eax
 510:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 513:	85 c9                	test   %ecx,%ecx
 515:	0f 84 8e 00 00 00    	je     5a9 <printf+0x1b9>
 51b:	0f b6 01             	movzbl (%ecx),%eax
 51e:	31 ff                	xor    %edi,%edi
 520:	89 cb                	mov    %ecx,%ebx
 522:	84 c0                	test   %al,%al
 524:	0f 84 0e ff ff ff    	je     438 <printf+0x48>
 52a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 52d:	89 de                	mov    %ebx,%esi
 52f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 532:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 535:	8d 76 00             	lea    0x0(%esi),%esi
 538:	83 ec 04             	sub    $0x4,%esp
 53b:	83 c6 01             	add    $0x1,%esi
 53e:	88 45 e3             	mov    %al,-0x1d(%ebp)
 541:	6a 01                	push   $0x1
 543:	57                   	push   %edi
 544:	53                   	push   %ebx
 545:	e8 68 fd ff ff       	call   2b2 <write>
 54a:	0f b6 06             	movzbl (%esi),%eax
 54d:	83 c4 10             	add    $0x10,%esp
 550:	84 c0                	test   %al,%al
 552:	75 e4                	jne    538 <printf+0x148>
 554:	8b 75 d0             	mov    -0x30(%ebp),%esi
 557:	31 ff                	xor    %edi,%edi
 559:	e9 da fe ff ff       	jmp    438 <printf+0x48>
 55e:	66 90                	xchg   %ax,%ax
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	b9 0a 00 00 00       	mov    $0xa,%ecx
 568:	6a 01                	push   $0x1
 56a:	e9 73 ff ff ff       	jmp    4e2 <printf+0xf2>
 56f:	90                   	nop
 570:	83 ec 04             	sub    $0x4,%esp
 573:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 576:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 579:	6a 01                	push   $0x1
 57b:	e9 21 ff ff ff       	jmp    4a1 <printf+0xb1>
 580:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 583:	83 ec 04             	sub    $0x4,%esp
 586:	8b 07                	mov    (%edi),%eax
 588:	6a 01                	push   $0x1
 58a:	83 c7 04             	add    $0x4,%edi
 58d:	88 45 e4             	mov    %al,-0x1c(%ebp)
 590:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 593:	50                   	push   %eax
 594:	ff 75 08             	pushl  0x8(%ebp)
 597:	e8 16 fd ff ff       	call   2b2 <write>
 59c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 59f:	83 c4 10             	add    $0x10,%esp
 5a2:	31 ff                	xor    %edi,%edi
 5a4:	e9 8f fe ff ff       	jmp    438 <printf+0x48>
 5a9:	bb 48 07 00 00       	mov    $0x748,%ebx
 5ae:	b8 28 00 00 00       	mov    $0x28,%eax
 5b3:	e9 72 ff ff ff       	jmp    52a <printf+0x13a>
 5b8:	66 90                	xchg   %ax,%ax
 5ba:	66 90                	xchg   %ax,%ax
 5bc:	66 90                	xchg   %ax,%ax
 5be:	66 90                	xchg   %ax,%ax

000005c0 <free>:
 5c0:	55                   	push   %ebp
 5c1:	a1 f4 09 00 00       	mov    0x9f4,%eax
 5c6:	89 e5                	mov    %esp,%ebp
 5c8:	57                   	push   %edi
 5c9:	56                   	push   %esi
 5ca:	53                   	push   %ebx
 5cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5d8:	39 c8                	cmp    %ecx,%eax
 5da:	8b 10                	mov    (%eax),%edx
 5dc:	73 32                	jae    610 <free+0x50>
 5de:	39 d1                	cmp    %edx,%ecx
 5e0:	72 04                	jb     5e6 <free+0x26>
 5e2:	39 d0                	cmp    %edx,%eax
 5e4:	72 32                	jb     618 <free+0x58>
 5e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5ec:	39 fa                	cmp    %edi,%edx
 5ee:	74 30                	je     620 <free+0x60>
 5f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5f3:	8b 50 04             	mov    0x4(%eax),%edx
 5f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5f9:	39 f1                	cmp    %esi,%ecx
 5fb:	74 3a                	je     637 <free+0x77>
 5fd:	89 08                	mov    %ecx,(%eax)
 5ff:	a3 f4 09 00 00       	mov    %eax,0x9f4
 604:	5b                   	pop    %ebx
 605:	5e                   	pop    %esi
 606:	5f                   	pop    %edi
 607:	5d                   	pop    %ebp
 608:	c3                   	ret    
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 610:	39 d0                	cmp    %edx,%eax
 612:	72 04                	jb     618 <free+0x58>
 614:	39 d1                	cmp    %edx,%ecx
 616:	72 ce                	jb     5e6 <free+0x26>
 618:	89 d0                	mov    %edx,%eax
 61a:	eb bc                	jmp    5d8 <free+0x18>
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 620:	03 72 04             	add    0x4(%edx),%esi
 623:	89 73 fc             	mov    %esi,-0x4(%ebx)
 626:	8b 10                	mov    (%eax),%edx
 628:	8b 12                	mov    (%edx),%edx
 62a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 62d:	8b 50 04             	mov    0x4(%eax),%edx
 630:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 633:	39 f1                	cmp    %esi,%ecx
 635:	75 c6                	jne    5fd <free+0x3d>
 637:	03 53 fc             	add    -0x4(%ebx),%edx
 63a:	a3 f4 09 00 00       	mov    %eax,0x9f4
 63f:	89 50 04             	mov    %edx,0x4(%eax)
 642:	8b 53 f8             	mov    -0x8(%ebx),%edx
 645:	89 10                	mov    %edx,(%eax)
 647:	5b                   	pop    %ebx
 648:	5e                   	pop    %esi
 649:	5f                   	pop    %edi
 64a:	5d                   	pop    %ebp
 64b:	c3                   	ret    
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000650 <malloc>:
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
 656:	83 ec 0c             	sub    $0xc,%esp
 659:	8b 45 08             	mov    0x8(%ebp),%eax
 65c:	8b 15 f4 09 00 00    	mov    0x9f4,%edx
 662:	8d 78 07             	lea    0x7(%eax),%edi
 665:	c1 ef 03             	shr    $0x3,%edi
 668:	83 c7 01             	add    $0x1,%edi
 66b:	85 d2                	test   %edx,%edx
 66d:	0f 84 9d 00 00 00    	je     710 <malloc+0xc0>
 673:	8b 02                	mov    (%edx),%eax
 675:	8b 48 04             	mov    0x4(%eax),%ecx
 678:	39 cf                	cmp    %ecx,%edi
 67a:	76 6c                	jbe    6e8 <malloc+0x98>
 67c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 682:	bb 00 10 00 00       	mov    $0x1000,%ebx
 687:	0f 43 df             	cmovae %edi,%ebx
 68a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 691:	eb 0e                	jmp    6a1 <malloc+0x51>
 693:	90                   	nop
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 698:	8b 02                	mov    (%edx),%eax
 69a:	8b 48 04             	mov    0x4(%eax),%ecx
 69d:	39 f9                	cmp    %edi,%ecx
 69f:	73 47                	jae    6e8 <malloc+0x98>
 6a1:	39 05 f4 09 00 00    	cmp    %eax,0x9f4
 6a7:	89 c2                	mov    %eax,%edx
 6a9:	75 ed                	jne    698 <malloc+0x48>
 6ab:	83 ec 0c             	sub    $0xc,%esp
 6ae:	56                   	push   %esi
 6af:	e8 66 fc ff ff       	call   31a <sbrk>
 6b4:	83 c4 10             	add    $0x10,%esp
 6b7:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ba:	74 1c                	je     6d8 <malloc+0x88>
 6bc:	89 58 04             	mov    %ebx,0x4(%eax)
 6bf:	83 ec 0c             	sub    $0xc,%esp
 6c2:	83 c0 08             	add    $0x8,%eax
 6c5:	50                   	push   %eax
 6c6:	e8 f5 fe ff ff       	call   5c0 <free>
 6cb:	8b 15 f4 09 00 00    	mov    0x9f4,%edx
 6d1:	83 c4 10             	add    $0x10,%esp
 6d4:	85 d2                	test   %edx,%edx
 6d6:	75 c0                	jne    698 <malloc+0x48>
 6d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6db:	31 c0                	xor    %eax,%eax
 6dd:	5b                   	pop    %ebx
 6de:	5e                   	pop    %esi
 6df:	5f                   	pop    %edi
 6e0:	5d                   	pop    %ebp
 6e1:	c3                   	ret    
 6e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6e8:	39 cf                	cmp    %ecx,%edi
 6ea:	74 54                	je     740 <malloc+0xf0>
 6ec:	29 f9                	sub    %edi,%ecx
 6ee:	89 48 04             	mov    %ecx,0x4(%eax)
 6f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 6f4:	89 78 04             	mov    %edi,0x4(%eax)
 6f7:	89 15 f4 09 00 00    	mov    %edx,0x9f4
 6fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 700:	83 c0 08             	add    $0x8,%eax
 703:	5b                   	pop    %ebx
 704:	5e                   	pop    %esi
 705:	5f                   	pop    %edi
 706:	5d                   	pop    %ebp
 707:	c3                   	ret    
 708:	90                   	nop
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 710:	c7 05 f4 09 00 00 f8 	movl   $0x9f8,0x9f4
 717:	09 00 00 
 71a:	c7 05 f8 09 00 00 f8 	movl   $0x9f8,0x9f8
 721:	09 00 00 
 724:	b8 f8 09 00 00       	mov    $0x9f8,%eax
 729:	c7 05 fc 09 00 00 00 	movl   $0x0,0x9fc
 730:	00 00 00 
 733:	e9 44 ff ff ff       	jmp    67c <malloc+0x2c>
 738:	90                   	nop
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 740:	8b 08                	mov    (%eax),%ecx
 742:	89 0a                	mov    %ecx,(%edx)
 744:	eb b1                	jmp    6f7 <malloc+0xa7>
