#!bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
VALIDATE(){
    if [[ $1 -ne 0 ]]
    then
        echo -e "$2.....$R FAILURE $N"
        exit 1
    elase
        echo -e "$2.....$G SUCCES $N"
    fi
}

if [ $USERID -ne 0 ]
then 
    echo "your not a root user"
exit 1
else
    echo "your in root user"
fi


dnf install mysql -y &>>$LOGFILE
VALIDATE $? "installing of mysql"

dnf install git -y &>>$LOGFILE
VALIDATE $? "installing of git"