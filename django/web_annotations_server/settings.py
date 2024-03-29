# Django settings for annotation project.

import os

DEBUG = True
if "DJANGO_IN_APACHE" in os.environ:
	#DEBUG = False
	pass



TEMPLATE_DEBUG = DEBUG

ADMINS = (
    ('Alexander Sorokin', 'sorokin2@uiuc.edu'),
)

MANAGERS = ADMINS

use_custom_config = 0;
config_mode = 'production';

if os.path.exists('~/.myhost'):
	host_id=open('~/.myhost').readlines()[0].strip();
	if host_id=='laptop':
		use_custom_config = 0;
		config_mode = 'laptop';

if os.path.exists('/var/django2/annotation/web_annotations_server/'):
	DJ_CODE_RT='/var/django2/annotation/web_annotations_server/'
elif os.path.exists('/Users/syrnick/projects/cv_web_tk/code/django/web_annotations_server/'):
	DJ_CODE_RT='/Users/syrnick/projects/cv_web_tk/code/django/web_annotations_server/';
elif os.path.exists('/var/django/web_annotations_server/'):
	DJ_CODE_RT='/var/django/web_annotations_server/'
elif os.path.exists('/var/django2/web_annotations_server/'):
	DJ_CODE_RT='/var/django2/web_annotations_server/'




DATABASE_ENGINE = 'mysql'           # 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'ado_mssql'.
DATABASE_NAME = 'annotations_v2_test'             # Or path to database file if using sqlite3.
#DATABASE_NAME = 'annotations_v2'             # Or path to database file if using sqlite3.
DATABASE_USER = 'ann_devel'             # Not used with sqlite3.
DATABASE_PASSWORD = 'ann_devel_password_11223344'         # Not used with sqlite3.	DATABASE_NAME = 'annotations'             # Or path to database file if using sqlite3.
DATABASE_HOST = ''             # Set to empty string for localhost. Not used with sqlite3.
DATABASE_PORT = ''             # Set to empty string for default. Not used with sqlite3.

# Local time zone for this installation. Choices can be found here:
# http://www.postgresql.org/docs/8.1/static/datetime-keywords.html#DATETIME-TIMEZONE-SET-TABLE
# although not all variations may be possible on all operating systems.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'America/Chicago'

# Language code for this installation. All choices can be found here:
# http://www.w3.org/TR/REC-html40/struct/dirlang.html#langcodes
# http://blogs.law.harvard.edu/tech/stories/storyReader$15
LANGUAGE_CODE = 'en-us'

SITE_ID = 1
SITE_NAME = 'vm6.willowgarage.com'

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

DEFAULT_CHARSET = 'utf-8'

# Absolute path to the directory that holds media.
# Example: "/home/media/media.lawrence.com/"
MEDIA_ROOT = ''

# URL that handles the media served from MEDIA_ROOT.
# Example: "http://media.lawrence.com"
MEDIA_URL = ''

# URL prefix for admin media -- CSS, JavaScript and images. Make sure to use a
# trailing slash.
# Examples: "http://foo.com/media/", "/media/".
ADMIN_MEDIA_PREFIX = '/media/'

# Make this unique, and don't share it with anybody.
SECRET_KEY = 's@l@c*0mj55c@!v9l9nhd!82bx0_j%(3j(6=0b+x-_o2o53ti#'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
#     'django.template.loaders.eggs.load_template_source',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',

    # Required for RPC4Django authenticated method calls
    # Requires Django 1.1+
    'django.contrib.auth.middleware.RemoteUserMiddleware',
    'snippets.basic_auth.BasicAuthenticationMiddleware',

    'django.middleware.doc.XViewMiddleware',
)

# Required for RPC4Django authenticated method calls
# Requires Django 1.1+
AUTHENTICATION_BACKENDS = (
	'django.contrib.auth.backends.ModelBackend',
	'django.contrib.auth.backends.RemoteUserBackend',
)

BASIC_WWW_AUTHENTICATION=True

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    DJ_CODE_RT+"templates/",
    #"/var/lib/python-support/python2.5/django/contrib/admin/templates/",
)

TEMPLATE_CONTEXT_PROCESSORS=("django.core.context_processors.auth",
			     "django.core.context_processors.debug",
			     "django.core.context_processors.i18n",
			     "django.core.context_processors.media")



DEFAULT_FROM_EMAIL='syrnick@gmail.com'
EMAIL_HOST='localhost'

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.admin',

    'tagging',
    'registration',
    'rpc4django',
    'celery',


    'mturk',
    'datastore',

    'mturk.protocols.gxml',
    'mturk.protocols.attributes',
    'mturk.protocols.grading',
    'mturk.protocols.grouping',
    'mturk.protocols.anyhtml',

    #'web_annotations_server.annotations',
    #'web_annotations_server.evaluation',
    #'web_annotations_server.autograding',
    #'web_annotations_server.mturk_latex',

    #'web_annotations_server.web_menu',
    #'annotation.annotation_store',
    #'web_annotations_server.image_collector',

    #'web_annotations_server.cv_models',
    #'web_annotations_server.state_machine',	
)

ACCOUNT_ACTIVATION_DAYS=4

ROOT_URLCONF = 'web_annotations_server.urls'

DATASETS_ROOT = '/var/datasets/'
SEGMENTATION_ROOT = DATASETS_ROOT+'segmentations/'

MTURK_WORK = '/var/mturk/autosubmit/'
MTURK_ENV = '/var/mturk/scripts/'


HOST_NAME_FOR_MTURK="http://vm6.willowgarage.com:8080/"

MTURK_BLOCK_WORKER_MIN_UTILITY=30

MTURK_QUALIFICATIONS_PREFIX="CV-WEB-TK: "

## number of hits to show per page
NUM_HITS_PER_PAGE = 20


#Evaluation app settings:
VOC_DEV_KIT='/home/sorokin2/voc_data/VOCdevkit'
MCR_ROOT='/opt/MATLAB/MATLAB_Compiler_Runtime/v79'

LEARNING_DS_ROOT='/var/django2/learning_datasets'
MODEL_STORE_ROOT='/var/django2/model_store'

WEBMENU_ROOT = '/var/django2/web_menu/'


BROKER_HOST = "127.0.0.1"
BROKER_PORT = 5672
BROKER_VHOST = "/"
BROKER_USER = "guest"
BROKER_PASSWORD = "guest"


QUEUE_RESTART_FREQUENCY=20

MTURK_BLOCK_WORKERS_ON_GOLD=True

MTURK_TEST_DATA='/var/django2/web_annotations_server/mturk/test_data/'

ROS_INSTALLED=True
ROS_INTEGRATION=True
MTURK_INTEGRATION=True
