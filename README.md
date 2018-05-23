# Seed Template for Django + RESTful + Angular/cli + Elastic Beanstalk

If you use this template as seed, git clone/fork it and you can start from section [Setup Environment](#setup-environment).

If you need to change the git repo to push to, use
```
git remote set-url origin <your git repo url, same as the one for clone>
git remote -v # souble check repo set correctly
```

If you want to show hidden files in Mac, press Command + Shift + .

## Table of Contents

- [Setup New Git Repo](#setup-new-git-repo)
- [Setup Environment](#setup-environment) *If you use this repo as seed, you can start here and skip previous sections.*
- [Setup Angular](#setup-angular)
- [Setup Django](#setup-django)
- [Bootstrap Angular under Django](#bootstrap-angular-under-django)
- [Setup Database](#setup-database)
- [Setup RESTful framework](#setup-restful-framework)
- [Deploy To Elastic Beanstalk](#deploy-to-elastic-beanstalk)
    - [Connect to database on Amazon RDS from GUI Client or Heroku](#optional-connect-to-database-on-amazon-rds-from-gui-client-or-heroku)
- [NEXT Angular](#next-angular)

## Setup New Git Repo

- Use gitignore python preset. *No need to add Node because Angular subfolder has its gitignore to handle Node ignore file.*
- git clone
- `.gitignore` add:
```
# Iriversland
/staticfiles
/static
frontend-bundle-dist
.DS_Store
...
```
- git add commit push
 
## Setup Environment

You can skip this section by running the script `setup-python-env.sh` under `/backend`.

- create virtual environment and activate it. Name the virtual environment with one of the below:
```
.env
.venv
env
venv
ENV
```
- `pip install -r requirements.txt`, requirements.txt as below:
```
# for django and restful
#
django==1.11.13
djangorestframework
django-cors-headers==2.2.0

# for AWS Elastic Beanstalk 
#
psycopg2
mako
awsebcli
```

## Setup Angular

*words in **bold** are needed after editing Angular code and want to run the project in Django.*

- In git repo root directory, run `ng new frontend`
- `ng serve --open` to start Node server and open in browser, if tested OK then `ctrl+c` to close it.
- In `angular.json` change the /dist/ output path:
```
...
"outputPath": "../backend/frontend-bundle-dist",
...
```
- `cd frontend`, then **`ng build` to create frontend distribution bundles**

## Setup Django

Following [this tutorial](https://www.techiediaries.com/django-angular-cli/).

- `cd your_git_repo_root/backend`, then `django-admin startproject django_backend .` **Make sure you add a DOT "." at the end!** This collects all django files in one folder except manage.py
- In settings.py 
  - add `corsheaders` to INSTALLED_APP
  - add `corsheaders.middleware.CorsMiddleware` to MIDDLEWARE
  - add line `CORS_ORIGIN_ALLOW_ALL = True`
 
 *can now accept POST/GET request from different origin/port if you use both node and django server. In production & this guide we'll only use Django as server, so we may not need CORS in this case.*

## Bootstrap Angular under Django

- Add Angular's `/dist/` in django static settings
```
...
STATIC_URL = '/static/'
...
ANGULAR_APP_DIR = os.path.join(BASE_DIR, 'frontend-bundle-dist') # django input static

STATICFILES_DIRS = [
    os.path.join(ANGULAR_APP_DIR), # additional path for django to collect static
]

STATIC_ROOT = os.path.join(BASE_DIR, 'www', 'static') # django output static. collectstatic will put the collected static files in STATIC_ROOT. www is for Elastic Beanstalk
```
- Let Django collect all static files `./manage.py collectstatic --noinput`
- Let Django serve angular’s `index.html` as start point && add routing for any Angular /static/ request. In Django project-wide `url.py` add (referring to [this post](https://www.techiediaries.com/django-angular-cli/))
```
# Static file end point
...
from django.contrib.staticfiles.views import serve
from django.views.generic import RedirectView
...
url(r'^(?!/?static/)(?!/?media/)(?P<path>.*\..*)$',
    RedirectView.as_view(url='/static/%(path)s', permanent=False)), # alter static access url

# Front end bootstrapper
url(r'^$', serve, kwargs={'path': 'index.html'}), # use static to serve templates
...
```

- Test if Django serves our Angular! `./manage.py runserver` and open your browser to `localhost:8000/`

## Setup Database

**TODO: skipped**

Setup database models. Our policy: we'll create one app for dealing with user account and one app for api. Depending on your needs, you can create other django apps like blog for posts, ..., etc. Also, models (defines database table schema) will live in each app it relates to, e.g., `CustomUser` model will live in `account/model.py`, `Post` model will live in `blog/model.py`.

- create app by `./manage.py startapp account`
  - edit `account/model.py`, write `from django.contrib.auth.models import AbstractUser` then `class CustomUser(AbstractUser):`. Let's have user's email unique so you have the option to login by email, follow [this SO post](https://stackoverflow.com/questions/45722025/forcing-unique-email-address-during-registration-with-django). Add email (also first/last name if you want) to `REQUIRED_FIELDS` in `CustomUser`.
  - edit django settings.py
```
AUTH_USER_MODEL = 'account.CustomUser' # override the default user model
```
  - create app by `./manage.py startapp api`
  - create app by `./manage.py startapp blog`. This is optional. You may want other app names based on your project needs. In this instruction we'll use blog as an example to build a blog in our website.
    - Setup `blog/model.py` for posts, add a `Post` class and specify necessary fields.
- `./manage.py makemigrations` then `./manage.py migrate`
  - Optional, you can create a super user to access to local database.

## Setup RESTful framework

**TODO: skipped**

Following [official quickstart tutorial](http://www.django-rest-framework.org/tutorial/quickstart/). Particularly, focus on the high level:

- Setup
  - in `settings.py` add
```
AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend', # by default use username to authenticate login
]
```
- Attach RESTful to existing models - let's try `CustomUser` or/and `Post` you created in previous section.
  - Create serializer for that model
  - Create view or viewset, then fetch model and the serializer in view class.
  - Setup url routing
  - Test query URLs in server with the built-in browsable api webpage!
- TODO: see how we can use it, to do CRUD operations. Try following [this](https://wsvincent.com/django-rest-framework-tutorial/) first to implement CRUD. To learn more about RESTful class views, use [this tutorial](https://www.techiediaries.com/tutorial-django-rest-framework-building-products-manager-api/) to figure out the RESTful class view by looking at their functional programming alternatives.
- TODO: Setup security: require login or certain user to access API.
- **TODO: Angular try to request a POST, see if no error**

## Deploy To Elastic Beanstalk

We'll mainly use [this tutorial](http://www.1strategy.com/blog/2017/05/23/tutorial-django-elastic-beanstalk/) to deploy Django to Elastic Beanstalk.

We currently have two successful deployments, one in [Ohio](http://iriversland2-dev.us-east-2.elasticbeanstalk.com/) and another in [Oregon](http://iriversland2-dev.us-west-2.elasticbeanstalk.com/).

You have several options regarding database and the website:
- Create database upon first deployment
  - If you need to migrate from other RDS database, restore them in management console and migrate. This is the Amazon recommended way.
- Don't create database when deploying
  - Connect to an existing RDS database: hardcode the database credentials in django setting.
  - Connecting to external database: hardcode credentials in django setting.

Have your model.py ready, and please keep reading if you have existing data to import. This instruction we create a new database (if you already have a online database to use please skip db creation parts). If you need to import data, you may want to use local database GUI client. This instruction we use PostgreSQL, you can use DBeaver (use Java) or PgAdmim.

- Copy `requirements.txt` into django root directory (in `git_repo_root/backend`). We will only deploy the code in `backend/`.
- Get in django root `cd backend` and `eb init` will give interactive prompt:
  - select data center location. Use US East (Ohio) to have best proximity for Mid-West area.
  - choose CNAME (prefix for the website URL)
  - get a aws credential and insert. IAM. Follow [this tutorial](http://www.1strategy.com/blog/2017/05/23/tutorial-django-elastic-beanstalk/). If you already have aws credential, you can skip steps below and enter those keys.
    - Go to [IAM website](https://console.aws.amazon.com/iam/home)
    - goto left side bar: User --> add user --> check programmatic access --> next
    - follow tutorial steps
    - save secret keys, enter these keys in console prompt
- Local project config for eb
  - django settings add CNAME (website domain URL) to `ALLOWED_HOSTS`
  - create the folder & file `.ebextensions/python.config`
  - in `python.config` write
```
container_commands:
  migrate:
    command: "python manage.py migrate"
    leader_only: true
  collectstatic:
    command: "python manage.py collectstatic --noinput"

option_settings:
  "aws:elasticbeanstalk:application:environment":
    DJANGO_SETTINGS_MODULE: "django_backend.settings"
    PYTHONPATH: "$PYTHONPATH"
  "aws:elasticbeanstalk:container:python":
    WSGIPath: "django_backend/wsgi.py"
    StaticFiles: "/static/=www/static/"

packages:
  yum:
    postgresql95-devel: []
```
  - make sure in Django settings you have `STATIC_ROOT = os.path.join(BASE_DIR, "www", "static")`
  - to connect to Amazon's RDS database, add in Django settings:
```
if 'RDS_DB_NAME' in os.environ:
    # deployed on amz
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql_psycopg2',
            'NAME': os.environ['RDS_DB_NAME'],
            'USER': os.environ['RDS_USERNAME'],
            'PASSWORD': os.environ['RDS_PASSWORD'],
            'HOST': os.environ['RDS_HOSTNAME'],
            'PORT': os.environ['RDS_PORT'],
        }
    }
```

- git add, git commit, then `eb create --scale 1 -db -db.engine postgres -db.i db.t2.micro`  
  - or you can add existing db later and just do `eb create --scale 1`. See how to [add existing db to a deployment](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.managing.db.html?icmpid=docs_elasticbeanstalk_console).
  - some interactive prompts. Refer to tutorial for details.
  - you can check [Elastic Beanstalk Main Page](https://console.aws.amazon.com/elasticbeanstalk/home) for deployment status.

*this will start deploying to eb for the very first time.*

- From now on, do your work, commit git, then do `eb deploy`


### (Optional) Connect to database on Amazon RDS from GUI Client or Heroku

Using Postgres database here.

- Edit amazon RDS permission, follow instructions below or see [heroku doc](https://devcenter.heroku.com/articles/amazon-rds) or [here](https://stackoverflow.com/questions/47661151/connecting-to-rds-postgres-from-heroku)
  1. let RDS always require SSL
    - **Amazon RDS/Parameter Groups**: Create a new parameter group to [force ssl](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts.General.SSL), if you don’t already have such group.
    - **Amazon RDS/Instance/modify database/DB parameter group:** enable group for ssl
  2. reboot the RDS instance immediately to force SSL!
  3. let RDS allow all inbound IP: Security Group (the one used by db)/Inbound: create rule for all traffic.
  4. let local/client db connection use SSL
    - turn on ssl, use `sslmode=require` *the amz official and heroku ask you to use `sslmode=verify-full`; then download a [certificate](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts.General.SSL) and using it with the connection by specifying its file path in `sslrootcert=...`; however, you can just use `require` if that works for you*
- get a decent database GUI client. DBeaver is OK. Can try [PgAdmin](https://www.pgadmin.org/).
  - test the connection. just hardcode the credentials e.g. db name/password obtained from the RDS console.
- Done!
- **TODO: Domain name - it's ugly now. how to change it?**
- future: [separate front/back end on different platform](https://stackoverflow.com/questions/41247687/how-to-deploy-separated-frontend-and-backend)
  - Frontend: GitHub Pages + CloudFlare
  - Backend: beanstalk
  - Cross domain setting: jwt

## NEXT Angular

How to do rounting, page layout rendering, and more.

- Keep following the official hero tutorial.
