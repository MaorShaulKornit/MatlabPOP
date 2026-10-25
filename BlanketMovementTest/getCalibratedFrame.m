function img = getCalibratedFrame(c,N,h)

obj = POPSnapshots('D:\POPrint\PreciseSnapshots',h);
img = obj.getCalibratedFrame(c,N);
end