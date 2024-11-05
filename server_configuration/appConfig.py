#!/usr/bin/python
# -*- coding: utf-8 -*-
import urllib


class CommonConfig(object):
    # User Type
    API_HEADERS = {'Content-type': 'application/json'}

class DevelopmentConfig(CommonConfig):
    DATABASE = "fireprjdb"
    BIND_PORT = 8081
    SQLALCHEMY_DATABASE_URI = 'mysql://dbadmin:p#ssw0rd@127.0.0.1/onixdb'
    #SQLALCHEMY_DATABASE_URI = 'mysql://dbadmin:p#ssw0rd@139.150.69.115/fireprjdb'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    DAEMON_HEADERS = {'Content-type': 'application/json'}
    UPLOAD_FOLDER = "./"


class ProductionConfig(CommonConfig):
    DATABASE = "fireprjdb"
    BIND_PORT = 8081
    SQLALCHEMY_DATABASE_URI = 'mysql://dbadmin:p#ssw0rd@127.0.0.1/fireprjdb'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    DAEMON_HEADERS = {'Content-type': 'application/json'}
    UPLOAD_FOLDER = "./"


