#!bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

if [ $USERID -ne 0 ]
then 
    echo "your not a root user"
exit 1
else
    echo "your in root user"
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2.....FAILURE"
        exit 1
    elase
        echo "$2.....SUCCES"
    fi
}

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "installing of mysql"

dnf install git -y &>>$LOGFILE
VALIDATE $? "installing of git"