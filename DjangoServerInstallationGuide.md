# Introduction #

The cv\_web\_tk server supports multiple components:
  * mech\_turk task server
  * VOC competition server
  * Annotation storage and access server
  * CV Web models

This installation guide guide walks through the installation of the common components and the mech turk server. Other components can be installed separately as django applications.

The installation assumes a bare Ubuntu linux 9.10 machine. Recent tests:
  * [r296](https://code.google.com/p/cv-web-annotation-toolkit/source/detail?r=296): Karmik Ubuntu (9.10) in vmware player.

These instructions assume no knowledge of django and the goal to install this server only. If you know, what's going on, feel free to skip steps and use other features. For example, you can use any database of your choice, change code and data locaitions, etc.


# Prerequisites #
  1. Install Ubuntu 9.10
  1. Install all package updates
  1. Install mysql, python, python-mysqldb
```
sudo apt-get install mysql-server python python-mysqldb 
```
  1. Recommended: Install phpmyadmin. It greatly helps in database administration. It will ask, which server to configure. Choose apache2. Make sure to write down the passwords.
```
sudo apt-get install phpmyadmin
```
  1. Install PIL (python imaging library) if it hasn't been installed. It's used for on-the-fly image manipulations and converting images.
```
sudo apt-get install python-imaging
```
  1. Install numpy, python\_cvxopt (needed for cvxmod below)
```
sudo apt-get install python-numpy python-cvxopt
```

# ROS install #

ROS provides great software management tools and many components of the server are ROS packages. For certain cases, the installation can be omitted, but it's really easy to install. It will download lots of stuff though.

The instructions come from [ros.org](http://www.ros.org/wiki/ROS/Installation). We create a system-wide install, but we don't really need full shared install (we skip marking as NO\_BUILD):
```
sudo apt-get install build-essential python-yaml cmake subversion

wget --no-check-certificate http://ros.org/rosinstall -O ~/rosinstall
chmod 755 ~/rosinstall
sudo ~/rosinstall /opt/ros http://ros.org/rosconfigs/all.rosconfig 
```

Now we need to compile packages used by the server
```
sudo bash
source /opt/ros/setup.sh
rosmake --rosdep-install cv_mech_turk2 mech_turk_ros
```

# Libraries and packages #

  1. django 1.1.1
```
wget http://www.djangoproject.com/download/1.1.1/tarball/
tar xzvf Django-1.1.1.tar.gz
cd Django-1.1.1
sudo python setup.py install
cd ..
```
  1. Install boto (for Mechanical Turk integration) with a patch.
```
wget http://boto.googlecode.com/files/boto-1.8d.tar.gz
tar xvzf boto-1.8d.tar.gz
wget http://cv-web-annotation-toolkit.googlecode.com/files/boto-1.8d_patch
cd boto-1.8d
patch -p1 <../boto-1.8d_patch
sudo python setup.py install
cd ..
```
  1. django-tagging  (v.0.3.0 for django 1.0.2)
```
wget http://django-tagging.googlecode.com/files/django-tagging-0.3.tar.gz
tar xvzf django-tagging-0.3.tar.gz
cd django-tagging-0.3
sudo python setup.py install
cd ..
```
  1. django-registration
```
wget http://bitbucket.org/ubernostrum/django-registration/get/v0.7.tar.gz
tar xvzf v0.7.tar.gz
cd django-registration
sudo python setup.py install
cd ..
```
  1. rpc4django
```
wget http://www.davidfischer.name/wp-content/uploads/2010/01/rpc4django-0.1.7.tar.gz
tar xvfz rpc4django-0.1.7.tar.gz
cd rpc4django-0.1.7
python setup.py install
cd ..
```
  1. CVXMOD - convex optimization modelling package
```
wget http://cvxmod.net/dist/cvxmod-0.4.6.tar.gz
tar xzf cvxmod-0.4.6.tar.gz
cd cvxmod-0.4.6/
python setup.py install
cd ..
```
  1. Celery + RabitMQ
    1. On python2.5, install multiprocessing:
```
easy_install multiprocessing
```
    1. Follow these [installation instructions](http://www.turnkeylinux.org/blog/django-celery-rabbitmq).
    1. Follow the links in comment 2 and install the celerybroker/celeryd in the /etc/init.d

  1. lxml for MTurk XML validation
```
sudo apt-get install libxslt1-dev
sudo easy_install lxml
```

# Django code installation #

  1. Set up a mysql database
    * Go to phpmyadmin at http://localhost/phpmyadmin
    * Choose create database (e.g. **crowd**)
    * Create a user for the database:
      * Go to database crowd, click Privileges
      * Click create user (e.g. **crowd\_django**),
      * Click generate password and save it somewhere
      * Check "Grant all privileges on database **crowd**"
  1. Choose server code location and create server dir
```
SRV_ROOT=/var/django
sudo mkdir $SRV_ROOT
sudo chown -R <<MY_USER>> $SRV_ROOT
cd $SRV_ROOT
django-admin.py startproject crowd_server
cd crowd_server
```
  1. Download the code components from the SVN. Replace syrnick with your google code account. Or remove the user and https to get read-only code.
```
export GCUSER=syrnick
svn checkout https://cv-web-annotation-toolkit.googlecode.com/svn/trunk/django/web_annotations_server/mturk/ mturk/ --username $GCUSER
svn checkout https://cv-web-annotation-toolkit.googlecode.com/svn/trunk/django/web_annotations_server/templates/ templates/ --username $GCUSER
svn checkout https://cv-web-annotation-toolkit.googlecode.com/svn/trunk/django/web_annotations_server/packages/ packages/ --username $GCUSER
svn checkout https://cv-web-annotation-toolkit.googlecode.com/svn/trunk/django/web_annotations_server/snippets/ snippets/ --username $GCUSER
svn checkout https://cv-web-annotation-toolkit.googlecode.com/svn/trunk/django/web_annotations_server/datastore/ datastore/ --username $GCUSER
svn checkout https://cv-web-annotation-toolkit.googlecode.com/svn/trunk/django/web_annotations_server/default_project/ default_project/ --username $GCUSER
```
  1. Install required javascript (open source, but aren't BSD)
```
cd mturk/code/js
wget http://vision.cs.uiuc.edu/annotation/all_js.tgz
tar xvzf all_js.tgz
cd ../../../
```
  1. Installing MTURK qualification definitions
```
cd mturk/schema
./download_xsd.sh
```
  1. Copy default configuration over the initial project values.
```
cp default_project/example_settings.py ./settings.py
cp default_project/example_urls.py ./urls.py
```
  1. Edit settings.py to specify your database connection and other local settings
  1. Run syncdb to create the database tables:
```
python manage.py syncdb
```
  1. Load initial configuration data
```
export PYTHONPATH=$PYTHONPATH:/var/django:/var/django/crowd_server
export DJANGO_SETTINGS_MODULE=crowd_server.settings
django-admin.py loaddata default_project/default.json
```
  1. Create required data directories
```
sudo mkdir /var/datasets/
sudo mkdir /var/datasets/tasks/
sudo mkdir /var/datasets/segmentations/
sudo chown -R www-data /var/datasets/
sudo chown -R www-data /var/django
```
  1. Run development server
```
sudo -u www-data bash
export PYTHONPATH=$PYTHONPATH:/var/django:/var/django/crowd_server
export DJANGO_SETTINGS_MODULE=crowd_server.settings
python manage.py runserver localhost:8080
```

# Installation into Apache #

  1. Install and enable mod\_python
```
sudo apt-get install libapache2-mod-python
```
  1. Download django\_crowd.conf and install it into /etc/apache2/conf.d
```
wget http://cv-web-annotation-toolkit.googlecode.com/files/django_crowd.conf
sudo mv django_crowd.conf /etc/apache2/conf.d/
```
  1. Edit django\_crowd.conf to match the directories with the local installation.
    * Update django code path (from /var/django)
    * Update ROS paths (from /opt/ros)
    * Update admin templates path (from /usr/local/lib/python2.6/dist-packages/django/contrib/admin/media)
  1. Restart the apache
```
sudo apache2ctl restart
```
  1. Compare the [apache site](http://localhost/) with the [development server](http://localhost:8080/). They should be identical.

**Note:**  Django development server will immediately pick up all changes, but Apache will not.

**Note2:** This configuration serves many static files through django. This is a performance issue and those files should be served through another server.

**Note3:** If apache is configured to works through https, we can use https in HOST\_NAME\_FOR\_MTURK in settings.py. This way Mechanical Turk will use a secure connection to the server.

**Note4:** "DocumentRoot /var/www" in the default site can cause trouble. If you get an error, try commenting it out.

## Installing Unit Test server ##

Unit test server assumes specific configuration of tasks and sessions on the server.

To install test server fixtures:
  1. Start with a blank database or create a new database and change settings.py. Be careful!!
  1. Download and extract the test fixture data:
```
wget http://cv-web-annotation-toolkit.googlecode.com/files/django_crowd_test_fixture_0.1.0.tgz
tar xvzf django_crowd_test_fixture_0.1.0.tgz
```
  1. Load the default fixtures into the database
```
django-admin.py loaddata default_project/default.json
```
  1. Copy the session images to /var/datasets
```
sudo cp -r django_crowd_test_fixture_0.1.0/test-bbox-data-1 /var/datasets/test-bbox-data1
sudo chown -R www-data /var/datasets/test-bbox-data1
```
  1. Create a test user
    1. Go to /admin/auth/user/
    1. Create a new user (e.g. mt-tester), choose a password
    1. Assign the user to the mt-api-test group