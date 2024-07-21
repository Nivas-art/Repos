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

dnf install nginx -y 
VALIDATE $? "installing ngnix is"

systemctl enable nginx
VALIDATE $? "enbaling"

systemctl start nginx
VALIDATE $? "starting"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "remove"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
VALIDATE $? "downloaded code"

cd /usr/share/nginx/html
VALIDATE $? "extracted"

unzip /tmp/frontend.zip
VALIDATE $? "unzipped"

cp /D/Repos/Repos/expense.sh /etc/nginx/default.d/expense.conf
VALIDATE $? "copied"

systemctl restart nginx
VALIDATE $? "restared"