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

- Setup database models. Our policy: we'll create one app for dealing with user account and one app for api. Depending on your needs, you can create other django apps like blog for posts, ..., etc. Also, models (defines database table schema) will live in each app it relates to, e.g., `CustomUser` model will live in `account/model.py`, `Post` model will live in `blog/model.py`.
  - create app by `./manage.py startapp account`
    - edit `account/model.py`, write `from django.contrib.auth.models import AbstractUser` then `class CustomUser(AbstractUser):`. Let's have user's email unique so you have the option to login by email, follow [this SO post](https://stackoverflow.com/questions/45722025/forcing-unique-email-address-during-registration-with-django). Add email (also first/last name if you want) to `REQUIRED_FIELDS` in `CustomUser`.
  - create app by `./manage.py startapp api`
  - create app by `./manage.py startapp blog`. This is optional. You may want other app names based on your project needs. In this instruction we'll use blog as an example to build a blog in our website.
    - Setup `blog/model.py` for posts, add a `Post` class and specify necessary fields.
- `./manage.py makemigrations` then `./manage.py migrate`
  - Optional, you can create a super user to access to local database.

## Setup RESTful framework

Following [official quickstart tutorial](http://www.django-rest-framework.org/tutorial/quickstart/). Particularly, focus on the high level:

- Attach RESTful to existing models - let's try `CustomUser` or/and `Post` you created in previous section.
  - Create serializer for that model
  - Create view or viewset, then fetch model and the serializer in view class.
  - Setup url routing
  - Test query URLs in server with the built-in browsable api webpage!
- TODO: see how we can use it, to do CRUD operations. Try following [this](https://wsvincent.com/django-rest-framework-tutorial/) first to implement CRUD. To learn more about RESTful class views, use [this tutorial](https://www.techiediaries.com/tutorial-django-rest-framework-building-products-manager-api/) to figure out the RESTful class view by looking at their functional programming alternatives.
- TODO: Setup security: require login or certain user to access API.
- **TODO: Angular try to request a POST, see if no error**

## Setup Angular

## Setup Elastic Beanstalk
