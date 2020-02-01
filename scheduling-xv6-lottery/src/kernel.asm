
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 90 bf 10 80       	mov    $0x8010bf90,%esp
8010002d:	b8 a0 2e 10 80       	mov    $0x80102ea0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb d4 bf 10 80       	mov    $0x8010bfd4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 80 72 10 80       	push   $0x80107280
80100051:	68 a0 bf 10 80       	push   $0x8010bfa0
80100056:	e8 e5 44 00 00       	call   80104540 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 ec 06 11 80 9c 	movl   $0x8011069c,0x801106ec
80100062:	06 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 f0 06 11 80 9c 	movl   $0x8011069c,0x801106f0
8010006c:	06 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 9c 06 11 80       	mov    $0x8011069c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 9c 06 11 80 	movl   $0x8011069c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 72 10 80       	push   $0x80107287
80100097:	50                   	push   %eax
80100098:	e8 73 43 00 00       	call   80104410 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 f0 06 11 80       	mov    0x801106f0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d f0 06 11 80    	mov    %ebx,0x801106f0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 9c 06 11 80       	cmp    $0x8011069c,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 a0 bf 10 80       	push   $0x8010bfa0
801000e4:	e8 97 45 00 00       	call   80104680 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d f0 06 11 80    	mov    0x801106f0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 9c 06 11 80    	cmp    $0x8011069c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 9c 06 11 80    	cmp    $0x8011069c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d ec 06 11 80    	mov    0x801106ec,%ebx
80100126:	81 fb 9c 06 11 80    	cmp    $0x8011069c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 9c 06 11 80    	cmp    $0x8011069c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 a0 bf 10 80       	push   $0x8010bfa0
80100162:	e8 d9 45 00 00       	call   80104740 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 de 42 00 00       	call   80104450 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 9d 1f 00 00       	call   80102120 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 8e 72 10 80       	push   $0x8010728e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 3d 43 00 00       	call   801044f0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 57 1f 00 00       	jmp    80102120 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 72 10 80       	push   $0x8010729f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 fc 42 00 00       	call   801044f0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 ac 42 00 00       	call   801044b0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 a0 bf 10 80 	movl   $0x8010bfa0,(%esp)
8010020b:	e8 70 44 00 00       	call   80104680 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 f0 06 11 80       	mov    0x801106f0,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 9c 06 11 80 	movl   $0x8011069c,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 f0 06 11 80       	mov    0x801106f0,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d f0 06 11 80    	mov    %ebx,0x801106f0
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 a0 bf 10 80 	movl   $0x8010bfa0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 df 44 00 00       	jmp    80104740 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 72 10 80       	push   $0x801072a6
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 db 14 00 00       	call   80101760 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 ef 43 00 00       	call   80104680 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 80 09 11 80    	mov    0x80110980,%edx
801002a7:	39 15 84 09 11 80    	cmp    %edx,0x80110984
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 80 09 11 80       	push   $0x80110980
801002c5:	e8 06 3c 00 00       	call   80103ed0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 80 09 11 80    	mov    0x80110980,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 84 09 11 80    	cmp    0x80110984,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 e0 35 00 00       	call   801038c0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 4c 44 00 00       	call   80104740 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 84 13 00 00       	call   80101680 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 80 09 11 80       	mov    %eax,0x80110980
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 00 09 11 80 	movsbl -0x7feef700(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 ee 43 00 00       	call   80104740 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 26 13 00 00       	call   80101680 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 80 09 11 80    	mov    %edx,0x80110980
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 82 23 00 00       	call   80102730 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 ad 72 10 80       	push   $0x801072ad
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 ff 7b 10 80 	movl   $0x80107bff,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 83 41 00 00       	call   80104560 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 c1 72 10 80       	push   $0x801072c1
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 41 5a 00 00       	call   80105e80 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 8f 59 00 00       	call   80105e80 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 83 59 00 00       	call   80105e80 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 77 59 00 00       	call   80105e80 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 17 43 00 00       	call   80104840 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 4a 42 00 00       	call   80104790 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 c5 72 10 80       	push   $0x801072c5
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 f0 72 10 80 	movzbl -0x7fef8d10(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 4c 11 00 00       	call   80101760 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 60 40 00 00       	call   80104680 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 f4 40 00 00       	call   80104740 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 2b 10 00 00       	call   80101680 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 1c 40 00 00       	call   80104740 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba d8 72 10 80       	mov    $0x801072d8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 8b 3e 00 00       	call   80104680 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 df 72 10 80       	push   $0x801072df
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 58 3e 00 00       	call   80104680 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 88 09 11 80       	mov    0x80110988,%eax
80100856:	3b 05 84 09 11 80    	cmp    0x80110984,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 88 09 11 80       	mov    %eax,0x80110988
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 b3 3e 00 00       	call   80104740 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 88 09 11 80       	mov    0x80110988,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 80 09 11 80    	sub    0x80110980,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 88 09 11 80    	mov    %edx,0x80110988
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 00 09 11 80    	mov    %cl,-0x7feef700(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 80 09 11 80       	mov    0x80110980,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 88 09 11 80    	cmp    %eax,0x80110988
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 84 09 11 80       	mov    %eax,0x80110984
          wakeup(&input.r);
80100911:	68 80 09 11 80       	push   $0x80110980
80100916:	e8 75 37 00 00       	call   80104090 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 88 09 11 80       	mov    0x80110988,%eax
8010093d:	39 05 84 09 11 80    	cmp    %eax,0x80110984
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 88 09 11 80       	mov    %eax,0x80110988
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 88 09 11 80       	mov    0x80110988,%eax
80100964:	3b 05 84 09 11 80    	cmp    0x80110984,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 00 09 11 80 0a 	cmpb   $0xa,-0x7feef700(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 d4 37 00 00       	jmp    80104170 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 00 09 11 80 0a 	movb   $0xa,-0x7feef700(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 88 09 11 80       	mov    0x80110988,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 e8 72 10 80       	push   $0x801072e8
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 6b 3b 00 00       	call   80104540 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 4c 13 11 80 00 	movl   $0x80100600,0x8011134c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 48 13 11 80 70 	movl   $0x80100270,0x80111348
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 d2 18 00 00       	call   801022d0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 9f 2e 00 00       	call   801038c0 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 74 21 00 00       	call   80102ba0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 a9 14 00 00       	call   80101ee0 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 33 0c 00 00       	call   80101680 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 02 0f 00 00       	call   80101960 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 a1 0e 00 00       	call   80101910 <iunlockput>
    end_op();
80100a6f:	e8 9c 21 00 00       	call   80102c10 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 37 65 00 00       	call   80106fd0 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8c 02 00 00    	je     80100d4b <exec+0x33b>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 f5 62 00 00       	call   80106df0 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 03 62 00 00       	call   80106d30 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 03 0e 00 00       	call   80101960 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 d9 63 00 00       	call   80106f50 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 76 0d 00 00       	call   80101910 <iunlockput>
  end_op();
80100b9a:	e8 71 20 00 00       	call   80102c10 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 41 62 00 00       	call   80106df0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 8a 63 00 00       	call   80106f50 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 38 20 00 00       	call   80102c10 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 01 73 10 80       	push   $0x80107301
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 65 64 00 00       	call   80107070 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 72 3d 00 00       	call   801049b0 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 5f 3d 00 00       	call   801049b0 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 6e 65 00 00       	call   801071d0 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 04 65 00 00       	call   801071d0 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 61 3c 00 00       	call   80104970 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d1f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d22:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d28:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d2e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d31:	89 0c 24             	mov    %ecx,(%esp)
80100d34:	e8 67 5e 00 00       	call   80106ba0 <switchuvm>
  freevm(oldpgdir);
80100d39:	89 3c 24             	mov    %edi,(%esp)
80100d3c:	e8 0f 62 00 00       	call   80106f50 <freevm>
  return 0;
80100d41:	83 c4 10             	add    $0x10,%esp
80100d44:	31 c0                	xor    %eax,%eax
80100d46:	e9 31 fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4b:	be 00 20 00 00       	mov    $0x2000,%esi
80100d50:	e9 3c fe ff ff       	jmp    80100b91 <exec+0x181>
80100d55:	66 90                	xchg   %ax,%ax
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 0d 73 10 80       	push   $0x8010730d
80100d6b:	68 a0 09 11 80       	push   $0x801109a0
80100d70:	e8 cb 37 00 00       	call   80104540 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb d4 09 11 80       	mov    $0x801109d4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 a0 09 11 80       	push   $0x801109a0
80100d91:	e8 ea 38 00 00       	call   80104680 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 34 13 11 80    	cmp    $0x80111334,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 a0 09 11 80       	push   $0x801109a0
80100dc1:	e8 7a 39 00 00       	call   80104740 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 a0 09 11 80       	push   $0x801109a0
80100dda:	e8 61 39 00 00       	call   80104740 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 a0 09 11 80       	push   $0x801109a0
80100dff:	e8 7c 38 00 00       	call   80104680 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 a0 09 11 80       	push   $0x801109a0
80100e1c:	e8 1f 39 00 00       	call   80104740 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 14 73 10 80       	push   $0x80107314
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 a0 09 11 80       	push   $0x801109a0
80100e51:	e8 2a 38 00 00       	call   80104680 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 a0 09 11 80 	movl   $0x801109a0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 bf 38 00 00       	jmp    80104740 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 a0 09 11 80       	push   $0x801109a0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 93 38 00 00       	call   80104740 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 7a 24 00 00       	call   80103350 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 bb 1c 00 00       	call   80102ba0 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 c0 08 00 00       	call   801017b0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 11 1d 00 00       	jmp    80102c10 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 1c 73 10 80       	push   $0x8010731c
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 56 07 00 00       	call   80101680 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 f9 09 00 00       	call   80101930 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 20 08 00 00       	call   80101760 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 f1 06 00 00       	call   80101680 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 c4 09 00 00       	call   80101960 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 ad 07 00 00       	call   80101760 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 2e 25 00 00       	jmp    80103500 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 26 73 10 80       	push   $0x80107326
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 17 07 00 00       	call   80101760 <iunlock>
      end_op();
80101049:	e8 c2 1b 00 00       	call   80102c10 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 25 1b 00 00       	call   80102ba0 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 fa 05 00 00       	call   80101680 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 c8 09 00 00       	call   80101a60 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 b3 06 00 00       	call   80101760 <iunlock>
      end_op();
801010ad:	e8 5e 1b 00 00       	call   80102c10 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 fe 22 00 00       	jmp    801033f0 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 2f 73 10 80       	push   $0x8010732f
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 35 73 10 80       	push   $0x80107335
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	56                   	push   %esi
80101114:	53                   	push   %ebx
80101115:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101117:	c1 ea 0c             	shr    $0xc,%edx
8010111a:	03 15 b8 13 11 80    	add    0x801113b8,%edx
80101120:	83 ec 08             	sub    $0x8,%esp
80101123:	52                   	push   %edx
80101124:	50                   	push   %eax
80101125:	e8 a6 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010112a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010112c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010112f:	ba 01 00 00 00       	mov    $0x1,%edx
80101134:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101137:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010113d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101140:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101142:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101147:	85 d1                	test   %edx,%ecx
80101149:	74 25                	je     80101170 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010114b:	f7 d2                	not    %edx
8010114d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010114f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101152:	21 ca                	and    %ecx,%edx
80101154:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101158:	56                   	push   %esi
80101159:	e8 12 1c 00 00       	call   80102d70 <log_write>
  brelse(bp);
8010115e:	89 34 24             	mov    %esi,(%esp)
80101161:	e8 7a f0 ff ff       	call   801001e0 <brelse>
}
80101166:	83 c4 10             	add    $0x10,%esp
80101169:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010116c:	5b                   	pop    %ebx
8010116d:	5e                   	pop    %esi
8010116e:	5d                   	pop    %ebp
8010116f:	c3                   	ret    
    panic("freeing free block");
80101170:	83 ec 0c             	sub    $0xc,%esp
80101173:	68 3f 73 10 80       	push   $0x8010733f
80101178:	e8 13 f2 ff ff       	call   80100390 <panic>
8010117d:	8d 76 00             	lea    0x0(%esi),%esi

80101180 <balloc>:
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101189:	8b 0d a0 13 11 80    	mov    0x801113a0,%ecx
{
8010118f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101192:	85 c9                	test   %ecx,%ecx
80101194:	0f 84 87 00 00 00    	je     80101221 <balloc+0xa1>
8010119a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a4:	83 ec 08             	sub    $0x8,%esp
801011a7:	89 f0                	mov    %esi,%eax
801011a9:	c1 f8 0c             	sar    $0xc,%eax
801011ac:	03 05 b8 13 11 80    	add    0x801113b8,%eax
801011b2:	50                   	push   %eax
801011b3:	ff 75 d8             	pushl  -0x28(%ebp)
801011b6:	e8 15 ef ff ff       	call   801000d0 <bread>
801011bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011be:	a1 a0 13 11 80       	mov    0x801113a0,%eax
801011c3:	83 c4 10             	add    $0x10,%esp
801011c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011c9:	31 c0                	xor    %eax,%eax
801011cb:	eb 2f                	jmp    801011fc <balloc+0x7c>
801011cd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011d0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011d5:	bb 01 00 00 00       	mov    $0x1,%ebx
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011df:	89 c1                	mov    %eax,%ecx
801011e1:	c1 f9 03             	sar    $0x3,%ecx
801011e4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011e9:	85 df                	test   %ebx,%edi
801011eb:	89 fa                	mov    %edi,%edx
801011ed:	74 41                	je     80101230 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ef:	83 c0 01             	add    $0x1,%eax
801011f2:	83 c6 01             	add    $0x1,%esi
801011f5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fa:	74 05                	je     80101201 <balloc+0x81>
801011fc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ff:	77 cf                	ja     801011d0 <balloc+0x50>
    brelse(bp);
80101201:	83 ec 0c             	sub    $0xc,%esp
80101204:	ff 75 e4             	pushl  -0x1c(%ebp)
80101207:	e8 d4 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	39 05 a0 13 11 80    	cmp    %eax,0x801113a0
8010121f:	77 80                	ja     801011a1 <balloc+0x21>
  panic("balloc: out of blocks");
80101221:	83 ec 0c             	sub    $0xc,%esp
80101224:	68 52 73 10 80       	push   $0x80107352
80101229:	e8 62 f1 ff ff       	call   80100390 <panic>
8010122e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101230:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101233:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101236:	09 da                	or     %ebx,%edx
80101238:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010123c:	57                   	push   %edi
8010123d:	e8 2e 1b 00 00       	call   80102d70 <log_write>
        brelse(bp);
80101242:	89 3c 24             	mov    %edi,(%esp)
80101245:	e8 96 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010124a:	58                   	pop    %eax
8010124b:	5a                   	pop    %edx
8010124c:	56                   	push   %esi
8010124d:	ff 75 d8             	pushl  -0x28(%ebp)
80101250:	e8 7b ee ff ff       	call   801000d0 <bread>
80101255:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101257:	8d 40 5c             	lea    0x5c(%eax),%eax
8010125a:	83 c4 0c             	add    $0xc,%esp
8010125d:	68 00 02 00 00       	push   $0x200
80101262:	6a 00                	push   $0x0
80101264:	50                   	push   %eax
80101265:	e8 26 35 00 00       	call   80104790 <memset>
  log_write(bp);
8010126a:	89 1c 24             	mov    %ebx,(%esp)
8010126d:	e8 fe 1a 00 00       	call   80102d70 <log_write>
  brelse(bp);
80101272:	89 1c 24             	mov    %ebx,(%esp)
80101275:	e8 66 ef ff ff       	call   801001e0 <brelse>
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010128a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101290 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	57                   	push   %edi
80101294:	56                   	push   %esi
80101295:	53                   	push   %ebx
80101296:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101298:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010129a:	bb f4 13 11 80       	mov    $0x801113f4,%ebx
{
8010129f:	83 ec 28             	sub    $0x28,%esp
801012a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012a5:	68 c0 13 11 80       	push   $0x801113c0
801012aa:	e8 d1 33 00 00       	call   80104680 <acquire>
801012af:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012b5:	eb 17                	jmp    801012ce <iget+0x3e>
801012b7:	89 f6                	mov    %esi,%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801012c0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012c6:	81 fb 14 30 11 80    	cmp    $0x80113014,%ebx
801012cc:	73 22                	jae    801012f0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012ce:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012d1:	85 c9                	test   %ecx,%ecx
801012d3:	7e 04                	jle    801012d9 <iget+0x49>
801012d5:	39 3b                	cmp    %edi,(%ebx)
801012d7:	74 4f                	je     80101328 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012d9:	85 f6                	test   %esi,%esi
801012db:	75 e3                	jne    801012c0 <iget+0x30>
801012dd:	85 c9                	test   %ecx,%ecx
801012df:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012e8:	81 fb 14 30 11 80    	cmp    $0x80113014,%ebx
801012ee:	72 de                	jb     801012ce <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012f0:	85 f6                	test   %esi,%esi
801012f2:	74 5b                	je     8010134f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012f4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801012f7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012f9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012fc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101303:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010130a:	68 c0 13 11 80       	push   $0x801113c0
8010130f:	e8 2c 34 00 00       	call   80104740 <release>

  return ip;
80101314:	83 c4 10             	add    $0x10,%esp
}
80101317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131a:	89 f0                	mov    %esi,%eax
8010131c:	5b                   	pop    %ebx
8010131d:	5e                   	pop    %esi
8010131e:	5f                   	pop    %edi
8010131f:	5d                   	pop    %ebp
80101320:	c3                   	ret    
80101321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101328:	39 53 04             	cmp    %edx,0x4(%ebx)
8010132b:	75 ac                	jne    801012d9 <iget+0x49>
      release(&icache.lock);
8010132d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101330:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101333:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101335:	68 c0 13 11 80       	push   $0x801113c0
      ip->ref++;
8010133a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010133d:	e8 fe 33 00 00       	call   80104740 <release>
      return ip;
80101342:	83 c4 10             	add    $0x10,%esp
}
80101345:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101348:	89 f0                	mov    %esi,%eax
8010134a:	5b                   	pop    %ebx
8010134b:	5e                   	pop    %esi
8010134c:	5f                   	pop    %edi
8010134d:	5d                   	pop    %ebp
8010134e:	c3                   	ret    
    panic("iget: no inodes");
8010134f:	83 ec 0c             	sub    $0xc,%esp
80101352:	68 68 73 10 80       	push   $0x80107368
80101357:	e8 34 f0 ff ff       	call   80100390 <panic>
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101360 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	89 c6                	mov    %eax,%esi
80101368:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010136b:	83 fa 0b             	cmp    $0xb,%edx
8010136e:	77 18                	ja     80101388 <bmap+0x28>
80101370:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101373:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101376:	85 db                	test   %ebx,%ebx
80101378:	74 76                	je     801013f0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137d:	89 d8                	mov    %ebx,%eax
8010137f:	5b                   	pop    %ebx
80101380:	5e                   	pop    %esi
80101381:	5f                   	pop    %edi
80101382:	5d                   	pop    %ebp
80101383:	c3                   	ret    
80101384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101388:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010138b:	83 fb 7f             	cmp    $0x7f,%ebx
8010138e:	0f 87 90 00 00 00    	ja     80101424 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101394:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010139a:	8b 00                	mov    (%eax),%eax
8010139c:	85 d2                	test   %edx,%edx
8010139e:	74 70                	je     80101410 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801013a0:	83 ec 08             	sub    $0x8,%esp
801013a3:	52                   	push   %edx
801013a4:	50                   	push   %eax
801013a5:	e8 26 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013aa:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013ae:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801013b1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013b3:	8b 1a                	mov    (%edx),%ebx
801013b5:	85 db                	test   %ebx,%ebx
801013b7:	75 1d                	jne    801013d6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801013b9:	8b 06                	mov    (%esi),%eax
801013bb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013be:	e8 bd fd ff ff       	call   80101180 <balloc>
801013c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013c6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801013c9:	89 c3                	mov    %eax,%ebx
801013cb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013cd:	57                   	push   %edi
801013ce:	e8 9d 19 00 00       	call   80102d70 <log_write>
801013d3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801013d6:	83 ec 0c             	sub    $0xc,%esp
801013d9:	57                   	push   %edi
801013da:	e8 01 ee ff ff       	call   801001e0 <brelse>
801013df:	83 c4 10             	add    $0x10,%esp
}
801013e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e5:	89 d8                	mov    %ebx,%eax
801013e7:	5b                   	pop    %ebx
801013e8:	5e                   	pop    %esi
801013e9:	5f                   	pop    %edi
801013ea:	5d                   	pop    %ebp
801013eb:	c3                   	ret    
801013ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801013f0:	8b 00                	mov    (%eax),%eax
801013f2:	e8 89 fd ff ff       	call   80101180 <balloc>
801013f7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801013fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801013fd:	89 c3                	mov    %eax,%ebx
}
801013ff:	89 d8                	mov    %ebx,%eax
80101401:	5b                   	pop    %ebx
80101402:	5e                   	pop    %esi
80101403:	5f                   	pop    %edi
80101404:	5d                   	pop    %ebp
80101405:	c3                   	ret    
80101406:	8d 76 00             	lea    0x0(%esi),%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101410:	e8 6b fd ff ff       	call   80101180 <balloc>
80101415:	89 c2                	mov    %eax,%edx
80101417:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010141d:	8b 06                	mov    (%esi),%eax
8010141f:	e9 7c ff ff ff       	jmp    801013a0 <bmap+0x40>
  panic("bmap: out of range");
80101424:	83 ec 0c             	sub    $0xc,%esp
80101427:	68 78 73 10 80       	push   $0x80107378
8010142c:	e8 5f ef ff ff       	call   80100390 <panic>
80101431:	eb 0d                	jmp    80101440 <readsb>
80101433:	90                   	nop
80101434:	90                   	nop
80101435:	90                   	nop
80101436:	90                   	nop
80101437:	90                   	nop
80101438:	90                   	nop
80101439:	90                   	nop
8010143a:	90                   	nop
8010143b:	90                   	nop
8010143c:	90                   	nop
8010143d:	90                   	nop
8010143e:	90                   	nop
8010143f:	90                   	nop

80101440 <readsb>:
{
80101440:	55                   	push   %ebp
80101441:	89 e5                	mov    %esp,%ebp
80101443:	56                   	push   %esi
80101444:	53                   	push   %ebx
80101445:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101448:	83 ec 08             	sub    $0x8,%esp
8010144b:	6a 01                	push   $0x1
8010144d:	ff 75 08             	pushl  0x8(%ebp)
80101450:	e8 7b ec ff ff       	call   801000d0 <bread>
80101455:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101457:	8d 40 5c             	lea    0x5c(%eax),%eax
8010145a:	83 c4 0c             	add    $0xc,%esp
8010145d:	6a 1c                	push   $0x1c
8010145f:	50                   	push   %eax
80101460:	56                   	push   %esi
80101461:	e8 da 33 00 00       	call   80104840 <memmove>
  brelse(bp);
80101466:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101469:	83 c4 10             	add    $0x10,%esp
}
8010146c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010146f:	5b                   	pop    %ebx
80101470:	5e                   	pop    %esi
80101471:	5d                   	pop    %ebp
  brelse(bp);
80101472:	e9 69 ed ff ff       	jmp    801001e0 <brelse>
80101477:	89 f6                	mov    %esi,%esi
80101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101480 <iinit>:
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	53                   	push   %ebx
80101484:	bb 00 14 11 80       	mov    $0x80111400,%ebx
80101489:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010148c:	68 8b 73 10 80       	push   $0x8010738b
80101491:	68 c0 13 11 80       	push   $0x801113c0
80101496:	e8 a5 30 00 00       	call   80104540 <initlock>
8010149b:	83 c4 10             	add    $0x10,%esp
8010149e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014a0:	83 ec 08             	sub    $0x8,%esp
801014a3:	68 92 73 10 80       	push   $0x80107392
801014a8:	53                   	push   %ebx
801014a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014af:	e8 5c 2f 00 00       	call   80104410 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014b4:	83 c4 10             	add    $0x10,%esp
801014b7:	81 fb 20 30 11 80    	cmp    $0x80113020,%ebx
801014bd:	75 e1                	jne    801014a0 <iinit+0x20>
  readsb(dev, &sb);
801014bf:	83 ec 08             	sub    $0x8,%esp
801014c2:	68 a0 13 11 80       	push   $0x801113a0
801014c7:	ff 75 08             	pushl  0x8(%ebp)
801014ca:	e8 71 ff ff ff       	call   80101440 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014cf:	ff 35 b8 13 11 80    	pushl  0x801113b8
801014d5:	ff 35 b4 13 11 80    	pushl  0x801113b4
801014db:	ff 35 b0 13 11 80    	pushl  0x801113b0
801014e1:	ff 35 ac 13 11 80    	pushl  0x801113ac
801014e7:	ff 35 a8 13 11 80    	pushl  0x801113a8
801014ed:	ff 35 a4 13 11 80    	pushl  0x801113a4
801014f3:	ff 35 a0 13 11 80    	pushl  0x801113a0
801014f9:	68 f8 73 10 80       	push   $0x801073f8
801014fe:	e8 5d f1 ff ff       	call   80100660 <cprintf>
}
80101503:	83 c4 30             	add    $0x30,%esp
80101506:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101509:	c9                   	leave  
8010150a:	c3                   	ret    
8010150b:	90                   	nop
8010150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101510 <ialloc>:
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	53                   	push   %ebx
80101516:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	83 3d a8 13 11 80 01 	cmpl   $0x1,0x801113a8
{
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	8b 75 08             	mov    0x8(%ebp),%esi
80101526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	0f 86 91 00 00 00    	jbe    801015c0 <ialloc+0xb0>
8010152f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101534:	eb 21                	jmp    80101557 <ialloc+0x47>
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101540:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101543:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101546:	57                   	push   %edi
80101547:	e8 94 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010154c:	83 c4 10             	add    $0x10,%esp
8010154f:	39 1d a8 13 11 80    	cmp    %ebx,0x801113a8
80101555:	76 69                	jbe    801015c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101557:	89 d8                	mov    %ebx,%eax
80101559:	83 ec 08             	sub    $0x8,%esp
8010155c:	c1 e8 03             	shr    $0x3,%eax
8010155f:	03 05 b4 13 11 80    	add    0x801113b4,%eax
80101565:	50                   	push   %eax
80101566:	56                   	push   %esi
80101567:	e8 64 eb ff ff       	call   801000d0 <bread>
8010156c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010156e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101570:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101573:	83 e0 07             	and    $0x7,%eax
80101576:	c1 e0 06             	shl    $0x6,%eax
80101579:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010157d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101581:	75 bd                	jne    80101540 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101589:	6a 40                	push   $0x40
8010158b:	6a 00                	push   $0x0
8010158d:	51                   	push   %ecx
8010158e:	e8 fd 31 00 00       	call   80104790 <memset>
      dip->type = type;
80101593:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010159a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010159d:	89 3c 24             	mov    %edi,(%esp)
801015a0:	e8 cb 17 00 00       	call   80102d70 <log_write>
      brelse(bp);
801015a5:	89 3c 24             	mov    %edi,(%esp)
801015a8:	e8 33 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ad:	83 c4 10             	add    $0x10,%esp
}
801015b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015b3:	89 da                	mov    %ebx,%edx
801015b5:	89 f0                	mov    %esi,%eax
}
801015b7:	5b                   	pop    %ebx
801015b8:	5e                   	pop    %esi
801015b9:	5f                   	pop    %edi
801015ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801015bb:	e9 d0 fc ff ff       	jmp    80101290 <iget>
  panic("ialloc: no inodes");
801015c0:	83 ec 0c             	sub    $0xc,%esp
801015c3:	68 98 73 10 80       	push   $0x80107398
801015c8:	e8 c3 ed ff ff       	call   80100390 <panic>
801015cd:	8d 76 00             	lea    0x0(%esi),%esi

801015d0 <iupdate>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d8:	83 ec 08             	sub    $0x8,%esp
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015de:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e1:	c1 e8 03             	shr    $0x3,%eax
801015e4:	03 05 b4 13 11 80    	add    0x801113b4,%eax
801015ea:	50                   	push   %eax
801015eb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ee:	e8 dd ea ff ff       	call   801000d0 <bread>
801015f3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015f8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ff:	83 e0 07             	and    $0x7,%eax
80101602:	c1 e0 06             	shl    $0x6,%eax
80101605:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101609:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010160c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101610:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101613:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101617:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010161b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010161f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101623:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101627:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010162a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162d:	6a 34                	push   $0x34
8010162f:	53                   	push   %ebx
80101630:	50                   	push   %eax
80101631:	e8 0a 32 00 00       	call   80104840 <memmove>
  log_write(bp);
80101636:	89 34 24             	mov    %esi,(%esp)
80101639:	e8 32 17 00 00       	call   80102d70 <log_write>
  brelse(bp);
8010163e:	89 75 08             	mov    %esi,0x8(%ebp)
80101641:	83 c4 10             	add    $0x10,%esp
}
80101644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5d                   	pop    %ebp
  brelse(bp);
8010164a:	e9 91 eb ff ff       	jmp    801001e0 <brelse>
8010164f:	90                   	nop

80101650 <idup>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	83 ec 10             	sub    $0x10,%esp
80101657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010165a:	68 c0 13 11 80       	push   $0x801113c0
8010165f:	e8 1c 30 00 00       	call   80104680 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 c0 13 11 80 	movl   $0x801113c0,(%esp)
8010166f:	e8 cc 30 00 00       	call   80104740 <release>
}
80101674:	89 d8                	mov    %ebx,%eax
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ilock>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101688:	85 db                	test   %ebx,%ebx
8010168a:	0f 84 b7 00 00 00    	je     80101747 <ilock+0xc7>
80101690:	8b 53 08             	mov    0x8(%ebx),%edx
80101693:	85 d2                	test   %edx,%edx
80101695:	0f 8e ac 00 00 00    	jle    80101747 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010169b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010169e:	83 ec 0c             	sub    $0xc,%esp
801016a1:	50                   	push   %eax
801016a2:	e8 a9 2d 00 00       	call   80104450 <acquiresleep>
  if(ip->valid == 0){
801016a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016aa:	83 c4 10             	add    $0x10,%esp
801016ad:	85 c0                	test   %eax,%eax
801016af:	74 0f                	je     801016c0 <ilock+0x40>
}
801016b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016b4:	5b                   	pop    %ebx
801016b5:	5e                   	pop    %esi
801016b6:	5d                   	pop    %ebp
801016b7:	c3                   	ret    
801016b8:	90                   	nop
801016b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016c0:	8b 43 04             	mov    0x4(%ebx),%eax
801016c3:	83 ec 08             	sub    $0x8,%esp
801016c6:	c1 e8 03             	shr    $0x3,%eax
801016c9:	03 05 b4 13 11 80    	add    0x801113b4,%eax
801016cf:	50                   	push   %eax
801016d0:	ff 33                	pushl  (%ebx)
801016d2:	e8 f9 e9 ff ff       	call   801000d0 <bread>
801016d7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016d9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101703:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101707:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010170b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010170e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101711:	6a 34                	push   $0x34
80101713:	50                   	push   %eax
80101714:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101717:	50                   	push   %eax
80101718:	e8 23 31 00 00       	call   80104840 <memmove>
    brelse(bp);
8010171d:	89 34 24             	mov    %esi,(%esp)
80101720:	e8 bb ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101725:	83 c4 10             	add    $0x10,%esp
80101728:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010172d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101734:	0f 85 77 ff ff ff    	jne    801016b1 <ilock+0x31>
      panic("ilock: no type");
8010173a:	83 ec 0c             	sub    $0xc,%esp
8010173d:	68 b0 73 10 80       	push   $0x801073b0
80101742:	e8 49 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101747:	83 ec 0c             	sub    $0xc,%esp
8010174a:	68 aa 73 10 80       	push   $0x801073aa
8010174f:	e8 3c ec ff ff       	call   80100390 <panic>
80101754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010175a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101760 <iunlock>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	74 28                	je     80101794 <iunlock+0x34>
8010176c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010176f:	83 ec 0c             	sub    $0xc,%esp
80101772:	56                   	push   %esi
80101773:	e8 78 2d 00 00       	call   801044f0 <holdingsleep>
80101778:	83 c4 10             	add    $0x10,%esp
8010177b:	85 c0                	test   %eax,%eax
8010177d:	74 15                	je     80101794 <iunlock+0x34>
8010177f:	8b 43 08             	mov    0x8(%ebx),%eax
80101782:	85 c0                	test   %eax,%eax
80101784:	7e 0e                	jle    80101794 <iunlock+0x34>
  releasesleep(&ip->lock);
80101786:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101789:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010178c:	5b                   	pop    %ebx
8010178d:	5e                   	pop    %esi
8010178e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010178f:	e9 1c 2d 00 00       	jmp    801044b0 <releasesleep>
    panic("iunlock");
80101794:	83 ec 0c             	sub    $0xc,%esp
80101797:	68 bf 73 10 80       	push   $0x801073bf
8010179c:	e8 ef eb ff ff       	call   80100390 <panic>
801017a1:	eb 0d                	jmp    801017b0 <iput>
801017a3:	90                   	nop
801017a4:	90                   	nop
801017a5:	90                   	nop
801017a6:	90                   	nop
801017a7:	90                   	nop
801017a8:	90                   	nop
801017a9:	90                   	nop
801017aa:	90                   	nop
801017ab:	90                   	nop
801017ac:	90                   	nop
801017ad:	90                   	nop
801017ae:	90                   	nop
801017af:	90                   	nop

801017b0 <iput>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	83 ec 28             	sub    $0x28,%esp
801017b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017bc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017bf:	57                   	push   %edi
801017c0:	e8 8b 2c 00 00       	call   80104450 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017c5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017c8:	83 c4 10             	add    $0x10,%esp
801017cb:	85 d2                	test   %edx,%edx
801017cd:	74 07                	je     801017d6 <iput+0x26>
801017cf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017d4:	74 32                	je     80101808 <iput+0x58>
  releasesleep(&ip->lock);
801017d6:	83 ec 0c             	sub    $0xc,%esp
801017d9:	57                   	push   %edi
801017da:	e8 d1 2c 00 00       	call   801044b0 <releasesleep>
  acquire(&icache.lock);
801017df:	c7 04 24 c0 13 11 80 	movl   $0x801113c0,(%esp)
801017e6:	e8 95 2e 00 00       	call   80104680 <acquire>
  ip->ref--;
801017eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ef:	83 c4 10             	add    $0x10,%esp
801017f2:	c7 45 08 c0 13 11 80 	movl   $0x801113c0,0x8(%ebp)
}
801017f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017fc:	5b                   	pop    %ebx
801017fd:	5e                   	pop    %esi
801017fe:	5f                   	pop    %edi
801017ff:	5d                   	pop    %ebp
  release(&icache.lock);
80101800:	e9 3b 2f 00 00       	jmp    80104740 <release>
80101805:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101808:	83 ec 0c             	sub    $0xc,%esp
8010180b:	68 c0 13 11 80       	push   $0x801113c0
80101810:	e8 6b 2e 00 00       	call   80104680 <acquire>
    int r = ip->ref;
80101815:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101818:	c7 04 24 c0 13 11 80 	movl   $0x801113c0,(%esp)
8010181f:	e8 1c 2f 00 00       	call   80104740 <release>
    if(r == 1){
80101824:	83 c4 10             	add    $0x10,%esp
80101827:	83 fe 01             	cmp    $0x1,%esi
8010182a:	75 aa                	jne    801017d6 <iput+0x26>
8010182c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101832:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101835:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101838:	89 cf                	mov    %ecx,%edi
8010183a:	eb 0b                	jmp    80101847 <iput+0x97>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101840:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101843:	39 fe                	cmp    %edi,%esi
80101845:	74 19                	je     80101860 <iput+0xb0>
    if(ip->addrs[i]){
80101847:	8b 16                	mov    (%esi),%edx
80101849:	85 d2                	test   %edx,%edx
8010184b:	74 f3                	je     80101840 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010184d:	8b 03                	mov    (%ebx),%eax
8010184f:	e8 bc f8 ff ff       	call   80101110 <bfree>
      ip->addrs[i] = 0;
80101854:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010185a:	eb e4                	jmp    80101840 <iput+0x90>
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101860:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101866:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101869:	85 c0                	test   %eax,%eax
8010186b:	75 33                	jne    801018a0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010186d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101870:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101877:	53                   	push   %ebx
80101878:	e8 53 fd ff ff       	call   801015d0 <iupdate>
      ip->type = 0;
8010187d:	31 c0                	xor    %eax,%eax
8010187f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101883:	89 1c 24             	mov    %ebx,(%esp)
80101886:	e8 45 fd ff ff       	call   801015d0 <iupdate>
      ip->valid = 0;
8010188b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101892:	83 c4 10             	add    $0x10,%esp
80101895:	e9 3c ff ff ff       	jmp    801017d6 <iput+0x26>
8010189a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018a0:	83 ec 08             	sub    $0x8,%esp
801018a3:	50                   	push   %eax
801018a4:	ff 33                	pushl  (%ebx)
801018a6:	e8 25 e8 ff ff       	call   801000d0 <bread>
801018ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018b1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018b7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ba:	83 c4 10             	add    $0x10,%esp
801018bd:	89 cf                	mov    %ecx,%edi
801018bf:	eb 0e                	jmp    801018cf <iput+0x11f>
801018c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018c8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018cb:	39 fe                	cmp    %edi,%esi
801018cd:	74 0f                	je     801018de <iput+0x12e>
      if(a[j])
801018cf:	8b 16                	mov    (%esi),%edx
801018d1:	85 d2                	test   %edx,%edx
801018d3:	74 f3                	je     801018c8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018d5:	8b 03                	mov    (%ebx),%eax
801018d7:	e8 34 f8 ff ff       	call   80101110 <bfree>
801018dc:	eb ea                	jmp    801018c8 <iput+0x118>
    brelse(bp);
801018de:	83 ec 0c             	sub    $0xc,%esp
801018e1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018e4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018e7:	e8 f4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018ec:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801018f2:	8b 03                	mov    (%ebx),%eax
801018f4:	e8 17 f8 ff ff       	call   80101110 <bfree>
    ip->addrs[NDIRECT] = 0;
801018f9:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101900:	00 00 00 
80101903:	83 c4 10             	add    $0x10,%esp
80101906:	e9 62 ff ff ff       	jmp    8010186d <iput+0xbd>
8010190b:	90                   	nop
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101910 <iunlockput>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 10             	sub    $0x10,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010191a:	53                   	push   %ebx
8010191b:	e8 40 fe ff ff       	call   80101760 <iunlock>
  iput(ip);
80101920:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101923:	83 c4 10             	add    $0x10,%esp
}
80101926:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101929:	c9                   	leave  
  iput(ip);
8010192a:	e9 81 fe ff ff       	jmp    801017b0 <iput>
8010192f:	90                   	nop

80101930 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	8b 55 08             	mov    0x8(%ebp),%edx
80101936:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101939:	8b 0a                	mov    (%edx),%ecx
8010193b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010193e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101941:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101944:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101948:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010194b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010194f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101953:	8b 52 58             	mov    0x58(%edx),%edx
80101956:	89 50 10             	mov    %edx,0x10(%eax)
}
80101959:	5d                   	pop    %ebp
8010195a:	c3                   	ret    
8010195b:	90                   	nop
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101960 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 1c             	sub    $0x1c,%esp
80101969:	8b 45 08             	mov    0x8(%ebp),%eax
8010196c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010196f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101972:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101977:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010197a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010197d:	8b 75 10             	mov    0x10(%ebp),%esi
80101980:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101983:	0f 84 a7 00 00 00    	je     80101a30 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101989:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010198c:	8b 40 58             	mov    0x58(%eax),%eax
8010198f:	39 c6                	cmp    %eax,%esi
80101991:	0f 87 ba 00 00 00    	ja     80101a51 <readi+0xf1>
80101997:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010199a:	89 f9                	mov    %edi,%ecx
8010199c:	01 f1                	add    %esi,%ecx
8010199e:	0f 82 ad 00 00 00    	jb     80101a51 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019a4:	89 c2                	mov    %eax,%edx
801019a6:	29 f2                	sub    %esi,%edx
801019a8:	39 c8                	cmp    %ecx,%eax
801019aa:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ad:	31 ff                	xor    %edi,%edi
801019af:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019b1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019b4:	74 6c                	je     80101a22 <readi+0xc2>
801019b6:	8d 76 00             	lea    0x0(%esi),%esi
801019b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019c0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019c3:	89 f2                	mov    %esi,%edx
801019c5:	c1 ea 09             	shr    $0x9,%edx
801019c8:	89 d8                	mov    %ebx,%eax
801019ca:	e8 91 f9 ff ff       	call   80101360 <bmap>
801019cf:	83 ec 08             	sub    $0x8,%esp
801019d2:	50                   	push   %eax
801019d3:	ff 33                	pushl  (%ebx)
801019d5:	e8 f6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019da:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019dd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019df:	89 f0                	mov    %esi,%eax
801019e1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019e6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019eb:	83 c4 0c             	add    $0xc,%esp
801019ee:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
801019f0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801019f4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801019f7:	29 fb                	sub    %edi,%ebx
801019f9:	39 d9                	cmp    %ebx,%ecx
801019fb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019fe:	53                   	push   %ebx
801019ff:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a00:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a02:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a05:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a07:	e8 34 2e 00 00       	call   80104840 <memmove>
    brelse(bp);
80101a0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a0f:	89 14 24             	mov    %edx,(%esp)
80101a12:	e8 c9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a17:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a20:	77 9e                	ja     801019c0 <readi+0x60>
  }
  return n;
80101a22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a28:	5b                   	pop    %ebx
80101a29:	5e                   	pop    %esi
80101a2a:	5f                   	pop    %edi
80101a2b:	5d                   	pop    %ebp
80101a2c:	c3                   	ret    
80101a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a34:	66 83 f8 09          	cmp    $0x9,%ax
80101a38:	77 17                	ja     80101a51 <readi+0xf1>
80101a3a:	8b 04 c5 40 13 11 80 	mov    -0x7feeecc0(,%eax,8),%eax
80101a41:	85 c0                	test   %eax,%eax
80101a43:	74 0c                	je     80101a51 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a45:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a4b:	5b                   	pop    %ebx
80101a4c:	5e                   	pop    %esi
80101a4d:	5f                   	pop    %edi
80101a4e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a4f:	ff e0                	jmp    *%eax
      return -1;
80101a51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a56:	eb cd                	jmp    80101a25 <readi+0xc5>
80101a58:	90                   	nop
80101a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a60 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 1c             	sub    $0x1c,%esp
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a6f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a77:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a7a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a7d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a80:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a83:	0f 84 b7 00 00 00    	je     80101b40 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a8f:	0f 82 eb 00 00 00    	jb     80101b80 <writei+0x120>
80101a95:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a98:	31 d2                	xor    %edx,%edx
80101a9a:	89 f8                	mov    %edi,%eax
80101a9c:	01 f0                	add    %esi,%eax
80101a9e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101aa1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101aa6:	0f 87 d4 00 00 00    	ja     80101b80 <writei+0x120>
80101aac:	85 d2                	test   %edx,%edx
80101aae:	0f 85 cc 00 00 00    	jne    80101b80 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ab4:	85 ff                	test   %edi,%edi
80101ab6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101abd:	74 72                	je     80101b31 <writei+0xd1>
80101abf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ac3:	89 f2                	mov    %esi,%edx
80101ac5:	c1 ea 09             	shr    $0x9,%edx
80101ac8:	89 f8                	mov    %edi,%eax
80101aca:	e8 91 f8 ff ff       	call   80101360 <bmap>
80101acf:	83 ec 08             	sub    $0x8,%esp
80101ad2:	50                   	push   %eax
80101ad3:	ff 37                	pushl  (%edi)
80101ad5:	e8 f6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101ada:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101add:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae2:	89 f0                	mov    %esi,%eax
80101ae4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ae9:	83 c4 0c             	add    $0xc,%esp
80101aec:	25 ff 01 00 00       	and    $0x1ff,%eax
80101af1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101af3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101af7:	39 d9                	cmp    %ebx,%ecx
80101af9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101afc:	53                   	push   %ebx
80101afd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b00:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b02:	50                   	push   %eax
80101b03:	e8 38 2d 00 00       	call   80104840 <memmove>
    log_write(bp);
80101b08:	89 3c 24             	mov    %edi,(%esp)
80101b0b:	e8 60 12 00 00       	call   80102d70 <log_write>
    brelse(bp);
80101b10:	89 3c 24             	mov    %edi,(%esp)
80101b13:	e8 c8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b18:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b1e:	83 c4 10             	add    $0x10,%esp
80101b21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b24:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b27:	77 97                	ja     80101ac0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b2f:	77 37                	ja     80101b68 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b31:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b37:	5b                   	pop    %ebx
80101b38:	5e                   	pop    %esi
80101b39:	5f                   	pop    %edi
80101b3a:	5d                   	pop    %ebp
80101b3b:	c3                   	ret    
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 36                	ja     80101b80 <writei+0x120>
80101b4a:	8b 04 c5 44 13 11 80 	mov    -0x7feeecbc(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 2b                	je     80101b80 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b6b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b6e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b71:	50                   	push   %eax
80101b72:	e8 59 fa ff ff       	call   801015d0 <iupdate>
80101b77:	83 c4 10             	add    $0x10,%esp
80101b7a:	eb b5                	jmp    80101b31 <writei+0xd1>
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b85:	eb ad                	jmp    80101b34 <writei+0xd4>
80101b87:	89 f6                	mov    %esi,%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b96:	6a 0e                	push   $0xe
80101b98:	ff 75 0c             	pushl  0xc(%ebp)
80101b9b:	ff 75 08             	pushl  0x8(%ebp)
80101b9e:	e8 0d 2d 00 00       	call   801048b0 <strncmp>
}
80101ba3:	c9                   	leave  
80101ba4:	c3                   	ret    
80101ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	57                   	push   %edi
80101bb4:	56                   	push   %esi
80101bb5:	53                   	push   %ebx
80101bb6:	83 ec 1c             	sub    $0x1c,%esp
80101bb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bbc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bc1:	0f 85 85 00 00 00    	jne    80101c4c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bc7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bca:	31 ff                	xor    %edi,%edi
80101bcc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bcf:	85 d2                	test   %edx,%edx
80101bd1:	74 3e                	je     80101c11 <dirlookup+0x61>
80101bd3:	90                   	nop
80101bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bd8:	6a 10                	push   $0x10
80101bda:	57                   	push   %edi
80101bdb:	56                   	push   %esi
80101bdc:	53                   	push   %ebx
80101bdd:	e8 7e fd ff ff       	call   80101960 <readi>
80101be2:	83 c4 10             	add    $0x10,%esp
80101be5:	83 f8 10             	cmp    $0x10,%eax
80101be8:	75 55                	jne    80101c3f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bef:	74 18                	je     80101c09 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101bf1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bf4:	83 ec 04             	sub    $0x4,%esp
80101bf7:	6a 0e                	push   $0xe
80101bf9:	50                   	push   %eax
80101bfa:	ff 75 0c             	pushl  0xc(%ebp)
80101bfd:	e8 ae 2c 00 00       	call   801048b0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	85 c0                	test   %eax,%eax
80101c07:	74 17                	je     80101c20 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c09:	83 c7 10             	add    $0x10,%edi
80101c0c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c0f:	72 c7                	jb     80101bd8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c11:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c14:	31 c0                	xor    %eax,%eax
}
80101c16:	5b                   	pop    %ebx
80101c17:	5e                   	pop    %esi
80101c18:	5f                   	pop    %edi
80101c19:	5d                   	pop    %ebp
80101c1a:	c3                   	ret    
80101c1b:	90                   	nop
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c20:	8b 45 10             	mov    0x10(%ebp),%eax
80101c23:	85 c0                	test   %eax,%eax
80101c25:	74 05                	je     80101c2c <dirlookup+0x7c>
        *poff = off;
80101c27:	8b 45 10             	mov    0x10(%ebp),%eax
80101c2a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c2c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c30:	8b 03                	mov    (%ebx),%eax
80101c32:	e8 59 f6 ff ff       	call   80101290 <iget>
}
80101c37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c3a:	5b                   	pop    %ebx
80101c3b:	5e                   	pop    %esi
80101c3c:	5f                   	pop    %edi
80101c3d:	5d                   	pop    %ebp
80101c3e:	c3                   	ret    
      panic("dirlookup read");
80101c3f:	83 ec 0c             	sub    $0xc,%esp
80101c42:	68 d9 73 10 80       	push   $0x801073d9
80101c47:	e8 44 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c4c:	83 ec 0c             	sub    $0xc,%esp
80101c4f:	68 c7 73 10 80       	push   $0x801073c7
80101c54:	e8 37 e7 ff ff       	call   80100390 <panic>
80101c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c60 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	57                   	push   %edi
80101c64:	56                   	push   %esi
80101c65:	53                   	push   %ebx
80101c66:	89 cf                	mov    %ecx,%edi
80101c68:	89 c3                	mov    %eax,%ebx
80101c6a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c6d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c70:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c73:	0f 84 67 01 00 00    	je     80101de0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c79:	e8 42 1c 00 00       	call   801038c0 <myproc>
  acquire(&icache.lock);
80101c7e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c81:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c84:	68 c0 13 11 80       	push   $0x801113c0
80101c89:	e8 f2 29 00 00       	call   80104680 <acquire>
  ip->ref++;
80101c8e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c92:	c7 04 24 c0 13 11 80 	movl   $0x801113c0,(%esp)
80101c99:	e8 a2 2a 00 00       	call   80104740 <release>
80101c9e:	83 c4 10             	add    $0x10,%esp
80101ca1:	eb 08                	jmp    80101cab <namex+0x4b>
80101ca3:	90                   	nop
80101ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ca8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cab:	0f b6 03             	movzbl (%ebx),%eax
80101cae:	3c 2f                	cmp    $0x2f,%al
80101cb0:	74 f6                	je     80101ca8 <namex+0x48>
  if(*path == 0)
80101cb2:	84 c0                	test   %al,%al
80101cb4:	0f 84 ee 00 00 00    	je     80101da8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cba:	0f b6 03             	movzbl (%ebx),%eax
80101cbd:	3c 2f                	cmp    $0x2f,%al
80101cbf:	0f 84 b3 00 00 00    	je     80101d78 <namex+0x118>
80101cc5:	84 c0                	test   %al,%al
80101cc7:	89 da                	mov    %ebx,%edx
80101cc9:	75 09                	jne    80101cd4 <namex+0x74>
80101ccb:	e9 a8 00 00 00       	jmp    80101d78 <namex+0x118>
80101cd0:	84 c0                	test   %al,%al
80101cd2:	74 0a                	je     80101cde <namex+0x7e>
    path++;
80101cd4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cd7:	0f b6 02             	movzbl (%edx),%eax
80101cda:	3c 2f                	cmp    $0x2f,%al
80101cdc:	75 f2                	jne    80101cd0 <namex+0x70>
80101cde:	89 d1                	mov    %edx,%ecx
80101ce0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101ce2:	83 f9 0d             	cmp    $0xd,%ecx
80101ce5:	0f 8e 91 00 00 00    	jle    80101d7c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101ceb:	83 ec 04             	sub    $0x4,%esp
80101cee:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cf1:	6a 0e                	push   $0xe
80101cf3:	53                   	push   %ebx
80101cf4:	57                   	push   %edi
80101cf5:	e8 46 2b 00 00       	call   80104840 <memmove>
    path++;
80101cfa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101cfd:	83 c4 10             	add    $0x10,%esp
    path++;
80101d00:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d02:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d05:	75 11                	jne    80101d18 <namex+0xb8>
80101d07:	89 f6                	mov    %esi,%esi
80101d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d10:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d13:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d16:	74 f8                	je     80101d10 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d18:	83 ec 0c             	sub    $0xc,%esp
80101d1b:	56                   	push   %esi
80101d1c:	e8 5f f9 ff ff       	call   80101680 <ilock>
    if(ip->type != T_DIR){
80101d21:	83 c4 10             	add    $0x10,%esp
80101d24:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d29:	0f 85 91 00 00 00    	jne    80101dc0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d2f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d32:	85 d2                	test   %edx,%edx
80101d34:	74 09                	je     80101d3f <namex+0xdf>
80101d36:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d39:	0f 84 b7 00 00 00    	je     80101df6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d3f:	83 ec 04             	sub    $0x4,%esp
80101d42:	6a 00                	push   $0x0
80101d44:	57                   	push   %edi
80101d45:	56                   	push   %esi
80101d46:	e8 65 fe ff ff       	call   80101bb0 <dirlookup>
80101d4b:	83 c4 10             	add    $0x10,%esp
80101d4e:	85 c0                	test   %eax,%eax
80101d50:	74 6e                	je     80101dc0 <namex+0x160>
  iunlock(ip);
80101d52:	83 ec 0c             	sub    $0xc,%esp
80101d55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d58:	56                   	push   %esi
80101d59:	e8 02 fa ff ff       	call   80101760 <iunlock>
  iput(ip);
80101d5e:	89 34 24             	mov    %esi,(%esp)
80101d61:	e8 4a fa ff ff       	call   801017b0 <iput>
80101d66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d69:	83 c4 10             	add    $0x10,%esp
80101d6c:	89 c6                	mov    %eax,%esi
80101d6e:	e9 38 ff ff ff       	jmp    80101cab <namex+0x4b>
80101d73:	90                   	nop
80101d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d78:	89 da                	mov    %ebx,%edx
80101d7a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d7c:	83 ec 04             	sub    $0x4,%esp
80101d7f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d82:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d85:	51                   	push   %ecx
80101d86:	53                   	push   %ebx
80101d87:	57                   	push   %edi
80101d88:	e8 b3 2a 00 00       	call   80104840 <memmove>
    name[len] = 0;
80101d8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d90:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d9a:	89 d3                	mov    %edx,%ebx
80101d9c:	e9 61 ff ff ff       	jmp    80101d02 <namex+0xa2>
80101da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101da8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dab:	85 c0                	test   %eax,%eax
80101dad:	75 5d                	jne    80101e0c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101daf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db2:	89 f0                	mov    %esi,%eax
80101db4:	5b                   	pop    %ebx
80101db5:	5e                   	pop    %esi
80101db6:	5f                   	pop    %edi
80101db7:	5d                   	pop    %ebp
80101db8:	c3                   	ret    
80101db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101dc0:	83 ec 0c             	sub    $0xc,%esp
80101dc3:	56                   	push   %esi
80101dc4:	e8 97 f9 ff ff       	call   80101760 <iunlock>
  iput(ip);
80101dc9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dcc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dce:	e8 dd f9 ff ff       	call   801017b0 <iput>
      return 0;
80101dd3:	83 c4 10             	add    $0x10,%esp
}
80101dd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd9:	89 f0                	mov    %esi,%eax
80101ddb:	5b                   	pop    %ebx
80101ddc:	5e                   	pop    %esi
80101ddd:	5f                   	pop    %edi
80101dde:	5d                   	pop    %ebp
80101ddf:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101de0:	ba 01 00 00 00       	mov    $0x1,%edx
80101de5:	b8 01 00 00 00       	mov    $0x1,%eax
80101dea:	e8 a1 f4 ff ff       	call   80101290 <iget>
80101def:	89 c6                	mov    %eax,%esi
80101df1:	e9 b5 fe ff ff       	jmp    80101cab <namex+0x4b>
      iunlock(ip);
80101df6:	83 ec 0c             	sub    $0xc,%esp
80101df9:	56                   	push   %esi
80101dfa:	e8 61 f9 ff ff       	call   80101760 <iunlock>
      return ip;
80101dff:	83 c4 10             	add    $0x10,%esp
}
80101e02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e05:	89 f0                	mov    %esi,%eax
80101e07:	5b                   	pop    %ebx
80101e08:	5e                   	pop    %esi
80101e09:	5f                   	pop    %edi
80101e0a:	5d                   	pop    %ebp
80101e0b:	c3                   	ret    
    iput(ip);
80101e0c:	83 ec 0c             	sub    $0xc,%esp
80101e0f:	56                   	push   %esi
    return 0;
80101e10:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e12:	e8 99 f9 ff ff       	call   801017b0 <iput>
    return 0;
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	eb 93                	jmp    80101daf <namex+0x14f>
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e20 <dirlink>:
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 20             	sub    $0x20,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e2c:	6a 00                	push   $0x0
80101e2e:	ff 75 0c             	pushl  0xc(%ebp)
80101e31:	53                   	push   %ebx
80101e32:	e8 79 fd ff ff       	call   80101bb0 <dirlookup>
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	85 c0                	test   %eax,%eax
80101e3c:	75 67                	jne    80101ea5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e3e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e41:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e44:	85 ff                	test   %edi,%edi
80101e46:	74 29                	je     80101e71 <dirlink+0x51>
80101e48:	31 ff                	xor    %edi,%edi
80101e4a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e4d:	eb 09                	jmp    80101e58 <dirlink+0x38>
80101e4f:	90                   	nop
80101e50:	83 c7 10             	add    $0x10,%edi
80101e53:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e56:	73 19                	jae    80101e71 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e58:	6a 10                	push   $0x10
80101e5a:	57                   	push   %edi
80101e5b:	56                   	push   %esi
80101e5c:	53                   	push   %ebx
80101e5d:	e8 fe fa ff ff       	call   80101960 <readi>
80101e62:	83 c4 10             	add    $0x10,%esp
80101e65:	83 f8 10             	cmp    $0x10,%eax
80101e68:	75 4e                	jne    80101eb8 <dirlink+0x98>
    if(de.inum == 0)
80101e6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e6f:	75 df                	jne    80101e50 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e71:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e74:	83 ec 04             	sub    $0x4,%esp
80101e77:	6a 0e                	push   $0xe
80101e79:	ff 75 0c             	pushl  0xc(%ebp)
80101e7c:	50                   	push   %eax
80101e7d:	e8 8e 2a 00 00       	call   80104910 <strncpy>
  de.inum = inum;
80101e82:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e85:	6a 10                	push   $0x10
80101e87:	57                   	push   %edi
80101e88:	56                   	push   %esi
80101e89:	53                   	push   %ebx
  de.inum = inum;
80101e8a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e8e:	e8 cd fb ff ff       	call   80101a60 <writei>
80101e93:	83 c4 20             	add    $0x20,%esp
80101e96:	83 f8 10             	cmp    $0x10,%eax
80101e99:	75 2a                	jne    80101ec5 <dirlink+0xa5>
  return 0;
80101e9b:	31 c0                	xor    %eax,%eax
}
80101e9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea0:	5b                   	pop    %ebx
80101ea1:	5e                   	pop    %esi
80101ea2:	5f                   	pop    %edi
80101ea3:	5d                   	pop    %ebp
80101ea4:	c3                   	ret    
    iput(ip);
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	50                   	push   %eax
80101ea9:	e8 02 f9 ff ff       	call   801017b0 <iput>
    return -1;
80101eae:	83 c4 10             	add    $0x10,%esp
80101eb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb6:	eb e5                	jmp    80101e9d <dirlink+0x7d>
      panic("dirlink read");
80101eb8:	83 ec 0c             	sub    $0xc,%esp
80101ebb:	68 e8 73 10 80       	push   $0x801073e8
80101ec0:	e8 cb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	68 e6 79 10 80       	push   $0x801079e6
80101ecd:	e8 be e4 ff ff       	call   80100390 <panic>
80101ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <namei>:

struct inode*
namei(char *path)
{
80101ee0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ee1:	31 d2                	xor    %edx,%edx
{
80101ee3:	89 e5                	mov    %esp,%ebp
80101ee5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101ee8:	8b 45 08             	mov    0x8(%ebp),%eax
80101eeb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101eee:	e8 6d fd ff ff       	call   80101c60 <namex>
}
80101ef3:	c9                   	leave  
80101ef4:	c3                   	ret    
80101ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f00:	55                   	push   %ebp
  return namex(path, 1, name);
80101f01:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f06:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f08:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f0e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f0f:	e9 4c fd ff ff       	jmp    80101c60 <namex>
80101f14:	66 90                	xchg   %ax,%ax
80101f16:	66 90                	xchg   %ax,%ax
80101f18:	66 90                	xchg   %ax,%ax
80101f1a:	66 90                	xchg   %ax,%ax
80101f1c:	66 90                	xchg   %ax,%ax
80101f1e:	66 90                	xchg   %ax,%ax

80101f20 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	57                   	push   %edi
80101f24:	56                   	push   %esi
80101f25:	53                   	push   %ebx
80101f26:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f29:	85 c0                	test   %eax,%eax
80101f2b:	0f 84 b4 00 00 00    	je     80101fe5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f31:	8b 58 08             	mov    0x8(%eax),%ebx
80101f34:	89 c6                	mov    %eax,%esi
80101f36:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f3c:	0f 87 96 00 00 00    	ja     80101fd8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f42:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f47:	89 f6                	mov    %esi,%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f50:	89 ca                	mov    %ecx,%edx
80101f52:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f53:	83 e0 c0             	and    $0xffffffc0,%eax
80101f56:	3c 40                	cmp    $0x40,%al
80101f58:	75 f6                	jne    80101f50 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f5a:	31 ff                	xor    %edi,%edi
80101f5c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f61:	89 f8                	mov    %edi,%eax
80101f63:	ee                   	out    %al,(%dx)
80101f64:	b8 01 00 00 00       	mov    $0x1,%eax
80101f69:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f6e:	ee                   	out    %al,(%dx)
80101f6f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f74:	89 d8                	mov    %ebx,%eax
80101f76:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f77:	89 d8                	mov    %ebx,%eax
80101f79:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f7e:	c1 f8 08             	sar    $0x8,%eax
80101f81:	ee                   	out    %al,(%dx)
80101f82:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f87:	89 f8                	mov    %edi,%eax
80101f89:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f8a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f8e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f93:	c1 e0 04             	shl    $0x4,%eax
80101f96:	83 e0 10             	and    $0x10,%eax
80101f99:	83 c8 e0             	or     $0xffffffe0,%eax
80101f9c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f9d:	f6 06 04             	testb  $0x4,(%esi)
80101fa0:	75 16                	jne    80101fb8 <idestart+0x98>
80101fa2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fa7:	89 ca                	mov    %ecx,%edx
80101fa9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fad:	5b                   	pop    %ebx
80101fae:	5e                   	pop    %esi
80101faf:	5f                   	pop    %edi
80101fb0:	5d                   	pop    %ebp
80101fb1:	c3                   	ret    
80101fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fb8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fbd:	89 ca                	mov    %ecx,%edx
80101fbf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fc0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fc5:	83 c6 5c             	add    $0x5c,%esi
80101fc8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fcd:	fc                   	cld    
80101fce:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fd3:	5b                   	pop    %ebx
80101fd4:	5e                   	pop    %esi
80101fd5:	5f                   	pop    %edi
80101fd6:	5d                   	pop    %ebp
80101fd7:	c3                   	ret    
    panic("incorrect blockno");
80101fd8:	83 ec 0c             	sub    $0xc,%esp
80101fdb:	68 54 74 10 80       	push   $0x80107454
80101fe0:	e8 ab e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101fe5:	83 ec 0c             	sub    $0xc,%esp
80101fe8:	68 4b 74 10 80       	push   $0x8010744b
80101fed:	e8 9e e3 ff ff       	call   80100390 <panic>
80101ff2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102000 <ideinit>:
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102006:	68 66 74 10 80       	push   $0x80107466
8010200b:	68 80 a5 10 80       	push   $0x8010a580
80102010:	e8 2b 25 00 00       	call   80104540 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102015:	58                   	pop    %eax
80102016:	a1 e0 36 11 80       	mov    0x801136e0,%eax
8010201b:	5a                   	pop    %edx
8010201c:	83 e8 01             	sub    $0x1,%eax
8010201f:	50                   	push   %eax
80102020:	6a 0e                	push   $0xe
80102022:	e8 a9 02 00 00       	call   801022d0 <ioapicenable>
80102027:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010202a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010202f:	90                   	nop
80102030:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102031:	83 e0 c0             	and    $0xffffffc0,%eax
80102034:	3c 40                	cmp    $0x40,%al
80102036:	75 f8                	jne    80102030 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102038:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010203d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102042:	ee                   	out    %al,(%dx)
80102043:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102048:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204d:	eb 06                	jmp    80102055 <ideinit+0x55>
8010204f:	90                   	nop
  for(i=0; i<1000; i++){
80102050:	83 e9 01             	sub    $0x1,%ecx
80102053:	74 0f                	je     80102064 <ideinit+0x64>
80102055:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102056:	84 c0                	test   %al,%al
80102058:	74 f6                	je     80102050 <ideinit+0x50>
      havedisk1 = 1;
8010205a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102061:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102064:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102069:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010206e:	ee                   	out    %al,(%dx)
}
8010206f:	c9                   	leave  
80102070:	c3                   	ret    
80102071:	eb 0d                	jmp    80102080 <ideintr>
80102073:	90                   	nop
80102074:	90                   	nop
80102075:	90                   	nop
80102076:	90                   	nop
80102077:	90                   	nop
80102078:	90                   	nop
80102079:	90                   	nop
8010207a:	90                   	nop
8010207b:	90                   	nop
8010207c:	90                   	nop
8010207d:	90                   	nop
8010207e:	90                   	nop
8010207f:	90                   	nop

80102080 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102089:	68 80 a5 10 80       	push   $0x8010a580
8010208e:	e8 ed 25 00 00       	call   80104680 <acquire>

  if((b = idequeue) == 0){
80102093:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102099:	83 c4 10             	add    $0x10,%esp
8010209c:	85 db                	test   %ebx,%ebx
8010209e:	74 67                	je     80102107 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020a0:	8b 43 58             	mov    0x58(%ebx),%eax
801020a3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020a8:	8b 3b                	mov    (%ebx),%edi
801020aa:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020b0:	75 31                	jne    801020e3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020b7:	89 f6                	mov    %esi,%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020c0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c1:	89 c6                	mov    %eax,%esi
801020c3:	83 e6 c0             	and    $0xffffffc0,%esi
801020c6:	89 f1                	mov    %esi,%ecx
801020c8:	80 f9 40             	cmp    $0x40,%cl
801020cb:	75 f3                	jne    801020c0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020cd:	a8 21                	test   $0x21,%al
801020cf:	75 12                	jne    801020e3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020d1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020d4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020d9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020de:	fc                   	cld    
801020df:	f3 6d                	rep insl (%dx),%es:(%edi)
801020e1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020e3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801020e6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801020e9:	89 f9                	mov    %edi,%ecx
801020eb:	83 c9 02             	or     $0x2,%ecx
801020ee:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801020f0:	53                   	push   %ebx
801020f1:	e8 9a 1f 00 00       	call   80104090 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020f6:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020fb:	83 c4 10             	add    $0x10,%esp
801020fe:	85 c0                	test   %eax,%eax
80102100:	74 05                	je     80102107 <ideintr+0x87>
    idestart(idequeue);
80102102:	e8 19 fe ff ff       	call   80101f20 <idestart>
    release(&idelock);
80102107:	83 ec 0c             	sub    $0xc,%esp
8010210a:	68 80 a5 10 80       	push   $0x8010a580
8010210f:	e8 2c 26 00 00       	call   80104740 <release>

  release(&idelock);
}
80102114:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102117:	5b                   	pop    %ebx
80102118:	5e                   	pop    %esi
80102119:	5f                   	pop    %edi
8010211a:	5d                   	pop    %ebp
8010211b:	c3                   	ret    
8010211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102120 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	53                   	push   %ebx
80102124:	83 ec 10             	sub    $0x10,%esp
80102127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010212a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010212d:	50                   	push   %eax
8010212e:	e8 bd 23 00 00       	call   801044f0 <holdingsleep>
80102133:	83 c4 10             	add    $0x10,%esp
80102136:	85 c0                	test   %eax,%eax
80102138:	0f 84 c6 00 00 00    	je     80102204 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010213e:	8b 03                	mov    (%ebx),%eax
80102140:	83 e0 06             	and    $0x6,%eax
80102143:	83 f8 02             	cmp    $0x2,%eax
80102146:	0f 84 ab 00 00 00    	je     801021f7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010214c:	8b 53 04             	mov    0x4(%ebx),%edx
8010214f:	85 d2                	test   %edx,%edx
80102151:	74 0d                	je     80102160 <iderw+0x40>
80102153:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102158:	85 c0                	test   %eax,%eax
8010215a:	0f 84 b1 00 00 00    	je     80102211 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102160:	83 ec 0c             	sub    $0xc,%esp
80102163:	68 80 a5 10 80       	push   $0x8010a580
80102168:	e8 13 25 00 00       	call   80104680 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102173:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102176:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010217d:	85 d2                	test   %edx,%edx
8010217f:	75 09                	jne    8010218a <iderw+0x6a>
80102181:	eb 6d                	jmp    801021f0 <iderw+0xd0>
80102183:	90                   	nop
80102184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102188:	89 c2                	mov    %eax,%edx
8010218a:	8b 42 58             	mov    0x58(%edx),%eax
8010218d:	85 c0                	test   %eax,%eax
8010218f:	75 f7                	jne    80102188 <iderw+0x68>
80102191:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102194:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102196:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010219c:	74 42                	je     801021e0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010219e:	8b 03                	mov    (%ebx),%eax
801021a0:	83 e0 06             	and    $0x6,%eax
801021a3:	83 f8 02             	cmp    $0x2,%eax
801021a6:	74 23                	je     801021cb <iderw+0xab>
801021a8:	90                   	nop
801021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021b0:	83 ec 08             	sub    $0x8,%esp
801021b3:	68 80 a5 10 80       	push   $0x8010a580
801021b8:	53                   	push   %ebx
801021b9:	e8 12 1d 00 00       	call   80103ed0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 c4 10             	add    $0x10,%esp
801021c3:	83 e0 06             	and    $0x6,%eax
801021c6:	83 f8 02             	cmp    $0x2,%eax
801021c9:	75 e5                	jne    801021b0 <iderw+0x90>
  }


  release(&idelock);
801021cb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021d5:	c9                   	leave  
  release(&idelock);
801021d6:	e9 65 25 00 00       	jmp    80104740 <release>
801021db:	90                   	nop
801021dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801021e0:	89 d8                	mov    %ebx,%eax
801021e2:	e8 39 fd ff ff       	call   80101f20 <idestart>
801021e7:	eb b5                	jmp    8010219e <iderw+0x7e>
801021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021f0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021f5:	eb 9d                	jmp    80102194 <iderw+0x74>
    panic("iderw: nothing to do");
801021f7:	83 ec 0c             	sub    $0xc,%esp
801021fa:	68 80 74 10 80       	push   $0x80107480
801021ff:	e8 8c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102204:	83 ec 0c             	sub    $0xc,%esp
80102207:	68 6a 74 10 80       	push   $0x8010746a
8010220c:	e8 7f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102211:	83 ec 0c             	sub    $0xc,%esp
80102214:	68 95 74 10 80       	push   $0x80107495
80102219:	e8 72 e1 ff ff       	call   80100390 <panic>
8010221e:	66 90                	xchg   %ax,%ax

80102220 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102220:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102221:	c7 05 14 30 11 80 00 	movl   $0xfec00000,0x80113014
80102228:	00 c0 fe 
{
8010222b:	89 e5                	mov    %esp,%ebp
8010222d:	56                   	push   %esi
8010222e:	53                   	push   %ebx
  ioapic->reg = reg;
8010222f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102236:	00 00 00 
  return ioapic->data;
80102239:	a1 14 30 11 80       	mov    0x80113014,%eax
8010223e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102241:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102247:	8b 0d 14 30 11 80    	mov    0x80113014,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010224d:	0f b6 15 40 31 11 80 	movzbl 0x80113140,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102254:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102257:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010225a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010225d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102260:	39 c2                	cmp    %eax,%edx
80102262:	74 16                	je     8010227a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102264:	83 ec 0c             	sub    $0xc,%esp
80102267:	68 b4 74 10 80       	push   $0x801074b4
8010226c:	e8 ef e3 ff ff       	call   80100660 <cprintf>
80102271:	8b 0d 14 30 11 80    	mov    0x80113014,%ecx
80102277:	83 c4 10             	add    $0x10,%esp
8010227a:	83 c3 21             	add    $0x21,%ebx
{
8010227d:	ba 10 00 00 00       	mov    $0x10,%edx
80102282:	b8 20 00 00 00       	mov    $0x20,%eax
80102287:	89 f6                	mov    %esi,%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102290:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102292:	8b 0d 14 30 11 80    	mov    0x80113014,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102298:	89 c6                	mov    %eax,%esi
8010229a:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022a0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022a3:	89 71 10             	mov    %esi,0x10(%ecx)
801022a6:	8d 72 01             	lea    0x1(%edx),%esi
801022a9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022ac:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022ae:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022b0:	8b 0d 14 30 11 80    	mov    0x80113014,%ecx
801022b6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022bd:	75 d1                	jne    80102290 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022c2:	5b                   	pop    %ebx
801022c3:	5e                   	pop    %esi
801022c4:	5d                   	pop    %ebp
801022c5:	c3                   	ret    
801022c6:	8d 76 00             	lea    0x0(%esi),%esi
801022c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022d0:	55                   	push   %ebp
  ioapic->reg = reg;
801022d1:	8b 0d 14 30 11 80    	mov    0x80113014,%ecx
{
801022d7:	89 e5                	mov    %esp,%ebp
801022d9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022dc:	8d 50 20             	lea    0x20(%eax),%edx
801022df:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022e3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022e5:	8b 0d 14 30 11 80    	mov    0x80113014,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022eb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022ee:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801022f4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022f6:	a1 14 30 11 80       	mov    0x80113014,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022fb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801022fe:	89 50 10             	mov    %edx,0x10(%eax)
}
80102301:	5d                   	pop    %ebp
80102302:	c3                   	ret    
80102303:	66 90                	xchg   %ax,%ax
80102305:	66 90                	xchg   %ax,%ax
80102307:	66 90                	xchg   %ax,%ax
80102309:	66 90                	xchg   %ax,%ax
8010230b:	66 90                	xchg   %ax,%ax
8010230d:	66 90                	xchg   %ax,%ax
8010230f:	90                   	nop

80102310 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102310:	55                   	push   %ebp
80102311:	89 e5                	mov    %esp,%ebp
80102313:	53                   	push   %ebx
80102314:	83 ec 04             	sub    $0x4,%esp
80102317:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010231a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102320:	75 70                	jne    80102392 <kfree+0x82>
80102322:	81 fb 88 61 11 80    	cmp    $0x80116188,%ebx
80102328:	72 68                	jb     80102392 <kfree+0x82>
8010232a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102330:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102335:	77 5b                	ja     80102392 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102337:	83 ec 04             	sub    $0x4,%esp
8010233a:	68 00 10 00 00       	push   $0x1000
8010233f:	6a 01                	push   $0x1
80102341:	53                   	push   %ebx
80102342:	e8 49 24 00 00       	call   80104790 <memset>

  if(kmem.use_lock)
80102347:	8b 15 54 30 11 80    	mov    0x80113054,%edx
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	85 d2                	test   %edx,%edx
80102352:	75 2c                	jne    80102380 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102354:	a1 58 30 11 80       	mov    0x80113058,%eax
80102359:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010235b:	a1 54 30 11 80       	mov    0x80113054,%eax
  kmem.freelist = r;
80102360:	89 1d 58 30 11 80    	mov    %ebx,0x80113058
  if(kmem.use_lock)
80102366:	85 c0                	test   %eax,%eax
80102368:	75 06                	jne    80102370 <kfree+0x60>
    release(&kmem.lock);
}
8010236a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010236d:	c9                   	leave  
8010236e:	c3                   	ret    
8010236f:	90                   	nop
    release(&kmem.lock);
80102370:	c7 45 08 20 30 11 80 	movl   $0x80113020,0x8(%ebp)
}
80102377:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010237a:	c9                   	leave  
    release(&kmem.lock);
8010237b:	e9 c0 23 00 00       	jmp    80104740 <release>
    acquire(&kmem.lock);
80102380:	83 ec 0c             	sub    $0xc,%esp
80102383:	68 20 30 11 80       	push   $0x80113020
80102388:	e8 f3 22 00 00       	call   80104680 <acquire>
8010238d:	83 c4 10             	add    $0x10,%esp
80102390:	eb c2                	jmp    80102354 <kfree+0x44>
    panic("kfree");
80102392:	83 ec 0c             	sub    $0xc,%esp
80102395:	68 e6 74 10 80       	push   $0x801074e6
8010239a:	e8 f1 df ff ff       	call   80100390 <panic>
8010239f:	90                   	nop

801023a0 <freerange>:
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	56                   	push   %esi
801023a4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023a5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023bd:	39 de                	cmp    %ebx,%esi
801023bf:	72 23                	jb     801023e4 <freerange+0x44>
801023c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023c8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ce:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023d7:	50                   	push   %eax
801023d8:	e8 33 ff ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023dd:	83 c4 10             	add    $0x10,%esp
801023e0:	39 f3                	cmp    %esi,%ebx
801023e2:	76 e4                	jbe    801023c8 <freerange+0x28>
}
801023e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023e7:	5b                   	pop    %ebx
801023e8:	5e                   	pop    %esi
801023e9:	5d                   	pop    %ebp
801023ea:	c3                   	ret    
801023eb:	90                   	nop
801023ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023f0 <kinit1>:
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	56                   	push   %esi
801023f4:	53                   	push   %ebx
801023f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023f8:	83 ec 08             	sub    $0x8,%esp
801023fb:	68 ec 74 10 80       	push   $0x801074ec
80102400:	68 20 30 11 80       	push   $0x80113020
80102405:	e8 36 21 00 00       	call   80104540 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010240a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010240d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102410:	c7 05 54 30 11 80 00 	movl   $0x0,0x80113054
80102417:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010241a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102420:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102426:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010242c:	39 de                	cmp    %ebx,%esi
8010242e:	72 1c                	jb     8010244c <kinit1+0x5c>
    kfree(p);
80102430:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102436:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102439:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010243f:	50                   	push   %eax
80102440:	e8 cb fe ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102445:	83 c4 10             	add    $0x10,%esp
80102448:	39 de                	cmp    %ebx,%esi
8010244a:	73 e4                	jae    80102430 <kinit1+0x40>
}
8010244c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010244f:	5b                   	pop    %ebx
80102450:	5e                   	pop    %esi
80102451:	5d                   	pop    %ebp
80102452:	c3                   	ret    
80102453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102460 <kinit2>:
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102465:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102468:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010246b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102471:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102477:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010247d:	39 de                	cmp    %ebx,%esi
8010247f:	72 23                	jb     801024a4 <kinit2+0x44>
80102481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102488:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010248e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102491:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102497:	50                   	push   %eax
80102498:	e8 73 fe ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010249d:	83 c4 10             	add    $0x10,%esp
801024a0:	39 de                	cmp    %ebx,%esi
801024a2:	73 e4                	jae    80102488 <kinit2+0x28>
  kmem.use_lock = 1;
801024a4:	c7 05 54 30 11 80 01 	movl   $0x1,0x80113054
801024ab:	00 00 00 
}
801024ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024b1:	5b                   	pop    %ebx
801024b2:	5e                   	pop    %esi
801024b3:	5d                   	pop    %ebp
801024b4:	c3                   	ret    
801024b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024c0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024c0:	a1 54 30 11 80       	mov    0x80113054,%eax
801024c5:	85 c0                	test   %eax,%eax
801024c7:	75 1f                	jne    801024e8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024c9:	a1 58 30 11 80       	mov    0x80113058,%eax
  if(r)
801024ce:	85 c0                	test   %eax,%eax
801024d0:	74 0e                	je     801024e0 <kalloc+0x20>
    kmem.freelist = r->next;
801024d2:	8b 10                	mov    (%eax),%edx
801024d4:	89 15 58 30 11 80    	mov    %edx,0x80113058
801024da:	c3                   	ret    
801024db:	90                   	nop
801024dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801024e0:	f3 c3                	repz ret 
801024e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801024e8:	55                   	push   %ebp
801024e9:	89 e5                	mov    %esp,%ebp
801024eb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801024ee:	68 20 30 11 80       	push   $0x80113020
801024f3:	e8 88 21 00 00       	call   80104680 <acquire>
  r = kmem.freelist;
801024f8:	a1 58 30 11 80       	mov    0x80113058,%eax
  if(r)
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	8b 15 54 30 11 80    	mov    0x80113054,%edx
80102506:	85 c0                	test   %eax,%eax
80102508:	74 08                	je     80102512 <kalloc+0x52>
    kmem.freelist = r->next;
8010250a:	8b 08                	mov    (%eax),%ecx
8010250c:	89 0d 58 30 11 80    	mov    %ecx,0x80113058
  if(kmem.use_lock)
80102512:	85 d2                	test   %edx,%edx
80102514:	74 16                	je     8010252c <kalloc+0x6c>
    release(&kmem.lock);
80102516:	83 ec 0c             	sub    $0xc,%esp
80102519:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010251c:	68 20 30 11 80       	push   $0x80113020
80102521:	e8 1a 22 00 00       	call   80104740 <release>
  return (char*)r;
80102526:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102529:	83 c4 10             	add    $0x10,%esp
}
8010252c:	c9                   	leave  
8010252d:	c3                   	ret    
8010252e:	66 90                	xchg   %ax,%ax

80102530 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102530:	ba 64 00 00 00       	mov    $0x64,%edx
80102535:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102536:	a8 01                	test   $0x1,%al
80102538:	0f 84 c2 00 00 00    	je     80102600 <kbdgetc+0xd0>
8010253e:	ba 60 00 00 00       	mov    $0x60,%edx
80102543:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102544:	0f b6 d0             	movzbl %al,%edx
80102547:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010254d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102553:	0f 84 7f 00 00 00    	je     801025d8 <kbdgetc+0xa8>
{
80102559:	55                   	push   %ebp
8010255a:	89 e5                	mov    %esp,%ebp
8010255c:	53                   	push   %ebx
8010255d:	89 cb                	mov    %ecx,%ebx
8010255f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102562:	84 c0                	test   %al,%al
80102564:	78 4a                	js     801025b0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102566:	85 db                	test   %ebx,%ebx
80102568:	74 09                	je     80102573 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010256a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010256d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102570:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102573:	0f b6 82 20 76 10 80 	movzbl -0x7fef89e0(%edx),%eax
8010257a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010257c:	0f b6 82 20 75 10 80 	movzbl -0x7fef8ae0(%edx),%eax
80102583:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102585:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102587:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010258d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102590:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102593:	8b 04 85 00 75 10 80 	mov    -0x7fef8b00(,%eax,4),%eax
8010259a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010259e:	74 31                	je     801025d1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025a0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025a3:	83 fa 19             	cmp    $0x19,%edx
801025a6:	77 40                	ja     801025e8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025a8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025ab:	5b                   	pop    %ebx
801025ac:	5d                   	pop    %ebp
801025ad:	c3                   	ret    
801025ae:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025b0:	83 e0 7f             	and    $0x7f,%eax
801025b3:	85 db                	test   %ebx,%ebx
801025b5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025b8:	0f b6 82 20 76 10 80 	movzbl -0x7fef89e0(%edx),%eax
801025bf:	83 c8 40             	or     $0x40,%eax
801025c2:	0f b6 c0             	movzbl %al,%eax
801025c5:	f7 d0                	not    %eax
801025c7:	21 c1                	and    %eax,%ecx
    return 0;
801025c9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025cb:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801025d1:	5b                   	pop    %ebx
801025d2:	5d                   	pop    %ebp
801025d3:	c3                   	ret    
801025d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025d8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025db:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025dd:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
801025e3:	c3                   	ret    
801025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801025e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025eb:	8d 50 20             	lea    0x20(%eax),%edx
}
801025ee:	5b                   	pop    %ebx
      c += 'a' - 'A';
801025ef:	83 f9 1a             	cmp    $0x1a,%ecx
801025f2:	0f 42 c2             	cmovb  %edx,%eax
}
801025f5:	5d                   	pop    %ebp
801025f6:	c3                   	ret    
801025f7:	89 f6                	mov    %esi,%esi
801025f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102605:	c3                   	ret    
80102606:	8d 76 00             	lea    0x0(%esi),%esi
80102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102610 <kbdintr>:

void
kbdintr(void)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102616:	68 30 25 10 80       	push   $0x80102530
8010261b:	e8 f0 e1 ff ff       	call   80100810 <consoleintr>
}
80102620:	83 c4 10             	add    $0x10,%esp
80102623:	c9                   	leave  
80102624:	c3                   	ret    
80102625:	66 90                	xchg   %ax,%ax
80102627:	66 90                	xchg   %ax,%ax
80102629:	66 90                	xchg   %ax,%ax
8010262b:	66 90                	xchg   %ax,%ax
8010262d:	66 90                	xchg   %ax,%ax
8010262f:	90                   	nop

80102630 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102630:	a1 5c 30 11 80       	mov    0x8011305c,%eax
{
80102635:	55                   	push   %ebp
80102636:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102638:	85 c0                	test   %eax,%eax
8010263a:	0f 84 c8 00 00 00    	je     80102708 <lapicinit+0xd8>
  lapic[index] = value;
80102640:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102647:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010264a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010264d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102654:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102657:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010265a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102661:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102664:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102667:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010266e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102671:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102674:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010267b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010267e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102681:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102688:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010268e:	8b 50 30             	mov    0x30(%eax),%edx
80102691:	c1 ea 10             	shr    $0x10,%edx
80102694:	80 fa 03             	cmp    $0x3,%dl
80102697:	77 77                	ja     80102710 <lapicinit+0xe0>
  lapic[index] = value;
80102699:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026a0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026a3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026cd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026da:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026e1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026e4:	8b 50 20             	mov    0x20(%eax),%edx
801026e7:	89 f6                	mov    %esi,%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026f0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026f6:	80 e6 10             	and    $0x10,%dh
801026f9:	75 f5                	jne    801026f0 <lapicinit+0xc0>
  lapic[index] = value;
801026fb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102702:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102705:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102708:	5d                   	pop    %ebp
80102709:	c3                   	ret    
8010270a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102710:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102717:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010271a:	8b 50 20             	mov    0x20(%eax),%edx
8010271d:	e9 77 ff ff ff       	jmp    80102699 <lapicinit+0x69>
80102722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102730 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102730:	8b 15 5c 30 11 80    	mov    0x8011305c,%edx
{
80102736:	55                   	push   %ebp
80102737:	31 c0                	xor    %eax,%eax
80102739:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010273b:	85 d2                	test   %edx,%edx
8010273d:	74 06                	je     80102745 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010273f:	8b 42 20             	mov    0x20(%edx),%eax
80102742:	c1 e8 18             	shr    $0x18,%eax
}
80102745:	5d                   	pop    %ebp
80102746:	c3                   	ret    
80102747:	89 f6                	mov    %esi,%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102750:	a1 5c 30 11 80       	mov    0x8011305c,%eax
{
80102755:	55                   	push   %ebp
80102756:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102758:	85 c0                	test   %eax,%eax
8010275a:	74 0d                	je     80102769 <lapiceoi+0x19>
  lapic[index] = value;
8010275c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102763:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102766:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102769:	5d                   	pop    %ebp
8010276a:	c3                   	ret    
8010276b:	90                   	nop
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102770 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
}
80102773:	5d                   	pop    %ebp
80102774:	c3                   	ret    
80102775:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102780:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102781:	b8 0f 00 00 00       	mov    $0xf,%eax
80102786:	ba 70 00 00 00       	mov    $0x70,%edx
8010278b:	89 e5                	mov    %esp,%ebp
8010278d:	53                   	push   %ebx
8010278e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102791:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102794:	ee                   	out    %al,(%dx)
80102795:	b8 0a 00 00 00       	mov    $0xa,%eax
8010279a:	ba 71 00 00 00       	mov    $0x71,%edx
8010279f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027a0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027a2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027a5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027ab:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027ad:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027b0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027b3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027b5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027b8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027be:	a1 5c 30 11 80       	mov    0x8011305c,%eax
801027c3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027c9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027cc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027d3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027d9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027e0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027e6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ec:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102801:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102807:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010280a:	5b                   	pop    %ebx
8010280b:	5d                   	pop    %ebp
8010280c:	c3                   	ret    
8010280d:	8d 76 00             	lea    0x0(%esi),%esi

80102810 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102810:	55                   	push   %ebp
80102811:	b8 0b 00 00 00       	mov    $0xb,%eax
80102816:	ba 70 00 00 00       	mov    $0x70,%edx
8010281b:	89 e5                	mov    %esp,%ebp
8010281d:	57                   	push   %edi
8010281e:	56                   	push   %esi
8010281f:	53                   	push   %ebx
80102820:	83 ec 4c             	sub    $0x4c,%esp
80102823:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102824:	ba 71 00 00 00       	mov    $0x71,%edx
80102829:	ec                   	in     (%dx),%al
8010282a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010282d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102832:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102835:	8d 76 00             	lea    0x0(%esi),%esi
80102838:	31 c0                	xor    %eax,%eax
8010283a:	89 da                	mov    %ebx,%edx
8010283c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010283d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102842:	89 ca                	mov    %ecx,%edx
80102844:	ec                   	in     (%dx),%al
80102845:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102848:	89 da                	mov    %ebx,%edx
8010284a:	b8 02 00 00 00       	mov    $0x2,%eax
8010284f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102850:	89 ca                	mov    %ecx,%edx
80102852:	ec                   	in     (%dx),%al
80102853:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102856:	89 da                	mov    %ebx,%edx
80102858:	b8 04 00 00 00       	mov    $0x4,%eax
8010285d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285e:	89 ca                	mov    %ecx,%edx
80102860:	ec                   	in     (%dx),%al
80102861:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102864:	89 da                	mov    %ebx,%edx
80102866:	b8 07 00 00 00       	mov    $0x7,%eax
8010286b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286c:	89 ca                	mov    %ecx,%edx
8010286e:	ec                   	in     (%dx),%al
8010286f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102872:	89 da                	mov    %ebx,%edx
80102874:	b8 08 00 00 00       	mov    $0x8,%eax
80102879:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287a:	89 ca                	mov    %ecx,%edx
8010287c:	ec                   	in     (%dx),%al
8010287d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010287f:	89 da                	mov    %ebx,%edx
80102881:	b8 09 00 00 00       	mov    $0x9,%eax
80102886:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102887:	89 ca                	mov    %ecx,%edx
80102889:	ec                   	in     (%dx),%al
8010288a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288c:	89 da                	mov    %ebx,%edx
8010288e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102893:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102894:	89 ca                	mov    %ecx,%edx
80102896:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102897:	84 c0                	test   %al,%al
80102899:	78 9d                	js     80102838 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010289b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010289f:	89 fa                	mov    %edi,%edx
801028a1:	0f b6 fa             	movzbl %dl,%edi
801028a4:	89 f2                	mov    %esi,%edx
801028a6:	0f b6 f2             	movzbl %dl,%esi
801028a9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ac:	89 da                	mov    %ebx,%edx
801028ae:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028b1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028b4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028b8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028bb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028bf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028c2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028c6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028c9:	31 c0                	xor    %eax,%eax
801028cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028cc:	89 ca                	mov    %ecx,%edx
801028ce:	ec                   	in     (%dx),%al
801028cf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d2:	89 da                	mov    %ebx,%edx
801028d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028d7:	b8 02 00 00 00       	mov    $0x2,%eax
801028dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028dd:	89 ca                	mov    %ecx,%edx
801028df:	ec                   	in     (%dx),%al
801028e0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e3:	89 da                	mov    %ebx,%edx
801028e5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028e8:	b8 04 00 00 00       	mov    $0x4,%eax
801028ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ee:	89 ca                	mov    %ecx,%edx
801028f0:	ec                   	in     (%dx),%al
801028f1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f4:	89 da                	mov    %ebx,%edx
801028f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028f9:	b8 07 00 00 00       	mov    $0x7,%eax
801028fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ff:	89 ca                	mov    %ecx,%edx
80102901:	ec                   	in     (%dx),%al
80102902:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102905:	89 da                	mov    %ebx,%edx
80102907:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010290a:	b8 08 00 00 00       	mov    $0x8,%eax
8010290f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102910:	89 ca                	mov    %ecx,%edx
80102912:	ec                   	in     (%dx),%al
80102913:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102916:	89 da                	mov    %ebx,%edx
80102918:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010291b:	b8 09 00 00 00       	mov    $0x9,%eax
80102920:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102921:	89 ca                	mov    %ecx,%edx
80102923:	ec                   	in     (%dx),%al
80102924:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102927:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010292a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010292d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102930:	6a 18                	push   $0x18
80102932:	50                   	push   %eax
80102933:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102936:	50                   	push   %eax
80102937:	e8 a4 1e 00 00       	call   801047e0 <memcmp>
8010293c:	83 c4 10             	add    $0x10,%esp
8010293f:	85 c0                	test   %eax,%eax
80102941:	0f 85 f1 fe ff ff    	jne    80102838 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102947:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010294b:	75 78                	jne    801029c5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010294d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102950:	89 c2                	mov    %eax,%edx
80102952:	83 e0 0f             	and    $0xf,%eax
80102955:	c1 ea 04             	shr    $0x4,%edx
80102958:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010295b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010295e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102961:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102964:	89 c2                	mov    %eax,%edx
80102966:	83 e0 0f             	and    $0xf,%eax
80102969:	c1 ea 04             	shr    $0x4,%edx
8010296c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102972:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102975:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102978:	89 c2                	mov    %eax,%edx
8010297a:	83 e0 0f             	and    $0xf,%eax
8010297d:	c1 ea 04             	shr    $0x4,%edx
80102980:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102983:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102986:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102989:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010298c:	89 c2                	mov    %eax,%edx
8010298e:	83 e0 0f             	and    $0xf,%eax
80102991:	c1 ea 04             	shr    $0x4,%edx
80102994:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102997:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010299a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010299d:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029a0:	89 c2                	mov    %eax,%edx
801029a2:	83 e0 0f             	and    $0xf,%eax
801029a5:	c1 ea 04             	shr    $0x4,%edx
801029a8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029ab:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ae:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029b1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029b4:	89 c2                	mov    %eax,%edx
801029b6:	83 e0 0f             	and    $0xf,%eax
801029b9:	c1 ea 04             	shr    $0x4,%edx
801029bc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029bf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029c2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029c5:	8b 75 08             	mov    0x8(%ebp),%esi
801029c8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029cb:	89 06                	mov    %eax,(%esi)
801029cd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029d0:	89 46 04             	mov    %eax,0x4(%esi)
801029d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029d6:	89 46 08             	mov    %eax,0x8(%esi)
801029d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029dc:	89 46 0c             	mov    %eax,0xc(%esi)
801029df:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029e2:	89 46 10             	mov    %eax,0x10(%esi)
801029e5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029e8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029eb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029f5:	5b                   	pop    %ebx
801029f6:	5e                   	pop    %esi
801029f7:	5f                   	pop    %edi
801029f8:	5d                   	pop    %ebp
801029f9:	c3                   	ret    
801029fa:	66 90                	xchg   %ax,%ax
801029fc:	66 90                	xchg   %ax,%ax
801029fe:	66 90                	xchg   %ax,%ax

80102a00 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a00:	8b 0d a8 30 11 80    	mov    0x801130a8,%ecx
80102a06:	85 c9                	test   %ecx,%ecx
80102a08:	0f 8e 8a 00 00 00    	jle    80102a98 <install_trans+0x98>
{
80102a0e:	55                   	push   %ebp
80102a0f:	89 e5                	mov    %esp,%ebp
80102a11:	57                   	push   %edi
80102a12:	56                   	push   %esi
80102a13:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a14:	31 db                	xor    %ebx,%ebx
{
80102a16:	83 ec 0c             	sub    $0xc,%esp
80102a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a20:	a1 94 30 11 80       	mov    0x80113094,%eax
80102a25:	83 ec 08             	sub    $0x8,%esp
80102a28:	01 d8                	add    %ebx,%eax
80102a2a:	83 c0 01             	add    $0x1,%eax
80102a2d:	50                   	push   %eax
80102a2e:	ff 35 a4 30 11 80    	pushl  0x801130a4
80102a34:	e8 97 d6 ff ff       	call   801000d0 <bread>
80102a39:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a3b:	58                   	pop    %eax
80102a3c:	5a                   	pop    %edx
80102a3d:	ff 34 9d ac 30 11 80 	pushl  -0x7feecf54(,%ebx,4)
80102a44:	ff 35 a4 30 11 80    	pushl  0x801130a4
  for (tail = 0; tail < log.lh.n; tail++) {
80102a4a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a4d:	e8 7e d6 ff ff       	call   801000d0 <bread>
80102a52:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a54:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a57:	83 c4 0c             	add    $0xc,%esp
80102a5a:	68 00 02 00 00       	push   $0x200
80102a5f:	50                   	push   %eax
80102a60:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a63:	50                   	push   %eax
80102a64:	e8 d7 1d 00 00       	call   80104840 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a69:	89 34 24             	mov    %esi,(%esp)
80102a6c:	e8 2f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a71:	89 3c 24             	mov    %edi,(%esp)
80102a74:	e8 67 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a79:	89 34 24             	mov    %esi,(%esp)
80102a7c:	e8 5f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102a81:	83 c4 10             	add    $0x10,%esp
80102a84:	39 1d a8 30 11 80    	cmp    %ebx,0x801130a8
80102a8a:	7f 94                	jg     80102a20 <install_trans+0x20>
  }
}
80102a8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a8f:	5b                   	pop    %ebx
80102a90:	5e                   	pop    %esi
80102a91:	5f                   	pop    %edi
80102a92:	5d                   	pop    %ebp
80102a93:	c3                   	ret    
80102a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a98:	f3 c3                	repz ret 
80102a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102aa0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	56                   	push   %esi
80102aa4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102aa5:	83 ec 08             	sub    $0x8,%esp
80102aa8:	ff 35 94 30 11 80    	pushl  0x80113094
80102aae:	ff 35 a4 30 11 80    	pushl  0x801130a4
80102ab4:	e8 17 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ab9:	8b 1d a8 30 11 80    	mov    0x801130a8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102abf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ac2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ac4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ac6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ac9:	7e 16                	jle    80102ae1 <write_head+0x41>
80102acb:	c1 e3 02             	shl    $0x2,%ebx
80102ace:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ad0:	8b 8a ac 30 11 80    	mov    -0x7feecf54(%edx),%ecx
80102ad6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102ada:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102add:	39 da                	cmp    %ebx,%edx
80102adf:	75 ef                	jne    80102ad0 <write_head+0x30>
  }
  bwrite(buf);
80102ae1:	83 ec 0c             	sub    $0xc,%esp
80102ae4:	56                   	push   %esi
80102ae5:	e8 b6 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102aea:	89 34 24             	mov    %esi,(%esp)
80102aed:	e8 ee d6 ff ff       	call   801001e0 <brelse>
}
80102af2:	83 c4 10             	add    $0x10,%esp
80102af5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102af8:	5b                   	pop    %ebx
80102af9:	5e                   	pop    %esi
80102afa:	5d                   	pop    %ebp
80102afb:	c3                   	ret    
80102afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b00 <initlog>:
{
80102b00:	55                   	push   %ebp
80102b01:	89 e5                	mov    %esp,%ebp
80102b03:	53                   	push   %ebx
80102b04:	83 ec 2c             	sub    $0x2c,%esp
80102b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b0a:	68 20 77 10 80       	push   $0x80107720
80102b0f:	68 60 30 11 80       	push   $0x80113060
80102b14:	e8 27 1a 00 00       	call   80104540 <initlock>
  readsb(dev, &sb);
80102b19:	58                   	pop    %eax
80102b1a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b1d:	5a                   	pop    %edx
80102b1e:	50                   	push   %eax
80102b1f:	53                   	push   %ebx
80102b20:	e8 1b e9 ff ff       	call   80101440 <readsb>
  log.size = sb.nlog;
80102b25:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b28:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b2b:	59                   	pop    %ecx
  log.dev = dev;
80102b2c:	89 1d a4 30 11 80    	mov    %ebx,0x801130a4
  log.size = sb.nlog;
80102b32:	89 15 98 30 11 80    	mov    %edx,0x80113098
  log.start = sb.logstart;
80102b38:	a3 94 30 11 80       	mov    %eax,0x80113094
  struct buf *buf = bread(log.dev, log.start);
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 8b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b45:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b48:	83 c4 10             	add    $0x10,%esp
80102b4b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b4d:	89 1d a8 30 11 80    	mov    %ebx,0x801130a8
  for (i = 0; i < log.lh.n; i++) {
80102b53:	7e 1c                	jle    80102b71 <initlog+0x71>
80102b55:	c1 e3 02             	shl    $0x2,%ebx
80102b58:	31 d2                	xor    %edx,%edx
80102b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b64:	83 c2 04             	add    $0x4,%edx
80102b67:	89 8a a8 30 11 80    	mov    %ecx,-0x7feecf58(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b6d:	39 d3                	cmp    %edx,%ebx
80102b6f:	75 ef                	jne    80102b60 <initlog+0x60>
  brelse(buf);
80102b71:	83 ec 0c             	sub    $0xc,%esp
80102b74:	50                   	push   %eax
80102b75:	e8 66 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b7a:	e8 81 fe ff ff       	call   80102a00 <install_trans>
  log.lh.n = 0;
80102b7f:	c7 05 a8 30 11 80 00 	movl   $0x0,0x801130a8
80102b86:	00 00 00 
  write_head(); // clear the log
80102b89:	e8 12 ff ff ff       	call   80102aa0 <write_head>
}
80102b8e:	83 c4 10             	add    $0x10,%esp
80102b91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b94:	c9                   	leave  
80102b95:	c3                   	ret    
80102b96:	8d 76 00             	lea    0x0(%esi),%esi
80102b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ba0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102ba6:	68 60 30 11 80       	push   $0x80113060
80102bab:	e8 d0 1a 00 00       	call   80104680 <acquire>
80102bb0:	83 c4 10             	add    $0x10,%esp
80102bb3:	eb 18                	jmp    80102bcd <begin_op+0x2d>
80102bb5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bb8:	83 ec 08             	sub    $0x8,%esp
80102bbb:	68 60 30 11 80       	push   $0x80113060
80102bc0:	68 60 30 11 80       	push   $0x80113060
80102bc5:	e8 06 13 00 00       	call   80103ed0 <sleep>
80102bca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bcd:	a1 a0 30 11 80       	mov    0x801130a0,%eax
80102bd2:	85 c0                	test   %eax,%eax
80102bd4:	75 e2                	jne    80102bb8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bd6:	a1 9c 30 11 80       	mov    0x8011309c,%eax
80102bdb:	8b 15 a8 30 11 80    	mov    0x801130a8,%edx
80102be1:	83 c0 01             	add    $0x1,%eax
80102be4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102be7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bea:	83 fa 1e             	cmp    $0x1e,%edx
80102bed:	7f c9                	jg     80102bb8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bef:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102bf2:	a3 9c 30 11 80       	mov    %eax,0x8011309c
      release(&log.lock);
80102bf7:	68 60 30 11 80       	push   $0x80113060
80102bfc:	e8 3f 1b 00 00       	call   80104740 <release>
      break;
    }
  }
}
80102c01:	83 c4 10             	add    $0x10,%esp
80102c04:	c9                   	leave  
80102c05:	c3                   	ret    
80102c06:	8d 76 00             	lea    0x0(%esi),%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c10 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	57                   	push   %edi
80102c14:	56                   	push   %esi
80102c15:	53                   	push   %ebx
80102c16:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c19:	68 60 30 11 80       	push   $0x80113060
80102c1e:	e8 5d 1a 00 00       	call   80104680 <acquire>
  log.outstanding -= 1;
80102c23:	a1 9c 30 11 80       	mov    0x8011309c,%eax
  if(log.committing)
80102c28:	8b 35 a0 30 11 80    	mov    0x801130a0,%esi
80102c2e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c31:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c34:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c36:	89 1d 9c 30 11 80    	mov    %ebx,0x8011309c
  if(log.committing)
80102c3c:	0f 85 1a 01 00 00    	jne    80102d5c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c42:	85 db                	test   %ebx,%ebx
80102c44:	0f 85 ee 00 00 00    	jne    80102d38 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c4a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c4d:	c7 05 a0 30 11 80 01 	movl   $0x1,0x801130a0
80102c54:	00 00 00 
  release(&log.lock);
80102c57:	68 60 30 11 80       	push   $0x80113060
80102c5c:	e8 df 1a 00 00       	call   80104740 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c61:	8b 0d a8 30 11 80    	mov    0x801130a8,%ecx
80102c67:	83 c4 10             	add    $0x10,%esp
80102c6a:	85 c9                	test   %ecx,%ecx
80102c6c:	0f 8e 85 00 00 00    	jle    80102cf7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c72:	a1 94 30 11 80       	mov    0x80113094,%eax
80102c77:	83 ec 08             	sub    $0x8,%esp
80102c7a:	01 d8                	add    %ebx,%eax
80102c7c:	83 c0 01             	add    $0x1,%eax
80102c7f:	50                   	push   %eax
80102c80:	ff 35 a4 30 11 80    	pushl  0x801130a4
80102c86:	e8 45 d4 ff ff       	call   801000d0 <bread>
80102c8b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c8d:	58                   	pop    %eax
80102c8e:	5a                   	pop    %edx
80102c8f:	ff 34 9d ac 30 11 80 	pushl  -0x7feecf54(,%ebx,4)
80102c96:	ff 35 a4 30 11 80    	pushl  0x801130a4
  for (tail = 0; tail < log.lh.n; tail++) {
80102c9c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c9f:	e8 2c d4 ff ff       	call   801000d0 <bread>
80102ca4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ca6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102ca9:	83 c4 0c             	add    $0xc,%esp
80102cac:	68 00 02 00 00       	push   $0x200
80102cb1:	50                   	push   %eax
80102cb2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cb5:	50                   	push   %eax
80102cb6:	e8 85 1b 00 00       	call   80104840 <memmove>
    bwrite(to);  // write the log
80102cbb:	89 34 24             	mov    %esi,(%esp)
80102cbe:	e8 dd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cc3:	89 3c 24             	mov    %edi,(%esp)
80102cc6:	e8 15 d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ccb:	89 34 24             	mov    %esi,(%esp)
80102cce:	e8 0d d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cd3:	83 c4 10             	add    $0x10,%esp
80102cd6:	3b 1d a8 30 11 80    	cmp    0x801130a8,%ebx
80102cdc:	7c 94                	jl     80102c72 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cde:	e8 bd fd ff ff       	call   80102aa0 <write_head>
    install_trans(); // Now install writes to home locations
80102ce3:	e8 18 fd ff ff       	call   80102a00 <install_trans>
    log.lh.n = 0;
80102ce8:	c7 05 a8 30 11 80 00 	movl   $0x0,0x801130a8
80102cef:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cf2:	e8 a9 fd ff ff       	call   80102aa0 <write_head>
    acquire(&log.lock);
80102cf7:	83 ec 0c             	sub    $0xc,%esp
80102cfa:	68 60 30 11 80       	push   $0x80113060
80102cff:	e8 7c 19 00 00       	call   80104680 <acquire>
    wakeup(&log);
80102d04:	c7 04 24 60 30 11 80 	movl   $0x80113060,(%esp)
    log.committing = 0;
80102d0b:	c7 05 a0 30 11 80 00 	movl   $0x0,0x801130a0
80102d12:	00 00 00 
    wakeup(&log);
80102d15:	e8 76 13 00 00       	call   80104090 <wakeup>
    release(&log.lock);
80102d1a:	c7 04 24 60 30 11 80 	movl   $0x80113060,(%esp)
80102d21:	e8 1a 1a 00 00       	call   80104740 <release>
80102d26:	83 c4 10             	add    $0x10,%esp
}
80102d29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d2c:	5b                   	pop    %ebx
80102d2d:	5e                   	pop    %esi
80102d2e:	5f                   	pop    %edi
80102d2f:	5d                   	pop    %ebp
80102d30:	c3                   	ret    
80102d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d38:	83 ec 0c             	sub    $0xc,%esp
80102d3b:	68 60 30 11 80       	push   $0x80113060
80102d40:	e8 4b 13 00 00       	call   80104090 <wakeup>
  release(&log.lock);
80102d45:	c7 04 24 60 30 11 80 	movl   $0x80113060,(%esp)
80102d4c:	e8 ef 19 00 00       	call   80104740 <release>
80102d51:	83 c4 10             	add    $0x10,%esp
}
80102d54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d57:	5b                   	pop    %ebx
80102d58:	5e                   	pop    %esi
80102d59:	5f                   	pop    %edi
80102d5a:	5d                   	pop    %ebp
80102d5b:	c3                   	ret    
    panic("log.committing");
80102d5c:	83 ec 0c             	sub    $0xc,%esp
80102d5f:	68 24 77 10 80       	push   $0x80107724
80102d64:	e8 27 d6 ff ff       	call   80100390 <panic>
80102d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d70 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	53                   	push   %ebx
80102d74:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d77:	8b 15 a8 30 11 80    	mov    0x801130a8,%edx
{
80102d7d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d80:	83 fa 1d             	cmp    $0x1d,%edx
80102d83:	0f 8f 9d 00 00 00    	jg     80102e26 <log_write+0xb6>
80102d89:	a1 98 30 11 80       	mov    0x80113098,%eax
80102d8e:	83 e8 01             	sub    $0x1,%eax
80102d91:	39 c2                	cmp    %eax,%edx
80102d93:	0f 8d 8d 00 00 00    	jge    80102e26 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d99:	a1 9c 30 11 80       	mov    0x8011309c,%eax
80102d9e:	85 c0                	test   %eax,%eax
80102da0:	0f 8e 8d 00 00 00    	jle    80102e33 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102da6:	83 ec 0c             	sub    $0xc,%esp
80102da9:	68 60 30 11 80       	push   $0x80113060
80102dae:	e8 cd 18 00 00       	call   80104680 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102db3:	8b 0d a8 30 11 80    	mov    0x801130a8,%ecx
80102db9:	83 c4 10             	add    $0x10,%esp
80102dbc:	83 f9 00             	cmp    $0x0,%ecx
80102dbf:	7e 57                	jle    80102e18 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dc1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102dc4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dc6:	3b 15 ac 30 11 80    	cmp    0x801130ac,%edx
80102dcc:	75 0b                	jne    80102dd9 <log_write+0x69>
80102dce:	eb 38                	jmp    80102e08 <log_write+0x98>
80102dd0:	39 14 85 ac 30 11 80 	cmp    %edx,-0x7feecf54(,%eax,4)
80102dd7:	74 2f                	je     80102e08 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102dd9:	83 c0 01             	add    $0x1,%eax
80102ddc:	39 c1                	cmp    %eax,%ecx
80102dde:	75 f0                	jne    80102dd0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102de0:	89 14 85 ac 30 11 80 	mov    %edx,-0x7feecf54(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102de7:	83 c0 01             	add    $0x1,%eax
80102dea:	a3 a8 30 11 80       	mov    %eax,0x801130a8
  b->flags |= B_DIRTY; // prevent eviction
80102def:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102df2:	c7 45 08 60 30 11 80 	movl   $0x80113060,0x8(%ebp)
}
80102df9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dfc:	c9                   	leave  
  release(&log.lock);
80102dfd:	e9 3e 19 00 00       	jmp    80104740 <release>
80102e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e08:	89 14 85 ac 30 11 80 	mov    %edx,-0x7feecf54(,%eax,4)
80102e0f:	eb de                	jmp    80102def <log_write+0x7f>
80102e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e18:	8b 43 08             	mov    0x8(%ebx),%eax
80102e1b:	a3 ac 30 11 80       	mov    %eax,0x801130ac
  if (i == log.lh.n)
80102e20:	75 cd                	jne    80102def <log_write+0x7f>
80102e22:	31 c0                	xor    %eax,%eax
80102e24:	eb c1                	jmp    80102de7 <log_write+0x77>
    panic("too big a transaction");
80102e26:	83 ec 0c             	sub    $0xc,%esp
80102e29:	68 33 77 10 80       	push   $0x80107733
80102e2e:	e8 5d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e33:	83 ec 0c             	sub    $0xc,%esp
80102e36:	68 49 77 10 80       	push   $0x80107749
80102e3b:	e8 50 d5 ff ff       	call   80100390 <panic>

80102e40 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	53                   	push   %ebx
80102e44:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e47:	e8 54 0a 00 00       	call   801038a0 <cpuid>
80102e4c:	89 c3                	mov    %eax,%ebx
80102e4e:	e8 4d 0a 00 00       	call   801038a0 <cpuid>
80102e53:	83 ec 04             	sub    $0x4,%esp
80102e56:	53                   	push   %ebx
80102e57:	50                   	push   %eax
80102e58:	68 64 77 10 80       	push   $0x80107764
80102e5d:	e8 fe d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e62:	e8 29 2c 00 00       	call   80105a90 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e67:	e8 b4 09 00 00       	call   80103820 <mycpu>
80102e6c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e6e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e73:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e7a:	e8 11 0d 00 00       	call   80103b90 <scheduler>
80102e7f:	90                   	nop

80102e80 <mpenter>:
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e86:	e8 f5 3c 00 00       	call   80106b80 <switchkvm>
  seginit();
80102e8b:	e8 60 3c 00 00       	call   80106af0 <seginit>
  lapicinit();
80102e90:	e8 9b f7 ff ff       	call   80102630 <lapicinit>
  mpmain();
80102e95:	e8 a6 ff ff ff       	call   80102e40 <mpmain>
80102e9a:	66 90                	xchg   %ax,%ax
80102e9c:	66 90                	xchg   %ax,%ax
80102e9e:	66 90                	xchg   %ax,%ax

80102ea0 <main>:
{
80102ea0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ea4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ea7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eaa:	55                   	push   %ebp
80102eab:	89 e5                	mov    %esp,%ebp
80102ead:	53                   	push   %ebx
80102eae:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102eaf:	83 ec 08             	sub    $0x8,%esp
80102eb2:	68 00 00 40 80       	push   $0x80400000
80102eb7:	68 88 61 11 80       	push   $0x80116188
80102ebc:	e8 2f f5 ff ff       	call   801023f0 <kinit1>
  kvmalloc();      // kernel page table
80102ec1:	e8 8a 41 00 00       	call   80107050 <kvmalloc>
  mpinit();        // detect other processors
80102ec6:	e8 75 01 00 00       	call   80103040 <mpinit>
  lapicinit();     // interrupt controller
80102ecb:	e8 60 f7 ff ff       	call   80102630 <lapicinit>
  seginit();       // segment descriptors
80102ed0:	e8 1b 3c 00 00       	call   80106af0 <seginit>
  picinit();       // disable pic
80102ed5:	e8 46 03 00 00       	call   80103220 <picinit>
  ioapicinit();    // another interrupt controller
80102eda:	e8 41 f3 ff ff       	call   80102220 <ioapicinit>
  consoleinit();   // console hardware
80102edf:	e8 dc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102ee4:	e8 d7 2e 00 00       	call   80105dc0 <uartinit>
  pinit();         // process table
80102ee9:	e8 12 09 00 00       	call   80103800 <pinit>
  tvinit();        // trap vectors
80102eee:	e8 1d 2b 00 00       	call   80105a10 <tvinit>
  binit();         // buffer cache
80102ef3:	e8 48 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ef8:	e8 63 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102efd:	e8 fe f0 ff ff       	call   80102000 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f02:	83 c4 0c             	add    $0xc,%esp
80102f05:	68 8a 00 00 00       	push   $0x8a
80102f0a:	68 8c a4 10 80       	push   $0x8010a48c
80102f0f:	68 00 70 00 80       	push   $0x80007000
80102f14:	e8 27 19 00 00       	call   80104840 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f19:	69 05 e0 36 11 80 b0 	imul   $0xb0,0x801136e0,%eax
80102f20:	00 00 00 
80102f23:	83 c4 10             	add    $0x10,%esp
80102f26:	05 60 31 11 80       	add    $0x80113160,%eax
80102f2b:	3d 60 31 11 80       	cmp    $0x80113160,%eax
80102f30:	76 71                	jbe    80102fa3 <main+0x103>
80102f32:	bb 60 31 11 80       	mov    $0x80113160,%ebx
80102f37:	89 f6                	mov    %esi,%esi
80102f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f40:	e8 db 08 00 00       	call   80103820 <mycpu>
80102f45:	39 d8                	cmp    %ebx,%eax
80102f47:	74 41                	je     80102f8a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f49:	e8 72 f5 ff ff       	call   801024c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f4e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f53:	c7 05 f8 6f 00 80 80 	movl   $0x80102e80,0x80006ff8
80102f5a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f5d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f64:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f67:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f6c:	0f b6 03             	movzbl (%ebx),%eax
80102f6f:	83 ec 08             	sub    $0x8,%esp
80102f72:	68 00 70 00 00       	push   $0x7000
80102f77:	50                   	push   %eax
80102f78:	e8 03 f8 ff ff       	call   80102780 <lapicstartap>
80102f7d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f80:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f86:	85 c0                	test   %eax,%eax
80102f88:	74 f6                	je     80102f80 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102f8a:	69 05 e0 36 11 80 b0 	imul   $0xb0,0x801136e0,%eax
80102f91:	00 00 00 
80102f94:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f9a:	05 60 31 11 80       	add    $0x80113160,%eax
80102f9f:	39 c3                	cmp    %eax,%ebx
80102fa1:	72 9d                	jb     80102f40 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fa3:	83 ec 08             	sub    $0x8,%esp
80102fa6:	68 00 00 00 8e       	push   $0x8e000000
80102fab:	68 00 00 40 80       	push   $0x80400000
80102fb0:	e8 ab f4 ff ff       	call   80102460 <kinit2>
  userinit();      // first user process
80102fb5:	e8 36 09 00 00       	call   801038f0 <userinit>
  mpmain();        // finish this processor's setup
80102fba:	e8 81 fe ff ff       	call   80102e40 <mpmain>
80102fbf:	90                   	nop

80102fc0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	57                   	push   %edi
80102fc4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fc5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102fcb:	53                   	push   %ebx
  e = addr+len;
80102fcc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fcf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102fd2:	39 de                	cmp    %ebx,%esi
80102fd4:	72 10                	jb     80102fe6 <mpsearch1+0x26>
80102fd6:	eb 50                	jmp    80103028 <mpsearch1+0x68>
80102fd8:	90                   	nop
80102fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fe0:	39 fb                	cmp    %edi,%ebx
80102fe2:	89 fe                	mov    %edi,%esi
80102fe4:	76 42                	jbe    80103028 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fe6:	83 ec 04             	sub    $0x4,%esp
80102fe9:	8d 7e 10             	lea    0x10(%esi),%edi
80102fec:	6a 04                	push   $0x4
80102fee:	68 78 77 10 80       	push   $0x80107778
80102ff3:	56                   	push   %esi
80102ff4:	e8 e7 17 00 00       	call   801047e0 <memcmp>
80102ff9:	83 c4 10             	add    $0x10,%esp
80102ffc:	85 c0                	test   %eax,%eax
80102ffe:	75 e0                	jne    80102fe0 <mpsearch1+0x20>
80103000:	89 f1                	mov    %esi,%ecx
80103002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103008:	0f b6 11             	movzbl (%ecx),%edx
8010300b:	83 c1 01             	add    $0x1,%ecx
8010300e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103010:	39 f9                	cmp    %edi,%ecx
80103012:	75 f4                	jne    80103008 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103014:	84 c0                	test   %al,%al
80103016:	75 c8                	jne    80102fe0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103018:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010301b:	89 f0                	mov    %esi,%eax
8010301d:	5b                   	pop    %ebx
8010301e:	5e                   	pop    %esi
8010301f:	5f                   	pop    %edi
80103020:	5d                   	pop    %ebp
80103021:	c3                   	ret    
80103022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103028:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010302b:	31 f6                	xor    %esi,%esi
}
8010302d:	89 f0                	mov    %esi,%eax
8010302f:	5b                   	pop    %ebx
80103030:	5e                   	pop    %esi
80103031:	5f                   	pop    %edi
80103032:	5d                   	pop    %ebp
80103033:	c3                   	ret    
80103034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010303a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103040 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	57                   	push   %edi
80103044:	56                   	push   %esi
80103045:	53                   	push   %ebx
80103046:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103049:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103050:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103057:	c1 e0 08             	shl    $0x8,%eax
8010305a:	09 d0                	or     %edx,%eax
8010305c:	c1 e0 04             	shl    $0x4,%eax
8010305f:	85 c0                	test   %eax,%eax
80103061:	75 1b                	jne    8010307e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103063:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010306a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103071:	c1 e0 08             	shl    $0x8,%eax
80103074:	09 d0                	or     %edx,%eax
80103076:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103079:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010307e:	ba 00 04 00 00       	mov    $0x400,%edx
80103083:	e8 38 ff ff ff       	call   80102fc0 <mpsearch1>
80103088:	85 c0                	test   %eax,%eax
8010308a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010308d:	0f 84 3d 01 00 00    	je     801031d0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103093:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103096:	8b 58 04             	mov    0x4(%eax),%ebx
80103099:	85 db                	test   %ebx,%ebx
8010309b:	0f 84 4f 01 00 00    	je     801031f0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030a1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030a7:	83 ec 04             	sub    $0x4,%esp
801030aa:	6a 04                	push   $0x4
801030ac:	68 95 77 10 80       	push   $0x80107795
801030b1:	56                   	push   %esi
801030b2:	e8 29 17 00 00       	call   801047e0 <memcmp>
801030b7:	83 c4 10             	add    $0x10,%esp
801030ba:	85 c0                	test   %eax,%eax
801030bc:	0f 85 2e 01 00 00    	jne    801031f0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030c2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030c9:	3c 01                	cmp    $0x1,%al
801030cb:	0f 95 c2             	setne  %dl
801030ce:	3c 04                	cmp    $0x4,%al
801030d0:	0f 95 c0             	setne  %al
801030d3:	20 c2                	and    %al,%dl
801030d5:	0f 85 15 01 00 00    	jne    801031f0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801030db:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801030e2:	66 85 ff             	test   %di,%di
801030e5:	74 1a                	je     80103101 <mpinit+0xc1>
801030e7:	89 f0                	mov    %esi,%eax
801030e9:	01 f7                	add    %esi,%edi
  sum = 0;
801030eb:	31 d2                	xor    %edx,%edx
801030ed:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801030f0:	0f b6 08             	movzbl (%eax),%ecx
801030f3:	83 c0 01             	add    $0x1,%eax
801030f6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801030f8:	39 c7                	cmp    %eax,%edi
801030fa:	75 f4                	jne    801030f0 <mpinit+0xb0>
801030fc:	84 d2                	test   %dl,%dl
801030fe:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103101:	85 f6                	test   %esi,%esi
80103103:	0f 84 e7 00 00 00    	je     801031f0 <mpinit+0x1b0>
80103109:	84 d2                	test   %dl,%dl
8010310b:	0f 85 df 00 00 00    	jne    801031f0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103111:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103117:	a3 5c 30 11 80       	mov    %eax,0x8011305c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010311c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103123:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103129:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312e:	01 d6                	add    %edx,%esi
80103130:	39 c6                	cmp    %eax,%esi
80103132:	76 23                	jbe    80103157 <mpinit+0x117>
    switch(*p){
80103134:	0f b6 10             	movzbl (%eax),%edx
80103137:	80 fa 04             	cmp    $0x4,%dl
8010313a:	0f 87 ca 00 00 00    	ja     8010320a <mpinit+0x1ca>
80103140:	ff 24 95 bc 77 10 80 	jmp    *-0x7fef8844(,%edx,4)
80103147:	89 f6                	mov    %esi,%esi
80103149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103150:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103153:	39 c6                	cmp    %eax,%esi
80103155:	77 dd                	ja     80103134 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103157:	85 db                	test   %ebx,%ebx
80103159:	0f 84 9e 00 00 00    	je     801031fd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010315f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103162:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103166:	74 15                	je     8010317d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103168:	b8 70 00 00 00       	mov    $0x70,%eax
8010316d:	ba 22 00 00 00       	mov    $0x22,%edx
80103172:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103173:	ba 23 00 00 00       	mov    $0x23,%edx
80103178:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103179:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010317c:	ee                   	out    %al,(%dx)
  }
}
8010317d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103180:	5b                   	pop    %ebx
80103181:	5e                   	pop    %esi
80103182:	5f                   	pop    %edi
80103183:	5d                   	pop    %ebp
80103184:	c3                   	ret    
80103185:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103188:	8b 0d e0 36 11 80    	mov    0x801136e0,%ecx
8010318e:	83 f9 07             	cmp    $0x7,%ecx
80103191:	7f 19                	jg     801031ac <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103193:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103197:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010319d:	83 c1 01             	add    $0x1,%ecx
801031a0:	89 0d e0 36 11 80    	mov    %ecx,0x801136e0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031a6:	88 97 60 31 11 80    	mov    %dl,-0x7feecea0(%edi)
      p += sizeof(struct mpproc);
801031ac:	83 c0 14             	add    $0x14,%eax
      continue;
801031af:	e9 7c ff ff ff       	jmp    80103130 <mpinit+0xf0>
801031b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031b8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031bc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031bf:	88 15 40 31 11 80    	mov    %dl,0x80113140
      continue;
801031c5:	e9 66 ff ff ff       	jmp    80103130 <mpinit+0xf0>
801031ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031d0:	ba 00 00 01 00       	mov    $0x10000,%edx
801031d5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031da:	e8 e1 fd ff ff       	call   80102fc0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031df:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801031e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031e4:	0f 85 a9 fe ff ff    	jne    80103093 <mpinit+0x53>
801031ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801031f0:	83 ec 0c             	sub    $0xc,%esp
801031f3:	68 7d 77 10 80       	push   $0x8010777d
801031f8:	e8 93 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801031fd:	83 ec 0c             	sub    $0xc,%esp
80103200:	68 9c 77 10 80       	push   $0x8010779c
80103205:	e8 86 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010320a:	31 db                	xor    %ebx,%ebx
8010320c:	e9 26 ff ff ff       	jmp    80103137 <mpinit+0xf7>
80103211:	66 90                	xchg   %ax,%ax
80103213:	66 90                	xchg   %ax,%ax
80103215:	66 90                	xchg   %ax,%ax
80103217:	66 90                	xchg   %ax,%ax
80103219:	66 90                	xchg   %ax,%ax
8010321b:	66 90                	xchg   %ax,%ax
8010321d:	66 90                	xchg   %ax,%ax
8010321f:	90                   	nop

80103220 <picinit>:
80103220:	55                   	push   %ebp
80103221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103226:	ba 21 00 00 00       	mov    $0x21,%edx
8010322b:	89 e5                	mov    %esp,%ebp
8010322d:	ee                   	out    %al,(%dx)
8010322e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103233:	ee                   	out    %al,(%dx)
80103234:	5d                   	pop    %ebp
80103235:	c3                   	ret    
80103236:	66 90                	xchg   %ax,%ax
80103238:	66 90                	xchg   %ax,%ax
8010323a:	66 90                	xchg   %ax,%ax
8010323c:	66 90                	xchg   %ax,%ax
8010323e:	66 90                	xchg   %ax,%ax

80103240 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103240:	55                   	push   %ebp
80103241:	89 e5                	mov    %esp,%ebp
80103243:	57                   	push   %edi
80103244:	56                   	push   %esi
80103245:	53                   	push   %ebx
80103246:	83 ec 0c             	sub    $0xc,%esp
80103249:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010324c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010324f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103255:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010325b:	e8 20 db ff ff       	call   80100d80 <filealloc>
80103260:	85 c0                	test   %eax,%eax
80103262:	89 03                	mov    %eax,(%ebx)
80103264:	74 22                	je     80103288 <pipealloc+0x48>
80103266:	e8 15 db ff ff       	call   80100d80 <filealloc>
8010326b:	85 c0                	test   %eax,%eax
8010326d:	89 06                	mov    %eax,(%esi)
8010326f:	74 3f                	je     801032b0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103271:	e8 4a f2 ff ff       	call   801024c0 <kalloc>
80103276:	85 c0                	test   %eax,%eax
80103278:	89 c7                	mov    %eax,%edi
8010327a:	75 54                	jne    801032d0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010327c:	8b 03                	mov    (%ebx),%eax
8010327e:	85 c0                	test   %eax,%eax
80103280:	75 34                	jne    801032b6 <pipealloc+0x76>
80103282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103288:	8b 06                	mov    (%esi),%eax
8010328a:	85 c0                	test   %eax,%eax
8010328c:	74 0c                	je     8010329a <pipealloc+0x5a>
    fileclose(*f1);
8010328e:	83 ec 0c             	sub    $0xc,%esp
80103291:	50                   	push   %eax
80103292:	e8 a9 db ff ff       	call   80100e40 <fileclose>
80103297:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010329a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010329d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032a2:	5b                   	pop    %ebx
801032a3:	5e                   	pop    %esi
801032a4:	5f                   	pop    %edi
801032a5:	5d                   	pop    %ebp
801032a6:	c3                   	ret    
801032a7:	89 f6                	mov    %esi,%esi
801032a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032b0:	8b 03                	mov    (%ebx),%eax
801032b2:	85 c0                	test   %eax,%eax
801032b4:	74 e4                	je     8010329a <pipealloc+0x5a>
    fileclose(*f0);
801032b6:	83 ec 0c             	sub    $0xc,%esp
801032b9:	50                   	push   %eax
801032ba:	e8 81 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032bf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032c1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032c4:	85 c0                	test   %eax,%eax
801032c6:	75 c6                	jne    8010328e <pipealloc+0x4e>
801032c8:	eb d0                	jmp    8010329a <pipealloc+0x5a>
801032ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032d0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032d3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032da:	00 00 00 
  p->writeopen = 1;
801032dd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032e4:	00 00 00 
  p->nwrite = 0;
801032e7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032ee:	00 00 00 
  p->nread = 0;
801032f1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801032f8:	00 00 00 
  initlock(&p->lock, "pipe");
801032fb:	68 d0 77 10 80       	push   $0x801077d0
80103300:	50                   	push   %eax
80103301:	e8 3a 12 00 00       	call   80104540 <initlock>
  (*f0)->type = FD_PIPE;
80103306:	8b 03                	mov    (%ebx),%eax
  return 0;
80103308:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010330b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103311:	8b 03                	mov    (%ebx),%eax
80103313:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103317:	8b 03                	mov    (%ebx),%eax
80103319:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010331d:	8b 03                	mov    (%ebx),%eax
8010331f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103322:	8b 06                	mov    (%esi),%eax
80103324:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010332a:	8b 06                	mov    (%esi),%eax
8010332c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103330:	8b 06                	mov    (%esi),%eax
80103332:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103336:	8b 06                	mov    (%esi),%eax
80103338:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010333b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010333e:	31 c0                	xor    %eax,%eax
}
80103340:	5b                   	pop    %ebx
80103341:	5e                   	pop    %esi
80103342:	5f                   	pop    %edi
80103343:	5d                   	pop    %ebp
80103344:	c3                   	ret    
80103345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103350 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	56                   	push   %esi
80103354:	53                   	push   %ebx
80103355:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103358:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010335b:	83 ec 0c             	sub    $0xc,%esp
8010335e:	53                   	push   %ebx
8010335f:	e8 1c 13 00 00       	call   80104680 <acquire>
  if(writable){
80103364:	83 c4 10             	add    $0x10,%esp
80103367:	85 f6                	test   %esi,%esi
80103369:	74 45                	je     801033b0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010336b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103371:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103374:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010337b:	00 00 00 
    wakeup(&p->nread);
8010337e:	50                   	push   %eax
8010337f:	e8 0c 0d 00 00       	call   80104090 <wakeup>
80103384:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103387:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010338d:	85 d2                	test   %edx,%edx
8010338f:	75 0a                	jne    8010339b <pipeclose+0x4b>
80103391:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103397:	85 c0                	test   %eax,%eax
80103399:	74 35                	je     801033d0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010339b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010339e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033a1:	5b                   	pop    %ebx
801033a2:	5e                   	pop    %esi
801033a3:	5d                   	pop    %ebp
    release(&p->lock);
801033a4:	e9 97 13 00 00       	jmp    80104740 <release>
801033a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033b0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033b6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033c0:	00 00 00 
    wakeup(&p->nwrite);
801033c3:	50                   	push   %eax
801033c4:	e8 c7 0c 00 00       	call   80104090 <wakeup>
801033c9:	83 c4 10             	add    $0x10,%esp
801033cc:	eb b9                	jmp    80103387 <pipeclose+0x37>
801033ce:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033d0:	83 ec 0c             	sub    $0xc,%esp
801033d3:	53                   	push   %ebx
801033d4:	e8 67 13 00 00       	call   80104740 <release>
    kfree((char*)p);
801033d9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033dc:	83 c4 10             	add    $0x10,%esp
}
801033df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033e2:	5b                   	pop    %ebx
801033e3:	5e                   	pop    %esi
801033e4:	5d                   	pop    %ebp
    kfree((char*)p);
801033e5:	e9 26 ef ff ff       	jmp    80102310 <kfree>
801033ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033f0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	57                   	push   %edi
801033f4:	56                   	push   %esi
801033f5:	53                   	push   %ebx
801033f6:	83 ec 28             	sub    $0x28,%esp
801033f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033fc:	53                   	push   %ebx
801033fd:	e8 7e 12 00 00       	call   80104680 <acquire>
  for(i = 0; i < n; i++){
80103402:	8b 45 10             	mov    0x10(%ebp),%eax
80103405:	83 c4 10             	add    $0x10,%esp
80103408:	85 c0                	test   %eax,%eax
8010340a:	0f 8e c9 00 00 00    	jle    801034d9 <pipewrite+0xe9>
80103410:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103413:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103419:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010341f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103422:	03 4d 10             	add    0x10(%ebp),%ecx
80103425:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103428:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010342e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103434:	39 d0                	cmp    %edx,%eax
80103436:	75 71                	jne    801034a9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103438:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010343e:	85 c0                	test   %eax,%eax
80103440:	74 4e                	je     80103490 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103442:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103448:	eb 3a                	jmp    80103484 <pipewrite+0x94>
8010344a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103450:	83 ec 0c             	sub    $0xc,%esp
80103453:	57                   	push   %edi
80103454:	e8 37 0c 00 00       	call   80104090 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103459:	5a                   	pop    %edx
8010345a:	59                   	pop    %ecx
8010345b:	53                   	push   %ebx
8010345c:	56                   	push   %esi
8010345d:	e8 6e 0a 00 00       	call   80103ed0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103462:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103468:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010346e:	83 c4 10             	add    $0x10,%esp
80103471:	05 00 02 00 00       	add    $0x200,%eax
80103476:	39 c2                	cmp    %eax,%edx
80103478:	75 36                	jne    801034b0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010347a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103480:	85 c0                	test   %eax,%eax
80103482:	74 0c                	je     80103490 <pipewrite+0xa0>
80103484:	e8 37 04 00 00       	call   801038c0 <myproc>
80103489:	8b 40 24             	mov    0x24(%eax),%eax
8010348c:	85 c0                	test   %eax,%eax
8010348e:	74 c0                	je     80103450 <pipewrite+0x60>
        release(&p->lock);
80103490:	83 ec 0c             	sub    $0xc,%esp
80103493:	53                   	push   %ebx
80103494:	e8 a7 12 00 00       	call   80104740 <release>
        return -1;
80103499:	83 c4 10             	add    $0x10,%esp
8010349c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034a4:	5b                   	pop    %ebx
801034a5:	5e                   	pop    %esi
801034a6:	5f                   	pop    %edi
801034a7:	5d                   	pop    %ebp
801034a8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034a9:	89 c2                	mov    %eax,%edx
801034ab:	90                   	nop
801034ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034b0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034b3:	8d 42 01             	lea    0x1(%edx),%eax
801034b6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034bc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034c2:	83 c6 01             	add    $0x1,%esi
801034c5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034c9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034cc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034cf:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034d3:	0f 85 4f ff ff ff    	jne    80103428 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034d9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034df:	83 ec 0c             	sub    $0xc,%esp
801034e2:	50                   	push   %eax
801034e3:	e8 a8 0b 00 00       	call   80104090 <wakeup>
  release(&p->lock);
801034e8:	89 1c 24             	mov    %ebx,(%esp)
801034eb:	e8 50 12 00 00       	call   80104740 <release>
  return n;
801034f0:	83 c4 10             	add    $0x10,%esp
801034f3:	8b 45 10             	mov    0x10(%ebp),%eax
801034f6:	eb a9                	jmp    801034a1 <pipewrite+0xb1>
801034f8:	90                   	nop
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103500 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103500:	55                   	push   %ebp
80103501:	89 e5                	mov    %esp,%ebp
80103503:	57                   	push   %edi
80103504:	56                   	push   %esi
80103505:	53                   	push   %ebx
80103506:	83 ec 18             	sub    $0x18,%esp
80103509:	8b 75 08             	mov    0x8(%ebp),%esi
8010350c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010350f:	56                   	push   %esi
80103510:	e8 6b 11 00 00       	call   80104680 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103515:	83 c4 10             	add    $0x10,%esp
80103518:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010351e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103524:	75 6a                	jne    80103590 <piperead+0x90>
80103526:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010352c:	85 db                	test   %ebx,%ebx
8010352e:	0f 84 c4 00 00 00    	je     801035f8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103534:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010353a:	eb 2d                	jmp    80103569 <piperead+0x69>
8010353c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103540:	83 ec 08             	sub    $0x8,%esp
80103543:	56                   	push   %esi
80103544:	53                   	push   %ebx
80103545:	e8 86 09 00 00       	call   80103ed0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010354a:	83 c4 10             	add    $0x10,%esp
8010354d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103553:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103559:	75 35                	jne    80103590 <piperead+0x90>
8010355b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103561:	85 d2                	test   %edx,%edx
80103563:	0f 84 8f 00 00 00    	je     801035f8 <piperead+0xf8>
    if(myproc()->killed){
80103569:	e8 52 03 00 00       	call   801038c0 <myproc>
8010356e:	8b 48 24             	mov    0x24(%eax),%ecx
80103571:	85 c9                	test   %ecx,%ecx
80103573:	74 cb                	je     80103540 <piperead+0x40>
      release(&p->lock);
80103575:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103578:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010357d:	56                   	push   %esi
8010357e:	e8 bd 11 00 00       	call   80104740 <release>
      return -1;
80103583:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103586:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103589:	89 d8                	mov    %ebx,%eax
8010358b:	5b                   	pop    %ebx
8010358c:	5e                   	pop    %esi
8010358d:	5f                   	pop    %edi
8010358e:	5d                   	pop    %ebp
8010358f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103590:	8b 45 10             	mov    0x10(%ebp),%eax
80103593:	85 c0                	test   %eax,%eax
80103595:	7e 61                	jle    801035f8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103597:	31 db                	xor    %ebx,%ebx
80103599:	eb 13                	jmp    801035ae <piperead+0xae>
8010359b:	90                   	nop
8010359c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035a0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035a6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035ac:	74 1f                	je     801035cd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035ae:	8d 41 01             	lea    0x1(%ecx),%eax
801035b1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035b7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035bd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035c2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035c5:	83 c3 01             	add    $0x1,%ebx
801035c8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035cb:	75 d3                	jne    801035a0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035cd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035d3:	83 ec 0c             	sub    $0xc,%esp
801035d6:	50                   	push   %eax
801035d7:	e8 b4 0a 00 00       	call   80104090 <wakeup>
  release(&p->lock);
801035dc:	89 34 24             	mov    %esi,(%esp)
801035df:	e8 5c 11 00 00       	call   80104740 <release>
  return i;
801035e4:	83 c4 10             	add    $0x10,%esp
}
801035e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035ea:	89 d8                	mov    %ebx,%eax
801035ec:	5b                   	pop    %ebx
801035ed:	5e                   	pop    %esi
801035ee:	5f                   	pop    %edi
801035ef:	5d                   	pop    %ebp
801035f0:	c3                   	ret    
801035f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035f8:	31 db                	xor    %ebx,%ebx
801035fa:	eb d1                	jmp    801035cd <piperead+0xcd>
801035fc:	66 90                	xchg   %ax,%ax
801035fe:	66 90                	xchg   %ax,%ax

80103600 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103604:	bb 34 37 11 80       	mov    $0x80113734,%ebx
{
80103609:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010360c:	68 00 37 11 80       	push   $0x80113700
80103611:	e8 6a 10 00 00       	call   80104680 <acquire>
80103616:	83 c4 10             	add    $0x10,%esp
80103619:	eb 13                	jmp    8010362e <allocproc+0x2e>
8010361b:	90                   	nop
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103620:	81 c3 88 00 00 00    	add    $0x88,%ebx
80103626:	81 fb 34 59 11 80    	cmp    $0x80115934,%ebx
8010362c:	73 7a                	jae    801036a8 <allocproc+0xa8>
    if(p->state == UNUSED)
8010362e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103631:	85 c0                	test   %eax,%eax
80103633:	75 eb                	jne    80103620 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103635:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
8010363a:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010363d:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103644:	8d 50 01             	lea    0x1(%eax),%edx
80103647:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
8010364a:	68 00 37 11 80       	push   $0x80113700
  p->pid = nextpid++;
8010364f:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103655:	e8 e6 10 00 00       	call   80104740 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010365a:	e8 61 ee ff ff       	call   801024c0 <kalloc>
8010365f:	83 c4 10             	add    $0x10,%esp
80103662:	85 c0                	test   %eax,%eax
80103664:	89 43 08             	mov    %eax,0x8(%ebx)
80103667:	74 58                	je     801036c1 <allocproc+0xc1>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103669:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010366f:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103672:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103677:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010367a:	c7 40 14 02 5a 10 80 	movl   $0x80105a02,0x14(%eax)
  p->context = (struct context*)sp;
80103681:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103684:	6a 14                	push   $0x14
80103686:	6a 00                	push   $0x0
80103688:	50                   	push   %eax
80103689:	e8 02 11 00 00       	call   80104790 <memset>
  p->context->eip = (uint)forkret;
8010368e:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103691:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103694:	c7 40 10 d0 36 10 80 	movl   $0x801036d0,0x10(%eax)
}
8010369b:	89 d8                	mov    %ebx,%eax
8010369d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036a0:	c9                   	leave  
801036a1:	c3                   	ret    
801036a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801036a8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801036ab:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801036ad:	68 00 37 11 80       	push   $0x80113700
801036b2:	e8 89 10 00 00       	call   80104740 <release>
}
801036b7:	89 d8                	mov    %ebx,%eax
  return 0;
801036b9:	83 c4 10             	add    $0x10,%esp
}
801036bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036bf:	c9                   	leave  
801036c0:	c3                   	ret    
    p->state = UNUSED;
801036c1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036c8:	31 db                	xor    %ebx,%ebx
801036ca:	eb cf                	jmp    8010369b <allocproc+0x9b>
801036cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036d0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036d6:	68 00 37 11 80       	push   $0x80113700
801036db:	e8 60 10 00 00       	call   80104740 <release>

  if (first) {
801036e0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801036e5:	83 c4 10             	add    $0x10,%esp
801036e8:	85 c0                	test   %eax,%eax
801036ea:	75 04                	jne    801036f0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036ec:	c9                   	leave  
801036ed:	c3                   	ret    
801036ee:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801036f0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801036f3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801036fa:	00 00 00 
    iinit(ROOTDEV);
801036fd:	6a 01                	push   $0x1
801036ff:	e8 7c dd ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
80103704:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010370b:	e8 f0 f3 ff ff       	call   80102b00 <initlog>
80103710:	83 c4 10             	add    $0x10,%esp
}
80103713:	c9                   	leave  
80103714:	c3                   	ret    
80103715:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103720 <setproctickets>:
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	56                   	push   %esi
80103724:	53                   	push   %ebx
80103725:	8b 75 0c             	mov    0xc(%ebp),%esi
80103728:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010372b:	83 ec 0c             	sub    $0xc,%esp
8010372e:	68 00 37 11 80       	push   $0x80113700
80103733:	e8 48 0f 00 00       	call   80104680 <acquire>
80103738:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010373b:	b8 34 37 11 80       	mov    $0x80113734,%eax
80103740:	eb 12                	jmp    80103754 <setproctickets+0x34>
80103742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103748:	05 88 00 00 00       	add    $0x88,%eax
8010374d:	3d 34 59 11 80       	cmp    $0x80115934,%eax
80103752:	73 08                	jae    8010375c <setproctickets+0x3c>
    if(p->pid == pid) {
80103754:	39 58 10             	cmp    %ebx,0x10(%eax)
80103757:	75 ef                	jne    80103748 <setproctickets+0x28>
        p->tickets = n;
80103759:	89 70 7c             	mov    %esi,0x7c(%eax)
  release(&ptable.lock);
8010375c:	c7 45 08 00 37 11 80 	movl   $0x80113700,0x8(%ebp)
}
80103763:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103766:	5b                   	pop    %ebx
80103767:	5e                   	pop    %esi
80103768:	5d                   	pop    %ebp
  release(&ptable.lock);
80103769:	e9 d2 0f 00 00       	jmp    80104740 <release>
8010376e:	66 90                	xchg   %ax,%ax

80103770 <setpstat>:
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	56                   	push   %esi
80103774:	53                   	push   %ebx
      int i = p - ptable.proc;
80103775:	bb cc ff ff ff       	mov    $0xffffffcc,%ebx
{
8010377a:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
8010377d:	83 ec 0c             	sub    $0xc,%esp
      int i = p - ptable.proc;
80103780:	81 eb 00 37 11 80    	sub    $0x80113700,%ebx
  acquire(&ptable.lock);
80103786:	68 00 37 11 80       	push   $0x80113700
8010378b:	e8 f0 0e 00 00       	call   80104680 <acquire>
80103790:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103793:	b8 34 37 11 80       	mov    $0x80113734,%eax
80103798:	90                   	nop
80103799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if (p->state != UNUSED){
801037a0:	8b 50 0c             	mov    0xc(%eax),%edx
801037a3:	85 d2                	test   %edx,%edx
801037a5:	74 35                	je     801037dc <setpstat+0x6c>
      int i = p - ptable.proc;
801037a7:	8d 14 18             	lea    (%eax,%ebx,1),%edx
	  target->pid[i] = p->pid;
801037aa:	8b 48 10             	mov    0x10(%eax),%ecx
      int i = p - ptable.proc;
801037ad:	c1 fa 03             	sar    $0x3,%edx
801037b0:	69 d2 f1 f0 f0 f0    	imul   $0xf0f0f0f1,%edx,%edx
801037b6:	8d 14 96             	lea    (%esi,%edx,4),%edx
	  target->pid[i] = p->pid;
801037b9:	89 8a 00 02 00 00    	mov    %ecx,0x200(%edx)
	  target->inuse[i] = p->inuse;
801037bf:	8b 88 84 00 00 00    	mov    0x84(%eax),%ecx
801037c5:	89 0a                	mov    %ecx,(%edx)
	  target->tickets[i] = p->tickets;
801037c7:	8b 48 7c             	mov    0x7c(%eax),%ecx
801037ca:	89 8a 00 01 00 00    	mov    %ecx,0x100(%edx)
	  target->ticks[i] = p->ticks;
801037d0:	8b 88 80 00 00 00    	mov    0x80(%eax),%ecx
801037d6:	89 8a 00 03 00 00    	mov    %ecx,0x300(%edx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801037dc:	05 88 00 00 00       	add    $0x88,%eax
801037e1:	3d 34 59 11 80       	cmp    $0x80115934,%eax
801037e6:	72 b8                	jb     801037a0 <setpstat+0x30>
  release(&ptable.lock);
801037e8:	c7 45 08 00 37 11 80 	movl   $0x80113700,0x8(%ebp)
}
801037ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037f2:	5b                   	pop    %ebx
801037f3:	5e                   	pop    %esi
801037f4:	5d                   	pop    %ebp
  release(&ptable.lock);
801037f5:	e9 46 0f 00 00       	jmp    80104740 <release>
801037fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103800 <pinit>:
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103806:	68 d5 77 10 80       	push   $0x801077d5
8010380b:	68 00 37 11 80       	push   $0x80113700
80103810:	e8 2b 0d 00 00       	call   80104540 <initlock>
}
80103815:	83 c4 10             	add    $0x10,%esp
80103818:	c9                   	leave  
80103819:	c3                   	ret    
8010381a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103820 <mycpu>:
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	56                   	push   %esi
80103824:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103825:	9c                   	pushf  
80103826:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103827:	f6 c4 02             	test   $0x2,%ah
8010382a:	75 5e                	jne    8010388a <mycpu+0x6a>
  apicid = lapicid();
8010382c:	e8 ff ee ff ff       	call   80102730 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103831:	8b 35 e0 36 11 80    	mov    0x801136e0,%esi
80103837:	85 f6                	test   %esi,%esi
80103839:	7e 42                	jle    8010387d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010383b:	0f b6 15 60 31 11 80 	movzbl 0x80113160,%edx
80103842:	39 d0                	cmp    %edx,%eax
80103844:	74 30                	je     80103876 <mycpu+0x56>
80103846:	b9 10 32 11 80       	mov    $0x80113210,%ecx
  for (i = 0; i < ncpu; ++i) {
8010384b:	31 d2                	xor    %edx,%edx
8010384d:	8d 76 00             	lea    0x0(%esi),%esi
80103850:	83 c2 01             	add    $0x1,%edx
80103853:	39 f2                	cmp    %esi,%edx
80103855:	74 26                	je     8010387d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103857:	0f b6 19             	movzbl (%ecx),%ebx
8010385a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103860:	39 c3                	cmp    %eax,%ebx
80103862:	75 ec                	jne    80103850 <mycpu+0x30>
80103864:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010386a:	05 60 31 11 80       	add    $0x80113160,%eax
}
8010386f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103872:	5b                   	pop    %ebx
80103873:	5e                   	pop    %esi
80103874:	5d                   	pop    %ebp
80103875:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103876:	b8 60 31 11 80       	mov    $0x80113160,%eax
      return &cpus[i];
8010387b:	eb f2                	jmp    8010386f <mycpu+0x4f>
  panic("unknown apicid\n");
8010387d:	83 ec 0c             	sub    $0xc,%esp
80103880:	68 dc 77 10 80       	push   $0x801077dc
80103885:	e8 06 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010388a:	83 ec 0c             	sub    $0xc,%esp
8010388d:	68 b8 78 10 80       	push   $0x801078b8
80103892:	e8 f9 ca ff ff       	call   80100390 <panic>
80103897:	89 f6                	mov    %esi,%esi
80103899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038a0 <cpuid>:
cpuid() {
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801038a6:	e8 75 ff ff ff       	call   80103820 <mycpu>
801038ab:	2d 60 31 11 80       	sub    $0x80113160,%eax
}
801038b0:	c9                   	leave  
  return mycpu()-cpus;
801038b1:	c1 f8 04             	sar    $0x4,%eax
801038b4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801038ba:	c3                   	ret    
801038bb:	90                   	nop
801038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038c0 <myproc>:
myproc(void) {
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	53                   	push   %ebx
801038c4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801038c7:	e8 e4 0c 00 00       	call   801045b0 <pushcli>
  c = mycpu();
801038cc:	e8 4f ff ff ff       	call   80103820 <mycpu>
  p = c->proc;
801038d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038d7:	e8 14 0d 00 00       	call   801045f0 <popcli>
}
801038dc:	83 c4 04             	add    $0x4,%esp
801038df:	89 d8                	mov    %ebx,%eax
801038e1:	5b                   	pop    %ebx
801038e2:	5d                   	pop    %ebp
801038e3:	c3                   	ret    
801038e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038f0 <userinit>:
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	53                   	push   %ebx
801038f4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038f7:	e8 04 fd ff ff       	call   80103600 <allocproc>
801038fc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038fe:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103903:	e8 c8 36 00 00       	call   80106fd0 <setupkvm>
80103908:	85 c0                	test   %eax,%eax
8010390a:	89 43 04             	mov    %eax,0x4(%ebx)
8010390d:	0f 84 c4 00 00 00    	je     801039d7 <userinit+0xe7>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103913:	83 ec 04             	sub    $0x4,%esp
80103916:	68 2c 00 00 00       	push   $0x2c
8010391b:	68 60 a4 10 80       	push   $0x8010a460
80103920:	50                   	push   %eax
80103921:	e8 8a 33 00 00       	call   80106cb0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103926:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103929:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010392f:	6a 4c                	push   $0x4c
80103931:	6a 00                	push   $0x0
80103933:	ff 73 18             	pushl  0x18(%ebx)
80103936:	e8 55 0e 00 00       	call   80104790 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010393b:	8b 43 18             	mov    0x18(%ebx),%eax
8010393e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103943:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103948:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010394b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010394f:	8b 43 18             	mov    0x18(%ebx),%eax
80103952:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103956:	8b 43 18             	mov    0x18(%ebx),%eax
80103959:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010395d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103961:	8b 43 18             	mov    0x18(%ebx),%eax
80103964:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103968:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010396c:	8b 43 18             	mov    0x18(%ebx),%eax
8010396f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103976:	8b 43 18             	mov    0x18(%ebx),%eax
80103979:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103980:	8b 43 18             	mov    0x18(%ebx),%eax
80103983:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010398a:	8d 43 6c             	lea    0x6c(%ebx),%eax
  p->tickets = 1;
8010398d:	c7 43 7c 01 00 00 00 	movl   $0x1,0x7c(%ebx)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103994:	6a 10                	push   $0x10
80103996:	68 05 78 10 80       	push   $0x80107805
8010399b:	50                   	push   %eax
8010399c:	e8 cf 0f 00 00       	call   80104970 <safestrcpy>
  p->cwd = namei("/");
801039a1:	c7 04 24 0e 78 10 80 	movl   $0x8010780e,(%esp)
801039a8:	e8 33 e5 ff ff       	call   80101ee0 <namei>
801039ad:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801039b0:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
801039b7:	e8 c4 0c 00 00       	call   80104680 <acquire>
  p->state = RUNNABLE;
801039bc:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801039c3:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
801039ca:	e8 71 0d 00 00       	call   80104740 <release>
}
801039cf:	83 c4 10             	add    $0x10,%esp
801039d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039d5:	c9                   	leave  
801039d6:	c3                   	ret    
    panic("userinit: out of memory?");
801039d7:	83 ec 0c             	sub    $0xc,%esp
801039da:	68 ec 77 10 80       	push   $0x801077ec
801039df:	e8 ac c9 ff ff       	call   80100390 <panic>
801039e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801039ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801039f0 <growproc>:
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	56                   	push   %esi
801039f4:	53                   	push   %ebx
801039f5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039f8:	e8 b3 0b 00 00       	call   801045b0 <pushcli>
  c = mycpu();
801039fd:	e8 1e fe ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103a02:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a08:	e8 e3 0b 00 00       	call   801045f0 <popcli>
  if(n > 0){
80103a0d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103a10:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a12:	7f 1c                	jg     80103a30 <growproc+0x40>
  } else if(n < 0){
80103a14:	75 3a                	jne    80103a50 <growproc+0x60>
  switchuvm(curproc);
80103a16:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a19:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a1b:	53                   	push   %ebx
80103a1c:	e8 7f 31 00 00       	call   80106ba0 <switchuvm>
  return 0;
80103a21:	83 c4 10             	add    $0x10,%esp
80103a24:	31 c0                	xor    %eax,%eax
}
80103a26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a29:	5b                   	pop    %ebx
80103a2a:	5e                   	pop    %esi
80103a2b:	5d                   	pop    %ebp
80103a2c:	c3                   	ret    
80103a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a30:	83 ec 04             	sub    $0x4,%esp
80103a33:	01 c6                	add    %eax,%esi
80103a35:	56                   	push   %esi
80103a36:	50                   	push   %eax
80103a37:	ff 73 04             	pushl  0x4(%ebx)
80103a3a:	e8 b1 33 00 00       	call   80106df0 <allocuvm>
80103a3f:	83 c4 10             	add    $0x10,%esp
80103a42:	85 c0                	test   %eax,%eax
80103a44:	75 d0                	jne    80103a16 <growproc+0x26>
      return -1;
80103a46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a4b:	eb d9                	jmp    80103a26 <growproc+0x36>
80103a4d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a50:	83 ec 04             	sub    $0x4,%esp
80103a53:	01 c6                	add    %eax,%esi
80103a55:	56                   	push   %esi
80103a56:	50                   	push   %eax
80103a57:	ff 73 04             	pushl  0x4(%ebx)
80103a5a:	e8 c1 34 00 00       	call   80106f20 <deallocuvm>
80103a5f:	83 c4 10             	add    $0x10,%esp
80103a62:	85 c0                	test   %eax,%eax
80103a64:	75 b0                	jne    80103a16 <growproc+0x26>
80103a66:	eb de                	jmp    80103a46 <growproc+0x56>
80103a68:	90                   	nop
80103a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a70 <fork>:
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	57                   	push   %edi
80103a74:	56                   	push   %esi
80103a75:	53                   	push   %ebx
80103a76:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a79:	e8 32 0b 00 00       	call   801045b0 <pushcli>
  c = mycpu();
80103a7e:	e8 9d fd ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103a83:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a89:	e8 62 0b 00 00       	call   801045f0 <popcli>
  if((np = allocproc()) == 0){
80103a8e:	e8 6d fb ff ff       	call   80103600 <allocproc>
80103a93:	85 c0                	test   %eax,%eax
80103a95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a98:	0f 84 bf 00 00 00    	je     80103b5d <fork+0xed>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a9e:	83 ec 08             	sub    $0x8,%esp
80103aa1:	ff 33                	pushl  (%ebx)
80103aa3:	ff 73 04             	pushl  0x4(%ebx)
80103aa6:	89 c7                	mov    %eax,%edi
80103aa8:	e8 f3 35 00 00       	call   801070a0 <copyuvm>
80103aad:	83 c4 10             	add    $0x10,%esp
80103ab0:	85 c0                	test   %eax,%eax
80103ab2:	89 47 04             	mov    %eax,0x4(%edi)
80103ab5:	0f 84 a9 00 00 00    	je     80103b64 <fork+0xf4>
  np->sz = curproc->sz;
80103abb:	8b 03                	mov    (%ebx),%eax
80103abd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  *np->tf = *curproc->tf;
80103ac0:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103ac5:	89 02                	mov    %eax,(%edx)
  np->parent = curproc;
80103ac7:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80103aca:	8b 7a 18             	mov    0x18(%edx),%edi
80103acd:	8b 73 18             	mov    0x18(%ebx),%esi
80103ad0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103ad2:	31 f6                	xor    %esi,%esi
  np->tickets = curproc->tickets;
80103ad4:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103ad7:	89 42 7c             	mov    %eax,0x7c(%edx)
  np->tf->eax = 0;
80103ada:	8b 42 18             	mov    0x18(%edx),%eax
80103add:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103ae8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103aec:	85 c0                	test   %eax,%eax
80103aee:	74 13                	je     80103b03 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103af0:	83 ec 0c             	sub    $0xc,%esp
80103af3:	50                   	push   %eax
80103af4:	e8 f7 d2 ff ff       	call   80100df0 <filedup>
80103af9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103afc:	83 c4 10             	add    $0x10,%esp
80103aff:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b03:	83 c6 01             	add    $0x1,%esi
80103b06:	83 fe 10             	cmp    $0x10,%esi
80103b09:	75 dd                	jne    80103ae8 <fork+0x78>
  np->cwd = idup(curproc->cwd);
80103b0b:	83 ec 0c             	sub    $0xc,%esp
80103b0e:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b11:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103b14:	e8 37 db ff ff       	call   80101650 <idup>
80103b19:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b1c:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b1f:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b22:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b25:	6a 10                	push   $0x10
80103b27:	53                   	push   %ebx
80103b28:	50                   	push   %eax
80103b29:	e8 42 0e 00 00       	call   80104970 <safestrcpy>
  pid = np->pid;
80103b2e:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103b31:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
80103b38:	e8 43 0b 00 00       	call   80104680 <acquire>
  np->state = RUNNABLE;
80103b3d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103b44:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
80103b4b:	e8 f0 0b 00 00       	call   80104740 <release>
  return pid;
80103b50:	83 c4 10             	add    $0x10,%esp
}
80103b53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b56:	89 d8                	mov    %ebx,%eax
80103b58:	5b                   	pop    %ebx
80103b59:	5e                   	pop    %esi
80103b5a:	5f                   	pop    %edi
80103b5b:	5d                   	pop    %ebp
80103b5c:	c3                   	ret    
    return -1;
80103b5d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b62:	eb ef                	jmp    80103b53 <fork+0xe3>
    kfree(np->kstack);
80103b64:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103b67:	83 ec 0c             	sub    $0xc,%esp
80103b6a:	ff 73 08             	pushl  0x8(%ebx)
80103b6d:	e8 9e e7 ff ff       	call   80102310 <kfree>
    np->kstack = 0;
80103b72:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103b79:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b80:	83 c4 10             	add    $0x10,%esp
80103b83:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b88:	eb c9                	jmp    80103b53 <fork+0xe3>
80103b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b90 <scheduler>:
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	57                   	push   %edi
80103b94:	56                   	push   %esi
80103b95:	53                   	push   %ebx
80103b96:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103b99:	e8 82 fc ff ff       	call   80103820 <mycpu>
  c->proc = 0;
80103b9e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ba5:	00 00 00 
  struct cpu *c = mycpu();
80103ba8:	89 c3                	mov    %eax,%ebx
80103baa:	8d 40 04             	lea    0x4(%eax),%eax
80103bad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
80103bb0:	fb                   	sti    
    int total_tickets = 0;
80103bb1:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bb3:	b8 34 37 11 80       	mov    $0x80113734,%eax
80103bb8:	90                   	nop
80103bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->state != RUNNABLE)
80103bc0:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103bc4:	75 03                	jne    80103bc9 <scheduler+0x39>
      total_tickets = total_tickets + p->tickets;
80103bc6:	03 50 7c             	add    0x7c(%eax),%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bc9:	05 88 00 00 00       	add    $0x88,%eax
80103bce:	3d 34 59 11 80       	cmp    $0x80115934,%eax
80103bd3:	72 eb                	jb     80103bc0 <scheduler+0x30>
    long winner = random_at_most((long) total_tickets);
80103bd5:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bd8:	be 34 37 11 80       	mov    $0x80113734,%esi
    long winner = random_at_most((long) total_tickets);
80103bdd:	52                   	push   %edx
80103bde:	e8 ed 07 00 00       	call   801043d0 <random_at_most>
    acquire(&ptable.lock);
80103be3:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
    long winner = random_at_most((long) total_tickets);
80103bea:	89 c7                	mov    %eax,%edi
    acquire(&ptable.lock);
80103bec:	e8 8f 0a 00 00       	call   80104680 <acquire>
80103bf1:	83 c4 10             	add    $0x10,%esp
    int tickets_passed = 0;
80103bf4:	31 c9                	xor    %ecx,%ecx
      if(p->state != RUNNABLE)
80103bf6:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80103bfa:	75 74                	jne    80103c70 <scheduler+0xe0>
      tickets_passed += p->tickets;
80103bfc:	03 4e 7c             	add    0x7c(%esi),%ecx
      if(tickets_passed<winner){
80103bff:	39 cf                	cmp    %ecx,%edi
80103c01:	7f 6d                	jg     80103c70 <scheduler+0xe0>
      switchuvm(p);
80103c03:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103c06:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
      switchuvm(p);
80103c0c:	56                   	push   %esi
80103c0d:	e8 8e 2f 00 00       	call   80106ba0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c12:	58                   	pop    %eax
80103c13:	5a                   	pop    %edx
80103c14:	ff 76 1c             	pushl  0x1c(%esi)
80103c17:	ff 75 e4             	pushl  -0x1c(%ebp)
      int start_ticks = ticks;
80103c1a:	8b 3d 80 61 11 80    	mov    0x80116180,%edi
      p->state = RUNNING;
80103c20:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      p->inuse = 1;
80103c27:	c7 86 84 00 00 00 01 	movl   $0x1,0x84(%esi)
80103c2e:	00 00 00 
      swtch(&(c->scheduler), p->context);
80103c31:	e8 95 0d 00 00       	call   801049cb <swtch>
      p->ticks += ticks - start_ticks;
80103c36:	a1 80 61 11 80       	mov    0x80116180,%eax
80103c3b:	29 f8                	sub    %edi,%eax
80103c3d:	01 86 80 00 00 00    	add    %eax,0x80(%esi)
      switchkvm();
80103c43:	e8 38 2f 00 00       	call   80106b80 <switchkvm>
      c->proc = 0;
80103c48:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103c4f:	00 00 00 
      break;
80103c52:	83 c4 10             	add    $0x10,%esp
    release(&ptable.lock);
80103c55:	83 ec 0c             	sub    $0xc,%esp
80103c58:	68 00 37 11 80       	push   $0x80113700
80103c5d:	e8 de 0a 00 00       	call   80104740 <release>
  for(;;){
80103c62:	83 c4 10             	add    $0x10,%esp
80103c65:	e9 46 ff ff ff       	jmp    80103bb0 <scheduler+0x20>
80103c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c70:	81 c6 88 00 00 00    	add    $0x88,%esi
80103c76:	81 fe 34 59 11 80    	cmp    $0x80115934,%esi
80103c7c:	0f 82 74 ff ff ff    	jb     80103bf6 <scheduler+0x66>
80103c82:	eb d1                	jmp    80103c55 <scheduler+0xc5>
80103c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c90 <sched>:
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	56                   	push   %esi
80103c94:	53                   	push   %ebx
  pushcli();
80103c95:	e8 16 09 00 00       	call   801045b0 <pushcli>
  c = mycpu();
80103c9a:	e8 81 fb ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103c9f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ca5:	e8 46 09 00 00       	call   801045f0 <popcli>
  if(!holding(&ptable.lock))
80103caa:	83 ec 0c             	sub    $0xc,%esp
80103cad:	68 00 37 11 80       	push   $0x80113700
80103cb2:	e8 99 09 00 00       	call   80104650 <holding>
80103cb7:	83 c4 10             	add    $0x10,%esp
80103cba:	85 c0                	test   %eax,%eax
80103cbc:	74 4f                	je     80103d0d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cbe:	e8 5d fb ff ff       	call   80103820 <mycpu>
80103cc3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cca:	75 68                	jne    80103d34 <sched+0xa4>
  if(p->state == RUNNING)
80103ccc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cd0:	74 55                	je     80103d27 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cd2:	9c                   	pushf  
80103cd3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cd4:	f6 c4 02             	test   $0x2,%ah
80103cd7:	75 41                	jne    80103d1a <sched+0x8a>
  intena = mycpu()->intena;
80103cd9:	e8 42 fb ff ff       	call   80103820 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cde:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103ce1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103ce7:	e8 34 fb ff ff       	call   80103820 <mycpu>
80103cec:	83 ec 08             	sub    $0x8,%esp
80103cef:	ff 70 04             	pushl  0x4(%eax)
80103cf2:	53                   	push   %ebx
80103cf3:	e8 d3 0c 00 00       	call   801049cb <swtch>
  mycpu()->intena = intena;
80103cf8:	e8 23 fb ff ff       	call   80103820 <mycpu>
}
80103cfd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d00:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d09:	5b                   	pop    %ebx
80103d0a:	5e                   	pop    %esi
80103d0b:	5d                   	pop    %ebp
80103d0c:	c3                   	ret    
    panic("sched ptable.lock");
80103d0d:	83 ec 0c             	sub    $0xc,%esp
80103d10:	68 10 78 10 80       	push   $0x80107810
80103d15:	e8 76 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103d1a:	83 ec 0c             	sub    $0xc,%esp
80103d1d:	68 3c 78 10 80       	push   $0x8010783c
80103d22:	e8 69 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103d27:	83 ec 0c             	sub    $0xc,%esp
80103d2a:	68 2e 78 10 80       	push   $0x8010782e
80103d2f:	e8 5c c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103d34:	83 ec 0c             	sub    $0xc,%esp
80103d37:	68 22 78 10 80       	push   $0x80107822
80103d3c:	e8 4f c6 ff ff       	call   80100390 <panic>
80103d41:	eb 0d                	jmp    80103d50 <exit>
80103d43:	90                   	nop
80103d44:	90                   	nop
80103d45:	90                   	nop
80103d46:	90                   	nop
80103d47:	90                   	nop
80103d48:	90                   	nop
80103d49:	90                   	nop
80103d4a:	90                   	nop
80103d4b:	90                   	nop
80103d4c:	90                   	nop
80103d4d:	90                   	nop
80103d4e:	90                   	nop
80103d4f:	90                   	nop

80103d50 <exit>:
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	57                   	push   %edi
80103d54:	56                   	push   %esi
80103d55:	53                   	push   %ebx
80103d56:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d59:	e8 52 08 00 00       	call   801045b0 <pushcli>
  c = mycpu();
80103d5e:	e8 bd fa ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103d63:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d69:	e8 82 08 00 00       	call   801045f0 <popcli>
  if(curproc == initproc)
80103d6e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d74:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d77:	8d 7e 68             	lea    0x68(%esi),%edi
80103d7a:	0f 84 f1 00 00 00    	je     80103e71 <exit+0x121>
    if(curproc->ofile[fd]){
80103d80:	8b 03                	mov    (%ebx),%eax
80103d82:	85 c0                	test   %eax,%eax
80103d84:	74 12                	je     80103d98 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d86:	83 ec 0c             	sub    $0xc,%esp
80103d89:	50                   	push   %eax
80103d8a:	e8 b1 d0 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103d8f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d95:	83 c4 10             	add    $0x10,%esp
80103d98:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d9b:	39 fb                	cmp    %edi,%ebx
80103d9d:	75 e1                	jne    80103d80 <exit+0x30>
  begin_op();
80103d9f:	e8 fc ed ff ff       	call   80102ba0 <begin_op>
  iput(curproc->cwd);
80103da4:	83 ec 0c             	sub    $0xc,%esp
80103da7:	ff 76 68             	pushl  0x68(%esi)
80103daa:	e8 01 da ff ff       	call   801017b0 <iput>
  end_op();
80103daf:	e8 5c ee ff ff       	call   80102c10 <end_op>
  curproc->cwd = 0;
80103db4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103dbb:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
80103dc2:	e8 b9 08 00 00       	call   80104680 <acquire>
  wakeup1(curproc->parent);
80103dc7:	8b 56 14             	mov    0x14(%esi),%edx
80103dca:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dcd:	b8 34 37 11 80       	mov    $0x80113734,%eax
80103dd2:	eb 10                	jmp    80103de4 <exit+0x94>
80103dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dd8:	05 88 00 00 00       	add    $0x88,%eax
80103ddd:	3d 34 59 11 80       	cmp    $0x80115934,%eax
80103de2:	73 1e                	jae    80103e02 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103de4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103de8:	75 ee                	jne    80103dd8 <exit+0x88>
80103dea:	3b 50 20             	cmp    0x20(%eax),%edx
80103ded:	75 e9                	jne    80103dd8 <exit+0x88>
      p->state = RUNNABLE;
80103def:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103df6:	05 88 00 00 00       	add    $0x88,%eax
80103dfb:	3d 34 59 11 80       	cmp    $0x80115934,%eax
80103e00:	72 e2                	jb     80103de4 <exit+0x94>
      p->parent = initproc;
80103e02:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e08:	ba 34 37 11 80       	mov    $0x80113734,%edx
80103e0d:	eb 0f                	jmp    80103e1e <exit+0xce>
80103e0f:	90                   	nop
80103e10:	81 c2 88 00 00 00    	add    $0x88,%edx
80103e16:	81 fa 34 59 11 80    	cmp    $0x80115934,%edx
80103e1c:	73 3a                	jae    80103e58 <exit+0x108>
    if(p->parent == curproc){
80103e1e:	39 72 14             	cmp    %esi,0x14(%edx)
80103e21:	75 ed                	jne    80103e10 <exit+0xc0>
      if(p->state == ZOMBIE)
80103e23:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e27:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e2a:	75 e4                	jne    80103e10 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e2c:	b8 34 37 11 80       	mov    $0x80113734,%eax
80103e31:	eb 11                	jmp    80103e44 <exit+0xf4>
80103e33:	90                   	nop
80103e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e38:	05 88 00 00 00       	add    $0x88,%eax
80103e3d:	3d 34 59 11 80       	cmp    $0x80115934,%eax
80103e42:	73 cc                	jae    80103e10 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e44:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e48:	75 ee                	jne    80103e38 <exit+0xe8>
80103e4a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e4d:	75 e9                	jne    80103e38 <exit+0xe8>
      p->state = RUNNABLE;
80103e4f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e56:	eb e0                	jmp    80103e38 <exit+0xe8>
  curproc->state = ZOMBIE;
80103e58:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e5f:	e8 2c fe ff ff       	call   80103c90 <sched>
  panic("zombie exit");
80103e64:	83 ec 0c             	sub    $0xc,%esp
80103e67:	68 5d 78 10 80       	push   $0x8010785d
80103e6c:	e8 1f c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e71:	83 ec 0c             	sub    $0xc,%esp
80103e74:	68 50 78 10 80       	push   $0x80107850
80103e79:	e8 12 c5 ff ff       	call   80100390 <panic>
80103e7e:	66 90                	xchg   %ax,%ax

80103e80 <yield>:
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	53                   	push   %ebx
80103e84:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e87:	68 00 37 11 80       	push   $0x80113700
80103e8c:	e8 ef 07 00 00       	call   80104680 <acquire>
  pushcli();
80103e91:	e8 1a 07 00 00       	call   801045b0 <pushcli>
  c = mycpu();
80103e96:	e8 85 f9 ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103e9b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ea1:	e8 4a 07 00 00       	call   801045f0 <popcli>
  myproc()->state = RUNNABLE;
80103ea6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ead:	e8 de fd ff ff       	call   80103c90 <sched>
  release(&ptable.lock);
80103eb2:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
80103eb9:	e8 82 08 00 00       	call   80104740 <release>
}
80103ebe:	83 c4 10             	add    $0x10,%esp
80103ec1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ec4:	c9                   	leave  
80103ec5:	c3                   	ret    
80103ec6:	8d 76 00             	lea    0x0(%esi),%esi
80103ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ed0 <sleep>:
{
80103ed0:	55                   	push   %ebp
80103ed1:	89 e5                	mov    %esp,%ebp
80103ed3:	57                   	push   %edi
80103ed4:	56                   	push   %esi
80103ed5:	53                   	push   %ebx
80103ed6:	83 ec 0c             	sub    $0xc,%esp
80103ed9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103edc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103edf:	e8 cc 06 00 00       	call   801045b0 <pushcli>
  c = mycpu();
80103ee4:	e8 37 f9 ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103ee9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103eef:	e8 fc 06 00 00       	call   801045f0 <popcli>
  if(p == 0)
80103ef4:	85 db                	test   %ebx,%ebx
80103ef6:	0f 84 87 00 00 00    	je     80103f83 <sleep+0xb3>
  if(lk == 0)
80103efc:	85 f6                	test   %esi,%esi
80103efe:	74 76                	je     80103f76 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f00:	81 fe 00 37 11 80    	cmp    $0x80113700,%esi
80103f06:	74 50                	je     80103f58 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f08:	83 ec 0c             	sub    $0xc,%esp
80103f0b:	68 00 37 11 80       	push   $0x80113700
80103f10:	e8 6b 07 00 00       	call   80104680 <acquire>
    release(lk);
80103f15:	89 34 24             	mov    %esi,(%esp)
80103f18:	e8 23 08 00 00       	call   80104740 <release>
  p->chan = chan;
80103f1d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f20:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f27:	e8 64 fd ff ff       	call   80103c90 <sched>
  p->chan = 0;
80103f2c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f33:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
80103f3a:	e8 01 08 00 00       	call   80104740 <release>
    acquire(lk);
80103f3f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f42:	83 c4 10             	add    $0x10,%esp
}
80103f45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f48:	5b                   	pop    %ebx
80103f49:	5e                   	pop    %esi
80103f4a:	5f                   	pop    %edi
80103f4b:	5d                   	pop    %ebp
    acquire(lk);
80103f4c:	e9 2f 07 00 00       	jmp    80104680 <acquire>
80103f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f58:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f5b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f62:	e8 29 fd ff ff       	call   80103c90 <sched>
  p->chan = 0;
80103f67:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f71:	5b                   	pop    %ebx
80103f72:	5e                   	pop    %esi
80103f73:	5f                   	pop    %edi
80103f74:	5d                   	pop    %ebp
80103f75:	c3                   	ret    
    panic("sleep without lk");
80103f76:	83 ec 0c             	sub    $0xc,%esp
80103f79:	68 6f 78 10 80       	push   $0x8010786f
80103f7e:	e8 0d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103f83:	83 ec 0c             	sub    $0xc,%esp
80103f86:	68 69 78 10 80       	push   $0x80107869
80103f8b:	e8 00 c4 ff ff       	call   80100390 <panic>

80103f90 <wait>:
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	56                   	push   %esi
80103f94:	53                   	push   %ebx
  pushcli();
80103f95:	e8 16 06 00 00       	call   801045b0 <pushcli>
  c = mycpu();
80103f9a:	e8 81 f8 ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103f9f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fa5:	e8 46 06 00 00       	call   801045f0 <popcli>
  acquire(&ptable.lock);
80103faa:	83 ec 0c             	sub    $0xc,%esp
80103fad:	68 00 37 11 80       	push   $0x80113700
80103fb2:	e8 c9 06 00 00       	call   80104680 <acquire>
80103fb7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103fba:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fbc:	bb 34 37 11 80       	mov    $0x80113734,%ebx
80103fc1:	eb 13                	jmp    80103fd6 <wait+0x46>
80103fc3:	90                   	nop
80103fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fc8:	81 c3 88 00 00 00    	add    $0x88,%ebx
80103fce:	81 fb 34 59 11 80    	cmp    $0x80115934,%ebx
80103fd4:	73 1e                	jae    80103ff4 <wait+0x64>
      if(p->parent != curproc)
80103fd6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103fd9:	75 ed                	jne    80103fc8 <wait+0x38>
      if(p->state == ZOMBIE){
80103fdb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fdf:	74 37                	je     80104018 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fe1:	81 c3 88 00 00 00    	add    $0x88,%ebx
      havekids = 1;
80103fe7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fec:	81 fb 34 59 11 80    	cmp    $0x80115934,%ebx
80103ff2:	72 e2                	jb     80103fd6 <wait+0x46>
    if(!havekids || curproc->killed){
80103ff4:	85 c0                	test   %eax,%eax
80103ff6:	74 76                	je     8010406e <wait+0xde>
80103ff8:	8b 46 24             	mov    0x24(%esi),%eax
80103ffb:	85 c0                	test   %eax,%eax
80103ffd:	75 6f                	jne    8010406e <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103fff:	83 ec 08             	sub    $0x8,%esp
80104002:	68 00 37 11 80       	push   $0x80113700
80104007:	56                   	push   %esi
80104008:	e8 c3 fe ff ff       	call   80103ed0 <sleep>
    havekids = 0;
8010400d:	83 c4 10             	add    $0x10,%esp
80104010:	eb a8                	jmp    80103fba <wait+0x2a>
80104012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104018:	83 ec 0c             	sub    $0xc,%esp
8010401b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010401e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104021:	e8 ea e2 ff ff       	call   80102310 <kfree>
        freevm(p->pgdir);
80104026:	5a                   	pop    %edx
80104027:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010402a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104031:	e8 1a 2f 00 00       	call   80106f50 <freevm>
        release(&ptable.lock);
80104036:	c7 04 24 00 37 11 80 	movl   $0x80113700,(%esp)
        p->pid = 0;
8010403d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104044:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010404b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010404f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104056:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010405d:	e8 de 06 00 00       	call   80104740 <release>
        return pid;
80104062:	83 c4 10             	add    $0x10,%esp
}
80104065:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104068:	89 f0                	mov    %esi,%eax
8010406a:	5b                   	pop    %ebx
8010406b:	5e                   	pop    %esi
8010406c:	5d                   	pop    %ebp
8010406d:	c3                   	ret    
      release(&ptable.lock);
8010406e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104071:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104076:	68 00 37 11 80       	push   $0x80113700
8010407b:	e8 c0 06 00 00       	call   80104740 <release>
      return -1;
80104080:	83 c4 10             	add    $0x10,%esp
80104083:	eb e0                	jmp    80104065 <wait+0xd5>
80104085:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104090 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	53                   	push   %ebx
80104094:	83 ec 10             	sub    $0x10,%esp
80104097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010409a:	68 00 37 11 80       	push   $0x80113700
8010409f:	e8 dc 05 00 00       	call   80104680 <acquire>
801040a4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040a7:	b8 34 37 11 80       	mov    $0x80113734,%eax
801040ac:	eb 0e                	jmp    801040bc <wakeup+0x2c>
801040ae:	66 90                	xchg   %ax,%ax
801040b0:	05 88 00 00 00       	add    $0x88,%eax
801040b5:	3d 34 59 11 80       	cmp    $0x80115934,%eax
801040ba:	73 1e                	jae    801040da <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801040bc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040c0:	75 ee                	jne    801040b0 <wakeup+0x20>
801040c2:	3b 58 20             	cmp    0x20(%eax),%ebx
801040c5:	75 e9                	jne    801040b0 <wakeup+0x20>
      p->state = RUNNABLE;
801040c7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040ce:	05 88 00 00 00       	add    $0x88,%eax
801040d3:	3d 34 59 11 80       	cmp    $0x80115934,%eax
801040d8:	72 e2                	jb     801040bc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801040da:	c7 45 08 00 37 11 80 	movl   $0x80113700,0x8(%ebp)
}
801040e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040e4:	c9                   	leave  
  release(&ptable.lock);
801040e5:	e9 56 06 00 00       	jmp    80104740 <release>
801040ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040f0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	53                   	push   %ebx
801040f4:	83 ec 10             	sub    $0x10,%esp
801040f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801040fa:	68 00 37 11 80       	push   $0x80113700
801040ff:	e8 7c 05 00 00       	call   80104680 <acquire>
80104104:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104107:	b8 34 37 11 80       	mov    $0x80113734,%eax
8010410c:	eb 0e                	jmp    8010411c <kill+0x2c>
8010410e:	66 90                	xchg   %ax,%ax
80104110:	05 88 00 00 00       	add    $0x88,%eax
80104115:	3d 34 59 11 80       	cmp    $0x80115934,%eax
8010411a:	73 34                	jae    80104150 <kill+0x60>
    if(p->pid == pid){
8010411c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010411f:	75 ef                	jne    80104110 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104121:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104125:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010412c:	75 07                	jne    80104135 <kill+0x45>
        p->state = RUNNABLE;
8010412e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104135:	83 ec 0c             	sub    $0xc,%esp
80104138:	68 00 37 11 80       	push   $0x80113700
8010413d:	e8 fe 05 00 00       	call   80104740 <release>
      return 0;
80104142:	83 c4 10             	add    $0x10,%esp
80104145:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104147:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010414a:	c9                   	leave  
8010414b:	c3                   	ret    
8010414c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104150:	83 ec 0c             	sub    $0xc,%esp
80104153:	68 00 37 11 80       	push   $0x80113700
80104158:	e8 e3 05 00 00       	call   80104740 <release>
  return -1;
8010415d:	83 c4 10             	add    $0x10,%esp
80104160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104165:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104168:	c9                   	leave  
80104169:	c3                   	ret    
8010416a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104170 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	57                   	push   %edi
80104174:	56                   	push   %esi
80104175:	53                   	push   %ebx
80104176:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104179:	bb 34 37 11 80       	mov    $0x80113734,%ebx
{
8010417e:	83 ec 3c             	sub    $0x3c,%esp
80104181:	eb 27                	jmp    801041aa <procdump+0x3a>
80104183:	90                   	nop
80104184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104188:	83 ec 0c             	sub    $0xc,%esp
8010418b:	68 ff 7b 10 80       	push   $0x80107bff
80104190:	e8 cb c4 ff ff       	call   80100660 <cprintf>
80104195:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104198:	81 c3 88 00 00 00    	add    $0x88,%ebx
8010419e:	81 fb 34 59 11 80    	cmp    $0x80115934,%ebx
801041a4:	0f 83 86 00 00 00    	jae    80104230 <procdump+0xc0>
    if(p->state == UNUSED)
801041aa:	8b 43 0c             	mov    0xc(%ebx),%eax
801041ad:	85 c0                	test   %eax,%eax
801041af:	74 e7                	je     80104198 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041b1:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801041b4:	ba 80 78 10 80       	mov    $0x80107880,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041b9:	77 11                	ja     801041cc <procdump+0x5c>
801041bb:	8b 14 85 e0 78 10 80 	mov    -0x7fef8720(,%eax,4),%edx
      state = "???";
801041c2:	b8 80 78 10 80       	mov    $0x80107880,%eax
801041c7:	85 d2                	test   %edx,%edx
801041c9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801041cc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041cf:	50                   	push   %eax
801041d0:	52                   	push   %edx
801041d1:	ff 73 10             	pushl  0x10(%ebx)
801041d4:	68 84 78 10 80       	push   $0x80107884
801041d9:	e8 82 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801041de:	83 c4 10             	add    $0x10,%esp
801041e1:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801041e5:	75 a1                	jne    80104188 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041e7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041ea:	83 ec 08             	sub    $0x8,%esp
801041ed:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041f0:	50                   	push   %eax
801041f1:	8b 43 1c             	mov    0x1c(%ebx),%eax
801041f4:	8b 40 0c             	mov    0xc(%eax),%eax
801041f7:	83 c0 08             	add    $0x8,%eax
801041fa:	50                   	push   %eax
801041fb:	e8 60 03 00 00       	call   80104560 <getcallerpcs>
80104200:	83 c4 10             	add    $0x10,%esp
80104203:	90                   	nop
80104204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104208:	8b 17                	mov    (%edi),%edx
8010420a:	85 d2                	test   %edx,%edx
8010420c:	0f 84 76 ff ff ff    	je     80104188 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104212:	83 ec 08             	sub    $0x8,%esp
80104215:	83 c7 04             	add    $0x4,%edi
80104218:	52                   	push   %edx
80104219:	68 c1 72 10 80       	push   $0x801072c1
8010421e:	e8 3d c4 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104223:	83 c4 10             	add    $0x10,%esp
80104226:	39 fe                	cmp    %edi,%esi
80104228:	75 de                	jne    80104208 <procdump+0x98>
8010422a:	e9 59 ff ff ff       	jmp    80104188 <procdump+0x18>
8010422f:	90                   	nop
  }
}
80104230:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104233:	5b                   	pop    %ebx
80104234:	5e                   	pop    %esi
80104235:	5f                   	pop    %edi
80104236:	5d                   	pop    %ebp
80104237:	c3                   	ret    
80104238:	66 90                	xchg   %ax,%ax
8010423a:	66 90                	xchg   %ax,%ax
8010423c:	66 90                	xchg   %ax,%ax
8010423e:	66 90                	xchg   %ax,%ax

80104240 <sgenrand>:
80104240:	55                   	push   %ebp
80104241:	b8 c4 a5 10 80       	mov    $0x8010a5c4,%eax
80104246:	b9 7c af 10 80       	mov    $0x8010af7c,%ecx
8010424b:	89 e5                	mov    %esp,%ebp
8010424d:	8b 55 08             	mov    0x8(%ebp),%edx
80104250:	89 15 c0 a5 10 80    	mov    %edx,0x8010a5c0
80104256:	eb 0b                	jmp    80104263 <sgenrand+0x23>
80104258:	90                   	nop
80104259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104260:	83 c0 04             	add    $0x4,%eax
80104263:	69 d2 cd 0d 01 00    	imul   $0x10dcd,%edx,%edx
80104269:	39 c1                	cmp    %eax,%ecx
8010426b:	89 10                	mov    %edx,(%eax)
8010426d:	75 f1                	jne    80104260 <sgenrand+0x20>
8010426f:	c7 05 08 a0 10 80 70 	movl   $0x270,0x8010a008
80104276:	02 00 00 
80104279:	5d                   	pop    %ebp
8010427a:	c3                   	ret    
8010427b:	90                   	nop
8010427c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104280 <genrand>:
80104280:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80104285:	55                   	push   %ebp
80104286:	89 e5                	mov    %esp,%ebp
80104288:	56                   	push   %esi
80104289:	53                   	push   %ebx
8010428a:	3d 6f 02 00 00       	cmp    $0x26f,%eax
8010428f:	0f 8e f9 00 00 00    	jle    8010438e <genrand+0x10e>
80104295:	3d 71 02 00 00       	cmp    $0x271,%eax
8010429a:	0f 84 fa 00 00 00    	je     8010439a <genrand+0x11a>
801042a0:	ba c0 a5 10 80       	mov    $0x8010a5c0,%edx
801042a5:	bb 4c a9 10 80       	mov    $0x8010a94c,%ebx
801042aa:	89 d1                	mov    %edx,%ecx
801042ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042b0:	8b 01                	mov    (%ecx),%eax
801042b2:	8b 71 04             	mov    0x4(%ecx),%esi
801042b5:	83 c1 04             	add    $0x4,%ecx
801042b8:	81 e6 ff ff ff 7f    	and    $0x7fffffff,%esi
801042be:	25 00 00 00 80       	and    $0x80000000,%eax
801042c3:	09 f0                	or     %esi,%eax
801042c5:	89 c6                	mov    %eax,%esi
801042c7:	83 e0 01             	and    $0x1,%eax
801042ca:	d1 ee                	shr    %esi
801042cc:	33 b1 30 06 00 00    	xor    0x630(%ecx),%esi
801042d2:	33 34 85 f8 78 10 80 	xor    -0x7fef8708(,%eax,4),%esi
801042d9:	89 71 fc             	mov    %esi,-0x4(%ecx)
801042dc:	39 cb                	cmp    %ecx,%ebx
801042de:	75 d0                	jne    801042b0 <genrand+0x30>
801042e0:	b9 f0 ab 10 80       	mov    $0x8010abf0,%ecx
801042e5:	8d 76 00             	lea    0x0(%esi),%esi
801042e8:	8b 82 8c 03 00 00    	mov    0x38c(%edx),%eax
801042ee:	8b 9a 90 03 00 00    	mov    0x390(%edx),%ebx
801042f4:	83 c2 04             	add    $0x4,%edx
801042f7:	81 e3 ff ff ff 7f    	and    $0x7fffffff,%ebx
801042fd:	25 00 00 00 80       	and    $0x80000000,%eax
80104302:	09 d8                	or     %ebx,%eax
80104304:	89 c3                	mov    %eax,%ebx
80104306:	83 e0 01             	and    $0x1,%eax
80104309:	d1 eb                	shr    %ebx
8010430b:	33 5a fc             	xor    -0x4(%edx),%ebx
8010430e:	33 1c 85 f8 78 10 80 	xor    -0x7fef8708(,%eax,4),%ebx
80104315:	89 9a 88 03 00 00    	mov    %ebx,0x388(%edx)
8010431b:	39 d1                	cmp    %edx,%ecx
8010431d:	75 c9                	jne    801042e8 <genrand+0x68>
8010431f:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80104324:	8b 0d 7c af 10 80    	mov    0x8010af7c,%ecx
8010432a:	89 c2                	mov    %eax,%edx
8010432c:	81 e1 00 00 00 80    	and    $0x80000000,%ecx
80104332:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
80104338:	09 d1                	or     %edx,%ecx
8010433a:	89 ca                	mov    %ecx,%edx
8010433c:	83 e1 01             	and    $0x1,%ecx
8010433f:	d1 ea                	shr    %edx
80104341:	33 15 f0 ab 10 80    	xor    0x8010abf0,%edx
80104347:	33 14 8d f8 78 10 80 	xor    -0x7fef8708(,%ecx,4),%edx
8010434e:	89 15 7c af 10 80    	mov    %edx,0x8010af7c
80104354:	ba 01 00 00 00       	mov    $0x1,%edx
80104359:	89 15 08 a0 10 80    	mov    %edx,0x8010a008
8010435f:	89 c2                	mov    %eax,%edx
80104361:	c1 ea 0b             	shr    $0xb,%edx
80104364:	31 c2                	xor    %eax,%edx
80104366:	89 d0                	mov    %edx,%eax
80104368:	c1 e0 07             	shl    $0x7,%eax
8010436b:	25 80 56 2c 9d       	and    $0x9d2c5680,%eax
80104370:	31 c2                	xor    %eax,%edx
80104372:	89 d0                	mov    %edx,%eax
80104374:	c1 e0 0f             	shl    $0xf,%eax
80104377:	25 00 00 c6 ef       	and    $0xefc60000,%eax
8010437c:	31 d0                	xor    %edx,%eax
8010437e:	89 c2                	mov    %eax,%edx
80104380:	c1 ea 12             	shr    $0x12,%edx
80104383:	31 d0                	xor    %edx,%eax
80104385:	5b                   	pop    %ebx
80104386:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
8010438b:	5e                   	pop    %esi
8010438c:	5d                   	pop    %ebp
8010438d:	c3                   	ret    
8010438e:	8d 50 01             	lea    0x1(%eax),%edx
80104391:	8b 04 85 c0 a5 10 80 	mov    -0x7fef5a40(,%eax,4),%eax
80104398:	eb bf                	jmp    80104359 <genrand+0xd9>
8010439a:	c7 05 c0 a5 10 80 05 	movl   $0x1105,0x8010a5c0
801043a1:	11 00 00 
801043a4:	b8 c4 a5 10 80       	mov    $0x8010a5c4,%eax
801043a9:	b9 7c af 10 80       	mov    $0x8010af7c,%ecx
801043ae:	ba 05 11 00 00       	mov    $0x1105,%edx
801043b3:	eb 06                	jmp    801043bb <genrand+0x13b>
801043b5:	8d 76 00             	lea    0x0(%esi),%esi
801043b8:	83 c0 04             	add    $0x4,%eax
801043bb:	69 d2 cd 0d 01 00    	imul   $0x10dcd,%edx,%edx
801043c1:	39 c1                	cmp    %eax,%ecx
801043c3:	89 10                	mov    %edx,(%eax)
801043c5:	75 f1                	jne    801043b8 <genrand+0x138>
801043c7:	e9 d4 fe ff ff       	jmp    801042a0 <genrand+0x20>
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043d0 <random_at_most>:
801043d0:	55                   	push   %ebp
801043d1:	31 d2                	xor    %edx,%edx
801043d3:	89 e5                	mov    %esp,%ebp
801043d5:	56                   	push   %esi
801043d6:	53                   	push   %ebx
801043d7:	8b 45 08             	mov    0x8(%ebp),%eax
801043da:	bb 00 00 00 80       	mov    $0x80000000,%ebx
801043df:	8d 48 01             	lea    0x1(%eax),%ecx
801043e2:	89 d8                	mov    %ebx,%eax
801043e4:	f7 f1                	div    %ecx
801043e6:	89 c6                	mov    %eax,%esi
801043e8:	29 d3                	sub    %edx,%ebx
801043ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043f0:	e8 8b fe ff ff       	call   80104280 <genrand>
801043f5:	39 d8                	cmp    %ebx,%eax
801043f7:	73 f7                	jae    801043f0 <random_at_most+0x20>
801043f9:	31 d2                	xor    %edx,%edx
801043fb:	f7 f6                	div    %esi
801043fd:	5b                   	pop    %ebx
801043fe:	5e                   	pop    %esi
801043ff:	5d                   	pop    %ebp
80104400:	c3                   	ret    
80104401:	66 90                	xchg   %ax,%ax
80104403:	66 90                	xchg   %ax,%ax
80104405:	66 90                	xchg   %ax,%ax
80104407:	66 90                	xchg   %ax,%ax
80104409:	66 90                	xchg   %ax,%ax
8010440b:	66 90                	xchg   %ax,%ax
8010440d:	66 90                	xchg   %ax,%ax
8010440f:	90                   	nop

80104410 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	53                   	push   %ebx
80104414:	83 ec 0c             	sub    $0xc,%esp
80104417:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010441a:	68 00 79 10 80       	push   $0x80107900
8010441f:	8d 43 04             	lea    0x4(%ebx),%eax
80104422:	50                   	push   %eax
80104423:	e8 18 01 00 00       	call   80104540 <initlock>
  lk->name = name;
80104428:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010442b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104431:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104434:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010443b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010443e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104441:	c9                   	leave  
80104442:	c3                   	ret    
80104443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104450 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	56                   	push   %esi
80104454:	53                   	push   %ebx
80104455:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104458:	83 ec 0c             	sub    $0xc,%esp
8010445b:	8d 73 04             	lea    0x4(%ebx),%esi
8010445e:	56                   	push   %esi
8010445f:	e8 1c 02 00 00       	call   80104680 <acquire>
  while (lk->locked) {
80104464:	8b 13                	mov    (%ebx),%edx
80104466:	83 c4 10             	add    $0x10,%esp
80104469:	85 d2                	test   %edx,%edx
8010446b:	74 16                	je     80104483 <acquiresleep+0x33>
8010446d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104470:	83 ec 08             	sub    $0x8,%esp
80104473:	56                   	push   %esi
80104474:	53                   	push   %ebx
80104475:	e8 56 fa ff ff       	call   80103ed0 <sleep>
  while (lk->locked) {
8010447a:	8b 03                	mov    (%ebx),%eax
8010447c:	83 c4 10             	add    $0x10,%esp
8010447f:	85 c0                	test   %eax,%eax
80104481:	75 ed                	jne    80104470 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104483:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104489:	e8 32 f4 ff ff       	call   801038c0 <myproc>
8010448e:	8b 40 10             	mov    0x10(%eax),%eax
80104491:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104494:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104497:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010449a:	5b                   	pop    %ebx
8010449b:	5e                   	pop    %esi
8010449c:	5d                   	pop    %ebp
  release(&lk->lk);
8010449d:	e9 9e 02 00 00       	jmp    80104740 <release>
801044a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044b0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	56                   	push   %esi
801044b4:	53                   	push   %ebx
801044b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801044b8:	83 ec 0c             	sub    $0xc,%esp
801044bb:	8d 73 04             	lea    0x4(%ebx),%esi
801044be:	56                   	push   %esi
801044bf:	e8 bc 01 00 00       	call   80104680 <acquire>
  lk->locked = 0;
801044c4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801044ca:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801044d1:	89 1c 24             	mov    %ebx,(%esp)
801044d4:	e8 b7 fb ff ff       	call   80104090 <wakeup>
  release(&lk->lk);
801044d9:	89 75 08             	mov    %esi,0x8(%ebp)
801044dc:	83 c4 10             	add    $0x10,%esp
}
801044df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044e2:	5b                   	pop    %ebx
801044e3:	5e                   	pop    %esi
801044e4:	5d                   	pop    %ebp
  release(&lk->lk);
801044e5:	e9 56 02 00 00       	jmp    80104740 <release>
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044f0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	57                   	push   %edi
801044f4:	56                   	push   %esi
801044f5:	53                   	push   %ebx
801044f6:	31 ff                	xor    %edi,%edi
801044f8:	83 ec 18             	sub    $0x18,%esp
801044fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801044fe:	8d 73 04             	lea    0x4(%ebx),%esi
80104501:	56                   	push   %esi
80104502:	e8 79 01 00 00       	call   80104680 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104507:	8b 03                	mov    (%ebx),%eax
80104509:	83 c4 10             	add    $0x10,%esp
8010450c:	85 c0                	test   %eax,%eax
8010450e:	74 13                	je     80104523 <holdingsleep+0x33>
80104510:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104513:	e8 a8 f3 ff ff       	call   801038c0 <myproc>
80104518:	39 58 10             	cmp    %ebx,0x10(%eax)
8010451b:	0f 94 c0             	sete   %al
8010451e:	0f b6 c0             	movzbl %al,%eax
80104521:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104523:	83 ec 0c             	sub    $0xc,%esp
80104526:	56                   	push   %esi
80104527:	e8 14 02 00 00       	call   80104740 <release>
  return r;
}
8010452c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010452f:	89 f8                	mov    %edi,%eax
80104531:	5b                   	pop    %ebx
80104532:	5e                   	pop    %esi
80104533:	5f                   	pop    %edi
80104534:	5d                   	pop    %ebp
80104535:	c3                   	ret    
80104536:	66 90                	xchg   %ax,%ax
80104538:	66 90                	xchg   %ax,%ax
8010453a:	66 90                	xchg   %ax,%ax
8010453c:	66 90                	xchg   %ax,%ax
8010453e:	66 90                	xchg   %ax,%ax

80104540 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104546:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104549:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010454f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104552:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104559:	5d                   	pop    %ebp
8010455a:	c3                   	ret    
8010455b:	90                   	nop
8010455c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104560 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104560:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104561:	31 d2                	xor    %edx,%edx
{
80104563:	89 e5                	mov    %esp,%ebp
80104565:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104566:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104569:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010456c:	83 e8 08             	sub    $0x8,%eax
8010456f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104570:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104576:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010457c:	77 1a                	ja     80104598 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010457e:	8b 58 04             	mov    0x4(%eax),%ebx
80104581:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104584:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104587:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104589:	83 fa 0a             	cmp    $0xa,%edx
8010458c:	75 e2                	jne    80104570 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010458e:	5b                   	pop    %ebx
8010458f:	5d                   	pop    %ebp
80104590:	c3                   	ret    
80104591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104598:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010459b:	83 c1 28             	add    $0x28,%ecx
8010459e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801045a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801045a6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801045a9:	39 c1                	cmp    %eax,%ecx
801045ab:	75 f3                	jne    801045a0 <getcallerpcs+0x40>
}
801045ad:	5b                   	pop    %ebx
801045ae:	5d                   	pop    %ebp
801045af:	c3                   	ret    

801045b0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	53                   	push   %ebx
801045b4:	83 ec 04             	sub    $0x4,%esp
801045b7:	9c                   	pushf  
801045b8:	5b                   	pop    %ebx
  asm volatile("cli");
801045b9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801045ba:	e8 61 f2 ff ff       	call   80103820 <mycpu>
801045bf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801045c5:	85 c0                	test   %eax,%eax
801045c7:	75 11                	jne    801045da <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801045c9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801045cf:	e8 4c f2 ff ff       	call   80103820 <mycpu>
801045d4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801045da:	e8 41 f2 ff ff       	call   80103820 <mycpu>
801045df:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801045e6:	83 c4 04             	add    $0x4,%esp
801045e9:	5b                   	pop    %ebx
801045ea:	5d                   	pop    %ebp
801045eb:	c3                   	ret    
801045ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045f0 <popcli>:

void
popcli(void)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045f6:	9c                   	pushf  
801045f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045f8:	f6 c4 02             	test   $0x2,%ah
801045fb:	75 35                	jne    80104632 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801045fd:	e8 1e f2 ff ff       	call   80103820 <mycpu>
80104602:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104609:	78 34                	js     8010463f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010460b:	e8 10 f2 ff ff       	call   80103820 <mycpu>
80104610:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104616:	85 d2                	test   %edx,%edx
80104618:	74 06                	je     80104620 <popcli+0x30>
    sti();
}
8010461a:	c9                   	leave  
8010461b:	c3                   	ret    
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104620:	e8 fb f1 ff ff       	call   80103820 <mycpu>
80104625:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010462b:	85 c0                	test   %eax,%eax
8010462d:	74 eb                	je     8010461a <popcli+0x2a>
  asm volatile("sti");
8010462f:	fb                   	sti    
}
80104630:	c9                   	leave  
80104631:	c3                   	ret    
    panic("popcli - interruptible");
80104632:	83 ec 0c             	sub    $0xc,%esp
80104635:	68 0b 79 10 80       	push   $0x8010790b
8010463a:	e8 51 bd ff ff       	call   80100390 <panic>
    panic("popcli");
8010463f:	83 ec 0c             	sub    $0xc,%esp
80104642:	68 22 79 10 80       	push   $0x80107922
80104647:	e8 44 bd ff ff       	call   80100390 <panic>
8010464c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104650 <holding>:
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	8b 75 08             	mov    0x8(%ebp),%esi
80104658:	31 db                	xor    %ebx,%ebx
  pushcli();
8010465a:	e8 51 ff ff ff       	call   801045b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010465f:	8b 06                	mov    (%esi),%eax
80104661:	85 c0                	test   %eax,%eax
80104663:	74 10                	je     80104675 <holding+0x25>
80104665:	8b 5e 08             	mov    0x8(%esi),%ebx
80104668:	e8 b3 f1 ff ff       	call   80103820 <mycpu>
8010466d:	39 c3                	cmp    %eax,%ebx
8010466f:	0f 94 c3             	sete   %bl
80104672:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104675:	e8 76 ff ff ff       	call   801045f0 <popcli>
}
8010467a:	89 d8                	mov    %ebx,%eax
8010467c:	5b                   	pop    %ebx
8010467d:	5e                   	pop    %esi
8010467e:	5d                   	pop    %ebp
8010467f:	c3                   	ret    

80104680 <acquire>:
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	56                   	push   %esi
80104684:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104685:	e8 26 ff ff ff       	call   801045b0 <pushcli>
  if(holding(lk))
8010468a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010468d:	83 ec 0c             	sub    $0xc,%esp
80104690:	53                   	push   %ebx
80104691:	e8 ba ff ff ff       	call   80104650 <holding>
80104696:	83 c4 10             	add    $0x10,%esp
80104699:	85 c0                	test   %eax,%eax
8010469b:	0f 85 83 00 00 00    	jne    80104724 <acquire+0xa4>
801046a1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801046a3:	ba 01 00 00 00       	mov    $0x1,%edx
801046a8:	eb 09                	jmp    801046b3 <acquire+0x33>
801046aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046b3:	89 d0                	mov    %edx,%eax
801046b5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801046b8:	85 c0                	test   %eax,%eax
801046ba:	75 f4                	jne    801046b0 <acquire+0x30>
  __sync_synchronize();
801046bc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801046c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046c4:	e8 57 f1 ff ff       	call   80103820 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801046c9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801046cc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801046cf:	89 e8                	mov    %ebp,%eax
801046d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046d8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801046de:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801046e4:	77 1a                	ja     80104700 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801046e6:	8b 48 04             	mov    0x4(%eax),%ecx
801046e9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801046ec:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801046ef:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801046f1:	83 fe 0a             	cmp    $0xa,%esi
801046f4:	75 e2                	jne    801046d8 <acquire+0x58>
}
801046f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046f9:	5b                   	pop    %ebx
801046fa:	5e                   	pop    %esi
801046fb:	5d                   	pop    %ebp
801046fc:	c3                   	ret    
801046fd:	8d 76 00             	lea    0x0(%esi),%esi
80104700:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104703:	83 c2 28             	add    $0x28,%edx
80104706:	8d 76 00             	lea    0x0(%esi),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104710:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104716:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104719:	39 d0                	cmp    %edx,%eax
8010471b:	75 f3                	jne    80104710 <acquire+0x90>
}
8010471d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104720:	5b                   	pop    %ebx
80104721:	5e                   	pop    %esi
80104722:	5d                   	pop    %ebp
80104723:	c3                   	ret    
    panic("acquire");
80104724:	83 ec 0c             	sub    $0xc,%esp
80104727:	68 29 79 10 80       	push   $0x80107929
8010472c:	e8 5f bc ff ff       	call   80100390 <panic>
80104731:	eb 0d                	jmp    80104740 <release>
80104733:	90                   	nop
80104734:	90                   	nop
80104735:	90                   	nop
80104736:	90                   	nop
80104737:	90                   	nop
80104738:	90                   	nop
80104739:	90                   	nop
8010473a:	90                   	nop
8010473b:	90                   	nop
8010473c:	90                   	nop
8010473d:	90                   	nop
8010473e:	90                   	nop
8010473f:	90                   	nop

80104740 <release>:
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	53                   	push   %ebx
80104744:	83 ec 10             	sub    $0x10,%esp
80104747:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010474a:	53                   	push   %ebx
8010474b:	e8 00 ff ff ff       	call   80104650 <holding>
80104750:	83 c4 10             	add    $0x10,%esp
80104753:	85 c0                	test   %eax,%eax
80104755:	74 22                	je     80104779 <release+0x39>
  lk->pcs[0] = 0;
80104757:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010475e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104765:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010476a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104770:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104773:	c9                   	leave  
  popcli();
80104774:	e9 77 fe ff ff       	jmp    801045f0 <popcli>
    panic("release");
80104779:	83 ec 0c             	sub    $0xc,%esp
8010477c:	68 31 79 10 80       	push   $0x80107931
80104781:	e8 0a bc ff ff       	call   80100390 <panic>
80104786:	66 90                	xchg   %ax,%ax
80104788:	66 90                	xchg   %ax,%ax
8010478a:	66 90                	xchg   %ax,%ax
8010478c:	66 90                	xchg   %ax,%ax
8010478e:	66 90                	xchg   %ax,%ax

80104790 <memset>:
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	57                   	push   %edi
80104794:	53                   	push   %ebx
80104795:	8b 55 08             	mov    0x8(%ebp),%edx
80104798:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010479b:	f6 c2 03             	test   $0x3,%dl
8010479e:	75 05                	jne    801047a5 <memset+0x15>
801047a0:	f6 c1 03             	test   $0x3,%cl
801047a3:	74 13                	je     801047b8 <memset+0x28>
801047a5:	89 d7                	mov    %edx,%edi
801047a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801047aa:	fc                   	cld    
801047ab:	f3 aa                	rep stos %al,%es:(%edi)
801047ad:	5b                   	pop    %ebx
801047ae:	89 d0                	mov    %edx,%eax
801047b0:	5f                   	pop    %edi
801047b1:	5d                   	pop    %ebp
801047b2:	c3                   	ret    
801047b3:	90                   	nop
801047b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047b8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
801047bc:	c1 e9 02             	shr    $0x2,%ecx
801047bf:	89 f8                	mov    %edi,%eax
801047c1:	89 fb                	mov    %edi,%ebx
801047c3:	c1 e0 18             	shl    $0x18,%eax
801047c6:	c1 e3 10             	shl    $0x10,%ebx
801047c9:	09 d8                	or     %ebx,%eax
801047cb:	09 f8                	or     %edi,%eax
801047cd:	c1 e7 08             	shl    $0x8,%edi
801047d0:	09 f8                	or     %edi,%eax
801047d2:	89 d7                	mov    %edx,%edi
801047d4:	fc                   	cld    
801047d5:	f3 ab                	rep stos %eax,%es:(%edi)
801047d7:	5b                   	pop    %ebx
801047d8:	89 d0                	mov    %edx,%eax
801047da:	5f                   	pop    %edi
801047db:	5d                   	pop    %ebp
801047dc:	c3                   	ret    
801047dd:	8d 76 00             	lea    0x0(%esi),%esi

801047e0 <memcmp>:
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	57                   	push   %edi
801047e4:	56                   	push   %esi
801047e5:	53                   	push   %ebx
801047e6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801047e9:	8b 75 08             	mov    0x8(%ebp),%esi
801047ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
801047ef:	85 db                	test   %ebx,%ebx
801047f1:	74 29                	je     8010481c <memcmp+0x3c>
801047f3:	0f b6 16             	movzbl (%esi),%edx
801047f6:	0f b6 0f             	movzbl (%edi),%ecx
801047f9:	38 d1                	cmp    %dl,%cl
801047fb:	75 2b                	jne    80104828 <memcmp+0x48>
801047fd:	b8 01 00 00 00       	mov    $0x1,%eax
80104802:	eb 14                	jmp    80104818 <memcmp+0x38>
80104804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104808:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010480c:	83 c0 01             	add    $0x1,%eax
8010480f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104814:	38 ca                	cmp    %cl,%dl
80104816:	75 10                	jne    80104828 <memcmp+0x48>
80104818:	39 d8                	cmp    %ebx,%eax
8010481a:	75 ec                	jne    80104808 <memcmp+0x28>
8010481c:	5b                   	pop    %ebx
8010481d:	31 c0                	xor    %eax,%eax
8010481f:	5e                   	pop    %esi
80104820:	5f                   	pop    %edi
80104821:	5d                   	pop    %ebp
80104822:	c3                   	ret    
80104823:	90                   	nop
80104824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104828:	0f b6 c2             	movzbl %dl,%eax
8010482b:	5b                   	pop    %ebx
8010482c:	29 c8                	sub    %ecx,%eax
8010482e:	5e                   	pop    %esi
8010482f:	5f                   	pop    %edi
80104830:	5d                   	pop    %ebp
80104831:	c3                   	ret    
80104832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104840 <memmove>:
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	56                   	push   %esi
80104844:	53                   	push   %ebx
80104845:	8b 45 08             	mov    0x8(%ebp),%eax
80104848:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010484b:	8b 75 10             	mov    0x10(%ebp),%esi
8010484e:	39 c3                	cmp    %eax,%ebx
80104850:	73 26                	jae    80104878 <memmove+0x38>
80104852:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104855:	39 c8                	cmp    %ecx,%eax
80104857:	73 1f                	jae    80104878 <memmove+0x38>
80104859:	85 f6                	test   %esi,%esi
8010485b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010485e:	74 0f                	je     8010486f <memmove+0x2f>
80104860:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104864:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104867:	83 ea 01             	sub    $0x1,%edx
8010486a:	83 fa ff             	cmp    $0xffffffff,%edx
8010486d:	75 f1                	jne    80104860 <memmove+0x20>
8010486f:	5b                   	pop    %ebx
80104870:	5e                   	pop    %esi
80104871:	5d                   	pop    %ebp
80104872:	c3                   	ret    
80104873:	90                   	nop
80104874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104878:	31 d2                	xor    %edx,%edx
8010487a:	85 f6                	test   %esi,%esi
8010487c:	74 f1                	je     8010486f <memmove+0x2f>
8010487e:	66 90                	xchg   %ax,%ax
80104880:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104884:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104887:	83 c2 01             	add    $0x1,%edx
8010488a:	39 d6                	cmp    %edx,%esi
8010488c:	75 f2                	jne    80104880 <memmove+0x40>
8010488e:	5b                   	pop    %ebx
8010488f:	5e                   	pop    %esi
80104890:	5d                   	pop    %ebp
80104891:	c3                   	ret    
80104892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048a0 <memcpy>:
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	5d                   	pop    %ebp
801048a4:	eb 9a                	jmp    80104840 <memmove>
801048a6:	8d 76 00             	lea    0x0(%esi),%esi
801048a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048b0 <strncmp>:
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	57                   	push   %edi
801048b4:	56                   	push   %esi
801048b5:	8b 7d 10             	mov    0x10(%ebp),%edi
801048b8:	53                   	push   %ebx
801048b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801048bc:	8b 75 0c             	mov    0xc(%ebp),%esi
801048bf:	85 ff                	test   %edi,%edi
801048c1:	74 2f                	je     801048f2 <strncmp+0x42>
801048c3:	0f b6 01             	movzbl (%ecx),%eax
801048c6:	0f b6 1e             	movzbl (%esi),%ebx
801048c9:	84 c0                	test   %al,%al
801048cb:	74 37                	je     80104904 <strncmp+0x54>
801048cd:	38 c3                	cmp    %al,%bl
801048cf:	75 33                	jne    80104904 <strncmp+0x54>
801048d1:	01 f7                	add    %esi,%edi
801048d3:	eb 13                	jmp    801048e8 <strncmp+0x38>
801048d5:	8d 76 00             	lea    0x0(%esi),%esi
801048d8:	0f b6 01             	movzbl (%ecx),%eax
801048db:	84 c0                	test   %al,%al
801048dd:	74 21                	je     80104900 <strncmp+0x50>
801048df:	0f b6 1a             	movzbl (%edx),%ebx
801048e2:	89 d6                	mov    %edx,%esi
801048e4:	38 d8                	cmp    %bl,%al
801048e6:	75 1c                	jne    80104904 <strncmp+0x54>
801048e8:	8d 56 01             	lea    0x1(%esi),%edx
801048eb:	83 c1 01             	add    $0x1,%ecx
801048ee:	39 fa                	cmp    %edi,%edx
801048f0:	75 e6                	jne    801048d8 <strncmp+0x28>
801048f2:	5b                   	pop    %ebx
801048f3:	31 c0                	xor    %eax,%eax
801048f5:	5e                   	pop    %esi
801048f6:	5f                   	pop    %edi
801048f7:	5d                   	pop    %ebp
801048f8:	c3                   	ret    
801048f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104900:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
80104904:	29 d8                	sub    %ebx,%eax
80104906:	5b                   	pop    %ebx
80104907:	5e                   	pop    %esi
80104908:	5f                   	pop    %edi
80104909:	5d                   	pop    %ebp
8010490a:	c3                   	ret    
8010490b:	90                   	nop
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <strncpy>:
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	56                   	push   %esi
80104914:	53                   	push   %ebx
80104915:	8b 45 08             	mov    0x8(%ebp),%eax
80104918:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010491b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010491e:	89 c2                	mov    %eax,%edx
80104920:	eb 19                	jmp    8010493b <strncpy+0x2b>
80104922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104928:	83 c3 01             	add    $0x1,%ebx
8010492b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010492f:	83 c2 01             	add    $0x1,%edx
80104932:	84 c9                	test   %cl,%cl
80104934:	88 4a ff             	mov    %cl,-0x1(%edx)
80104937:	74 09                	je     80104942 <strncpy+0x32>
80104939:	89 f1                	mov    %esi,%ecx
8010493b:	85 c9                	test   %ecx,%ecx
8010493d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104940:	7f e6                	jg     80104928 <strncpy+0x18>
80104942:	31 c9                	xor    %ecx,%ecx
80104944:	85 f6                	test   %esi,%esi
80104946:	7e 17                	jle    8010495f <strncpy+0x4f>
80104948:	90                   	nop
80104949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104950:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104954:	89 f3                	mov    %esi,%ebx
80104956:	83 c1 01             	add    $0x1,%ecx
80104959:	29 cb                	sub    %ecx,%ebx
8010495b:	85 db                	test   %ebx,%ebx
8010495d:	7f f1                	jg     80104950 <strncpy+0x40>
8010495f:	5b                   	pop    %ebx
80104960:	5e                   	pop    %esi
80104961:	5d                   	pop    %ebp
80104962:	c3                   	ret    
80104963:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104970 <safestrcpy>:
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
80104975:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104978:	8b 45 08             	mov    0x8(%ebp),%eax
8010497b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010497e:	85 c9                	test   %ecx,%ecx
80104980:	7e 26                	jle    801049a8 <safestrcpy+0x38>
80104982:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104986:	89 c1                	mov    %eax,%ecx
80104988:	eb 17                	jmp    801049a1 <safestrcpy+0x31>
8010498a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104990:	83 c2 01             	add    $0x1,%edx
80104993:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104997:	83 c1 01             	add    $0x1,%ecx
8010499a:	84 db                	test   %bl,%bl
8010499c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010499f:	74 04                	je     801049a5 <safestrcpy+0x35>
801049a1:	39 f2                	cmp    %esi,%edx
801049a3:	75 eb                	jne    80104990 <safestrcpy+0x20>
801049a5:	c6 01 00             	movb   $0x0,(%ecx)
801049a8:	5b                   	pop    %ebx
801049a9:	5e                   	pop    %esi
801049aa:	5d                   	pop    %ebp
801049ab:	c3                   	ret    
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049b0 <strlen>:
801049b0:	55                   	push   %ebp
801049b1:	31 c0                	xor    %eax,%eax
801049b3:	89 e5                	mov    %esp,%ebp
801049b5:	8b 55 08             	mov    0x8(%ebp),%edx
801049b8:	80 3a 00             	cmpb   $0x0,(%edx)
801049bb:	74 0c                	je     801049c9 <strlen+0x19>
801049bd:	8d 76 00             	lea    0x0(%esi),%esi
801049c0:	83 c0 01             	add    $0x1,%eax
801049c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801049c7:	75 f7                	jne    801049c0 <strlen+0x10>
801049c9:	5d                   	pop    %ebp
801049ca:	c3                   	ret    

801049cb <swtch>:
801049cb:	8b 44 24 04          	mov    0x4(%esp),%eax
801049cf:	8b 54 24 08          	mov    0x8(%esp),%edx
801049d3:	55                   	push   %ebp
801049d4:	53                   	push   %ebx
801049d5:	56                   	push   %esi
801049d6:	57                   	push   %edi
801049d7:	89 20                	mov    %esp,(%eax)
801049d9:	89 d4                	mov    %edx,%esp
801049db:	5f                   	pop    %edi
801049dc:	5e                   	pop    %esi
801049dd:	5b                   	pop    %ebx
801049de:	5d                   	pop    %ebp
801049df:	c3                   	ret    

801049e0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	53                   	push   %ebx
801049e4:	83 ec 04             	sub    $0x4,%esp
801049e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801049ea:	e8 d1 ee ff ff       	call   801038c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049ef:	8b 00                	mov    (%eax),%eax
801049f1:	39 d8                	cmp    %ebx,%eax
801049f3:	76 1b                	jbe    80104a10 <fetchint+0x30>
801049f5:	8d 53 04             	lea    0x4(%ebx),%edx
801049f8:	39 d0                	cmp    %edx,%eax
801049fa:	72 14                	jb     80104a10 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801049fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ff:	8b 13                	mov    (%ebx),%edx
80104a01:	89 10                	mov    %edx,(%eax)
  return 0;
80104a03:	31 c0                	xor    %eax,%eax
}
80104a05:	83 c4 04             	add    $0x4,%esp
80104a08:	5b                   	pop    %ebx
80104a09:	5d                   	pop    %ebp
80104a0a:	c3                   	ret    
80104a0b:	90                   	nop
80104a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a15:	eb ee                	jmp    80104a05 <fetchint+0x25>
80104a17:	89 f6                	mov    %esi,%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	53                   	push   %ebx
80104a24:	83 ec 04             	sub    $0x4,%esp
80104a27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104a2a:	e8 91 ee ff ff       	call   801038c0 <myproc>

  if(addr >= curproc->sz)
80104a2f:	39 18                	cmp    %ebx,(%eax)
80104a31:	76 29                	jbe    80104a5c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104a33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104a36:	89 da                	mov    %ebx,%edx
80104a38:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104a3a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104a3c:	39 c3                	cmp    %eax,%ebx
80104a3e:	73 1c                	jae    80104a5c <fetchstr+0x3c>
    if(*s == 0)
80104a40:	80 3b 00             	cmpb   $0x0,(%ebx)
80104a43:	75 10                	jne    80104a55 <fetchstr+0x35>
80104a45:	eb 39                	jmp    80104a80 <fetchstr+0x60>
80104a47:	89 f6                	mov    %esi,%esi
80104a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a50:	80 3a 00             	cmpb   $0x0,(%edx)
80104a53:	74 1b                	je     80104a70 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104a55:	83 c2 01             	add    $0x1,%edx
80104a58:	39 d0                	cmp    %edx,%eax
80104a5a:	77 f4                	ja     80104a50 <fetchstr+0x30>
    return -1;
80104a5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104a61:	83 c4 04             	add    $0x4,%esp
80104a64:	5b                   	pop    %ebx
80104a65:	5d                   	pop    %ebp
80104a66:	c3                   	ret    
80104a67:	89 f6                	mov    %esi,%esi
80104a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a70:	83 c4 04             	add    $0x4,%esp
80104a73:	89 d0                	mov    %edx,%eax
80104a75:	29 d8                	sub    %ebx,%eax
80104a77:	5b                   	pop    %ebx
80104a78:	5d                   	pop    %ebp
80104a79:	c3                   	ret    
80104a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104a80:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104a82:	eb dd                	jmp    80104a61 <fetchstr+0x41>
80104a84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a90 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	56                   	push   %esi
80104a94:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a95:	e8 26 ee ff ff       	call   801038c0 <myproc>
80104a9a:	8b 40 18             	mov    0x18(%eax),%eax
80104a9d:	8b 55 08             	mov    0x8(%ebp),%edx
80104aa0:	8b 40 44             	mov    0x44(%eax),%eax
80104aa3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104aa6:	e8 15 ee ff ff       	call   801038c0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104aab:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104aad:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ab0:	39 c6                	cmp    %eax,%esi
80104ab2:	73 1c                	jae    80104ad0 <argint+0x40>
80104ab4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ab7:	39 d0                	cmp    %edx,%eax
80104ab9:	72 15                	jb     80104ad0 <argint+0x40>
  *ip = *(int*)(addr);
80104abb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104abe:	8b 53 04             	mov    0x4(%ebx),%edx
80104ac1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ac3:	31 c0                	xor    %eax,%eax
}
80104ac5:	5b                   	pop    %ebx
80104ac6:	5e                   	pop    %esi
80104ac7:	5d                   	pop    %ebp
80104ac8:	c3                   	ret    
80104ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ad5:	eb ee                	jmp    80104ac5 <argint+0x35>
80104ad7:	89 f6                	mov    %esi,%esi
80104ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ae0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	56                   	push   %esi
80104ae4:	53                   	push   %ebx
80104ae5:	83 ec 10             	sub    $0x10,%esp
80104ae8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104aeb:	e8 d0 ed ff ff       	call   801038c0 <myproc>
80104af0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104af2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104af5:	83 ec 08             	sub    $0x8,%esp
80104af8:	50                   	push   %eax
80104af9:	ff 75 08             	pushl  0x8(%ebp)
80104afc:	e8 8f ff ff ff       	call   80104a90 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104b01:	83 c4 10             	add    $0x10,%esp
80104b04:	85 c0                	test   %eax,%eax
80104b06:	78 28                	js     80104b30 <argptr+0x50>
80104b08:	85 db                	test   %ebx,%ebx
80104b0a:	78 24                	js     80104b30 <argptr+0x50>
80104b0c:	8b 16                	mov    (%esi),%edx
80104b0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b11:	39 c2                	cmp    %eax,%edx
80104b13:	76 1b                	jbe    80104b30 <argptr+0x50>
80104b15:	01 c3                	add    %eax,%ebx
80104b17:	39 da                	cmp    %ebx,%edx
80104b19:	72 15                	jb     80104b30 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104b1b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b1e:	89 02                	mov    %eax,(%edx)
  return 0;
80104b20:	31 c0                	xor    %eax,%eax
}
80104b22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b25:	5b                   	pop    %ebx
80104b26:	5e                   	pop    %esi
80104b27:	5d                   	pop    %ebp
80104b28:	c3                   	ret    
80104b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b35:	eb eb                	jmp    80104b22 <argptr+0x42>
80104b37:	89 f6                	mov    %esi,%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b40 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104b46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b49:	50                   	push   %eax
80104b4a:	ff 75 08             	pushl  0x8(%ebp)
80104b4d:	e8 3e ff ff ff       	call   80104a90 <argint>
80104b52:	83 c4 10             	add    $0x10,%esp
80104b55:	85 c0                	test   %eax,%eax
80104b57:	78 17                	js     80104b70 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104b59:	83 ec 08             	sub    $0x8,%esp
80104b5c:	ff 75 0c             	pushl  0xc(%ebp)
80104b5f:	ff 75 f4             	pushl  -0xc(%ebp)
80104b62:	e8 b9 fe ff ff       	call   80104a20 <fetchstr>
80104b67:	83 c4 10             	add    $0x10,%esp
}
80104b6a:	c9                   	leave  
80104b6b:	c3                   	ret    
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b75:	c9                   	leave  
80104b76:	c3                   	ret    
80104b77:	89 f6                	mov    %esi,%esi
80104b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b80 <syscall>:
[SYS_getpinfo] sys_getpinfo,
};

void
syscall(void)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	53                   	push   %ebx
80104b84:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104b87:	e8 34 ed ff ff       	call   801038c0 <myproc>
80104b8c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104b8e:	8b 40 18             	mov    0x18(%eax),%eax
80104b91:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104b94:	8d 50 ff             	lea    -0x1(%eax),%edx
80104b97:	83 fa 16             	cmp    $0x16,%edx
80104b9a:	77 1c                	ja     80104bb8 <syscall+0x38>
80104b9c:	8b 14 85 60 79 10 80 	mov    -0x7fef86a0(,%eax,4),%edx
80104ba3:	85 d2                	test   %edx,%edx
80104ba5:	74 11                	je     80104bb8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104ba7:	ff d2                	call   *%edx
80104ba9:	8b 53 18             	mov    0x18(%ebx),%edx
80104bac:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104baf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bb2:	c9                   	leave  
80104bb3:	c3                   	ret    
80104bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104bb8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104bb9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104bbc:	50                   	push   %eax
80104bbd:	ff 73 10             	pushl  0x10(%ebx)
80104bc0:	68 39 79 10 80       	push   $0x80107939
80104bc5:	e8 96 ba ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104bca:	8b 43 18             	mov    0x18(%ebx),%eax
80104bcd:	83 c4 10             	add    $0x10,%esp
80104bd0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104bd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bda:	c9                   	leave  
80104bdb:	c3                   	ret    
80104bdc:	66 90                	xchg   %ax,%ax
80104bde:	66 90                	xchg   %ax,%ax

80104be0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	57                   	push   %edi
80104be4:	56                   	push   %esi
80104be5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104be6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104be9:	83 ec 34             	sub    $0x34,%esp
80104bec:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104bef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104bf2:	56                   	push   %esi
80104bf3:	50                   	push   %eax
{
80104bf4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104bf7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104bfa:	e8 01 d3 ff ff       	call   80101f00 <nameiparent>
80104bff:	83 c4 10             	add    $0x10,%esp
80104c02:	85 c0                	test   %eax,%eax
80104c04:	0f 84 46 01 00 00    	je     80104d50 <create+0x170>
    return 0;
  ilock(dp);
80104c0a:	83 ec 0c             	sub    $0xc,%esp
80104c0d:	89 c3                	mov    %eax,%ebx
80104c0f:	50                   	push   %eax
80104c10:	e8 6b ca ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104c15:	83 c4 0c             	add    $0xc,%esp
80104c18:	6a 00                	push   $0x0
80104c1a:	56                   	push   %esi
80104c1b:	53                   	push   %ebx
80104c1c:	e8 8f cf ff ff       	call   80101bb0 <dirlookup>
80104c21:	83 c4 10             	add    $0x10,%esp
80104c24:	85 c0                	test   %eax,%eax
80104c26:	89 c7                	mov    %eax,%edi
80104c28:	74 36                	je     80104c60 <create+0x80>
    iunlockput(dp);
80104c2a:	83 ec 0c             	sub    $0xc,%esp
80104c2d:	53                   	push   %ebx
80104c2e:	e8 dd cc ff ff       	call   80101910 <iunlockput>
    ilock(ip);
80104c33:	89 3c 24             	mov    %edi,(%esp)
80104c36:	e8 45 ca ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104c3b:	83 c4 10             	add    $0x10,%esp
80104c3e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104c43:	0f 85 97 00 00 00    	jne    80104ce0 <create+0x100>
80104c49:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104c4e:	0f 85 8c 00 00 00    	jne    80104ce0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c57:	89 f8                	mov    %edi,%eax
80104c59:	5b                   	pop    %ebx
80104c5a:	5e                   	pop    %esi
80104c5b:	5f                   	pop    %edi
80104c5c:	5d                   	pop    %ebp
80104c5d:	c3                   	ret    
80104c5e:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104c60:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104c64:	83 ec 08             	sub    $0x8,%esp
80104c67:	50                   	push   %eax
80104c68:	ff 33                	pushl  (%ebx)
80104c6a:	e8 a1 c8 ff ff       	call   80101510 <ialloc>
80104c6f:	83 c4 10             	add    $0x10,%esp
80104c72:	85 c0                	test   %eax,%eax
80104c74:	89 c7                	mov    %eax,%edi
80104c76:	0f 84 e8 00 00 00    	je     80104d64 <create+0x184>
  ilock(ip);
80104c7c:	83 ec 0c             	sub    $0xc,%esp
80104c7f:	50                   	push   %eax
80104c80:	e8 fb c9 ff ff       	call   80101680 <ilock>
  ip->major = major;
80104c85:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104c89:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104c8d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104c91:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104c95:	b8 01 00 00 00       	mov    $0x1,%eax
80104c9a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104c9e:	89 3c 24             	mov    %edi,(%esp)
80104ca1:	e8 2a c9 ff ff       	call   801015d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104ca6:	83 c4 10             	add    $0x10,%esp
80104ca9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104cae:	74 50                	je     80104d00 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104cb0:	83 ec 04             	sub    $0x4,%esp
80104cb3:	ff 77 04             	pushl  0x4(%edi)
80104cb6:	56                   	push   %esi
80104cb7:	53                   	push   %ebx
80104cb8:	e8 63 d1 ff ff       	call   80101e20 <dirlink>
80104cbd:	83 c4 10             	add    $0x10,%esp
80104cc0:	85 c0                	test   %eax,%eax
80104cc2:	0f 88 8f 00 00 00    	js     80104d57 <create+0x177>
  iunlockput(dp);
80104cc8:	83 ec 0c             	sub    $0xc,%esp
80104ccb:	53                   	push   %ebx
80104ccc:	e8 3f cc ff ff       	call   80101910 <iunlockput>
  return ip;
80104cd1:	83 c4 10             	add    $0x10,%esp
}
80104cd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cd7:	89 f8                	mov    %edi,%eax
80104cd9:	5b                   	pop    %ebx
80104cda:	5e                   	pop    %esi
80104cdb:	5f                   	pop    %edi
80104cdc:	5d                   	pop    %ebp
80104cdd:	c3                   	ret    
80104cde:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104ce0:	83 ec 0c             	sub    $0xc,%esp
80104ce3:	57                   	push   %edi
    return 0;
80104ce4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104ce6:	e8 25 cc ff ff       	call   80101910 <iunlockput>
    return 0;
80104ceb:	83 c4 10             	add    $0x10,%esp
}
80104cee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cf1:	89 f8                	mov    %edi,%eax
80104cf3:	5b                   	pop    %ebx
80104cf4:	5e                   	pop    %esi
80104cf5:	5f                   	pop    %edi
80104cf6:	5d                   	pop    %ebp
80104cf7:	c3                   	ret    
80104cf8:	90                   	nop
80104cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104d00:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104d05:	83 ec 0c             	sub    $0xc,%esp
80104d08:	53                   	push   %ebx
80104d09:	e8 c2 c8 ff ff       	call   801015d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104d0e:	83 c4 0c             	add    $0xc,%esp
80104d11:	ff 77 04             	pushl  0x4(%edi)
80104d14:	68 dc 79 10 80       	push   $0x801079dc
80104d19:	57                   	push   %edi
80104d1a:	e8 01 d1 ff ff       	call   80101e20 <dirlink>
80104d1f:	83 c4 10             	add    $0x10,%esp
80104d22:	85 c0                	test   %eax,%eax
80104d24:	78 1c                	js     80104d42 <create+0x162>
80104d26:	83 ec 04             	sub    $0x4,%esp
80104d29:	ff 73 04             	pushl  0x4(%ebx)
80104d2c:	68 db 79 10 80       	push   $0x801079db
80104d31:	57                   	push   %edi
80104d32:	e8 e9 d0 ff ff       	call   80101e20 <dirlink>
80104d37:	83 c4 10             	add    $0x10,%esp
80104d3a:	85 c0                	test   %eax,%eax
80104d3c:	0f 89 6e ff ff ff    	jns    80104cb0 <create+0xd0>
      panic("create dots");
80104d42:	83 ec 0c             	sub    $0xc,%esp
80104d45:	68 cf 79 10 80       	push   $0x801079cf
80104d4a:	e8 41 b6 ff ff       	call   80100390 <panic>
80104d4f:	90                   	nop
    return 0;
80104d50:	31 ff                	xor    %edi,%edi
80104d52:	e9 fd fe ff ff       	jmp    80104c54 <create+0x74>
    panic("create: dirlink");
80104d57:	83 ec 0c             	sub    $0xc,%esp
80104d5a:	68 de 79 10 80       	push   $0x801079de
80104d5f:	e8 2c b6 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104d64:	83 ec 0c             	sub    $0xc,%esp
80104d67:	68 c0 79 10 80       	push   $0x801079c0
80104d6c:	e8 1f b6 ff ff       	call   80100390 <panic>
80104d71:	eb 0d                	jmp    80104d80 <argfd.constprop.0>
80104d73:	90                   	nop
80104d74:	90                   	nop
80104d75:	90                   	nop
80104d76:	90                   	nop
80104d77:	90                   	nop
80104d78:	90                   	nop
80104d79:	90                   	nop
80104d7a:	90                   	nop
80104d7b:	90                   	nop
80104d7c:	90                   	nop
80104d7d:	90                   	nop
80104d7e:	90                   	nop
80104d7f:	90                   	nop

80104d80 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	56                   	push   %esi
80104d84:	53                   	push   %ebx
80104d85:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104d87:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104d8a:	89 d6                	mov    %edx,%esi
80104d8c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104d8f:	50                   	push   %eax
80104d90:	6a 00                	push   $0x0
80104d92:	e8 f9 fc ff ff       	call   80104a90 <argint>
80104d97:	83 c4 10             	add    $0x10,%esp
80104d9a:	85 c0                	test   %eax,%eax
80104d9c:	78 2a                	js     80104dc8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d9e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104da2:	77 24                	ja     80104dc8 <argfd.constprop.0+0x48>
80104da4:	e8 17 eb ff ff       	call   801038c0 <myproc>
80104da9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104dac:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104db0:	85 c0                	test   %eax,%eax
80104db2:	74 14                	je     80104dc8 <argfd.constprop.0+0x48>
  if(pfd)
80104db4:	85 db                	test   %ebx,%ebx
80104db6:	74 02                	je     80104dba <argfd.constprop.0+0x3a>
    *pfd = fd;
80104db8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104dba:	89 06                	mov    %eax,(%esi)
  return 0;
80104dbc:	31 c0                	xor    %eax,%eax
}
80104dbe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dc1:	5b                   	pop    %ebx
80104dc2:	5e                   	pop    %esi
80104dc3:	5d                   	pop    %ebp
80104dc4:	c3                   	ret    
80104dc5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104dc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dcd:	eb ef                	jmp    80104dbe <argfd.constprop.0+0x3e>
80104dcf:	90                   	nop

80104dd0 <sys_dup>:
{
80104dd0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104dd1:	31 c0                	xor    %eax,%eax
{
80104dd3:	89 e5                	mov    %esp,%ebp
80104dd5:	56                   	push   %esi
80104dd6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104dd7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104dda:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104ddd:	e8 9e ff ff ff       	call   80104d80 <argfd.constprop.0>
80104de2:	85 c0                	test   %eax,%eax
80104de4:	78 42                	js     80104e28 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104de6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104de9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104deb:	e8 d0 ea ff ff       	call   801038c0 <myproc>
80104df0:	eb 0e                	jmp    80104e00 <sys_dup+0x30>
80104df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104df8:	83 c3 01             	add    $0x1,%ebx
80104dfb:	83 fb 10             	cmp    $0x10,%ebx
80104dfe:	74 28                	je     80104e28 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104e00:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104e04:	85 d2                	test   %edx,%edx
80104e06:	75 f0                	jne    80104df8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104e08:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104e0c:	83 ec 0c             	sub    $0xc,%esp
80104e0f:	ff 75 f4             	pushl  -0xc(%ebp)
80104e12:	e8 d9 bf ff ff       	call   80100df0 <filedup>
  return fd;
80104e17:	83 c4 10             	add    $0x10,%esp
}
80104e1a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e1d:	89 d8                	mov    %ebx,%eax
80104e1f:	5b                   	pop    %ebx
80104e20:	5e                   	pop    %esi
80104e21:	5d                   	pop    %ebp
80104e22:	c3                   	ret    
80104e23:	90                   	nop
80104e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e28:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104e2b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104e30:	89 d8                	mov    %ebx,%eax
80104e32:	5b                   	pop    %ebx
80104e33:	5e                   	pop    %esi
80104e34:	5d                   	pop    %ebp
80104e35:	c3                   	ret    
80104e36:	8d 76 00             	lea    0x0(%esi),%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e40 <sys_read>:
{
80104e40:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e41:	31 c0                	xor    %eax,%eax
{
80104e43:	89 e5                	mov    %esp,%ebp
80104e45:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e48:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e4b:	e8 30 ff ff ff       	call   80104d80 <argfd.constprop.0>
80104e50:	85 c0                	test   %eax,%eax
80104e52:	78 4c                	js     80104ea0 <sys_read+0x60>
80104e54:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e57:	83 ec 08             	sub    $0x8,%esp
80104e5a:	50                   	push   %eax
80104e5b:	6a 02                	push   $0x2
80104e5d:	e8 2e fc ff ff       	call   80104a90 <argint>
80104e62:	83 c4 10             	add    $0x10,%esp
80104e65:	85 c0                	test   %eax,%eax
80104e67:	78 37                	js     80104ea0 <sys_read+0x60>
80104e69:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e6c:	83 ec 04             	sub    $0x4,%esp
80104e6f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e72:	50                   	push   %eax
80104e73:	6a 01                	push   $0x1
80104e75:	e8 66 fc ff ff       	call   80104ae0 <argptr>
80104e7a:	83 c4 10             	add    $0x10,%esp
80104e7d:	85 c0                	test   %eax,%eax
80104e7f:	78 1f                	js     80104ea0 <sys_read+0x60>
  return fileread(f, p, n);
80104e81:	83 ec 04             	sub    $0x4,%esp
80104e84:	ff 75 f0             	pushl  -0x10(%ebp)
80104e87:	ff 75 f4             	pushl  -0xc(%ebp)
80104e8a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e8d:	e8 ce c0 ff ff       	call   80100f60 <fileread>
80104e92:	83 c4 10             	add    $0x10,%esp
}
80104e95:	c9                   	leave  
80104e96:	c3                   	ret    
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ea5:	c9                   	leave  
80104ea6:	c3                   	ret    
80104ea7:	89 f6                	mov    %esi,%esi
80104ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104eb0 <sys_write>:
{
80104eb0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104eb1:	31 c0                	xor    %eax,%eax
{
80104eb3:	89 e5                	mov    %esp,%ebp
80104eb5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104eb8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ebb:	e8 c0 fe ff ff       	call   80104d80 <argfd.constprop.0>
80104ec0:	85 c0                	test   %eax,%eax
80104ec2:	78 4c                	js     80104f10 <sys_write+0x60>
80104ec4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ec7:	83 ec 08             	sub    $0x8,%esp
80104eca:	50                   	push   %eax
80104ecb:	6a 02                	push   $0x2
80104ecd:	e8 be fb ff ff       	call   80104a90 <argint>
80104ed2:	83 c4 10             	add    $0x10,%esp
80104ed5:	85 c0                	test   %eax,%eax
80104ed7:	78 37                	js     80104f10 <sys_write+0x60>
80104ed9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104edc:	83 ec 04             	sub    $0x4,%esp
80104edf:	ff 75 f0             	pushl  -0x10(%ebp)
80104ee2:	50                   	push   %eax
80104ee3:	6a 01                	push   $0x1
80104ee5:	e8 f6 fb ff ff       	call   80104ae0 <argptr>
80104eea:	83 c4 10             	add    $0x10,%esp
80104eed:	85 c0                	test   %eax,%eax
80104eef:	78 1f                	js     80104f10 <sys_write+0x60>
  return filewrite(f, p, n);
80104ef1:	83 ec 04             	sub    $0x4,%esp
80104ef4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ef7:	ff 75 f4             	pushl  -0xc(%ebp)
80104efa:	ff 75 ec             	pushl  -0x14(%ebp)
80104efd:	e8 ee c0 ff ff       	call   80100ff0 <filewrite>
80104f02:	83 c4 10             	add    $0x10,%esp
}
80104f05:	c9                   	leave  
80104f06:	c3                   	ret    
80104f07:	89 f6                	mov    %esi,%esi
80104f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104f10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f15:	c9                   	leave  
80104f16:	c3                   	ret    
80104f17:	89 f6                	mov    %esi,%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f20 <sys_close>:
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104f26:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104f29:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f2c:	e8 4f fe ff ff       	call   80104d80 <argfd.constprop.0>
80104f31:	85 c0                	test   %eax,%eax
80104f33:	78 2b                	js     80104f60 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104f35:	e8 86 e9 ff ff       	call   801038c0 <myproc>
80104f3a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104f3d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104f40:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104f47:	00 
  fileclose(f);
80104f48:	ff 75 f4             	pushl  -0xc(%ebp)
80104f4b:	e8 f0 be ff ff       	call   80100e40 <fileclose>
  return 0;
80104f50:	83 c4 10             	add    $0x10,%esp
80104f53:	31 c0                	xor    %eax,%eax
}
80104f55:	c9                   	leave  
80104f56:	c3                   	ret    
80104f57:	89 f6                	mov    %esi,%esi
80104f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f65:	c9                   	leave  
80104f66:	c3                   	ret    
80104f67:	89 f6                	mov    %esi,%esi
80104f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f70 <sys_fstat>:
{
80104f70:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f71:	31 c0                	xor    %eax,%eax
{
80104f73:	89 e5                	mov    %esp,%ebp
80104f75:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f78:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104f7b:	e8 00 fe ff ff       	call   80104d80 <argfd.constprop.0>
80104f80:	85 c0                	test   %eax,%eax
80104f82:	78 2c                	js     80104fb0 <sys_fstat+0x40>
80104f84:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f87:	83 ec 04             	sub    $0x4,%esp
80104f8a:	6a 14                	push   $0x14
80104f8c:	50                   	push   %eax
80104f8d:	6a 01                	push   $0x1
80104f8f:	e8 4c fb ff ff       	call   80104ae0 <argptr>
80104f94:	83 c4 10             	add    $0x10,%esp
80104f97:	85 c0                	test   %eax,%eax
80104f99:	78 15                	js     80104fb0 <sys_fstat+0x40>
  return filestat(f, st);
80104f9b:	83 ec 08             	sub    $0x8,%esp
80104f9e:	ff 75 f4             	pushl  -0xc(%ebp)
80104fa1:	ff 75 f0             	pushl  -0x10(%ebp)
80104fa4:	e8 67 bf ff ff       	call   80100f10 <filestat>
80104fa9:	83 c4 10             	add    $0x10,%esp
}
80104fac:	c9                   	leave  
80104fad:	c3                   	ret    
80104fae:	66 90                	xchg   %ax,%ax
    return -1;
80104fb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fb5:	c9                   	leave  
80104fb6:	c3                   	ret    
80104fb7:	89 f6                	mov    %esi,%esi
80104fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fc0 <sys_link>:
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	57                   	push   %edi
80104fc4:	56                   	push   %esi
80104fc5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fc6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104fc9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fcc:	50                   	push   %eax
80104fcd:	6a 00                	push   $0x0
80104fcf:	e8 6c fb ff ff       	call   80104b40 <argstr>
80104fd4:	83 c4 10             	add    $0x10,%esp
80104fd7:	85 c0                	test   %eax,%eax
80104fd9:	0f 88 fb 00 00 00    	js     801050da <sys_link+0x11a>
80104fdf:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104fe2:	83 ec 08             	sub    $0x8,%esp
80104fe5:	50                   	push   %eax
80104fe6:	6a 01                	push   $0x1
80104fe8:	e8 53 fb ff ff       	call   80104b40 <argstr>
80104fed:	83 c4 10             	add    $0x10,%esp
80104ff0:	85 c0                	test   %eax,%eax
80104ff2:	0f 88 e2 00 00 00    	js     801050da <sys_link+0x11a>
  begin_op();
80104ff8:	e8 a3 db ff ff       	call   80102ba0 <begin_op>
  if((ip = namei(old)) == 0){
80104ffd:	83 ec 0c             	sub    $0xc,%esp
80105000:	ff 75 d4             	pushl  -0x2c(%ebp)
80105003:	e8 d8 ce ff ff       	call   80101ee0 <namei>
80105008:	83 c4 10             	add    $0x10,%esp
8010500b:	85 c0                	test   %eax,%eax
8010500d:	89 c3                	mov    %eax,%ebx
8010500f:	0f 84 ea 00 00 00    	je     801050ff <sys_link+0x13f>
  ilock(ip);
80105015:	83 ec 0c             	sub    $0xc,%esp
80105018:	50                   	push   %eax
80105019:	e8 62 c6 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
8010501e:	83 c4 10             	add    $0x10,%esp
80105021:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105026:	0f 84 bb 00 00 00    	je     801050e7 <sys_link+0x127>
  ip->nlink++;
8010502c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105031:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105034:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105037:	53                   	push   %ebx
80105038:	e8 93 c5 ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
8010503d:	89 1c 24             	mov    %ebx,(%esp)
80105040:	e8 1b c7 ff ff       	call   80101760 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105045:	58                   	pop    %eax
80105046:	5a                   	pop    %edx
80105047:	57                   	push   %edi
80105048:	ff 75 d0             	pushl  -0x30(%ebp)
8010504b:	e8 b0 ce ff ff       	call   80101f00 <nameiparent>
80105050:	83 c4 10             	add    $0x10,%esp
80105053:	85 c0                	test   %eax,%eax
80105055:	89 c6                	mov    %eax,%esi
80105057:	74 5b                	je     801050b4 <sys_link+0xf4>
  ilock(dp);
80105059:	83 ec 0c             	sub    $0xc,%esp
8010505c:	50                   	push   %eax
8010505d:	e8 1e c6 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105062:	83 c4 10             	add    $0x10,%esp
80105065:	8b 03                	mov    (%ebx),%eax
80105067:	39 06                	cmp    %eax,(%esi)
80105069:	75 3d                	jne    801050a8 <sys_link+0xe8>
8010506b:	83 ec 04             	sub    $0x4,%esp
8010506e:	ff 73 04             	pushl  0x4(%ebx)
80105071:	57                   	push   %edi
80105072:	56                   	push   %esi
80105073:	e8 a8 cd ff ff       	call   80101e20 <dirlink>
80105078:	83 c4 10             	add    $0x10,%esp
8010507b:	85 c0                	test   %eax,%eax
8010507d:	78 29                	js     801050a8 <sys_link+0xe8>
  iunlockput(dp);
8010507f:	83 ec 0c             	sub    $0xc,%esp
80105082:	56                   	push   %esi
80105083:	e8 88 c8 ff ff       	call   80101910 <iunlockput>
  iput(ip);
80105088:	89 1c 24             	mov    %ebx,(%esp)
8010508b:	e8 20 c7 ff ff       	call   801017b0 <iput>
  end_op();
80105090:	e8 7b db ff ff       	call   80102c10 <end_op>
  return 0;
80105095:	83 c4 10             	add    $0x10,%esp
80105098:	31 c0                	xor    %eax,%eax
}
8010509a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010509d:	5b                   	pop    %ebx
8010509e:	5e                   	pop    %esi
8010509f:	5f                   	pop    %edi
801050a0:	5d                   	pop    %ebp
801050a1:	c3                   	ret    
801050a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801050a8:	83 ec 0c             	sub    $0xc,%esp
801050ab:	56                   	push   %esi
801050ac:	e8 5f c8 ff ff       	call   80101910 <iunlockput>
    goto bad;
801050b1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801050b4:	83 ec 0c             	sub    $0xc,%esp
801050b7:	53                   	push   %ebx
801050b8:	e8 c3 c5 ff ff       	call   80101680 <ilock>
  ip->nlink--;
801050bd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050c2:	89 1c 24             	mov    %ebx,(%esp)
801050c5:	e8 06 c5 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
801050ca:	89 1c 24             	mov    %ebx,(%esp)
801050cd:	e8 3e c8 ff ff       	call   80101910 <iunlockput>
  end_op();
801050d2:	e8 39 db ff ff       	call   80102c10 <end_op>
  return -1;
801050d7:	83 c4 10             	add    $0x10,%esp
}
801050da:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801050dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050e2:	5b                   	pop    %ebx
801050e3:	5e                   	pop    %esi
801050e4:	5f                   	pop    %edi
801050e5:	5d                   	pop    %ebp
801050e6:	c3                   	ret    
    iunlockput(ip);
801050e7:	83 ec 0c             	sub    $0xc,%esp
801050ea:	53                   	push   %ebx
801050eb:	e8 20 c8 ff ff       	call   80101910 <iunlockput>
    end_op();
801050f0:	e8 1b db ff ff       	call   80102c10 <end_op>
    return -1;
801050f5:	83 c4 10             	add    $0x10,%esp
801050f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050fd:	eb 9b                	jmp    8010509a <sys_link+0xda>
    end_op();
801050ff:	e8 0c db ff ff       	call   80102c10 <end_op>
    return -1;
80105104:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105109:	eb 8f                	jmp    8010509a <sys_link+0xda>
8010510b:	90                   	nop
8010510c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105110 <sys_unlink>:
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	57                   	push   %edi
80105114:	56                   	push   %esi
80105115:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105116:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105119:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010511c:	50                   	push   %eax
8010511d:	6a 00                	push   $0x0
8010511f:	e8 1c fa ff ff       	call   80104b40 <argstr>
80105124:	83 c4 10             	add    $0x10,%esp
80105127:	85 c0                	test   %eax,%eax
80105129:	0f 88 77 01 00 00    	js     801052a6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010512f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105132:	e8 69 da ff ff       	call   80102ba0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105137:	83 ec 08             	sub    $0x8,%esp
8010513a:	53                   	push   %ebx
8010513b:	ff 75 c0             	pushl  -0x40(%ebp)
8010513e:	e8 bd cd ff ff       	call   80101f00 <nameiparent>
80105143:	83 c4 10             	add    $0x10,%esp
80105146:	85 c0                	test   %eax,%eax
80105148:	89 c6                	mov    %eax,%esi
8010514a:	0f 84 60 01 00 00    	je     801052b0 <sys_unlink+0x1a0>
  ilock(dp);
80105150:	83 ec 0c             	sub    $0xc,%esp
80105153:	50                   	push   %eax
80105154:	e8 27 c5 ff ff       	call   80101680 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105159:	58                   	pop    %eax
8010515a:	5a                   	pop    %edx
8010515b:	68 dc 79 10 80       	push   $0x801079dc
80105160:	53                   	push   %ebx
80105161:	e8 2a ca ff ff       	call   80101b90 <namecmp>
80105166:	83 c4 10             	add    $0x10,%esp
80105169:	85 c0                	test   %eax,%eax
8010516b:	0f 84 03 01 00 00    	je     80105274 <sys_unlink+0x164>
80105171:	83 ec 08             	sub    $0x8,%esp
80105174:	68 db 79 10 80       	push   $0x801079db
80105179:	53                   	push   %ebx
8010517a:	e8 11 ca ff ff       	call   80101b90 <namecmp>
8010517f:	83 c4 10             	add    $0x10,%esp
80105182:	85 c0                	test   %eax,%eax
80105184:	0f 84 ea 00 00 00    	je     80105274 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010518a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010518d:	83 ec 04             	sub    $0x4,%esp
80105190:	50                   	push   %eax
80105191:	53                   	push   %ebx
80105192:	56                   	push   %esi
80105193:	e8 18 ca ff ff       	call   80101bb0 <dirlookup>
80105198:	83 c4 10             	add    $0x10,%esp
8010519b:	85 c0                	test   %eax,%eax
8010519d:	89 c3                	mov    %eax,%ebx
8010519f:	0f 84 cf 00 00 00    	je     80105274 <sys_unlink+0x164>
  ilock(ip);
801051a5:	83 ec 0c             	sub    $0xc,%esp
801051a8:	50                   	push   %eax
801051a9:	e8 d2 c4 ff ff       	call   80101680 <ilock>
  if(ip->nlink < 1)
801051ae:	83 c4 10             	add    $0x10,%esp
801051b1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801051b6:	0f 8e 10 01 00 00    	jle    801052cc <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801051bc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051c1:	74 6d                	je     80105230 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801051c3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801051c6:	83 ec 04             	sub    $0x4,%esp
801051c9:	6a 10                	push   $0x10
801051cb:	6a 00                	push   $0x0
801051cd:	50                   	push   %eax
801051ce:	e8 bd f5 ff ff       	call   80104790 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051d3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801051d6:	6a 10                	push   $0x10
801051d8:	ff 75 c4             	pushl  -0x3c(%ebp)
801051db:	50                   	push   %eax
801051dc:	56                   	push   %esi
801051dd:	e8 7e c8 ff ff       	call   80101a60 <writei>
801051e2:	83 c4 20             	add    $0x20,%esp
801051e5:	83 f8 10             	cmp    $0x10,%eax
801051e8:	0f 85 eb 00 00 00    	jne    801052d9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801051ee:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051f3:	0f 84 97 00 00 00    	je     80105290 <sys_unlink+0x180>
  iunlockput(dp);
801051f9:	83 ec 0c             	sub    $0xc,%esp
801051fc:	56                   	push   %esi
801051fd:	e8 0e c7 ff ff       	call   80101910 <iunlockput>
  ip->nlink--;
80105202:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105207:	89 1c 24             	mov    %ebx,(%esp)
8010520a:	e8 c1 c3 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
8010520f:	89 1c 24             	mov    %ebx,(%esp)
80105212:	e8 f9 c6 ff ff       	call   80101910 <iunlockput>
  end_op();
80105217:	e8 f4 d9 ff ff       	call   80102c10 <end_op>
  return 0;
8010521c:	83 c4 10             	add    $0x10,%esp
8010521f:	31 c0                	xor    %eax,%eax
}
80105221:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105224:	5b                   	pop    %ebx
80105225:	5e                   	pop    %esi
80105226:	5f                   	pop    %edi
80105227:	5d                   	pop    %ebp
80105228:	c3                   	ret    
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105230:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105234:	76 8d                	jbe    801051c3 <sys_unlink+0xb3>
80105236:	bf 20 00 00 00       	mov    $0x20,%edi
8010523b:	eb 0f                	jmp    8010524c <sys_unlink+0x13c>
8010523d:	8d 76 00             	lea    0x0(%esi),%esi
80105240:	83 c7 10             	add    $0x10,%edi
80105243:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105246:	0f 83 77 ff ff ff    	jae    801051c3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010524c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010524f:	6a 10                	push   $0x10
80105251:	57                   	push   %edi
80105252:	50                   	push   %eax
80105253:	53                   	push   %ebx
80105254:	e8 07 c7 ff ff       	call   80101960 <readi>
80105259:	83 c4 10             	add    $0x10,%esp
8010525c:	83 f8 10             	cmp    $0x10,%eax
8010525f:	75 5e                	jne    801052bf <sys_unlink+0x1af>
    if(de.inum != 0)
80105261:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105266:	74 d8                	je     80105240 <sys_unlink+0x130>
    iunlockput(ip);
80105268:	83 ec 0c             	sub    $0xc,%esp
8010526b:	53                   	push   %ebx
8010526c:	e8 9f c6 ff ff       	call   80101910 <iunlockput>
    goto bad;
80105271:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105274:	83 ec 0c             	sub    $0xc,%esp
80105277:	56                   	push   %esi
80105278:	e8 93 c6 ff ff       	call   80101910 <iunlockput>
  end_op();
8010527d:	e8 8e d9 ff ff       	call   80102c10 <end_op>
  return -1;
80105282:	83 c4 10             	add    $0x10,%esp
80105285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010528a:	eb 95                	jmp    80105221 <sys_unlink+0x111>
8010528c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105290:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105295:	83 ec 0c             	sub    $0xc,%esp
80105298:	56                   	push   %esi
80105299:	e8 32 c3 ff ff       	call   801015d0 <iupdate>
8010529e:	83 c4 10             	add    $0x10,%esp
801052a1:	e9 53 ff ff ff       	jmp    801051f9 <sys_unlink+0xe9>
    return -1;
801052a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052ab:	e9 71 ff ff ff       	jmp    80105221 <sys_unlink+0x111>
    end_op();
801052b0:	e8 5b d9 ff ff       	call   80102c10 <end_op>
    return -1;
801052b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052ba:	e9 62 ff ff ff       	jmp    80105221 <sys_unlink+0x111>
      panic("isdirempty: readi");
801052bf:	83 ec 0c             	sub    $0xc,%esp
801052c2:	68 00 7a 10 80       	push   $0x80107a00
801052c7:	e8 c4 b0 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801052cc:	83 ec 0c             	sub    $0xc,%esp
801052cf:	68 ee 79 10 80       	push   $0x801079ee
801052d4:	e8 b7 b0 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801052d9:	83 ec 0c             	sub    $0xc,%esp
801052dc:	68 12 7a 10 80       	push   $0x80107a12
801052e1:	e8 aa b0 ff ff       	call   80100390 <panic>
801052e6:	8d 76 00             	lea    0x0(%esi),%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052f0 <sys_open>:

int
sys_open(void)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	57                   	push   %edi
801052f4:	56                   	push   %esi
801052f5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052f6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801052f9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052fc:	50                   	push   %eax
801052fd:	6a 00                	push   $0x0
801052ff:	e8 3c f8 ff ff       	call   80104b40 <argstr>
80105304:	83 c4 10             	add    $0x10,%esp
80105307:	85 c0                	test   %eax,%eax
80105309:	0f 88 1d 01 00 00    	js     8010542c <sys_open+0x13c>
8010530f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105312:	83 ec 08             	sub    $0x8,%esp
80105315:	50                   	push   %eax
80105316:	6a 01                	push   $0x1
80105318:	e8 73 f7 ff ff       	call   80104a90 <argint>
8010531d:	83 c4 10             	add    $0x10,%esp
80105320:	85 c0                	test   %eax,%eax
80105322:	0f 88 04 01 00 00    	js     8010542c <sys_open+0x13c>
    return -1;

  begin_op();
80105328:	e8 73 d8 ff ff       	call   80102ba0 <begin_op>

  if(omode & O_CREATE){
8010532d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105331:	0f 85 a9 00 00 00    	jne    801053e0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105337:	83 ec 0c             	sub    $0xc,%esp
8010533a:	ff 75 e0             	pushl  -0x20(%ebp)
8010533d:	e8 9e cb ff ff       	call   80101ee0 <namei>
80105342:	83 c4 10             	add    $0x10,%esp
80105345:	85 c0                	test   %eax,%eax
80105347:	89 c6                	mov    %eax,%esi
80105349:	0f 84 b2 00 00 00    	je     80105401 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010534f:	83 ec 0c             	sub    $0xc,%esp
80105352:	50                   	push   %eax
80105353:	e8 28 c3 ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105358:	83 c4 10             	add    $0x10,%esp
8010535b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105360:	0f 84 aa 00 00 00    	je     80105410 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105366:	e8 15 ba ff ff       	call   80100d80 <filealloc>
8010536b:	85 c0                	test   %eax,%eax
8010536d:	89 c7                	mov    %eax,%edi
8010536f:	0f 84 a6 00 00 00    	je     8010541b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105375:	e8 46 e5 ff ff       	call   801038c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010537a:	31 db                	xor    %ebx,%ebx
8010537c:	eb 0e                	jmp    8010538c <sys_open+0x9c>
8010537e:	66 90                	xchg   %ax,%ax
80105380:	83 c3 01             	add    $0x1,%ebx
80105383:	83 fb 10             	cmp    $0x10,%ebx
80105386:	0f 84 ac 00 00 00    	je     80105438 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010538c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105390:	85 d2                	test   %edx,%edx
80105392:	75 ec                	jne    80105380 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105394:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105397:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010539b:	56                   	push   %esi
8010539c:	e8 bf c3 ff ff       	call   80101760 <iunlock>
  end_op();
801053a1:	e8 6a d8 ff ff       	call   80102c10 <end_op>

  f->type = FD_INODE;
801053a6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801053ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053af:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801053b2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801053b5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801053bc:	89 d0                	mov    %edx,%eax
801053be:	f7 d0                	not    %eax
801053c0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053c3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801053c6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053c9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801053cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053d0:	89 d8                	mov    %ebx,%eax
801053d2:	5b                   	pop    %ebx
801053d3:	5e                   	pop    %esi
801053d4:	5f                   	pop    %edi
801053d5:	5d                   	pop    %ebp
801053d6:	c3                   	ret    
801053d7:	89 f6                	mov    %esi,%esi
801053d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801053e0:	83 ec 0c             	sub    $0xc,%esp
801053e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801053e6:	31 c9                	xor    %ecx,%ecx
801053e8:	6a 00                	push   $0x0
801053ea:	ba 02 00 00 00       	mov    $0x2,%edx
801053ef:	e8 ec f7 ff ff       	call   80104be0 <create>
    if(ip == 0){
801053f4:	83 c4 10             	add    $0x10,%esp
801053f7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801053f9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801053fb:	0f 85 65 ff ff ff    	jne    80105366 <sys_open+0x76>
      end_op();
80105401:	e8 0a d8 ff ff       	call   80102c10 <end_op>
      return -1;
80105406:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010540b:	eb c0                	jmp    801053cd <sys_open+0xdd>
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105410:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105413:	85 c9                	test   %ecx,%ecx
80105415:	0f 84 4b ff ff ff    	je     80105366 <sys_open+0x76>
    iunlockput(ip);
8010541b:	83 ec 0c             	sub    $0xc,%esp
8010541e:	56                   	push   %esi
8010541f:	e8 ec c4 ff ff       	call   80101910 <iunlockput>
    end_op();
80105424:	e8 e7 d7 ff ff       	call   80102c10 <end_op>
    return -1;
80105429:	83 c4 10             	add    $0x10,%esp
8010542c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105431:	eb 9a                	jmp    801053cd <sys_open+0xdd>
80105433:	90                   	nop
80105434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105438:	83 ec 0c             	sub    $0xc,%esp
8010543b:	57                   	push   %edi
8010543c:	e8 ff b9 ff ff       	call   80100e40 <fileclose>
80105441:	83 c4 10             	add    $0x10,%esp
80105444:	eb d5                	jmp    8010541b <sys_open+0x12b>
80105446:	8d 76 00             	lea    0x0(%esi),%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105450 <sys_mkdir>:

int
sys_mkdir(void)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105456:	e8 45 d7 ff ff       	call   80102ba0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010545b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010545e:	83 ec 08             	sub    $0x8,%esp
80105461:	50                   	push   %eax
80105462:	6a 00                	push   $0x0
80105464:	e8 d7 f6 ff ff       	call   80104b40 <argstr>
80105469:	83 c4 10             	add    $0x10,%esp
8010546c:	85 c0                	test   %eax,%eax
8010546e:	78 30                	js     801054a0 <sys_mkdir+0x50>
80105470:	83 ec 0c             	sub    $0xc,%esp
80105473:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105476:	31 c9                	xor    %ecx,%ecx
80105478:	6a 00                	push   $0x0
8010547a:	ba 01 00 00 00       	mov    $0x1,%edx
8010547f:	e8 5c f7 ff ff       	call   80104be0 <create>
80105484:	83 c4 10             	add    $0x10,%esp
80105487:	85 c0                	test   %eax,%eax
80105489:	74 15                	je     801054a0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010548b:	83 ec 0c             	sub    $0xc,%esp
8010548e:	50                   	push   %eax
8010548f:	e8 7c c4 ff ff       	call   80101910 <iunlockput>
  end_op();
80105494:	e8 77 d7 ff ff       	call   80102c10 <end_op>
  return 0;
80105499:	83 c4 10             	add    $0x10,%esp
8010549c:	31 c0                	xor    %eax,%eax
}
8010549e:	c9                   	leave  
8010549f:	c3                   	ret    
    end_op();
801054a0:	e8 6b d7 ff ff       	call   80102c10 <end_op>
    return -1;
801054a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054aa:	c9                   	leave  
801054ab:	c3                   	ret    
801054ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054b0 <sys_mknod>:

int
sys_mknod(void)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
801054b3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801054b6:	e8 e5 d6 ff ff       	call   80102ba0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801054bb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801054be:	83 ec 08             	sub    $0x8,%esp
801054c1:	50                   	push   %eax
801054c2:	6a 00                	push   $0x0
801054c4:	e8 77 f6 ff ff       	call   80104b40 <argstr>
801054c9:	83 c4 10             	add    $0x10,%esp
801054cc:	85 c0                	test   %eax,%eax
801054ce:	78 60                	js     80105530 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801054d0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054d3:	83 ec 08             	sub    $0x8,%esp
801054d6:	50                   	push   %eax
801054d7:	6a 01                	push   $0x1
801054d9:	e8 b2 f5 ff ff       	call   80104a90 <argint>
  if((argstr(0, &path)) < 0 ||
801054de:	83 c4 10             	add    $0x10,%esp
801054e1:	85 c0                	test   %eax,%eax
801054e3:	78 4b                	js     80105530 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801054e5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054e8:	83 ec 08             	sub    $0x8,%esp
801054eb:	50                   	push   %eax
801054ec:	6a 02                	push   $0x2
801054ee:	e8 9d f5 ff ff       	call   80104a90 <argint>
     argint(1, &major) < 0 ||
801054f3:	83 c4 10             	add    $0x10,%esp
801054f6:	85 c0                	test   %eax,%eax
801054f8:	78 36                	js     80105530 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801054fa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801054fe:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105501:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105505:	ba 03 00 00 00       	mov    $0x3,%edx
8010550a:	50                   	push   %eax
8010550b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010550e:	e8 cd f6 ff ff       	call   80104be0 <create>
80105513:	83 c4 10             	add    $0x10,%esp
80105516:	85 c0                	test   %eax,%eax
80105518:	74 16                	je     80105530 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010551a:	83 ec 0c             	sub    $0xc,%esp
8010551d:	50                   	push   %eax
8010551e:	e8 ed c3 ff ff       	call   80101910 <iunlockput>
  end_op();
80105523:	e8 e8 d6 ff ff       	call   80102c10 <end_op>
  return 0;
80105528:	83 c4 10             	add    $0x10,%esp
8010552b:	31 c0                	xor    %eax,%eax
}
8010552d:	c9                   	leave  
8010552e:	c3                   	ret    
8010552f:	90                   	nop
    end_op();
80105530:	e8 db d6 ff ff       	call   80102c10 <end_op>
    return -1;
80105535:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010553a:	c9                   	leave  
8010553b:	c3                   	ret    
8010553c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105540 <sys_chdir>:

int
sys_chdir(void)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	56                   	push   %esi
80105544:	53                   	push   %ebx
80105545:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105548:	e8 73 e3 ff ff       	call   801038c0 <myproc>
8010554d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010554f:	e8 4c d6 ff ff       	call   80102ba0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105554:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105557:	83 ec 08             	sub    $0x8,%esp
8010555a:	50                   	push   %eax
8010555b:	6a 00                	push   $0x0
8010555d:	e8 de f5 ff ff       	call   80104b40 <argstr>
80105562:	83 c4 10             	add    $0x10,%esp
80105565:	85 c0                	test   %eax,%eax
80105567:	78 77                	js     801055e0 <sys_chdir+0xa0>
80105569:	83 ec 0c             	sub    $0xc,%esp
8010556c:	ff 75 f4             	pushl  -0xc(%ebp)
8010556f:	e8 6c c9 ff ff       	call   80101ee0 <namei>
80105574:	83 c4 10             	add    $0x10,%esp
80105577:	85 c0                	test   %eax,%eax
80105579:	89 c3                	mov    %eax,%ebx
8010557b:	74 63                	je     801055e0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010557d:	83 ec 0c             	sub    $0xc,%esp
80105580:	50                   	push   %eax
80105581:	e8 fa c0 ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
80105586:	83 c4 10             	add    $0x10,%esp
80105589:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010558e:	75 30                	jne    801055c0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105590:	83 ec 0c             	sub    $0xc,%esp
80105593:	53                   	push   %ebx
80105594:	e8 c7 c1 ff ff       	call   80101760 <iunlock>
  iput(curproc->cwd);
80105599:	58                   	pop    %eax
8010559a:	ff 76 68             	pushl  0x68(%esi)
8010559d:	e8 0e c2 ff ff       	call   801017b0 <iput>
  end_op();
801055a2:	e8 69 d6 ff ff       	call   80102c10 <end_op>
  curproc->cwd = ip;
801055a7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801055aa:	83 c4 10             	add    $0x10,%esp
801055ad:	31 c0                	xor    %eax,%eax
}
801055af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055b2:	5b                   	pop    %ebx
801055b3:	5e                   	pop    %esi
801055b4:	5d                   	pop    %ebp
801055b5:	c3                   	ret    
801055b6:	8d 76 00             	lea    0x0(%esi),%esi
801055b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801055c0:	83 ec 0c             	sub    $0xc,%esp
801055c3:	53                   	push   %ebx
801055c4:	e8 47 c3 ff ff       	call   80101910 <iunlockput>
    end_op();
801055c9:	e8 42 d6 ff ff       	call   80102c10 <end_op>
    return -1;
801055ce:	83 c4 10             	add    $0x10,%esp
801055d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055d6:	eb d7                	jmp    801055af <sys_chdir+0x6f>
801055d8:	90                   	nop
801055d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801055e0:	e8 2b d6 ff ff       	call   80102c10 <end_op>
    return -1;
801055e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ea:	eb c3                	jmp    801055af <sys_chdir+0x6f>
801055ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055f0 <sys_exec>:

int
sys_exec(void)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	57                   	push   %edi
801055f4:	56                   	push   %esi
801055f5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801055f6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801055fc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105602:	50                   	push   %eax
80105603:	6a 00                	push   $0x0
80105605:	e8 36 f5 ff ff       	call   80104b40 <argstr>
8010560a:	83 c4 10             	add    $0x10,%esp
8010560d:	85 c0                	test   %eax,%eax
8010560f:	0f 88 87 00 00 00    	js     8010569c <sys_exec+0xac>
80105615:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010561b:	83 ec 08             	sub    $0x8,%esp
8010561e:	50                   	push   %eax
8010561f:	6a 01                	push   $0x1
80105621:	e8 6a f4 ff ff       	call   80104a90 <argint>
80105626:	83 c4 10             	add    $0x10,%esp
80105629:	85 c0                	test   %eax,%eax
8010562b:	78 6f                	js     8010569c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010562d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105633:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105636:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105638:	68 80 00 00 00       	push   $0x80
8010563d:	6a 00                	push   $0x0
8010563f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105645:	50                   	push   %eax
80105646:	e8 45 f1 ff ff       	call   80104790 <memset>
8010564b:	83 c4 10             	add    $0x10,%esp
8010564e:	eb 2c                	jmp    8010567c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105650:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105656:	85 c0                	test   %eax,%eax
80105658:	74 56                	je     801056b0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010565a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105660:	83 ec 08             	sub    $0x8,%esp
80105663:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105666:	52                   	push   %edx
80105667:	50                   	push   %eax
80105668:	e8 b3 f3 ff ff       	call   80104a20 <fetchstr>
8010566d:	83 c4 10             	add    $0x10,%esp
80105670:	85 c0                	test   %eax,%eax
80105672:	78 28                	js     8010569c <sys_exec+0xac>
  for(i=0;; i++){
80105674:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105677:	83 fb 20             	cmp    $0x20,%ebx
8010567a:	74 20                	je     8010569c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010567c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105682:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105689:	83 ec 08             	sub    $0x8,%esp
8010568c:	57                   	push   %edi
8010568d:	01 f0                	add    %esi,%eax
8010568f:	50                   	push   %eax
80105690:	e8 4b f3 ff ff       	call   801049e0 <fetchint>
80105695:	83 c4 10             	add    $0x10,%esp
80105698:	85 c0                	test   %eax,%eax
8010569a:	79 b4                	jns    80105650 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010569c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010569f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056a4:	5b                   	pop    %ebx
801056a5:	5e                   	pop    %esi
801056a6:	5f                   	pop    %edi
801056a7:	5d                   	pop    %ebp
801056a8:	c3                   	ret    
801056a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801056b0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801056b6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801056b9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801056c0:	00 00 00 00 
  return exec(path, argv);
801056c4:	50                   	push   %eax
801056c5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801056cb:	e8 40 b3 ff ff       	call   80100a10 <exec>
801056d0:	83 c4 10             	add    $0x10,%esp
}
801056d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056d6:	5b                   	pop    %ebx
801056d7:	5e                   	pop    %esi
801056d8:	5f                   	pop    %edi
801056d9:	5d                   	pop    %ebp
801056da:	c3                   	ret    
801056db:	90                   	nop
801056dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056e0 <sys_pipe>:

int
sys_pipe(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	57                   	push   %edi
801056e4:	56                   	push   %esi
801056e5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056e6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801056e9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801056ec:	6a 08                	push   $0x8
801056ee:	50                   	push   %eax
801056ef:	6a 00                	push   $0x0
801056f1:	e8 ea f3 ff ff       	call   80104ae0 <argptr>
801056f6:	83 c4 10             	add    $0x10,%esp
801056f9:	85 c0                	test   %eax,%eax
801056fb:	0f 88 ae 00 00 00    	js     801057af <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105701:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105704:	83 ec 08             	sub    $0x8,%esp
80105707:	50                   	push   %eax
80105708:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010570b:	50                   	push   %eax
8010570c:	e8 2f db ff ff       	call   80103240 <pipealloc>
80105711:	83 c4 10             	add    $0x10,%esp
80105714:	85 c0                	test   %eax,%eax
80105716:	0f 88 93 00 00 00    	js     801057af <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010571c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010571f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105721:	e8 9a e1 ff ff       	call   801038c0 <myproc>
80105726:	eb 10                	jmp    80105738 <sys_pipe+0x58>
80105728:	90                   	nop
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105730:	83 c3 01             	add    $0x1,%ebx
80105733:	83 fb 10             	cmp    $0x10,%ebx
80105736:	74 60                	je     80105798 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105738:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010573c:	85 f6                	test   %esi,%esi
8010573e:	75 f0                	jne    80105730 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105740:	8d 73 08             	lea    0x8(%ebx),%esi
80105743:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105747:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010574a:	e8 71 e1 ff ff       	call   801038c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010574f:	31 d2                	xor    %edx,%edx
80105751:	eb 0d                	jmp    80105760 <sys_pipe+0x80>
80105753:	90                   	nop
80105754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105758:	83 c2 01             	add    $0x1,%edx
8010575b:	83 fa 10             	cmp    $0x10,%edx
8010575e:	74 28                	je     80105788 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105760:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105764:	85 c9                	test   %ecx,%ecx
80105766:	75 f0                	jne    80105758 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105768:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010576c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010576f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105771:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105774:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105777:	31 c0                	xor    %eax,%eax
}
80105779:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010577c:	5b                   	pop    %ebx
8010577d:	5e                   	pop    %esi
8010577e:	5f                   	pop    %edi
8010577f:	5d                   	pop    %ebp
80105780:	c3                   	ret    
80105781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105788:	e8 33 e1 ff ff       	call   801038c0 <myproc>
8010578d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105794:	00 
80105795:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105798:	83 ec 0c             	sub    $0xc,%esp
8010579b:	ff 75 e0             	pushl  -0x20(%ebp)
8010579e:	e8 9d b6 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
801057a3:	58                   	pop    %eax
801057a4:	ff 75 e4             	pushl  -0x1c(%ebp)
801057a7:	e8 94 b6 ff ff       	call   80100e40 <fileclose>
    return -1;
801057ac:	83 c4 10             	add    $0x10,%esp
801057af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057b4:	eb c3                	jmp    80105779 <sys_pipe+0x99>
801057b6:	66 90                	xchg   %ax,%ax
801057b8:	66 90                	xchg   %ax,%ax
801057ba:	66 90                	xchg   %ax,%ax
801057bc:	66 90                	xchg   %ax,%ax
801057be:	66 90                	xchg   %ax,%ax

801057c0 <sys_settickets>:
#include "proc.h"
#include "pstat.h"

int
sys_settickets(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
801057c4:	83 ec 14             	sub    $0x14,%esp
  struct proc *curproc = myproc();
801057c7:	e8 f4 e0 ff ff       	call   801038c0 <myproc>
801057cc:	89 c3                	mov    %eax,%ebx
  int amount;
  argint(0, &amount);
801057ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057d1:	83 ec 08             	sub    $0x8,%esp
801057d4:	50                   	push   %eax
801057d5:	6a 00                	push   $0x0
801057d7:	e8 b4 f2 ff ff       	call   80104a90 <argint>
  if (amount < 1)
801057dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057df:	83 c4 10             	add    $0x10,%esp
801057e2:	85 c0                	test   %eax,%eax
801057e4:	7e 1a                	jle    80105800 <sys_settickets+0x40>
    return -1;
  setproctickets(curproc->pid, amount);
801057e6:	83 ec 08             	sub    $0x8,%esp
801057e9:	50                   	push   %eax
801057ea:	ff 73 10             	pushl  0x10(%ebx)
801057ed:	e8 2e df ff ff       	call   80103720 <setproctickets>
  return 0;
801057f2:	83 c4 10             	add    $0x10,%esp
801057f5:	31 c0                	xor    %eax,%eax
}
801057f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057fa:	c9                   	leave  
801057fb:	c3                   	ret    
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105805:	eb f0                	jmp    801057f7 <sys_settickets+0x37>
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105810 <sys_getpinfo>:

int
sys_getpinfo(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	83 ec 1c             	sub    $0x1c,%esp
  struct pstat *target;
  argptr(0, (void*)&target, sizeof(*target));
80105816:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105819:	68 00 04 00 00       	push   $0x400
8010581e:	50                   	push   %eax
8010581f:	6a 00                	push   $0x0
80105821:	e8 ba f2 ff ff       	call   80104ae0 <argptr>
  setpstat(target);
80105826:	58                   	pop    %eax
80105827:	ff 75 f4             	pushl  -0xc(%ebp)
8010582a:	e8 41 df ff ff       	call   80103770 <setpstat>
  return 0;
}
8010582f:	31 c0                	xor    %eax,%eax
80105831:	c9                   	leave  
80105832:	c3                   	ret    
80105833:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105840 <sys_fork>:

int
sys_fork(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105843:	5d                   	pop    %ebp
  return fork();
80105844:	e9 27 e2 ff ff       	jmp    80103a70 <fork>
80105849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105850 <sys_exit>:

int
sys_exit(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	83 ec 08             	sub    $0x8,%esp
  exit();
80105856:	e8 f5 e4 ff ff       	call   80103d50 <exit>
  return 0;  // not reached
}
8010585b:	31 c0                	xor    %eax,%eax
8010585d:	c9                   	leave  
8010585e:	c3                   	ret    
8010585f:	90                   	nop

80105860 <sys_wait>:

int
sys_wait(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105863:	5d                   	pop    %ebp
  return wait();
80105864:	e9 27 e7 ff ff       	jmp    80103f90 <wait>
80105869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105870 <sys_kill>:

int
sys_kill(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105876:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105879:	50                   	push   %eax
8010587a:	6a 00                	push   $0x0
8010587c:	e8 0f f2 ff ff       	call   80104a90 <argint>
80105881:	83 c4 10             	add    $0x10,%esp
80105884:	85 c0                	test   %eax,%eax
80105886:	78 18                	js     801058a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105888:	83 ec 0c             	sub    $0xc,%esp
8010588b:	ff 75 f4             	pushl  -0xc(%ebp)
8010588e:	e8 5d e8 ff ff       	call   801040f0 <kill>
80105893:	83 c4 10             	add    $0x10,%esp
}
80105896:	c9                   	leave  
80105897:	c3                   	ret    
80105898:	90                   	nop
80105899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801058a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058a5:	c9                   	leave  
801058a6:	c3                   	ret    
801058a7:	89 f6                	mov    %esi,%esi
801058a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058b0 <sys_getpid>:

int
sys_getpid(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801058b6:	e8 05 e0 ff ff       	call   801038c0 <myproc>
801058bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801058be:	c9                   	leave  
801058bf:	c3                   	ret    

801058c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801058ca:	50                   	push   %eax
801058cb:	6a 00                	push   $0x0
801058cd:	e8 be f1 ff ff       	call   80104a90 <argint>
801058d2:	83 c4 10             	add    $0x10,%esp
801058d5:	85 c0                	test   %eax,%eax
801058d7:	78 27                	js     80105900 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801058d9:	e8 e2 df ff ff       	call   801038c0 <myproc>
  if(growproc(n) < 0)
801058de:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801058e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801058e3:	ff 75 f4             	pushl  -0xc(%ebp)
801058e6:	e8 05 e1 ff ff       	call   801039f0 <growproc>
801058eb:	83 c4 10             	add    $0x10,%esp
801058ee:	85 c0                	test   %eax,%eax
801058f0:	78 0e                	js     80105900 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801058f2:	89 d8                	mov    %ebx,%eax
801058f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058f7:	c9                   	leave  
801058f8:	c3                   	ret    
801058f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105900:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105905:	eb eb                	jmp    801058f2 <sys_sbrk+0x32>
80105907:	89 f6                	mov    %esi,%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105910 <sys_sleep>:

int
sys_sleep(void)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105914:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105917:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010591a:	50                   	push   %eax
8010591b:	6a 00                	push   $0x0
8010591d:	e8 6e f1 ff ff       	call   80104a90 <argint>
80105922:	83 c4 10             	add    $0x10,%esp
80105925:	85 c0                	test   %eax,%eax
80105927:	0f 88 8a 00 00 00    	js     801059b7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010592d:	83 ec 0c             	sub    $0xc,%esp
80105930:	68 40 59 11 80       	push   $0x80115940
80105935:	e8 46 ed ff ff       	call   80104680 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010593a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010593d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105940:	8b 1d 80 61 11 80    	mov    0x80116180,%ebx
  while(ticks - ticks0 < n){
80105946:	85 d2                	test   %edx,%edx
80105948:	75 27                	jne    80105971 <sys_sleep+0x61>
8010594a:	eb 54                	jmp    801059a0 <sys_sleep+0x90>
8010594c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105950:	83 ec 08             	sub    $0x8,%esp
80105953:	68 40 59 11 80       	push   $0x80115940
80105958:	68 80 61 11 80       	push   $0x80116180
8010595d:	e8 6e e5 ff ff       	call   80103ed0 <sleep>
  while(ticks - ticks0 < n){
80105962:	a1 80 61 11 80       	mov    0x80116180,%eax
80105967:	83 c4 10             	add    $0x10,%esp
8010596a:	29 d8                	sub    %ebx,%eax
8010596c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010596f:	73 2f                	jae    801059a0 <sys_sleep+0x90>
    if(myproc()->killed){
80105971:	e8 4a df ff ff       	call   801038c0 <myproc>
80105976:	8b 40 24             	mov    0x24(%eax),%eax
80105979:	85 c0                	test   %eax,%eax
8010597b:	74 d3                	je     80105950 <sys_sleep+0x40>
      release(&tickslock);
8010597d:	83 ec 0c             	sub    $0xc,%esp
80105980:	68 40 59 11 80       	push   $0x80115940
80105985:	e8 b6 ed ff ff       	call   80104740 <release>
      return -1;
8010598a:	83 c4 10             	add    $0x10,%esp
8010598d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105992:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105995:	c9                   	leave  
80105996:	c3                   	ret    
80105997:	89 f6                	mov    %esi,%esi
80105999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801059a0:	83 ec 0c             	sub    $0xc,%esp
801059a3:	68 40 59 11 80       	push   $0x80115940
801059a8:	e8 93 ed ff ff       	call   80104740 <release>
  return 0;
801059ad:	83 c4 10             	add    $0x10,%esp
801059b0:	31 c0                	xor    %eax,%eax
}
801059b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059b5:	c9                   	leave  
801059b6:	c3                   	ret    
    return -1;
801059b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059bc:	eb f4                	jmp    801059b2 <sys_sleep+0xa2>
801059be:	66 90                	xchg   %ax,%ax

801059c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	53                   	push   %ebx
801059c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059c7:	68 40 59 11 80       	push   $0x80115940
801059cc:	e8 af ec ff ff       	call   80104680 <acquire>
  xticks = ticks;
801059d1:	8b 1d 80 61 11 80    	mov    0x80116180,%ebx
  release(&tickslock);
801059d7:	c7 04 24 40 59 11 80 	movl   $0x80115940,(%esp)
801059de:	e8 5d ed ff ff       	call   80104740 <release>
  return xticks;
}
801059e3:	89 d8                	mov    %ebx,%eax
801059e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059e8:	c9                   	leave  
801059e9:	c3                   	ret    

801059ea <alltraps>:
801059ea:	1e                   	push   %ds
801059eb:	06                   	push   %es
801059ec:	0f a0                	push   %fs
801059ee:	0f a8                	push   %gs
801059f0:	60                   	pusha  
801059f1:	66 b8 10 00          	mov    $0x10,%ax
801059f5:	8e d8                	mov    %eax,%ds
801059f7:	8e c0                	mov    %eax,%es
801059f9:	54                   	push   %esp
801059fa:	e8 c1 00 00 00       	call   80105ac0 <trap>
801059ff:	83 c4 04             	add    $0x4,%esp

80105a02 <trapret>:
80105a02:	61                   	popa   
80105a03:	0f a9                	pop    %gs
80105a05:	0f a1                	pop    %fs
80105a07:	07                   	pop    %es
80105a08:	1f                   	pop    %ds
80105a09:	83 c4 08             	add    $0x8,%esp
80105a0c:	cf                   	iret   
80105a0d:	66 90                	xchg   %ax,%ax
80105a0f:	90                   	nop

80105a10 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a10:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105a11:	31 c0                	xor    %eax,%eax
{
80105a13:	89 e5                	mov    %esp,%ebp
80105a15:	83 ec 08             	sub    $0x8,%esp
80105a18:	90                   	nop
80105a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a20:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105a27:	c7 04 c5 82 59 11 80 	movl   $0x8e000008,-0x7feea67e(,%eax,8)
80105a2e:	08 00 00 8e 
80105a32:	66 89 14 c5 80 59 11 	mov    %dx,-0x7feea680(,%eax,8)
80105a39:	80 
80105a3a:	c1 ea 10             	shr    $0x10,%edx
80105a3d:	66 89 14 c5 86 59 11 	mov    %dx,-0x7feea67a(,%eax,8)
80105a44:	80 
  for(i = 0; i < 256; i++)
80105a45:	83 c0 01             	add    $0x1,%eax
80105a48:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a4d:	75 d1                	jne    80105a20 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a4f:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105a54:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a57:	c7 05 82 5b 11 80 08 	movl   $0xef000008,0x80115b82
80105a5e:	00 00 ef 
  initlock(&tickslock, "time");
80105a61:	68 21 7a 10 80       	push   $0x80107a21
80105a66:	68 40 59 11 80       	push   $0x80115940
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a6b:	66 a3 80 5b 11 80    	mov    %ax,0x80115b80
80105a71:	c1 e8 10             	shr    $0x10,%eax
80105a74:	66 a3 86 5b 11 80    	mov    %ax,0x80115b86
  initlock(&tickslock, "time");
80105a7a:	e8 c1 ea ff ff       	call   80104540 <initlock>
}
80105a7f:	83 c4 10             	add    $0x10,%esp
80105a82:	c9                   	leave  
80105a83:	c3                   	ret    
80105a84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105a90 <idtinit>:

void
idtinit(void)
{
80105a90:	55                   	push   %ebp
  pd[0] = size-1;
80105a91:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a96:	89 e5                	mov    %esp,%ebp
80105a98:	83 ec 10             	sub    $0x10,%esp
80105a9b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a9f:	b8 80 59 11 80       	mov    $0x80115980,%eax
80105aa4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105aa8:	c1 e8 10             	shr    $0x10,%eax
80105aab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105aaf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ab2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ab5:	c9                   	leave  
80105ab6:	c3                   	ret    
80105ab7:	89 f6                	mov    %esi,%esi
80105ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ac0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	57                   	push   %edi
80105ac4:	56                   	push   %esi
80105ac5:	53                   	push   %ebx
80105ac6:	83 ec 1c             	sub    $0x1c,%esp
80105ac9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105acc:	8b 47 30             	mov    0x30(%edi),%eax
80105acf:	83 f8 40             	cmp    $0x40,%eax
80105ad2:	0f 84 f0 00 00 00    	je     80105bc8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105ad8:	83 e8 20             	sub    $0x20,%eax
80105adb:	83 f8 1f             	cmp    $0x1f,%eax
80105ade:	77 10                	ja     80105af0 <trap+0x30>
80105ae0:	ff 24 85 c8 7a 10 80 	jmp    *-0x7fef8538(,%eax,4)
80105ae7:	89 f6                	mov    %esi,%esi
80105ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105af0:	e8 cb dd ff ff       	call   801038c0 <myproc>
80105af5:	85 c0                	test   %eax,%eax
80105af7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105afa:	0f 84 14 02 00 00    	je     80105d14 <trap+0x254>
80105b00:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105b04:	0f 84 0a 02 00 00    	je     80105d14 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105b0a:	0f 20 d1             	mov    %cr2,%ecx
80105b0d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b10:	e8 8b dd ff ff       	call   801038a0 <cpuid>
80105b15:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105b18:	8b 47 34             	mov    0x34(%edi),%eax
80105b1b:	8b 77 30             	mov    0x30(%edi),%esi
80105b1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b21:	e8 9a dd ff ff       	call   801038c0 <myproc>
80105b26:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105b29:	e8 92 dd ff ff       	call   801038c0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b2e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105b31:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105b34:	51                   	push   %ecx
80105b35:	53                   	push   %ebx
80105b36:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105b37:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b3a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b3d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105b3e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b41:	52                   	push   %edx
80105b42:	ff 70 10             	pushl  0x10(%eax)
80105b45:	68 84 7a 10 80       	push   $0x80107a84
80105b4a:	e8 11 ab ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105b4f:	83 c4 20             	add    $0x20,%esp
80105b52:	e8 69 dd ff ff       	call   801038c0 <myproc>
80105b57:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b5e:	e8 5d dd ff ff       	call   801038c0 <myproc>
80105b63:	85 c0                	test   %eax,%eax
80105b65:	74 1d                	je     80105b84 <trap+0xc4>
80105b67:	e8 54 dd ff ff       	call   801038c0 <myproc>
80105b6c:	8b 50 24             	mov    0x24(%eax),%edx
80105b6f:	85 d2                	test   %edx,%edx
80105b71:	74 11                	je     80105b84 <trap+0xc4>
80105b73:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b77:	83 e0 03             	and    $0x3,%eax
80105b7a:	66 83 f8 03          	cmp    $0x3,%ax
80105b7e:	0f 84 4c 01 00 00    	je     80105cd0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b84:	e8 37 dd ff ff       	call   801038c0 <myproc>
80105b89:	85 c0                	test   %eax,%eax
80105b8b:	74 0b                	je     80105b98 <trap+0xd8>
80105b8d:	e8 2e dd ff ff       	call   801038c0 <myproc>
80105b92:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b96:	74 68                	je     80105c00 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b98:	e8 23 dd ff ff       	call   801038c0 <myproc>
80105b9d:	85 c0                	test   %eax,%eax
80105b9f:	74 19                	je     80105bba <trap+0xfa>
80105ba1:	e8 1a dd ff ff       	call   801038c0 <myproc>
80105ba6:	8b 40 24             	mov    0x24(%eax),%eax
80105ba9:	85 c0                	test   %eax,%eax
80105bab:	74 0d                	je     80105bba <trap+0xfa>
80105bad:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105bb1:	83 e0 03             	and    $0x3,%eax
80105bb4:	66 83 f8 03          	cmp    $0x3,%ax
80105bb8:	74 37                	je     80105bf1 <trap+0x131>
    exit();
}
80105bba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bbd:	5b                   	pop    %ebx
80105bbe:	5e                   	pop    %esi
80105bbf:	5f                   	pop    %edi
80105bc0:	5d                   	pop    %ebp
80105bc1:	c3                   	ret    
80105bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105bc8:	e8 f3 dc ff ff       	call   801038c0 <myproc>
80105bcd:	8b 58 24             	mov    0x24(%eax),%ebx
80105bd0:	85 db                	test   %ebx,%ebx
80105bd2:	0f 85 e8 00 00 00    	jne    80105cc0 <trap+0x200>
    myproc()->tf = tf;
80105bd8:	e8 e3 dc ff ff       	call   801038c0 <myproc>
80105bdd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105be0:	e8 9b ef ff ff       	call   80104b80 <syscall>
    if(myproc()->killed)
80105be5:	e8 d6 dc ff ff       	call   801038c0 <myproc>
80105bea:	8b 48 24             	mov    0x24(%eax),%ecx
80105bed:	85 c9                	test   %ecx,%ecx
80105bef:	74 c9                	je     80105bba <trap+0xfa>
}
80105bf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bf4:	5b                   	pop    %ebx
80105bf5:	5e                   	pop    %esi
80105bf6:	5f                   	pop    %edi
80105bf7:	5d                   	pop    %ebp
      exit();
80105bf8:	e9 53 e1 ff ff       	jmp    80103d50 <exit>
80105bfd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105c00:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105c04:	75 92                	jne    80105b98 <trap+0xd8>
    yield();
80105c06:	e8 75 e2 ff ff       	call   80103e80 <yield>
80105c0b:	eb 8b                	jmp    80105b98 <trap+0xd8>
80105c0d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105c10:	e8 8b dc ff ff       	call   801038a0 <cpuid>
80105c15:	85 c0                	test   %eax,%eax
80105c17:	0f 84 c3 00 00 00    	je     80105ce0 <trap+0x220>
    lapiceoi();
80105c1d:	e8 2e cb ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c22:	e8 99 dc ff ff       	call   801038c0 <myproc>
80105c27:	85 c0                	test   %eax,%eax
80105c29:	0f 85 38 ff ff ff    	jne    80105b67 <trap+0xa7>
80105c2f:	e9 50 ff ff ff       	jmp    80105b84 <trap+0xc4>
80105c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105c38:	e8 d3 c9 ff ff       	call   80102610 <kbdintr>
    lapiceoi();
80105c3d:	e8 0e cb ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c42:	e8 79 dc ff ff       	call   801038c0 <myproc>
80105c47:	85 c0                	test   %eax,%eax
80105c49:	0f 85 18 ff ff ff    	jne    80105b67 <trap+0xa7>
80105c4f:	e9 30 ff ff ff       	jmp    80105b84 <trap+0xc4>
80105c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105c58:	e8 53 02 00 00       	call   80105eb0 <uartintr>
    lapiceoi();
80105c5d:	e8 ee ca ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c62:	e8 59 dc ff ff       	call   801038c0 <myproc>
80105c67:	85 c0                	test   %eax,%eax
80105c69:	0f 85 f8 fe ff ff    	jne    80105b67 <trap+0xa7>
80105c6f:	e9 10 ff ff ff       	jmp    80105b84 <trap+0xc4>
80105c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105c78:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105c7c:	8b 77 38             	mov    0x38(%edi),%esi
80105c7f:	e8 1c dc ff ff       	call   801038a0 <cpuid>
80105c84:	56                   	push   %esi
80105c85:	53                   	push   %ebx
80105c86:	50                   	push   %eax
80105c87:	68 2c 7a 10 80       	push   $0x80107a2c
80105c8c:	e8 cf a9 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105c91:	e8 ba ca ff ff       	call   80102750 <lapiceoi>
    break;
80105c96:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c99:	e8 22 dc ff ff       	call   801038c0 <myproc>
80105c9e:	85 c0                	test   %eax,%eax
80105ca0:	0f 85 c1 fe ff ff    	jne    80105b67 <trap+0xa7>
80105ca6:	e9 d9 fe ff ff       	jmp    80105b84 <trap+0xc4>
80105cab:	90                   	nop
80105cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105cb0:	e8 cb c3 ff ff       	call   80102080 <ideintr>
80105cb5:	e9 63 ff ff ff       	jmp    80105c1d <trap+0x15d>
80105cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105cc0:	e8 8b e0 ff ff       	call   80103d50 <exit>
80105cc5:	e9 0e ff ff ff       	jmp    80105bd8 <trap+0x118>
80105cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105cd0:	e8 7b e0 ff ff       	call   80103d50 <exit>
80105cd5:	e9 aa fe ff ff       	jmp    80105b84 <trap+0xc4>
80105cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105ce0:	83 ec 0c             	sub    $0xc,%esp
80105ce3:	68 40 59 11 80       	push   $0x80115940
80105ce8:	e8 93 e9 ff ff       	call   80104680 <acquire>
      wakeup(&ticks);
80105ced:	c7 04 24 80 61 11 80 	movl   $0x80116180,(%esp)
      ticks++;
80105cf4:	83 05 80 61 11 80 01 	addl   $0x1,0x80116180
      wakeup(&ticks);
80105cfb:	e8 90 e3 ff ff       	call   80104090 <wakeup>
      release(&tickslock);
80105d00:	c7 04 24 40 59 11 80 	movl   $0x80115940,(%esp)
80105d07:	e8 34 ea ff ff       	call   80104740 <release>
80105d0c:	83 c4 10             	add    $0x10,%esp
80105d0f:	e9 09 ff ff ff       	jmp    80105c1d <trap+0x15d>
80105d14:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d17:	e8 84 db ff ff       	call   801038a0 <cpuid>
80105d1c:	83 ec 0c             	sub    $0xc,%esp
80105d1f:	56                   	push   %esi
80105d20:	53                   	push   %ebx
80105d21:	50                   	push   %eax
80105d22:	ff 77 30             	pushl  0x30(%edi)
80105d25:	68 50 7a 10 80       	push   $0x80107a50
80105d2a:	e8 31 a9 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105d2f:	83 c4 14             	add    $0x14,%esp
80105d32:	68 26 7a 10 80       	push   $0x80107a26
80105d37:	e8 54 a6 ff ff       	call   80100390 <panic>
80105d3c:	66 90                	xchg   %ax,%ax
80105d3e:	66 90                	xchg   %ax,%ax

80105d40 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d40:	a1 80 af 10 80       	mov    0x8010af80,%eax
{
80105d45:	55                   	push   %ebp
80105d46:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105d48:	85 c0                	test   %eax,%eax
80105d4a:	74 1c                	je     80105d68 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d4c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d51:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d52:	a8 01                	test   $0x1,%al
80105d54:	74 12                	je     80105d68 <uartgetc+0x28>
80105d56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d5b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d5c:	0f b6 c0             	movzbl %al,%eax
}
80105d5f:	5d                   	pop    %ebp
80105d60:	c3                   	ret    
80105d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d6d:	5d                   	pop    %ebp
80105d6e:	c3                   	ret    
80105d6f:	90                   	nop

80105d70 <uartputc.part.0>:
uartputc(int c)
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	57                   	push   %edi
80105d74:	56                   	push   %esi
80105d75:	53                   	push   %ebx
80105d76:	89 c7                	mov    %eax,%edi
80105d78:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d7d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d82:	83 ec 0c             	sub    $0xc,%esp
80105d85:	eb 1b                	jmp    80105da2 <uartputc.part.0+0x32>
80105d87:	89 f6                	mov    %esi,%esi
80105d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105d90:	83 ec 0c             	sub    $0xc,%esp
80105d93:	6a 0a                	push   $0xa
80105d95:	e8 d6 c9 ff ff       	call   80102770 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d9a:	83 c4 10             	add    $0x10,%esp
80105d9d:	83 eb 01             	sub    $0x1,%ebx
80105da0:	74 07                	je     80105da9 <uartputc.part.0+0x39>
80105da2:	89 f2                	mov    %esi,%edx
80105da4:	ec                   	in     (%dx),%al
80105da5:	a8 20                	test   $0x20,%al
80105da7:	74 e7                	je     80105d90 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105da9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dae:	89 f8                	mov    %edi,%eax
80105db0:	ee                   	out    %al,(%dx)
}
80105db1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105db4:	5b                   	pop    %ebx
80105db5:	5e                   	pop    %esi
80105db6:	5f                   	pop    %edi
80105db7:	5d                   	pop    %ebp
80105db8:	c3                   	ret    
80105db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105dc0 <uartinit>:
{
80105dc0:	55                   	push   %ebp
80105dc1:	31 c9                	xor    %ecx,%ecx
80105dc3:	89 c8                	mov    %ecx,%eax
80105dc5:	89 e5                	mov    %esp,%ebp
80105dc7:	57                   	push   %edi
80105dc8:	56                   	push   %esi
80105dc9:	53                   	push   %ebx
80105dca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105dcf:	89 da                	mov    %ebx,%edx
80105dd1:	83 ec 0c             	sub    $0xc,%esp
80105dd4:	ee                   	out    %al,(%dx)
80105dd5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105dda:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105ddf:	89 fa                	mov    %edi,%edx
80105de1:	ee                   	out    %al,(%dx)
80105de2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105de7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dec:	ee                   	out    %al,(%dx)
80105ded:	be f9 03 00 00       	mov    $0x3f9,%esi
80105df2:	89 c8                	mov    %ecx,%eax
80105df4:	89 f2                	mov    %esi,%edx
80105df6:	ee                   	out    %al,(%dx)
80105df7:	b8 03 00 00 00       	mov    $0x3,%eax
80105dfc:	89 fa                	mov    %edi,%edx
80105dfe:	ee                   	out    %al,(%dx)
80105dff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105e04:	89 c8                	mov    %ecx,%eax
80105e06:	ee                   	out    %al,(%dx)
80105e07:	b8 01 00 00 00       	mov    $0x1,%eax
80105e0c:	89 f2                	mov    %esi,%edx
80105e0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e0f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e14:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105e15:	3c ff                	cmp    $0xff,%al
80105e17:	74 5a                	je     80105e73 <uartinit+0xb3>
  uart = 1;
80105e19:	c7 05 80 af 10 80 01 	movl   $0x1,0x8010af80
80105e20:	00 00 00 
80105e23:	89 da                	mov    %ebx,%edx
80105e25:	ec                   	in     (%dx),%al
80105e26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e2b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105e2c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105e2f:	bb 48 7b 10 80       	mov    $0x80107b48,%ebx
  ioapicenable(IRQ_COM1, 0);
80105e34:	6a 00                	push   $0x0
80105e36:	6a 04                	push   $0x4
80105e38:	e8 93 c4 ff ff       	call   801022d0 <ioapicenable>
80105e3d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105e40:	b8 78 00 00 00       	mov    $0x78,%eax
80105e45:	eb 13                	jmp    80105e5a <uartinit+0x9a>
80105e47:	89 f6                	mov    %esi,%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e50:	83 c3 01             	add    $0x1,%ebx
80105e53:	0f be 03             	movsbl (%ebx),%eax
80105e56:	84 c0                	test   %al,%al
80105e58:	74 19                	je     80105e73 <uartinit+0xb3>
  if(!uart)
80105e5a:	8b 15 80 af 10 80    	mov    0x8010af80,%edx
80105e60:	85 d2                	test   %edx,%edx
80105e62:	74 ec                	je     80105e50 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105e64:	83 c3 01             	add    $0x1,%ebx
80105e67:	e8 04 ff ff ff       	call   80105d70 <uartputc.part.0>
80105e6c:	0f be 03             	movsbl (%ebx),%eax
80105e6f:	84 c0                	test   %al,%al
80105e71:	75 e7                	jne    80105e5a <uartinit+0x9a>
}
80105e73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e76:	5b                   	pop    %ebx
80105e77:	5e                   	pop    %esi
80105e78:	5f                   	pop    %edi
80105e79:	5d                   	pop    %ebp
80105e7a:	c3                   	ret    
80105e7b:	90                   	nop
80105e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e80 <uartputc>:
  if(!uart)
80105e80:	8b 15 80 af 10 80    	mov    0x8010af80,%edx
{
80105e86:	55                   	push   %ebp
80105e87:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105e89:	85 d2                	test   %edx,%edx
{
80105e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105e8e:	74 10                	je     80105ea0 <uartputc+0x20>
}
80105e90:	5d                   	pop    %ebp
80105e91:	e9 da fe ff ff       	jmp    80105d70 <uartputc.part.0>
80105e96:	8d 76 00             	lea    0x0(%esi),%esi
80105e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ea0:	5d                   	pop    %ebp
80105ea1:	c3                   	ret    
80105ea2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105eb0 <uartintr>:

void
uartintr(void)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105eb6:	68 40 5d 10 80       	push   $0x80105d40
80105ebb:	e8 50 a9 ff ff       	call   80100810 <consoleintr>
}
80105ec0:	83 c4 10             	add    $0x10,%esp
80105ec3:	c9                   	leave  
80105ec4:	c3                   	ret    

80105ec5 <vector0>:
80105ec5:	6a 00                	push   $0x0
80105ec7:	6a 00                	push   $0x0
80105ec9:	e9 1c fb ff ff       	jmp    801059ea <alltraps>

80105ece <vector1>:
80105ece:	6a 00                	push   $0x0
80105ed0:	6a 01                	push   $0x1
80105ed2:	e9 13 fb ff ff       	jmp    801059ea <alltraps>

80105ed7 <vector2>:
80105ed7:	6a 00                	push   $0x0
80105ed9:	6a 02                	push   $0x2
80105edb:	e9 0a fb ff ff       	jmp    801059ea <alltraps>

80105ee0 <vector3>:
80105ee0:	6a 00                	push   $0x0
80105ee2:	6a 03                	push   $0x3
80105ee4:	e9 01 fb ff ff       	jmp    801059ea <alltraps>

80105ee9 <vector4>:
80105ee9:	6a 00                	push   $0x0
80105eeb:	6a 04                	push   $0x4
80105eed:	e9 f8 fa ff ff       	jmp    801059ea <alltraps>

80105ef2 <vector5>:
80105ef2:	6a 00                	push   $0x0
80105ef4:	6a 05                	push   $0x5
80105ef6:	e9 ef fa ff ff       	jmp    801059ea <alltraps>

80105efb <vector6>:
80105efb:	6a 00                	push   $0x0
80105efd:	6a 06                	push   $0x6
80105eff:	e9 e6 fa ff ff       	jmp    801059ea <alltraps>

80105f04 <vector7>:
80105f04:	6a 00                	push   $0x0
80105f06:	6a 07                	push   $0x7
80105f08:	e9 dd fa ff ff       	jmp    801059ea <alltraps>

80105f0d <vector8>:
80105f0d:	6a 08                	push   $0x8
80105f0f:	e9 d6 fa ff ff       	jmp    801059ea <alltraps>

80105f14 <vector9>:
80105f14:	6a 00                	push   $0x0
80105f16:	6a 09                	push   $0x9
80105f18:	e9 cd fa ff ff       	jmp    801059ea <alltraps>

80105f1d <vector10>:
80105f1d:	6a 0a                	push   $0xa
80105f1f:	e9 c6 fa ff ff       	jmp    801059ea <alltraps>

80105f24 <vector11>:
80105f24:	6a 0b                	push   $0xb
80105f26:	e9 bf fa ff ff       	jmp    801059ea <alltraps>

80105f2b <vector12>:
80105f2b:	6a 0c                	push   $0xc
80105f2d:	e9 b8 fa ff ff       	jmp    801059ea <alltraps>

80105f32 <vector13>:
80105f32:	6a 0d                	push   $0xd
80105f34:	e9 b1 fa ff ff       	jmp    801059ea <alltraps>

80105f39 <vector14>:
80105f39:	6a 0e                	push   $0xe
80105f3b:	e9 aa fa ff ff       	jmp    801059ea <alltraps>

80105f40 <vector15>:
80105f40:	6a 00                	push   $0x0
80105f42:	6a 0f                	push   $0xf
80105f44:	e9 a1 fa ff ff       	jmp    801059ea <alltraps>

80105f49 <vector16>:
80105f49:	6a 00                	push   $0x0
80105f4b:	6a 10                	push   $0x10
80105f4d:	e9 98 fa ff ff       	jmp    801059ea <alltraps>

80105f52 <vector17>:
80105f52:	6a 11                	push   $0x11
80105f54:	e9 91 fa ff ff       	jmp    801059ea <alltraps>

80105f59 <vector18>:
80105f59:	6a 00                	push   $0x0
80105f5b:	6a 12                	push   $0x12
80105f5d:	e9 88 fa ff ff       	jmp    801059ea <alltraps>

80105f62 <vector19>:
80105f62:	6a 00                	push   $0x0
80105f64:	6a 13                	push   $0x13
80105f66:	e9 7f fa ff ff       	jmp    801059ea <alltraps>

80105f6b <vector20>:
80105f6b:	6a 00                	push   $0x0
80105f6d:	6a 14                	push   $0x14
80105f6f:	e9 76 fa ff ff       	jmp    801059ea <alltraps>

80105f74 <vector21>:
80105f74:	6a 00                	push   $0x0
80105f76:	6a 15                	push   $0x15
80105f78:	e9 6d fa ff ff       	jmp    801059ea <alltraps>

80105f7d <vector22>:
80105f7d:	6a 00                	push   $0x0
80105f7f:	6a 16                	push   $0x16
80105f81:	e9 64 fa ff ff       	jmp    801059ea <alltraps>

80105f86 <vector23>:
80105f86:	6a 00                	push   $0x0
80105f88:	6a 17                	push   $0x17
80105f8a:	e9 5b fa ff ff       	jmp    801059ea <alltraps>

80105f8f <vector24>:
80105f8f:	6a 00                	push   $0x0
80105f91:	6a 18                	push   $0x18
80105f93:	e9 52 fa ff ff       	jmp    801059ea <alltraps>

80105f98 <vector25>:
80105f98:	6a 00                	push   $0x0
80105f9a:	6a 19                	push   $0x19
80105f9c:	e9 49 fa ff ff       	jmp    801059ea <alltraps>

80105fa1 <vector26>:
80105fa1:	6a 00                	push   $0x0
80105fa3:	6a 1a                	push   $0x1a
80105fa5:	e9 40 fa ff ff       	jmp    801059ea <alltraps>

80105faa <vector27>:
80105faa:	6a 00                	push   $0x0
80105fac:	6a 1b                	push   $0x1b
80105fae:	e9 37 fa ff ff       	jmp    801059ea <alltraps>

80105fb3 <vector28>:
80105fb3:	6a 00                	push   $0x0
80105fb5:	6a 1c                	push   $0x1c
80105fb7:	e9 2e fa ff ff       	jmp    801059ea <alltraps>

80105fbc <vector29>:
80105fbc:	6a 00                	push   $0x0
80105fbe:	6a 1d                	push   $0x1d
80105fc0:	e9 25 fa ff ff       	jmp    801059ea <alltraps>

80105fc5 <vector30>:
80105fc5:	6a 00                	push   $0x0
80105fc7:	6a 1e                	push   $0x1e
80105fc9:	e9 1c fa ff ff       	jmp    801059ea <alltraps>

80105fce <vector31>:
80105fce:	6a 00                	push   $0x0
80105fd0:	6a 1f                	push   $0x1f
80105fd2:	e9 13 fa ff ff       	jmp    801059ea <alltraps>

80105fd7 <vector32>:
80105fd7:	6a 00                	push   $0x0
80105fd9:	6a 20                	push   $0x20
80105fdb:	e9 0a fa ff ff       	jmp    801059ea <alltraps>

80105fe0 <vector33>:
80105fe0:	6a 00                	push   $0x0
80105fe2:	6a 21                	push   $0x21
80105fe4:	e9 01 fa ff ff       	jmp    801059ea <alltraps>

80105fe9 <vector34>:
80105fe9:	6a 00                	push   $0x0
80105feb:	6a 22                	push   $0x22
80105fed:	e9 f8 f9 ff ff       	jmp    801059ea <alltraps>

80105ff2 <vector35>:
80105ff2:	6a 00                	push   $0x0
80105ff4:	6a 23                	push   $0x23
80105ff6:	e9 ef f9 ff ff       	jmp    801059ea <alltraps>

80105ffb <vector36>:
80105ffb:	6a 00                	push   $0x0
80105ffd:	6a 24                	push   $0x24
80105fff:	e9 e6 f9 ff ff       	jmp    801059ea <alltraps>

80106004 <vector37>:
80106004:	6a 00                	push   $0x0
80106006:	6a 25                	push   $0x25
80106008:	e9 dd f9 ff ff       	jmp    801059ea <alltraps>

8010600d <vector38>:
8010600d:	6a 00                	push   $0x0
8010600f:	6a 26                	push   $0x26
80106011:	e9 d4 f9 ff ff       	jmp    801059ea <alltraps>

80106016 <vector39>:
80106016:	6a 00                	push   $0x0
80106018:	6a 27                	push   $0x27
8010601a:	e9 cb f9 ff ff       	jmp    801059ea <alltraps>

8010601f <vector40>:
8010601f:	6a 00                	push   $0x0
80106021:	6a 28                	push   $0x28
80106023:	e9 c2 f9 ff ff       	jmp    801059ea <alltraps>

80106028 <vector41>:
80106028:	6a 00                	push   $0x0
8010602a:	6a 29                	push   $0x29
8010602c:	e9 b9 f9 ff ff       	jmp    801059ea <alltraps>

80106031 <vector42>:
80106031:	6a 00                	push   $0x0
80106033:	6a 2a                	push   $0x2a
80106035:	e9 b0 f9 ff ff       	jmp    801059ea <alltraps>

8010603a <vector43>:
8010603a:	6a 00                	push   $0x0
8010603c:	6a 2b                	push   $0x2b
8010603e:	e9 a7 f9 ff ff       	jmp    801059ea <alltraps>

80106043 <vector44>:
80106043:	6a 00                	push   $0x0
80106045:	6a 2c                	push   $0x2c
80106047:	e9 9e f9 ff ff       	jmp    801059ea <alltraps>

8010604c <vector45>:
8010604c:	6a 00                	push   $0x0
8010604e:	6a 2d                	push   $0x2d
80106050:	e9 95 f9 ff ff       	jmp    801059ea <alltraps>

80106055 <vector46>:
80106055:	6a 00                	push   $0x0
80106057:	6a 2e                	push   $0x2e
80106059:	e9 8c f9 ff ff       	jmp    801059ea <alltraps>

8010605e <vector47>:
8010605e:	6a 00                	push   $0x0
80106060:	6a 2f                	push   $0x2f
80106062:	e9 83 f9 ff ff       	jmp    801059ea <alltraps>

80106067 <vector48>:
80106067:	6a 00                	push   $0x0
80106069:	6a 30                	push   $0x30
8010606b:	e9 7a f9 ff ff       	jmp    801059ea <alltraps>

80106070 <vector49>:
80106070:	6a 00                	push   $0x0
80106072:	6a 31                	push   $0x31
80106074:	e9 71 f9 ff ff       	jmp    801059ea <alltraps>

80106079 <vector50>:
80106079:	6a 00                	push   $0x0
8010607b:	6a 32                	push   $0x32
8010607d:	e9 68 f9 ff ff       	jmp    801059ea <alltraps>

80106082 <vector51>:
80106082:	6a 00                	push   $0x0
80106084:	6a 33                	push   $0x33
80106086:	e9 5f f9 ff ff       	jmp    801059ea <alltraps>

8010608b <vector52>:
8010608b:	6a 00                	push   $0x0
8010608d:	6a 34                	push   $0x34
8010608f:	e9 56 f9 ff ff       	jmp    801059ea <alltraps>

80106094 <vector53>:
80106094:	6a 00                	push   $0x0
80106096:	6a 35                	push   $0x35
80106098:	e9 4d f9 ff ff       	jmp    801059ea <alltraps>

8010609d <vector54>:
8010609d:	6a 00                	push   $0x0
8010609f:	6a 36                	push   $0x36
801060a1:	e9 44 f9 ff ff       	jmp    801059ea <alltraps>

801060a6 <vector55>:
801060a6:	6a 00                	push   $0x0
801060a8:	6a 37                	push   $0x37
801060aa:	e9 3b f9 ff ff       	jmp    801059ea <alltraps>

801060af <vector56>:
801060af:	6a 00                	push   $0x0
801060b1:	6a 38                	push   $0x38
801060b3:	e9 32 f9 ff ff       	jmp    801059ea <alltraps>

801060b8 <vector57>:
801060b8:	6a 00                	push   $0x0
801060ba:	6a 39                	push   $0x39
801060bc:	e9 29 f9 ff ff       	jmp    801059ea <alltraps>

801060c1 <vector58>:
801060c1:	6a 00                	push   $0x0
801060c3:	6a 3a                	push   $0x3a
801060c5:	e9 20 f9 ff ff       	jmp    801059ea <alltraps>

801060ca <vector59>:
801060ca:	6a 00                	push   $0x0
801060cc:	6a 3b                	push   $0x3b
801060ce:	e9 17 f9 ff ff       	jmp    801059ea <alltraps>

801060d3 <vector60>:
801060d3:	6a 00                	push   $0x0
801060d5:	6a 3c                	push   $0x3c
801060d7:	e9 0e f9 ff ff       	jmp    801059ea <alltraps>

801060dc <vector61>:
801060dc:	6a 00                	push   $0x0
801060de:	6a 3d                	push   $0x3d
801060e0:	e9 05 f9 ff ff       	jmp    801059ea <alltraps>

801060e5 <vector62>:
801060e5:	6a 00                	push   $0x0
801060e7:	6a 3e                	push   $0x3e
801060e9:	e9 fc f8 ff ff       	jmp    801059ea <alltraps>

801060ee <vector63>:
801060ee:	6a 00                	push   $0x0
801060f0:	6a 3f                	push   $0x3f
801060f2:	e9 f3 f8 ff ff       	jmp    801059ea <alltraps>

801060f7 <vector64>:
801060f7:	6a 00                	push   $0x0
801060f9:	6a 40                	push   $0x40
801060fb:	e9 ea f8 ff ff       	jmp    801059ea <alltraps>

80106100 <vector65>:
80106100:	6a 00                	push   $0x0
80106102:	6a 41                	push   $0x41
80106104:	e9 e1 f8 ff ff       	jmp    801059ea <alltraps>

80106109 <vector66>:
80106109:	6a 00                	push   $0x0
8010610b:	6a 42                	push   $0x42
8010610d:	e9 d8 f8 ff ff       	jmp    801059ea <alltraps>

80106112 <vector67>:
80106112:	6a 00                	push   $0x0
80106114:	6a 43                	push   $0x43
80106116:	e9 cf f8 ff ff       	jmp    801059ea <alltraps>

8010611b <vector68>:
8010611b:	6a 00                	push   $0x0
8010611d:	6a 44                	push   $0x44
8010611f:	e9 c6 f8 ff ff       	jmp    801059ea <alltraps>

80106124 <vector69>:
80106124:	6a 00                	push   $0x0
80106126:	6a 45                	push   $0x45
80106128:	e9 bd f8 ff ff       	jmp    801059ea <alltraps>

8010612d <vector70>:
8010612d:	6a 00                	push   $0x0
8010612f:	6a 46                	push   $0x46
80106131:	e9 b4 f8 ff ff       	jmp    801059ea <alltraps>

80106136 <vector71>:
80106136:	6a 00                	push   $0x0
80106138:	6a 47                	push   $0x47
8010613a:	e9 ab f8 ff ff       	jmp    801059ea <alltraps>

8010613f <vector72>:
8010613f:	6a 00                	push   $0x0
80106141:	6a 48                	push   $0x48
80106143:	e9 a2 f8 ff ff       	jmp    801059ea <alltraps>

80106148 <vector73>:
80106148:	6a 00                	push   $0x0
8010614a:	6a 49                	push   $0x49
8010614c:	e9 99 f8 ff ff       	jmp    801059ea <alltraps>

80106151 <vector74>:
80106151:	6a 00                	push   $0x0
80106153:	6a 4a                	push   $0x4a
80106155:	e9 90 f8 ff ff       	jmp    801059ea <alltraps>

8010615a <vector75>:
8010615a:	6a 00                	push   $0x0
8010615c:	6a 4b                	push   $0x4b
8010615e:	e9 87 f8 ff ff       	jmp    801059ea <alltraps>

80106163 <vector76>:
80106163:	6a 00                	push   $0x0
80106165:	6a 4c                	push   $0x4c
80106167:	e9 7e f8 ff ff       	jmp    801059ea <alltraps>

8010616c <vector77>:
8010616c:	6a 00                	push   $0x0
8010616e:	6a 4d                	push   $0x4d
80106170:	e9 75 f8 ff ff       	jmp    801059ea <alltraps>

80106175 <vector78>:
80106175:	6a 00                	push   $0x0
80106177:	6a 4e                	push   $0x4e
80106179:	e9 6c f8 ff ff       	jmp    801059ea <alltraps>

8010617e <vector79>:
8010617e:	6a 00                	push   $0x0
80106180:	6a 4f                	push   $0x4f
80106182:	e9 63 f8 ff ff       	jmp    801059ea <alltraps>

80106187 <vector80>:
80106187:	6a 00                	push   $0x0
80106189:	6a 50                	push   $0x50
8010618b:	e9 5a f8 ff ff       	jmp    801059ea <alltraps>

80106190 <vector81>:
80106190:	6a 00                	push   $0x0
80106192:	6a 51                	push   $0x51
80106194:	e9 51 f8 ff ff       	jmp    801059ea <alltraps>

80106199 <vector82>:
80106199:	6a 00                	push   $0x0
8010619b:	6a 52                	push   $0x52
8010619d:	e9 48 f8 ff ff       	jmp    801059ea <alltraps>

801061a2 <vector83>:
801061a2:	6a 00                	push   $0x0
801061a4:	6a 53                	push   $0x53
801061a6:	e9 3f f8 ff ff       	jmp    801059ea <alltraps>

801061ab <vector84>:
801061ab:	6a 00                	push   $0x0
801061ad:	6a 54                	push   $0x54
801061af:	e9 36 f8 ff ff       	jmp    801059ea <alltraps>

801061b4 <vector85>:
801061b4:	6a 00                	push   $0x0
801061b6:	6a 55                	push   $0x55
801061b8:	e9 2d f8 ff ff       	jmp    801059ea <alltraps>

801061bd <vector86>:
801061bd:	6a 00                	push   $0x0
801061bf:	6a 56                	push   $0x56
801061c1:	e9 24 f8 ff ff       	jmp    801059ea <alltraps>

801061c6 <vector87>:
801061c6:	6a 00                	push   $0x0
801061c8:	6a 57                	push   $0x57
801061ca:	e9 1b f8 ff ff       	jmp    801059ea <alltraps>

801061cf <vector88>:
801061cf:	6a 00                	push   $0x0
801061d1:	6a 58                	push   $0x58
801061d3:	e9 12 f8 ff ff       	jmp    801059ea <alltraps>

801061d8 <vector89>:
801061d8:	6a 00                	push   $0x0
801061da:	6a 59                	push   $0x59
801061dc:	e9 09 f8 ff ff       	jmp    801059ea <alltraps>

801061e1 <vector90>:
801061e1:	6a 00                	push   $0x0
801061e3:	6a 5a                	push   $0x5a
801061e5:	e9 00 f8 ff ff       	jmp    801059ea <alltraps>

801061ea <vector91>:
801061ea:	6a 00                	push   $0x0
801061ec:	6a 5b                	push   $0x5b
801061ee:	e9 f7 f7 ff ff       	jmp    801059ea <alltraps>

801061f3 <vector92>:
801061f3:	6a 00                	push   $0x0
801061f5:	6a 5c                	push   $0x5c
801061f7:	e9 ee f7 ff ff       	jmp    801059ea <alltraps>

801061fc <vector93>:
801061fc:	6a 00                	push   $0x0
801061fe:	6a 5d                	push   $0x5d
80106200:	e9 e5 f7 ff ff       	jmp    801059ea <alltraps>

80106205 <vector94>:
80106205:	6a 00                	push   $0x0
80106207:	6a 5e                	push   $0x5e
80106209:	e9 dc f7 ff ff       	jmp    801059ea <alltraps>

8010620e <vector95>:
8010620e:	6a 00                	push   $0x0
80106210:	6a 5f                	push   $0x5f
80106212:	e9 d3 f7 ff ff       	jmp    801059ea <alltraps>

80106217 <vector96>:
80106217:	6a 00                	push   $0x0
80106219:	6a 60                	push   $0x60
8010621b:	e9 ca f7 ff ff       	jmp    801059ea <alltraps>

80106220 <vector97>:
80106220:	6a 00                	push   $0x0
80106222:	6a 61                	push   $0x61
80106224:	e9 c1 f7 ff ff       	jmp    801059ea <alltraps>

80106229 <vector98>:
80106229:	6a 00                	push   $0x0
8010622b:	6a 62                	push   $0x62
8010622d:	e9 b8 f7 ff ff       	jmp    801059ea <alltraps>

80106232 <vector99>:
80106232:	6a 00                	push   $0x0
80106234:	6a 63                	push   $0x63
80106236:	e9 af f7 ff ff       	jmp    801059ea <alltraps>

8010623b <vector100>:
8010623b:	6a 00                	push   $0x0
8010623d:	6a 64                	push   $0x64
8010623f:	e9 a6 f7 ff ff       	jmp    801059ea <alltraps>

80106244 <vector101>:
80106244:	6a 00                	push   $0x0
80106246:	6a 65                	push   $0x65
80106248:	e9 9d f7 ff ff       	jmp    801059ea <alltraps>

8010624d <vector102>:
8010624d:	6a 00                	push   $0x0
8010624f:	6a 66                	push   $0x66
80106251:	e9 94 f7 ff ff       	jmp    801059ea <alltraps>

80106256 <vector103>:
80106256:	6a 00                	push   $0x0
80106258:	6a 67                	push   $0x67
8010625a:	e9 8b f7 ff ff       	jmp    801059ea <alltraps>

8010625f <vector104>:
8010625f:	6a 00                	push   $0x0
80106261:	6a 68                	push   $0x68
80106263:	e9 82 f7 ff ff       	jmp    801059ea <alltraps>

80106268 <vector105>:
80106268:	6a 00                	push   $0x0
8010626a:	6a 69                	push   $0x69
8010626c:	e9 79 f7 ff ff       	jmp    801059ea <alltraps>

80106271 <vector106>:
80106271:	6a 00                	push   $0x0
80106273:	6a 6a                	push   $0x6a
80106275:	e9 70 f7 ff ff       	jmp    801059ea <alltraps>

8010627a <vector107>:
8010627a:	6a 00                	push   $0x0
8010627c:	6a 6b                	push   $0x6b
8010627e:	e9 67 f7 ff ff       	jmp    801059ea <alltraps>

80106283 <vector108>:
80106283:	6a 00                	push   $0x0
80106285:	6a 6c                	push   $0x6c
80106287:	e9 5e f7 ff ff       	jmp    801059ea <alltraps>

8010628c <vector109>:
8010628c:	6a 00                	push   $0x0
8010628e:	6a 6d                	push   $0x6d
80106290:	e9 55 f7 ff ff       	jmp    801059ea <alltraps>

80106295 <vector110>:
80106295:	6a 00                	push   $0x0
80106297:	6a 6e                	push   $0x6e
80106299:	e9 4c f7 ff ff       	jmp    801059ea <alltraps>

8010629e <vector111>:
8010629e:	6a 00                	push   $0x0
801062a0:	6a 6f                	push   $0x6f
801062a2:	e9 43 f7 ff ff       	jmp    801059ea <alltraps>

801062a7 <vector112>:
801062a7:	6a 00                	push   $0x0
801062a9:	6a 70                	push   $0x70
801062ab:	e9 3a f7 ff ff       	jmp    801059ea <alltraps>

801062b0 <vector113>:
801062b0:	6a 00                	push   $0x0
801062b2:	6a 71                	push   $0x71
801062b4:	e9 31 f7 ff ff       	jmp    801059ea <alltraps>

801062b9 <vector114>:
801062b9:	6a 00                	push   $0x0
801062bb:	6a 72                	push   $0x72
801062bd:	e9 28 f7 ff ff       	jmp    801059ea <alltraps>

801062c2 <vector115>:
801062c2:	6a 00                	push   $0x0
801062c4:	6a 73                	push   $0x73
801062c6:	e9 1f f7 ff ff       	jmp    801059ea <alltraps>

801062cb <vector116>:
801062cb:	6a 00                	push   $0x0
801062cd:	6a 74                	push   $0x74
801062cf:	e9 16 f7 ff ff       	jmp    801059ea <alltraps>

801062d4 <vector117>:
801062d4:	6a 00                	push   $0x0
801062d6:	6a 75                	push   $0x75
801062d8:	e9 0d f7 ff ff       	jmp    801059ea <alltraps>

801062dd <vector118>:
801062dd:	6a 00                	push   $0x0
801062df:	6a 76                	push   $0x76
801062e1:	e9 04 f7 ff ff       	jmp    801059ea <alltraps>

801062e6 <vector119>:
801062e6:	6a 00                	push   $0x0
801062e8:	6a 77                	push   $0x77
801062ea:	e9 fb f6 ff ff       	jmp    801059ea <alltraps>

801062ef <vector120>:
801062ef:	6a 00                	push   $0x0
801062f1:	6a 78                	push   $0x78
801062f3:	e9 f2 f6 ff ff       	jmp    801059ea <alltraps>

801062f8 <vector121>:
801062f8:	6a 00                	push   $0x0
801062fa:	6a 79                	push   $0x79
801062fc:	e9 e9 f6 ff ff       	jmp    801059ea <alltraps>

80106301 <vector122>:
80106301:	6a 00                	push   $0x0
80106303:	6a 7a                	push   $0x7a
80106305:	e9 e0 f6 ff ff       	jmp    801059ea <alltraps>

8010630a <vector123>:
8010630a:	6a 00                	push   $0x0
8010630c:	6a 7b                	push   $0x7b
8010630e:	e9 d7 f6 ff ff       	jmp    801059ea <alltraps>

80106313 <vector124>:
80106313:	6a 00                	push   $0x0
80106315:	6a 7c                	push   $0x7c
80106317:	e9 ce f6 ff ff       	jmp    801059ea <alltraps>

8010631c <vector125>:
8010631c:	6a 00                	push   $0x0
8010631e:	6a 7d                	push   $0x7d
80106320:	e9 c5 f6 ff ff       	jmp    801059ea <alltraps>

80106325 <vector126>:
80106325:	6a 00                	push   $0x0
80106327:	6a 7e                	push   $0x7e
80106329:	e9 bc f6 ff ff       	jmp    801059ea <alltraps>

8010632e <vector127>:
8010632e:	6a 00                	push   $0x0
80106330:	6a 7f                	push   $0x7f
80106332:	e9 b3 f6 ff ff       	jmp    801059ea <alltraps>

80106337 <vector128>:
80106337:	6a 00                	push   $0x0
80106339:	68 80 00 00 00       	push   $0x80
8010633e:	e9 a7 f6 ff ff       	jmp    801059ea <alltraps>

80106343 <vector129>:
80106343:	6a 00                	push   $0x0
80106345:	68 81 00 00 00       	push   $0x81
8010634a:	e9 9b f6 ff ff       	jmp    801059ea <alltraps>

8010634f <vector130>:
8010634f:	6a 00                	push   $0x0
80106351:	68 82 00 00 00       	push   $0x82
80106356:	e9 8f f6 ff ff       	jmp    801059ea <alltraps>

8010635b <vector131>:
8010635b:	6a 00                	push   $0x0
8010635d:	68 83 00 00 00       	push   $0x83
80106362:	e9 83 f6 ff ff       	jmp    801059ea <alltraps>

80106367 <vector132>:
80106367:	6a 00                	push   $0x0
80106369:	68 84 00 00 00       	push   $0x84
8010636e:	e9 77 f6 ff ff       	jmp    801059ea <alltraps>

80106373 <vector133>:
80106373:	6a 00                	push   $0x0
80106375:	68 85 00 00 00       	push   $0x85
8010637a:	e9 6b f6 ff ff       	jmp    801059ea <alltraps>

8010637f <vector134>:
8010637f:	6a 00                	push   $0x0
80106381:	68 86 00 00 00       	push   $0x86
80106386:	e9 5f f6 ff ff       	jmp    801059ea <alltraps>

8010638b <vector135>:
8010638b:	6a 00                	push   $0x0
8010638d:	68 87 00 00 00       	push   $0x87
80106392:	e9 53 f6 ff ff       	jmp    801059ea <alltraps>

80106397 <vector136>:
80106397:	6a 00                	push   $0x0
80106399:	68 88 00 00 00       	push   $0x88
8010639e:	e9 47 f6 ff ff       	jmp    801059ea <alltraps>

801063a3 <vector137>:
801063a3:	6a 00                	push   $0x0
801063a5:	68 89 00 00 00       	push   $0x89
801063aa:	e9 3b f6 ff ff       	jmp    801059ea <alltraps>

801063af <vector138>:
801063af:	6a 00                	push   $0x0
801063b1:	68 8a 00 00 00       	push   $0x8a
801063b6:	e9 2f f6 ff ff       	jmp    801059ea <alltraps>

801063bb <vector139>:
801063bb:	6a 00                	push   $0x0
801063bd:	68 8b 00 00 00       	push   $0x8b
801063c2:	e9 23 f6 ff ff       	jmp    801059ea <alltraps>

801063c7 <vector140>:
801063c7:	6a 00                	push   $0x0
801063c9:	68 8c 00 00 00       	push   $0x8c
801063ce:	e9 17 f6 ff ff       	jmp    801059ea <alltraps>

801063d3 <vector141>:
801063d3:	6a 00                	push   $0x0
801063d5:	68 8d 00 00 00       	push   $0x8d
801063da:	e9 0b f6 ff ff       	jmp    801059ea <alltraps>

801063df <vector142>:
801063df:	6a 00                	push   $0x0
801063e1:	68 8e 00 00 00       	push   $0x8e
801063e6:	e9 ff f5 ff ff       	jmp    801059ea <alltraps>

801063eb <vector143>:
801063eb:	6a 00                	push   $0x0
801063ed:	68 8f 00 00 00       	push   $0x8f
801063f2:	e9 f3 f5 ff ff       	jmp    801059ea <alltraps>

801063f7 <vector144>:
801063f7:	6a 00                	push   $0x0
801063f9:	68 90 00 00 00       	push   $0x90
801063fe:	e9 e7 f5 ff ff       	jmp    801059ea <alltraps>

80106403 <vector145>:
80106403:	6a 00                	push   $0x0
80106405:	68 91 00 00 00       	push   $0x91
8010640a:	e9 db f5 ff ff       	jmp    801059ea <alltraps>

8010640f <vector146>:
8010640f:	6a 00                	push   $0x0
80106411:	68 92 00 00 00       	push   $0x92
80106416:	e9 cf f5 ff ff       	jmp    801059ea <alltraps>

8010641b <vector147>:
8010641b:	6a 00                	push   $0x0
8010641d:	68 93 00 00 00       	push   $0x93
80106422:	e9 c3 f5 ff ff       	jmp    801059ea <alltraps>

80106427 <vector148>:
80106427:	6a 00                	push   $0x0
80106429:	68 94 00 00 00       	push   $0x94
8010642e:	e9 b7 f5 ff ff       	jmp    801059ea <alltraps>

80106433 <vector149>:
80106433:	6a 00                	push   $0x0
80106435:	68 95 00 00 00       	push   $0x95
8010643a:	e9 ab f5 ff ff       	jmp    801059ea <alltraps>

8010643f <vector150>:
8010643f:	6a 00                	push   $0x0
80106441:	68 96 00 00 00       	push   $0x96
80106446:	e9 9f f5 ff ff       	jmp    801059ea <alltraps>

8010644b <vector151>:
8010644b:	6a 00                	push   $0x0
8010644d:	68 97 00 00 00       	push   $0x97
80106452:	e9 93 f5 ff ff       	jmp    801059ea <alltraps>

80106457 <vector152>:
80106457:	6a 00                	push   $0x0
80106459:	68 98 00 00 00       	push   $0x98
8010645e:	e9 87 f5 ff ff       	jmp    801059ea <alltraps>

80106463 <vector153>:
80106463:	6a 00                	push   $0x0
80106465:	68 99 00 00 00       	push   $0x99
8010646a:	e9 7b f5 ff ff       	jmp    801059ea <alltraps>

8010646f <vector154>:
8010646f:	6a 00                	push   $0x0
80106471:	68 9a 00 00 00       	push   $0x9a
80106476:	e9 6f f5 ff ff       	jmp    801059ea <alltraps>

8010647b <vector155>:
8010647b:	6a 00                	push   $0x0
8010647d:	68 9b 00 00 00       	push   $0x9b
80106482:	e9 63 f5 ff ff       	jmp    801059ea <alltraps>

80106487 <vector156>:
80106487:	6a 00                	push   $0x0
80106489:	68 9c 00 00 00       	push   $0x9c
8010648e:	e9 57 f5 ff ff       	jmp    801059ea <alltraps>

80106493 <vector157>:
80106493:	6a 00                	push   $0x0
80106495:	68 9d 00 00 00       	push   $0x9d
8010649a:	e9 4b f5 ff ff       	jmp    801059ea <alltraps>

8010649f <vector158>:
8010649f:	6a 00                	push   $0x0
801064a1:	68 9e 00 00 00       	push   $0x9e
801064a6:	e9 3f f5 ff ff       	jmp    801059ea <alltraps>

801064ab <vector159>:
801064ab:	6a 00                	push   $0x0
801064ad:	68 9f 00 00 00       	push   $0x9f
801064b2:	e9 33 f5 ff ff       	jmp    801059ea <alltraps>

801064b7 <vector160>:
801064b7:	6a 00                	push   $0x0
801064b9:	68 a0 00 00 00       	push   $0xa0
801064be:	e9 27 f5 ff ff       	jmp    801059ea <alltraps>

801064c3 <vector161>:
801064c3:	6a 00                	push   $0x0
801064c5:	68 a1 00 00 00       	push   $0xa1
801064ca:	e9 1b f5 ff ff       	jmp    801059ea <alltraps>

801064cf <vector162>:
801064cf:	6a 00                	push   $0x0
801064d1:	68 a2 00 00 00       	push   $0xa2
801064d6:	e9 0f f5 ff ff       	jmp    801059ea <alltraps>

801064db <vector163>:
801064db:	6a 00                	push   $0x0
801064dd:	68 a3 00 00 00       	push   $0xa3
801064e2:	e9 03 f5 ff ff       	jmp    801059ea <alltraps>

801064e7 <vector164>:
801064e7:	6a 00                	push   $0x0
801064e9:	68 a4 00 00 00       	push   $0xa4
801064ee:	e9 f7 f4 ff ff       	jmp    801059ea <alltraps>

801064f3 <vector165>:
801064f3:	6a 00                	push   $0x0
801064f5:	68 a5 00 00 00       	push   $0xa5
801064fa:	e9 eb f4 ff ff       	jmp    801059ea <alltraps>

801064ff <vector166>:
801064ff:	6a 00                	push   $0x0
80106501:	68 a6 00 00 00       	push   $0xa6
80106506:	e9 df f4 ff ff       	jmp    801059ea <alltraps>

8010650b <vector167>:
8010650b:	6a 00                	push   $0x0
8010650d:	68 a7 00 00 00       	push   $0xa7
80106512:	e9 d3 f4 ff ff       	jmp    801059ea <alltraps>

80106517 <vector168>:
80106517:	6a 00                	push   $0x0
80106519:	68 a8 00 00 00       	push   $0xa8
8010651e:	e9 c7 f4 ff ff       	jmp    801059ea <alltraps>

80106523 <vector169>:
80106523:	6a 00                	push   $0x0
80106525:	68 a9 00 00 00       	push   $0xa9
8010652a:	e9 bb f4 ff ff       	jmp    801059ea <alltraps>

8010652f <vector170>:
8010652f:	6a 00                	push   $0x0
80106531:	68 aa 00 00 00       	push   $0xaa
80106536:	e9 af f4 ff ff       	jmp    801059ea <alltraps>

8010653b <vector171>:
8010653b:	6a 00                	push   $0x0
8010653d:	68 ab 00 00 00       	push   $0xab
80106542:	e9 a3 f4 ff ff       	jmp    801059ea <alltraps>

80106547 <vector172>:
80106547:	6a 00                	push   $0x0
80106549:	68 ac 00 00 00       	push   $0xac
8010654e:	e9 97 f4 ff ff       	jmp    801059ea <alltraps>

80106553 <vector173>:
80106553:	6a 00                	push   $0x0
80106555:	68 ad 00 00 00       	push   $0xad
8010655a:	e9 8b f4 ff ff       	jmp    801059ea <alltraps>

8010655f <vector174>:
8010655f:	6a 00                	push   $0x0
80106561:	68 ae 00 00 00       	push   $0xae
80106566:	e9 7f f4 ff ff       	jmp    801059ea <alltraps>

8010656b <vector175>:
8010656b:	6a 00                	push   $0x0
8010656d:	68 af 00 00 00       	push   $0xaf
80106572:	e9 73 f4 ff ff       	jmp    801059ea <alltraps>

80106577 <vector176>:
80106577:	6a 00                	push   $0x0
80106579:	68 b0 00 00 00       	push   $0xb0
8010657e:	e9 67 f4 ff ff       	jmp    801059ea <alltraps>

80106583 <vector177>:
80106583:	6a 00                	push   $0x0
80106585:	68 b1 00 00 00       	push   $0xb1
8010658a:	e9 5b f4 ff ff       	jmp    801059ea <alltraps>

8010658f <vector178>:
8010658f:	6a 00                	push   $0x0
80106591:	68 b2 00 00 00       	push   $0xb2
80106596:	e9 4f f4 ff ff       	jmp    801059ea <alltraps>

8010659b <vector179>:
8010659b:	6a 00                	push   $0x0
8010659d:	68 b3 00 00 00       	push   $0xb3
801065a2:	e9 43 f4 ff ff       	jmp    801059ea <alltraps>

801065a7 <vector180>:
801065a7:	6a 00                	push   $0x0
801065a9:	68 b4 00 00 00       	push   $0xb4
801065ae:	e9 37 f4 ff ff       	jmp    801059ea <alltraps>

801065b3 <vector181>:
801065b3:	6a 00                	push   $0x0
801065b5:	68 b5 00 00 00       	push   $0xb5
801065ba:	e9 2b f4 ff ff       	jmp    801059ea <alltraps>

801065bf <vector182>:
801065bf:	6a 00                	push   $0x0
801065c1:	68 b6 00 00 00       	push   $0xb6
801065c6:	e9 1f f4 ff ff       	jmp    801059ea <alltraps>

801065cb <vector183>:
801065cb:	6a 00                	push   $0x0
801065cd:	68 b7 00 00 00       	push   $0xb7
801065d2:	e9 13 f4 ff ff       	jmp    801059ea <alltraps>

801065d7 <vector184>:
801065d7:	6a 00                	push   $0x0
801065d9:	68 b8 00 00 00       	push   $0xb8
801065de:	e9 07 f4 ff ff       	jmp    801059ea <alltraps>

801065e3 <vector185>:
801065e3:	6a 00                	push   $0x0
801065e5:	68 b9 00 00 00       	push   $0xb9
801065ea:	e9 fb f3 ff ff       	jmp    801059ea <alltraps>

801065ef <vector186>:
801065ef:	6a 00                	push   $0x0
801065f1:	68 ba 00 00 00       	push   $0xba
801065f6:	e9 ef f3 ff ff       	jmp    801059ea <alltraps>

801065fb <vector187>:
801065fb:	6a 00                	push   $0x0
801065fd:	68 bb 00 00 00       	push   $0xbb
80106602:	e9 e3 f3 ff ff       	jmp    801059ea <alltraps>

80106607 <vector188>:
80106607:	6a 00                	push   $0x0
80106609:	68 bc 00 00 00       	push   $0xbc
8010660e:	e9 d7 f3 ff ff       	jmp    801059ea <alltraps>

80106613 <vector189>:
80106613:	6a 00                	push   $0x0
80106615:	68 bd 00 00 00       	push   $0xbd
8010661a:	e9 cb f3 ff ff       	jmp    801059ea <alltraps>

8010661f <vector190>:
8010661f:	6a 00                	push   $0x0
80106621:	68 be 00 00 00       	push   $0xbe
80106626:	e9 bf f3 ff ff       	jmp    801059ea <alltraps>

8010662b <vector191>:
8010662b:	6a 00                	push   $0x0
8010662d:	68 bf 00 00 00       	push   $0xbf
80106632:	e9 b3 f3 ff ff       	jmp    801059ea <alltraps>

80106637 <vector192>:
80106637:	6a 00                	push   $0x0
80106639:	68 c0 00 00 00       	push   $0xc0
8010663e:	e9 a7 f3 ff ff       	jmp    801059ea <alltraps>

80106643 <vector193>:
80106643:	6a 00                	push   $0x0
80106645:	68 c1 00 00 00       	push   $0xc1
8010664a:	e9 9b f3 ff ff       	jmp    801059ea <alltraps>

8010664f <vector194>:
8010664f:	6a 00                	push   $0x0
80106651:	68 c2 00 00 00       	push   $0xc2
80106656:	e9 8f f3 ff ff       	jmp    801059ea <alltraps>

8010665b <vector195>:
8010665b:	6a 00                	push   $0x0
8010665d:	68 c3 00 00 00       	push   $0xc3
80106662:	e9 83 f3 ff ff       	jmp    801059ea <alltraps>

80106667 <vector196>:
80106667:	6a 00                	push   $0x0
80106669:	68 c4 00 00 00       	push   $0xc4
8010666e:	e9 77 f3 ff ff       	jmp    801059ea <alltraps>

80106673 <vector197>:
80106673:	6a 00                	push   $0x0
80106675:	68 c5 00 00 00       	push   $0xc5
8010667a:	e9 6b f3 ff ff       	jmp    801059ea <alltraps>

8010667f <vector198>:
8010667f:	6a 00                	push   $0x0
80106681:	68 c6 00 00 00       	push   $0xc6
80106686:	e9 5f f3 ff ff       	jmp    801059ea <alltraps>

8010668b <vector199>:
8010668b:	6a 00                	push   $0x0
8010668d:	68 c7 00 00 00       	push   $0xc7
80106692:	e9 53 f3 ff ff       	jmp    801059ea <alltraps>

80106697 <vector200>:
80106697:	6a 00                	push   $0x0
80106699:	68 c8 00 00 00       	push   $0xc8
8010669e:	e9 47 f3 ff ff       	jmp    801059ea <alltraps>

801066a3 <vector201>:
801066a3:	6a 00                	push   $0x0
801066a5:	68 c9 00 00 00       	push   $0xc9
801066aa:	e9 3b f3 ff ff       	jmp    801059ea <alltraps>

801066af <vector202>:
801066af:	6a 00                	push   $0x0
801066b1:	68 ca 00 00 00       	push   $0xca
801066b6:	e9 2f f3 ff ff       	jmp    801059ea <alltraps>

801066bb <vector203>:
801066bb:	6a 00                	push   $0x0
801066bd:	68 cb 00 00 00       	push   $0xcb
801066c2:	e9 23 f3 ff ff       	jmp    801059ea <alltraps>

801066c7 <vector204>:
801066c7:	6a 00                	push   $0x0
801066c9:	68 cc 00 00 00       	push   $0xcc
801066ce:	e9 17 f3 ff ff       	jmp    801059ea <alltraps>

801066d3 <vector205>:
801066d3:	6a 00                	push   $0x0
801066d5:	68 cd 00 00 00       	push   $0xcd
801066da:	e9 0b f3 ff ff       	jmp    801059ea <alltraps>

801066df <vector206>:
801066df:	6a 00                	push   $0x0
801066e1:	68 ce 00 00 00       	push   $0xce
801066e6:	e9 ff f2 ff ff       	jmp    801059ea <alltraps>

801066eb <vector207>:
801066eb:	6a 00                	push   $0x0
801066ed:	68 cf 00 00 00       	push   $0xcf
801066f2:	e9 f3 f2 ff ff       	jmp    801059ea <alltraps>

801066f7 <vector208>:
801066f7:	6a 00                	push   $0x0
801066f9:	68 d0 00 00 00       	push   $0xd0
801066fe:	e9 e7 f2 ff ff       	jmp    801059ea <alltraps>

80106703 <vector209>:
80106703:	6a 00                	push   $0x0
80106705:	68 d1 00 00 00       	push   $0xd1
8010670a:	e9 db f2 ff ff       	jmp    801059ea <alltraps>

8010670f <vector210>:
8010670f:	6a 00                	push   $0x0
80106711:	68 d2 00 00 00       	push   $0xd2
80106716:	e9 cf f2 ff ff       	jmp    801059ea <alltraps>

8010671b <vector211>:
8010671b:	6a 00                	push   $0x0
8010671d:	68 d3 00 00 00       	push   $0xd3
80106722:	e9 c3 f2 ff ff       	jmp    801059ea <alltraps>

80106727 <vector212>:
80106727:	6a 00                	push   $0x0
80106729:	68 d4 00 00 00       	push   $0xd4
8010672e:	e9 b7 f2 ff ff       	jmp    801059ea <alltraps>

80106733 <vector213>:
80106733:	6a 00                	push   $0x0
80106735:	68 d5 00 00 00       	push   $0xd5
8010673a:	e9 ab f2 ff ff       	jmp    801059ea <alltraps>

8010673f <vector214>:
8010673f:	6a 00                	push   $0x0
80106741:	68 d6 00 00 00       	push   $0xd6
80106746:	e9 9f f2 ff ff       	jmp    801059ea <alltraps>

8010674b <vector215>:
8010674b:	6a 00                	push   $0x0
8010674d:	68 d7 00 00 00       	push   $0xd7
80106752:	e9 93 f2 ff ff       	jmp    801059ea <alltraps>

80106757 <vector216>:
80106757:	6a 00                	push   $0x0
80106759:	68 d8 00 00 00       	push   $0xd8
8010675e:	e9 87 f2 ff ff       	jmp    801059ea <alltraps>

80106763 <vector217>:
80106763:	6a 00                	push   $0x0
80106765:	68 d9 00 00 00       	push   $0xd9
8010676a:	e9 7b f2 ff ff       	jmp    801059ea <alltraps>

8010676f <vector218>:
8010676f:	6a 00                	push   $0x0
80106771:	68 da 00 00 00       	push   $0xda
80106776:	e9 6f f2 ff ff       	jmp    801059ea <alltraps>

8010677b <vector219>:
8010677b:	6a 00                	push   $0x0
8010677d:	68 db 00 00 00       	push   $0xdb
80106782:	e9 63 f2 ff ff       	jmp    801059ea <alltraps>

80106787 <vector220>:
80106787:	6a 00                	push   $0x0
80106789:	68 dc 00 00 00       	push   $0xdc
8010678e:	e9 57 f2 ff ff       	jmp    801059ea <alltraps>

80106793 <vector221>:
80106793:	6a 00                	push   $0x0
80106795:	68 dd 00 00 00       	push   $0xdd
8010679a:	e9 4b f2 ff ff       	jmp    801059ea <alltraps>

8010679f <vector222>:
8010679f:	6a 00                	push   $0x0
801067a1:	68 de 00 00 00       	push   $0xde
801067a6:	e9 3f f2 ff ff       	jmp    801059ea <alltraps>

801067ab <vector223>:
801067ab:	6a 00                	push   $0x0
801067ad:	68 df 00 00 00       	push   $0xdf
801067b2:	e9 33 f2 ff ff       	jmp    801059ea <alltraps>

801067b7 <vector224>:
801067b7:	6a 00                	push   $0x0
801067b9:	68 e0 00 00 00       	push   $0xe0
801067be:	e9 27 f2 ff ff       	jmp    801059ea <alltraps>

801067c3 <vector225>:
801067c3:	6a 00                	push   $0x0
801067c5:	68 e1 00 00 00       	push   $0xe1
801067ca:	e9 1b f2 ff ff       	jmp    801059ea <alltraps>

801067cf <vector226>:
801067cf:	6a 00                	push   $0x0
801067d1:	68 e2 00 00 00       	push   $0xe2
801067d6:	e9 0f f2 ff ff       	jmp    801059ea <alltraps>

801067db <vector227>:
801067db:	6a 00                	push   $0x0
801067dd:	68 e3 00 00 00       	push   $0xe3
801067e2:	e9 03 f2 ff ff       	jmp    801059ea <alltraps>

801067e7 <vector228>:
801067e7:	6a 00                	push   $0x0
801067e9:	68 e4 00 00 00       	push   $0xe4
801067ee:	e9 f7 f1 ff ff       	jmp    801059ea <alltraps>

801067f3 <vector229>:
801067f3:	6a 00                	push   $0x0
801067f5:	68 e5 00 00 00       	push   $0xe5
801067fa:	e9 eb f1 ff ff       	jmp    801059ea <alltraps>

801067ff <vector230>:
801067ff:	6a 00                	push   $0x0
80106801:	68 e6 00 00 00       	push   $0xe6
80106806:	e9 df f1 ff ff       	jmp    801059ea <alltraps>

8010680b <vector231>:
8010680b:	6a 00                	push   $0x0
8010680d:	68 e7 00 00 00       	push   $0xe7
80106812:	e9 d3 f1 ff ff       	jmp    801059ea <alltraps>

80106817 <vector232>:
80106817:	6a 00                	push   $0x0
80106819:	68 e8 00 00 00       	push   $0xe8
8010681e:	e9 c7 f1 ff ff       	jmp    801059ea <alltraps>

80106823 <vector233>:
80106823:	6a 00                	push   $0x0
80106825:	68 e9 00 00 00       	push   $0xe9
8010682a:	e9 bb f1 ff ff       	jmp    801059ea <alltraps>

8010682f <vector234>:
8010682f:	6a 00                	push   $0x0
80106831:	68 ea 00 00 00       	push   $0xea
80106836:	e9 af f1 ff ff       	jmp    801059ea <alltraps>

8010683b <vector235>:
8010683b:	6a 00                	push   $0x0
8010683d:	68 eb 00 00 00       	push   $0xeb
80106842:	e9 a3 f1 ff ff       	jmp    801059ea <alltraps>

80106847 <vector236>:
80106847:	6a 00                	push   $0x0
80106849:	68 ec 00 00 00       	push   $0xec
8010684e:	e9 97 f1 ff ff       	jmp    801059ea <alltraps>

80106853 <vector237>:
80106853:	6a 00                	push   $0x0
80106855:	68 ed 00 00 00       	push   $0xed
8010685a:	e9 8b f1 ff ff       	jmp    801059ea <alltraps>

8010685f <vector238>:
8010685f:	6a 00                	push   $0x0
80106861:	68 ee 00 00 00       	push   $0xee
80106866:	e9 7f f1 ff ff       	jmp    801059ea <alltraps>

8010686b <vector239>:
8010686b:	6a 00                	push   $0x0
8010686d:	68 ef 00 00 00       	push   $0xef
80106872:	e9 73 f1 ff ff       	jmp    801059ea <alltraps>

80106877 <vector240>:
80106877:	6a 00                	push   $0x0
80106879:	68 f0 00 00 00       	push   $0xf0
8010687e:	e9 67 f1 ff ff       	jmp    801059ea <alltraps>

80106883 <vector241>:
80106883:	6a 00                	push   $0x0
80106885:	68 f1 00 00 00       	push   $0xf1
8010688a:	e9 5b f1 ff ff       	jmp    801059ea <alltraps>

8010688f <vector242>:
8010688f:	6a 00                	push   $0x0
80106891:	68 f2 00 00 00       	push   $0xf2
80106896:	e9 4f f1 ff ff       	jmp    801059ea <alltraps>

8010689b <vector243>:
8010689b:	6a 00                	push   $0x0
8010689d:	68 f3 00 00 00       	push   $0xf3
801068a2:	e9 43 f1 ff ff       	jmp    801059ea <alltraps>

801068a7 <vector244>:
801068a7:	6a 00                	push   $0x0
801068a9:	68 f4 00 00 00       	push   $0xf4
801068ae:	e9 37 f1 ff ff       	jmp    801059ea <alltraps>

801068b3 <vector245>:
801068b3:	6a 00                	push   $0x0
801068b5:	68 f5 00 00 00       	push   $0xf5
801068ba:	e9 2b f1 ff ff       	jmp    801059ea <alltraps>

801068bf <vector246>:
801068bf:	6a 00                	push   $0x0
801068c1:	68 f6 00 00 00       	push   $0xf6
801068c6:	e9 1f f1 ff ff       	jmp    801059ea <alltraps>

801068cb <vector247>:
801068cb:	6a 00                	push   $0x0
801068cd:	68 f7 00 00 00       	push   $0xf7
801068d2:	e9 13 f1 ff ff       	jmp    801059ea <alltraps>

801068d7 <vector248>:
801068d7:	6a 00                	push   $0x0
801068d9:	68 f8 00 00 00       	push   $0xf8
801068de:	e9 07 f1 ff ff       	jmp    801059ea <alltraps>

801068e3 <vector249>:
801068e3:	6a 00                	push   $0x0
801068e5:	68 f9 00 00 00       	push   $0xf9
801068ea:	e9 fb f0 ff ff       	jmp    801059ea <alltraps>

801068ef <vector250>:
801068ef:	6a 00                	push   $0x0
801068f1:	68 fa 00 00 00       	push   $0xfa
801068f6:	e9 ef f0 ff ff       	jmp    801059ea <alltraps>

801068fb <vector251>:
801068fb:	6a 00                	push   $0x0
801068fd:	68 fb 00 00 00       	push   $0xfb
80106902:	e9 e3 f0 ff ff       	jmp    801059ea <alltraps>

80106907 <vector252>:
80106907:	6a 00                	push   $0x0
80106909:	68 fc 00 00 00       	push   $0xfc
8010690e:	e9 d7 f0 ff ff       	jmp    801059ea <alltraps>

80106913 <vector253>:
80106913:	6a 00                	push   $0x0
80106915:	68 fd 00 00 00       	push   $0xfd
8010691a:	e9 cb f0 ff ff       	jmp    801059ea <alltraps>

8010691f <vector254>:
8010691f:	6a 00                	push   $0x0
80106921:	68 fe 00 00 00       	push   $0xfe
80106926:	e9 bf f0 ff ff       	jmp    801059ea <alltraps>

8010692b <vector255>:
8010692b:	6a 00                	push   $0x0
8010692d:	68 ff 00 00 00       	push   $0xff
80106932:	e9 b3 f0 ff ff       	jmp    801059ea <alltraps>
80106937:	66 90                	xchg   %ax,%ax
80106939:	66 90                	xchg   %ax,%ax
8010693b:	66 90                	xchg   %ax,%ax
8010693d:	66 90                	xchg   %ax,%ax
8010693f:	90                   	nop

80106940 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106940:	55                   	push   %ebp
80106941:	89 e5                	mov    %esp,%ebp
80106943:	57                   	push   %edi
80106944:	56                   	push   %esi
80106945:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106946:	89 d3                	mov    %edx,%ebx
{
80106948:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010694a:	c1 eb 16             	shr    $0x16,%ebx
8010694d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106950:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106953:	8b 06                	mov    (%esi),%eax
80106955:	a8 01                	test   $0x1,%al
80106957:	74 27                	je     80106980 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106959:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010695e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106964:	c1 ef 0a             	shr    $0xa,%edi
}
80106967:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010696a:	89 fa                	mov    %edi,%edx
8010696c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106972:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106975:	5b                   	pop    %ebx
80106976:	5e                   	pop    %esi
80106977:	5f                   	pop    %edi
80106978:	5d                   	pop    %ebp
80106979:	c3                   	ret    
8010697a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106980:	85 c9                	test   %ecx,%ecx
80106982:	74 2c                	je     801069b0 <walkpgdir+0x70>
80106984:	e8 37 bb ff ff       	call   801024c0 <kalloc>
80106989:	85 c0                	test   %eax,%eax
8010698b:	89 c3                	mov    %eax,%ebx
8010698d:	74 21                	je     801069b0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010698f:	83 ec 04             	sub    $0x4,%esp
80106992:	68 00 10 00 00       	push   $0x1000
80106997:	6a 00                	push   $0x0
80106999:	50                   	push   %eax
8010699a:	e8 f1 dd ff ff       	call   80104790 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010699f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801069a5:	83 c4 10             	add    $0x10,%esp
801069a8:	83 c8 07             	or     $0x7,%eax
801069ab:	89 06                	mov    %eax,(%esi)
801069ad:	eb b5                	jmp    80106964 <walkpgdir+0x24>
801069af:	90                   	nop
}
801069b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801069b3:	31 c0                	xor    %eax,%eax
}
801069b5:	5b                   	pop    %ebx
801069b6:	5e                   	pop    %esi
801069b7:	5f                   	pop    %edi
801069b8:	5d                   	pop    %ebp
801069b9:	c3                   	ret    
801069ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801069c0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	57                   	push   %edi
801069c4:	56                   	push   %esi
801069c5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801069c6:	89 d3                	mov    %edx,%ebx
801069c8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801069ce:	83 ec 1c             	sub    $0x1c,%esp
801069d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801069d4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801069d8:	8b 7d 08             	mov    0x8(%ebp),%edi
801069db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801069e6:	29 df                	sub    %ebx,%edi
801069e8:	83 c8 01             	or     $0x1,%eax
801069eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801069ee:	eb 15                	jmp    80106a05 <mappages+0x45>
    if(*pte & PTE_P)
801069f0:	f6 00 01             	testb  $0x1,(%eax)
801069f3:	75 45                	jne    80106a3a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801069f5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801069f8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801069fb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801069fd:	74 31                	je     80106a30 <mappages+0x70>
      break;
    a += PGSIZE;
801069ff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a08:	b9 01 00 00 00       	mov    $0x1,%ecx
80106a0d:	89 da                	mov    %ebx,%edx
80106a0f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106a12:	e8 29 ff ff ff       	call   80106940 <walkpgdir>
80106a17:	85 c0                	test   %eax,%eax
80106a19:	75 d5                	jne    801069f0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106a1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106a1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a23:	5b                   	pop    %ebx
80106a24:	5e                   	pop    %esi
80106a25:	5f                   	pop    %edi
80106a26:	5d                   	pop    %ebp
80106a27:	c3                   	ret    
80106a28:	90                   	nop
80106a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a30:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106a33:	31 c0                	xor    %eax,%eax
}
80106a35:	5b                   	pop    %ebx
80106a36:	5e                   	pop    %esi
80106a37:	5f                   	pop    %edi
80106a38:	5d                   	pop    %ebp
80106a39:	c3                   	ret    
      panic("remap");
80106a3a:	83 ec 0c             	sub    $0xc,%esp
80106a3d:	68 50 7b 10 80       	push   $0x80107b50
80106a42:	e8 49 99 ff ff       	call   80100390 <panic>
80106a47:	89 f6                	mov    %esi,%esi
80106a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a50 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
80106a53:	57                   	push   %edi
80106a54:	56                   	push   %esi
80106a55:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a56:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a5c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
80106a5e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a64:	83 ec 1c             	sub    $0x1c,%esp
80106a67:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106a6a:	39 d3                	cmp    %edx,%ebx
80106a6c:	73 66                	jae    80106ad4 <deallocuvm.part.0+0x84>
80106a6e:	89 d6                	mov    %edx,%esi
80106a70:	eb 3d                	jmp    80106aaf <deallocuvm.part.0+0x5f>
80106a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a78:	8b 10                	mov    (%eax),%edx
80106a7a:	f6 c2 01             	test   $0x1,%dl
80106a7d:	74 26                	je     80106aa5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a7f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a85:	74 58                	je     80106adf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106a87:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106a8a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106a90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106a93:	52                   	push   %edx
80106a94:	e8 77 b8 ff ff       	call   80102310 <kfree>
      *pte = 0;
80106a99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a9c:	83 c4 10             	add    $0x10,%esp
80106a9f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106aa5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106aab:	39 f3                	cmp    %esi,%ebx
80106aad:	73 25                	jae    80106ad4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106aaf:	31 c9                	xor    %ecx,%ecx
80106ab1:	89 da                	mov    %ebx,%edx
80106ab3:	89 f8                	mov    %edi,%eax
80106ab5:	e8 86 fe ff ff       	call   80106940 <walkpgdir>
    if(!pte)
80106aba:	85 c0                	test   %eax,%eax
80106abc:	75 ba                	jne    80106a78 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106abe:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106ac4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106aca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ad0:	39 f3                	cmp    %esi,%ebx
80106ad2:	72 db                	jb     80106aaf <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106ad4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ad7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ada:	5b                   	pop    %ebx
80106adb:	5e                   	pop    %esi
80106adc:	5f                   	pop    %edi
80106add:	5d                   	pop    %ebp
80106ade:	c3                   	ret    
        panic("kfree");
80106adf:	83 ec 0c             	sub    $0xc,%esp
80106ae2:	68 e6 74 10 80       	push   $0x801074e6
80106ae7:	e8 a4 98 ff ff       	call   80100390 <panic>
80106aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106af0 <seginit>:
{
80106af0:	55                   	push   %ebp
80106af1:	89 e5                	mov    %esp,%ebp
80106af3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106af6:	e8 a5 cd ff ff       	call   801038a0 <cpuid>
80106afb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106b01:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106b06:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b0a:	c7 80 d8 31 11 80 ff 	movl   $0xffff,-0x7feece28(%eax)
80106b11:	ff 00 00 
80106b14:	c7 80 dc 31 11 80 00 	movl   $0xcf9a00,-0x7feece24(%eax)
80106b1b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b1e:	c7 80 e0 31 11 80 ff 	movl   $0xffff,-0x7feece20(%eax)
80106b25:	ff 00 00 
80106b28:	c7 80 e4 31 11 80 00 	movl   $0xcf9200,-0x7feece1c(%eax)
80106b2f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b32:	c7 80 e8 31 11 80 ff 	movl   $0xffff,-0x7feece18(%eax)
80106b39:	ff 00 00 
80106b3c:	c7 80 ec 31 11 80 00 	movl   $0xcffa00,-0x7feece14(%eax)
80106b43:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b46:	c7 80 f0 31 11 80 ff 	movl   $0xffff,-0x7feece10(%eax)
80106b4d:	ff 00 00 
80106b50:	c7 80 f4 31 11 80 00 	movl   $0xcff200,-0x7feece0c(%eax)
80106b57:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106b5a:	05 d0 31 11 80       	add    $0x801131d0,%eax
  pd[1] = (uint)p;
80106b5f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b63:	c1 e8 10             	shr    $0x10,%eax
80106b66:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106b6a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b6d:	0f 01 10             	lgdtl  (%eax)
}
80106b70:	c9                   	leave  
80106b71:	c3                   	ret    
80106b72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b80 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b80:	a1 84 61 11 80       	mov    0x80116184,%eax
{
80106b85:	55                   	push   %ebp
80106b86:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b88:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b8d:	0f 22 d8             	mov    %eax,%cr3
}
80106b90:	5d                   	pop    %ebp
80106b91:	c3                   	ret    
80106b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ba0 <switchuvm>:
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	57                   	push   %edi
80106ba4:	56                   	push   %esi
80106ba5:	53                   	push   %ebx
80106ba6:	83 ec 1c             	sub    $0x1c,%esp
80106ba9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106bac:	85 db                	test   %ebx,%ebx
80106bae:	0f 84 cb 00 00 00    	je     80106c7f <switchuvm+0xdf>
  if(p->kstack == 0)
80106bb4:	8b 43 08             	mov    0x8(%ebx),%eax
80106bb7:	85 c0                	test   %eax,%eax
80106bb9:	0f 84 da 00 00 00    	je     80106c99 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106bbf:	8b 43 04             	mov    0x4(%ebx),%eax
80106bc2:	85 c0                	test   %eax,%eax
80106bc4:	0f 84 c2 00 00 00    	je     80106c8c <switchuvm+0xec>
  pushcli();
80106bca:	e8 e1 d9 ff ff       	call   801045b0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106bcf:	e8 4c cc ff ff       	call   80103820 <mycpu>
80106bd4:	89 c6                	mov    %eax,%esi
80106bd6:	e8 45 cc ff ff       	call   80103820 <mycpu>
80106bdb:	89 c7                	mov    %eax,%edi
80106bdd:	e8 3e cc ff ff       	call   80103820 <mycpu>
80106be2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106be5:	83 c7 08             	add    $0x8,%edi
80106be8:	e8 33 cc ff ff       	call   80103820 <mycpu>
80106bed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106bf0:	83 c0 08             	add    $0x8,%eax
80106bf3:	ba 67 00 00 00       	mov    $0x67,%edx
80106bf8:	c1 e8 18             	shr    $0x18,%eax
80106bfb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106c02:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106c09:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c0f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106c14:	83 c1 08             	add    $0x8,%ecx
80106c17:	c1 e9 10             	shr    $0x10,%ecx
80106c1a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106c20:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106c25:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c2c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106c31:	e8 ea cb ff ff       	call   80103820 <mycpu>
80106c36:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c3d:	e8 de cb ff ff       	call   80103820 <mycpu>
80106c42:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c46:	8b 73 08             	mov    0x8(%ebx),%esi
80106c49:	e8 d2 cb ff ff       	call   80103820 <mycpu>
80106c4e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106c54:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c57:	e8 c4 cb ff ff       	call   80103820 <mycpu>
80106c5c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106c60:	b8 28 00 00 00       	mov    $0x28,%eax
80106c65:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106c68:	8b 43 04             	mov    0x4(%ebx),%eax
80106c6b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c70:	0f 22 d8             	mov    %eax,%cr3
}
80106c73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c76:	5b                   	pop    %ebx
80106c77:	5e                   	pop    %esi
80106c78:	5f                   	pop    %edi
80106c79:	5d                   	pop    %ebp
  popcli();
80106c7a:	e9 71 d9 ff ff       	jmp    801045f0 <popcli>
    panic("switchuvm: no process");
80106c7f:	83 ec 0c             	sub    $0xc,%esp
80106c82:	68 56 7b 10 80       	push   $0x80107b56
80106c87:	e8 04 97 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106c8c:	83 ec 0c             	sub    $0xc,%esp
80106c8f:	68 81 7b 10 80       	push   $0x80107b81
80106c94:	e8 f7 96 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106c99:	83 ec 0c             	sub    $0xc,%esp
80106c9c:	68 6c 7b 10 80       	push   $0x80107b6c
80106ca1:	e8 ea 96 ff ff       	call   80100390 <panic>
80106ca6:	8d 76 00             	lea    0x0(%esi),%esi
80106ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cb0 <inituvm>:
{
80106cb0:	55                   	push   %ebp
80106cb1:	89 e5                	mov    %esp,%ebp
80106cb3:	57                   	push   %edi
80106cb4:	56                   	push   %esi
80106cb5:	53                   	push   %ebx
80106cb6:	83 ec 1c             	sub    $0x1c,%esp
80106cb9:	8b 75 10             	mov    0x10(%ebp),%esi
80106cbc:	8b 45 08             	mov    0x8(%ebp),%eax
80106cbf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106cc2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106cc8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106ccb:	77 49                	ja     80106d16 <inituvm+0x66>
  mem = kalloc();
80106ccd:	e8 ee b7 ff ff       	call   801024c0 <kalloc>
  memset(mem, 0, PGSIZE);
80106cd2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106cd5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106cd7:	68 00 10 00 00       	push   $0x1000
80106cdc:	6a 00                	push   $0x0
80106cde:	50                   	push   %eax
80106cdf:	e8 ac da ff ff       	call   80104790 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106ce4:	58                   	pop    %eax
80106ce5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106ceb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106cf0:	5a                   	pop    %edx
80106cf1:	6a 06                	push   $0x6
80106cf3:	50                   	push   %eax
80106cf4:	31 d2                	xor    %edx,%edx
80106cf6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106cf9:	e8 c2 fc ff ff       	call   801069c0 <mappages>
  memmove(mem, init, sz);
80106cfe:	89 75 10             	mov    %esi,0x10(%ebp)
80106d01:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106d04:	83 c4 10             	add    $0x10,%esp
80106d07:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106d0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d0d:	5b                   	pop    %ebx
80106d0e:	5e                   	pop    %esi
80106d0f:	5f                   	pop    %edi
80106d10:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106d11:	e9 2a db ff ff       	jmp    80104840 <memmove>
    panic("inituvm: more than a page");
80106d16:	83 ec 0c             	sub    $0xc,%esp
80106d19:	68 95 7b 10 80       	push   $0x80107b95
80106d1e:	e8 6d 96 ff ff       	call   80100390 <panic>
80106d23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d30 <loaduvm>:
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
80106d36:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106d39:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106d40:	0f 85 91 00 00 00    	jne    80106dd7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106d46:	8b 75 18             	mov    0x18(%ebp),%esi
80106d49:	31 db                	xor    %ebx,%ebx
80106d4b:	85 f6                	test   %esi,%esi
80106d4d:	75 1a                	jne    80106d69 <loaduvm+0x39>
80106d4f:	eb 6f                	jmp    80106dc0 <loaduvm+0x90>
80106d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d58:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d5e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d64:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d67:	76 57                	jbe    80106dc0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d69:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d6c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d6f:	31 c9                	xor    %ecx,%ecx
80106d71:	01 da                	add    %ebx,%edx
80106d73:	e8 c8 fb ff ff       	call   80106940 <walkpgdir>
80106d78:	85 c0                	test   %eax,%eax
80106d7a:	74 4e                	je     80106dca <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106d7c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d7e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106d81:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106d86:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d8b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d91:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d94:	01 d9                	add    %ebx,%ecx
80106d96:	05 00 00 00 80       	add    $0x80000000,%eax
80106d9b:	57                   	push   %edi
80106d9c:	51                   	push   %ecx
80106d9d:	50                   	push   %eax
80106d9e:	ff 75 10             	pushl  0x10(%ebp)
80106da1:	e8 ba ab ff ff       	call   80101960 <readi>
80106da6:	83 c4 10             	add    $0x10,%esp
80106da9:	39 f8                	cmp    %edi,%eax
80106dab:	74 ab                	je     80106d58 <loaduvm+0x28>
}
80106dad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106db5:	5b                   	pop    %ebx
80106db6:	5e                   	pop    %esi
80106db7:	5f                   	pop    %edi
80106db8:	5d                   	pop    %ebp
80106db9:	c3                   	ret    
80106dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106dc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106dc3:	31 c0                	xor    %eax,%eax
}
80106dc5:	5b                   	pop    %ebx
80106dc6:	5e                   	pop    %esi
80106dc7:	5f                   	pop    %edi
80106dc8:	5d                   	pop    %ebp
80106dc9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106dca:	83 ec 0c             	sub    $0xc,%esp
80106dcd:	68 af 7b 10 80       	push   $0x80107baf
80106dd2:	e8 b9 95 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106dd7:	83 ec 0c             	sub    $0xc,%esp
80106dda:	68 50 7c 10 80       	push   $0x80107c50
80106ddf:	e8 ac 95 ff ff       	call   80100390 <panic>
80106de4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106dea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106df0 <allocuvm>:
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	57                   	push   %edi
80106df4:	56                   	push   %esi
80106df5:	53                   	push   %ebx
80106df6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106df9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106dfc:	85 ff                	test   %edi,%edi
80106dfe:	0f 88 8e 00 00 00    	js     80106e92 <allocuvm+0xa2>
  if(newsz < oldsz)
80106e04:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e07:	0f 82 93 00 00 00    	jb     80106ea0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e10:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106e16:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106e1c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106e1f:	0f 86 7e 00 00 00    	jbe    80106ea3 <allocuvm+0xb3>
80106e25:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106e28:	8b 7d 08             	mov    0x8(%ebp),%edi
80106e2b:	eb 42                	jmp    80106e6f <allocuvm+0x7f>
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106e30:	83 ec 04             	sub    $0x4,%esp
80106e33:	68 00 10 00 00       	push   $0x1000
80106e38:	6a 00                	push   $0x0
80106e3a:	50                   	push   %eax
80106e3b:	e8 50 d9 ff ff       	call   80104790 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e40:	58                   	pop    %eax
80106e41:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e47:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e4c:	5a                   	pop    %edx
80106e4d:	6a 06                	push   $0x6
80106e4f:	50                   	push   %eax
80106e50:	89 da                	mov    %ebx,%edx
80106e52:	89 f8                	mov    %edi,%eax
80106e54:	e8 67 fb ff ff       	call   801069c0 <mappages>
80106e59:	83 c4 10             	add    $0x10,%esp
80106e5c:	85 c0                	test   %eax,%eax
80106e5e:	78 50                	js     80106eb0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106e60:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e66:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106e69:	0f 86 81 00 00 00    	jbe    80106ef0 <allocuvm+0x100>
    mem = kalloc();
80106e6f:	e8 4c b6 ff ff       	call   801024c0 <kalloc>
    if(mem == 0){
80106e74:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106e76:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e78:	75 b6                	jne    80106e30 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106e7a:	83 ec 0c             	sub    $0xc,%esp
80106e7d:	68 cd 7b 10 80       	push   $0x80107bcd
80106e82:	e8 d9 97 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106e87:	83 c4 10             	add    $0x10,%esp
80106e8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e8d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106e90:	77 6e                	ja     80106f00 <allocuvm+0x110>
}
80106e92:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106e95:	31 ff                	xor    %edi,%edi
}
80106e97:	89 f8                	mov    %edi,%eax
80106e99:	5b                   	pop    %ebx
80106e9a:	5e                   	pop    %esi
80106e9b:	5f                   	pop    %edi
80106e9c:	5d                   	pop    %ebp
80106e9d:	c3                   	ret    
80106e9e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106ea0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106ea3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ea6:	89 f8                	mov    %edi,%eax
80106ea8:	5b                   	pop    %ebx
80106ea9:	5e                   	pop    %esi
80106eaa:	5f                   	pop    %edi
80106eab:	5d                   	pop    %ebp
80106eac:	c3                   	ret    
80106ead:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106eb0:	83 ec 0c             	sub    $0xc,%esp
80106eb3:	68 e5 7b 10 80       	push   $0x80107be5
80106eb8:	e8 a3 97 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106ebd:	83 c4 10             	add    $0x10,%esp
80106ec0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ec3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106ec6:	76 0d                	jbe    80106ed5 <allocuvm+0xe5>
80106ec8:	89 c1                	mov    %eax,%ecx
80106eca:	8b 55 10             	mov    0x10(%ebp),%edx
80106ecd:	8b 45 08             	mov    0x8(%ebp),%eax
80106ed0:	e8 7b fb ff ff       	call   80106a50 <deallocuvm.part.0>
      kfree(mem);
80106ed5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106ed8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106eda:	56                   	push   %esi
80106edb:	e8 30 b4 ff ff       	call   80102310 <kfree>
      return 0;
80106ee0:	83 c4 10             	add    $0x10,%esp
}
80106ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ee6:	89 f8                	mov    %edi,%eax
80106ee8:	5b                   	pop    %ebx
80106ee9:	5e                   	pop    %esi
80106eea:	5f                   	pop    %edi
80106eeb:	5d                   	pop    %ebp
80106eec:	c3                   	ret    
80106eed:	8d 76 00             	lea    0x0(%esi),%esi
80106ef0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ef6:	5b                   	pop    %ebx
80106ef7:	89 f8                	mov    %edi,%eax
80106ef9:	5e                   	pop    %esi
80106efa:	5f                   	pop    %edi
80106efb:	5d                   	pop    %ebp
80106efc:	c3                   	ret    
80106efd:	8d 76 00             	lea    0x0(%esi),%esi
80106f00:	89 c1                	mov    %eax,%ecx
80106f02:	8b 55 10             	mov    0x10(%ebp),%edx
80106f05:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106f08:	31 ff                	xor    %edi,%edi
80106f0a:	e8 41 fb ff ff       	call   80106a50 <deallocuvm.part.0>
80106f0f:	eb 92                	jmp    80106ea3 <allocuvm+0xb3>
80106f11:	eb 0d                	jmp    80106f20 <deallocuvm>
80106f13:	90                   	nop
80106f14:	90                   	nop
80106f15:	90                   	nop
80106f16:	90                   	nop
80106f17:	90                   	nop
80106f18:	90                   	nop
80106f19:	90                   	nop
80106f1a:	90                   	nop
80106f1b:	90                   	nop
80106f1c:	90                   	nop
80106f1d:	90                   	nop
80106f1e:	90                   	nop
80106f1f:	90                   	nop

80106f20 <deallocuvm>:
{
80106f20:	55                   	push   %ebp
80106f21:	89 e5                	mov    %esp,%ebp
80106f23:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f26:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106f29:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106f2c:	39 d1                	cmp    %edx,%ecx
80106f2e:	73 10                	jae    80106f40 <deallocuvm+0x20>
}
80106f30:	5d                   	pop    %ebp
80106f31:	e9 1a fb ff ff       	jmp    80106a50 <deallocuvm.part.0>
80106f36:	8d 76 00             	lea    0x0(%esi),%esi
80106f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106f40:	89 d0                	mov    %edx,%eax
80106f42:	5d                   	pop    %ebp
80106f43:	c3                   	ret    
80106f44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f50 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106f50:	55                   	push   %ebp
80106f51:	89 e5                	mov    %esp,%ebp
80106f53:	57                   	push   %edi
80106f54:	56                   	push   %esi
80106f55:	53                   	push   %ebx
80106f56:	83 ec 0c             	sub    $0xc,%esp
80106f59:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106f5c:	85 f6                	test   %esi,%esi
80106f5e:	74 59                	je     80106fb9 <freevm+0x69>
80106f60:	31 c9                	xor    %ecx,%ecx
80106f62:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f67:	89 f0                	mov    %esi,%eax
80106f69:	e8 e2 fa ff ff       	call   80106a50 <deallocuvm.part.0>
80106f6e:	89 f3                	mov    %esi,%ebx
80106f70:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f76:	eb 0f                	jmp    80106f87 <freevm+0x37>
80106f78:	90                   	nop
80106f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f80:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f83:	39 fb                	cmp    %edi,%ebx
80106f85:	74 23                	je     80106faa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f87:	8b 03                	mov    (%ebx),%eax
80106f89:	a8 01                	test   $0x1,%al
80106f8b:	74 f3                	je     80106f80 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106f92:	83 ec 0c             	sub    $0xc,%esp
80106f95:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f98:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106f9d:	50                   	push   %eax
80106f9e:	e8 6d b3 ff ff       	call   80102310 <kfree>
80106fa3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106fa6:	39 fb                	cmp    %edi,%ebx
80106fa8:	75 dd                	jne    80106f87 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106faa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fb0:	5b                   	pop    %ebx
80106fb1:	5e                   	pop    %esi
80106fb2:	5f                   	pop    %edi
80106fb3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106fb4:	e9 57 b3 ff ff       	jmp    80102310 <kfree>
    panic("freevm: no pgdir");
80106fb9:	83 ec 0c             	sub    $0xc,%esp
80106fbc:	68 01 7c 10 80       	push   $0x80107c01
80106fc1:	e8 ca 93 ff ff       	call   80100390 <panic>
80106fc6:	8d 76 00             	lea    0x0(%esi),%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fd0 <setupkvm>:
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	56                   	push   %esi
80106fd4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106fd5:	e8 e6 b4 ff ff       	call   801024c0 <kalloc>
80106fda:	85 c0                	test   %eax,%eax
80106fdc:	89 c6                	mov    %eax,%esi
80106fde:	74 42                	je     80107022 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106fe0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106fe3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106fe8:	68 00 10 00 00       	push   $0x1000
80106fed:	6a 00                	push   $0x0
80106fef:	50                   	push   %eax
80106ff0:	e8 9b d7 ff ff       	call   80104790 <memset>
80106ff5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106ff8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ffb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ffe:	83 ec 08             	sub    $0x8,%esp
80107001:	8b 13                	mov    (%ebx),%edx
80107003:	ff 73 0c             	pushl  0xc(%ebx)
80107006:	50                   	push   %eax
80107007:	29 c1                	sub    %eax,%ecx
80107009:	89 f0                	mov    %esi,%eax
8010700b:	e8 b0 f9 ff ff       	call   801069c0 <mappages>
80107010:	83 c4 10             	add    $0x10,%esp
80107013:	85 c0                	test   %eax,%eax
80107015:	78 19                	js     80107030 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107017:	83 c3 10             	add    $0x10,%ebx
8010701a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107020:	75 d6                	jne    80106ff8 <setupkvm+0x28>
}
80107022:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107025:	89 f0                	mov    %esi,%eax
80107027:	5b                   	pop    %ebx
80107028:	5e                   	pop    %esi
80107029:	5d                   	pop    %ebp
8010702a:	c3                   	ret    
8010702b:	90                   	nop
8010702c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107030:	83 ec 0c             	sub    $0xc,%esp
80107033:	56                   	push   %esi
      return 0;
80107034:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107036:	e8 15 ff ff ff       	call   80106f50 <freevm>
      return 0;
8010703b:	83 c4 10             	add    $0x10,%esp
}
8010703e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107041:	89 f0                	mov    %esi,%eax
80107043:	5b                   	pop    %ebx
80107044:	5e                   	pop    %esi
80107045:	5d                   	pop    %ebp
80107046:	c3                   	ret    
80107047:	89 f6                	mov    %esi,%esi
80107049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107050 <kvmalloc>:
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107056:	e8 75 ff ff ff       	call   80106fd0 <setupkvm>
8010705b:	a3 84 61 11 80       	mov    %eax,0x80116184
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107060:	05 00 00 00 80       	add    $0x80000000,%eax
80107065:	0f 22 d8             	mov    %eax,%cr3
}
80107068:	c9                   	leave  
80107069:	c3                   	ret    
8010706a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107070 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107070:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107071:	31 c9                	xor    %ecx,%ecx
{
80107073:	89 e5                	mov    %esp,%ebp
80107075:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107078:	8b 55 0c             	mov    0xc(%ebp),%edx
8010707b:	8b 45 08             	mov    0x8(%ebp),%eax
8010707e:	e8 bd f8 ff ff       	call   80106940 <walkpgdir>
  if(pte == 0)
80107083:	85 c0                	test   %eax,%eax
80107085:	74 05                	je     8010708c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107087:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010708a:	c9                   	leave  
8010708b:	c3                   	ret    
    panic("clearpteu");
8010708c:	83 ec 0c             	sub    $0xc,%esp
8010708f:	68 12 7c 10 80       	push   $0x80107c12
80107094:	e8 f7 92 ff ff       	call   80100390 <panic>
80107099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801070a0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	57                   	push   %edi
801070a4:	56                   	push   %esi
801070a5:	53                   	push   %ebx
801070a6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801070a9:	e8 22 ff ff ff       	call   80106fd0 <setupkvm>
801070ae:	85 c0                	test   %eax,%eax
801070b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801070b3:	0f 84 9f 00 00 00    	je     80107158 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801070b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801070bc:	85 c9                	test   %ecx,%ecx
801070be:	0f 84 94 00 00 00    	je     80107158 <copyuvm+0xb8>
801070c4:	31 ff                	xor    %edi,%edi
801070c6:	eb 4a                	jmp    80107112 <copyuvm+0x72>
801070c8:	90                   	nop
801070c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801070d0:	83 ec 04             	sub    $0x4,%esp
801070d3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801070d9:	68 00 10 00 00       	push   $0x1000
801070de:	53                   	push   %ebx
801070df:	50                   	push   %eax
801070e0:	e8 5b d7 ff ff       	call   80104840 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801070e5:	58                   	pop    %eax
801070e6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801070ec:	b9 00 10 00 00       	mov    $0x1000,%ecx
801070f1:	5a                   	pop    %edx
801070f2:	ff 75 e4             	pushl  -0x1c(%ebp)
801070f5:	50                   	push   %eax
801070f6:	89 fa                	mov    %edi,%edx
801070f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070fb:	e8 c0 f8 ff ff       	call   801069c0 <mappages>
80107100:	83 c4 10             	add    $0x10,%esp
80107103:	85 c0                	test   %eax,%eax
80107105:	78 61                	js     80107168 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107107:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010710d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107110:	76 46                	jbe    80107158 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107112:	8b 45 08             	mov    0x8(%ebp),%eax
80107115:	31 c9                	xor    %ecx,%ecx
80107117:	89 fa                	mov    %edi,%edx
80107119:	e8 22 f8 ff ff       	call   80106940 <walkpgdir>
8010711e:	85 c0                	test   %eax,%eax
80107120:	74 61                	je     80107183 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107122:	8b 00                	mov    (%eax),%eax
80107124:	a8 01                	test   $0x1,%al
80107126:	74 4e                	je     80107176 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107128:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010712a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
8010712f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107135:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107138:	e8 83 b3 ff ff       	call   801024c0 <kalloc>
8010713d:	85 c0                	test   %eax,%eax
8010713f:	89 c6                	mov    %eax,%esi
80107141:	75 8d                	jne    801070d0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107143:	83 ec 0c             	sub    $0xc,%esp
80107146:	ff 75 e0             	pushl  -0x20(%ebp)
80107149:	e8 02 fe ff ff       	call   80106f50 <freevm>
  return 0;
8010714e:	83 c4 10             	add    $0x10,%esp
80107151:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107158:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010715b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010715e:	5b                   	pop    %ebx
8010715f:	5e                   	pop    %esi
80107160:	5f                   	pop    %edi
80107161:	5d                   	pop    %ebp
80107162:	c3                   	ret    
80107163:	90                   	nop
80107164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107168:	83 ec 0c             	sub    $0xc,%esp
8010716b:	56                   	push   %esi
8010716c:	e8 9f b1 ff ff       	call   80102310 <kfree>
      goto bad;
80107171:	83 c4 10             	add    $0x10,%esp
80107174:	eb cd                	jmp    80107143 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107176:	83 ec 0c             	sub    $0xc,%esp
80107179:	68 36 7c 10 80       	push   $0x80107c36
8010717e:	e8 0d 92 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107183:	83 ec 0c             	sub    $0xc,%esp
80107186:	68 1c 7c 10 80       	push   $0x80107c1c
8010718b:	e8 00 92 ff ff       	call   80100390 <panic>

80107190 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107190:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107191:	31 c9                	xor    %ecx,%ecx
{
80107193:	89 e5                	mov    %esp,%ebp
80107195:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107198:	8b 55 0c             	mov    0xc(%ebp),%edx
8010719b:	8b 45 08             	mov    0x8(%ebp),%eax
8010719e:	e8 9d f7 ff ff       	call   80106940 <walkpgdir>
  if((*pte & PTE_P) == 0)
801071a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801071a5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801071a6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801071a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801071ad:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801071b0:	05 00 00 00 80       	add    $0x80000000,%eax
801071b5:	83 fa 05             	cmp    $0x5,%edx
801071b8:	ba 00 00 00 00       	mov    $0x0,%edx
801071bd:	0f 45 c2             	cmovne %edx,%eax
}
801071c0:	c3                   	ret    
801071c1:	eb 0d                	jmp    801071d0 <copyout>
801071c3:	90                   	nop
801071c4:	90                   	nop
801071c5:	90                   	nop
801071c6:	90                   	nop
801071c7:	90                   	nop
801071c8:	90                   	nop
801071c9:	90                   	nop
801071ca:	90                   	nop
801071cb:	90                   	nop
801071cc:	90                   	nop
801071cd:	90                   	nop
801071ce:	90                   	nop
801071cf:	90                   	nop

801071d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801071d0:	55                   	push   %ebp
801071d1:	89 e5                	mov    %esp,%ebp
801071d3:	57                   	push   %edi
801071d4:	56                   	push   %esi
801071d5:	53                   	push   %ebx
801071d6:	83 ec 1c             	sub    $0x1c,%esp
801071d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801071dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801071df:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801071e2:	85 db                	test   %ebx,%ebx
801071e4:	75 40                	jne    80107226 <copyout+0x56>
801071e6:	eb 70                	jmp    80107258 <copyout+0x88>
801071e8:	90                   	nop
801071e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801071f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801071f3:	89 f1                	mov    %esi,%ecx
801071f5:	29 d1                	sub    %edx,%ecx
801071f7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801071fd:	39 d9                	cmp    %ebx,%ecx
801071ff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107202:	29 f2                	sub    %esi,%edx
80107204:	83 ec 04             	sub    $0x4,%esp
80107207:	01 d0                	add    %edx,%eax
80107209:	51                   	push   %ecx
8010720a:	57                   	push   %edi
8010720b:	50                   	push   %eax
8010720c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010720f:	e8 2c d6 ff ff       	call   80104840 <memmove>
    len -= n;
    buf += n;
80107214:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107217:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010721a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107220:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107222:	29 cb                	sub    %ecx,%ebx
80107224:	74 32                	je     80107258 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107226:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107228:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010722b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010722e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107234:	56                   	push   %esi
80107235:	ff 75 08             	pushl  0x8(%ebp)
80107238:	e8 53 ff ff ff       	call   80107190 <uva2ka>
    if(pa0 == 0)
8010723d:	83 c4 10             	add    $0x10,%esp
80107240:	85 c0                	test   %eax,%eax
80107242:	75 ac                	jne    801071f0 <copyout+0x20>
  }
  return 0;
}
80107244:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107247:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010724c:	5b                   	pop    %ebx
8010724d:	5e                   	pop    %esi
8010724e:	5f                   	pop    %edi
8010724f:	5d                   	pop    %ebp
80107250:	c3                   	ret    
80107251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107258:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010725b:	31 c0                	xor    %eax,%eax
}
8010725d:	5b                   	pop    %ebx
8010725e:	5e                   	pop    %esi
8010725f:	5f                   	pop    %edi
80107260:	5d                   	pop    %ebp
80107261:	c3                   	ret    
