#!bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%f-%h-%m-%s)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$TIMESTAMP-$SCRIPT_NAME.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
echo "please enter a pwd"
read sql_root_pwd

if [ $USERID -ne 0 ]
then
    echo "your not in root user"
    exit 1
else
    echo "your in root user"
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2....$R FAILURE $N"
    else
        echo -e "$2....$G PASS $N"
    fi
}

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "install of mysql serever is"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enable of mysql serever is"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "start of mysql is"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "pwd of mysql is"

mysql -h 18.212.67.192 -uroot -pExpenseApp@1 -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
    VALIDATE $? "pwd of sql is"
else
    echo -e "pwd already setiped....$G SKIPPING $N"
fi 