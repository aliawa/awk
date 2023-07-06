#! /usr/bin/awk -f 



#! /usr/bin/awk -f 


# Push an item into a queue "s". Return the size of the new queue.
function push(q,item) {     
    i = q[0]++
    q[i] = item
}


# Pop an item from a queue "q". Return the item.
function pop(q) {
    if (q[0] != q[1] ) {
        i = q[1]++
        item = q[i]
        delete q[i]
    } else {
        item=""
    }
    return item
}


BEGIN {
    queue[0]=2 # write pointer
    queue[1]=2 # read pointer
}



/^\"[A-Z]* .* SIP\/2.0/ {
    print substr($0, 2)
    output=1
    next
}

/^\"SIP\/2.0/ {
     print substr($0, 2)
     output=1
     next
}

/sipMsg.c.*TX as/ {
    print "Sent: ", $4
    print ""
    next
}

/sipMsg.c.*Received:/ {
    src = pop(queue)
    print src
    print $2
    print ""
    next
}

/SIP_CALLBACK id=/ {
    sz = push(queue, $5)
}

/"[\n\t\r ]$/ {
    if (output==1) {
        output=0
        print ""
        print "--------------------------------------------"
        print ""
        print ""
    }
}

{
    if (output==1){
        print $0
    }
}



