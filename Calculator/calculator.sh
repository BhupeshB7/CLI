#!/bin/bash
isValid(){
        local re='^[0-9]+$'
        if [[ $1 =~ $re ]];  then
                return 0
        else
                return 1
        fi
}
addition() {
    echo "Enter the first Number:"
    read num1
    if ! isValid $num1; then
            echo "Invalid Number. $num1 is not a Number"
            return
    fi
    echo "Enter the Second Number:"
    read num2
    if ! isValid $num2; then
             echo "Invalid Number, $num2 is not a number"
            return
    fi
    sum=$((num1 + num2))
    echo "Sum of $num1 + $num2 = $sum"
}

subtraction() {
    echo "Enter the first Number:"
    read num1
    if ! isValid $num1; then
             echo "Invalid Number, $num1 is not a number"
            return
    fi
    echo "Enter the Second Number:"
    read num2
    if ! isValid $num2; then
             echo "Invalid Number, $num2 is not a number"
            return
    fi
    difference=$((num1 - num2))
    echo "Difference of $num1 - $num2 = $difference"
}

multiplication() {
    echo "Enter the first Number:"
    read num1
    if ! isValid $num1; then
             echo "Invalid Number, $num1 is not a number"
            return
    fi
    echo "Enter the Second Number:"
    read num2
    if ! isValid $num2; then
            echo "Invalid Number, $num2 is not a number"
            return
    fi
    product=$((num1 * num2))
    echo "Product of $num1 * $num2 = $product"
}
division(){
     echo "Enter the first Number:"
    read num1
    if ! isValid $num1; then
             echo "Invalid Number, $num1 is not a number"
            return
    fi
    echo "Enter the Second Number:"
    read num2
    if ! isValid $num2; then
            echo "Invalid Number, $num2 is not a number"
            return
    fi
    if [ $num2 -eq 0 ] ;then
            echo "Error: Divisor Should not be zero"
    else
    quotient=$((num1/num2))
    reminder=$((num1%num2))
    echo "Division of $num1 / $num2 = $quotient (Quotient) and $reminder (Reminder)"
    fi
}
displayMenu(){

        echo "Enter the choice of operation:"
        echo "1. Addition"
        echo "2. Subtraction"
        echo "3. Multiplication"
        echo "4. Division"
        echo "5. Exit"
        read choice
}
while true;
do
        displayMenu

case $choice in
    1)
        addition
        ;;
    2)
        subtraction
        ;;
    3)
        multiplication
        ;;
    4) division
        ;;
    5)
            echo "Have a Good day, Exiting..."
            break;
        ;;
    *)
        echo "Invalid choice. Please select 1, 2, 3,4 or 5."
        ;;
esac
done
