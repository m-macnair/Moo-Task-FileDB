#!/bin/bash
rm test_db.sqlite
sqlite3 test_db.sqlite < core.sql
sqlite3 test_db.sqlite < host.sql

