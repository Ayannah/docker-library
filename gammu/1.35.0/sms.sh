#!/bin/bash

for i in `seq $SMS_MESSAGES`; do
    message="SMS_${i}_TEXT"
    mobile_number="SMS_${i}_NUMBER"
    echo "Message from $mobile_number: $message"
done
