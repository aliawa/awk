# Flip endianess.
# input:0x01020304  --> output:0x04030201
# input file should have one number per line
{
    for(n=strtonum($0);n!=0;n=rshift(n,8)) {
        nn = or(lshift(nn,8),and(n, 0xff))
    }
}
