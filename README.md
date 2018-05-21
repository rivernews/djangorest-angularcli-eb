# Seed Template for Django + RESTful + Angular/cli + Elastic Beanstalk

## Setup New Git Repo

- Use gitignore python preset. *No need to add Node because Angular subfolder has its gitignore to handle Node ignore file.*
- git clone
- Gitignore exclude django root `/staticfiles` or `/static`, include `/dist/` for Angular
- git add commit push
 
## Setup Environment

- create virtual environment and activate it
- `pip install -r requirements.txt`, requirements.txt as below:
```
django==1.11.13
djangorestframework
django-cors-headers==2.2.0

# for heroku
gunicorn==19.8.1
django-heroku==0.3.1

# for AWS Elastic Beanstalk 
psycopg2
mako
awsebcli
```

## Setup Django

## Setup RESTful framework

## Setup Angular

## Setup Elastic Beanstalk
