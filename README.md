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
# for django and restful
#
django==1.11.13
djangorestframework
django-cors-headers==2.2.0


# for heroku
#
# gunicorn==19.8.1
# django-heroku==0.3.1


# for AWS Elastic Beanstalk 
#
psycopg2
mako
awsebcli
```

## Setup Django

- `./manage.py startproject backend .` **Make sure you add a DOT "." at the end!** This collects all django files in one folder except manage.py
- In settings.py 
  - add `‘corsheaders’,` to INSTALLED_APP
  - add `'corsheaders.middleware.CorsMiddleware',` to MIDDLEWARE
  - add line `CORS_ORIGIN_ALLOW_ALL = True`
 
 *can now accept POST/GET request from different origin/port if you use both node and django server. In production & this guide we'll only use Django as server, so we may not need CORS in this case.*

- Our policy: we'll create one app for dealing with user account and one app for api. Depending on your needs, you can create other django apps like blog for posts, ..., etc. Also, models (defines database table schema) will live in each app it relates to, e.g., `CustomUser` model will live in `account/model.py`, `Post` model will live in `blog/model.py`.
  - create app by `./manage.py startapp account`
  - create app by `./manage.py startapp api`
  - create app by `./manage.py startapp blog`. This is optional. You may want other app names based on your project needs. In this instruction we'll use blog as an example to build a blog in our website.
- edit `account/model.py`
- edit `blog/model.py`

## Setup RESTful framework

## Setup Angular

## Setup Elastic Beanstalk
