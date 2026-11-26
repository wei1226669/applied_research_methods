#!/usr/bin/env bash
# Installs a PostgreSQL server and the Python driver psycopg2 in the GitHub Codespace.
# Needed only for 07b_database_postgresql.ipynb (bonus: PostgreSQL instead of SQLite).
#
# Run once in the Codespace terminal (from the repository folder):
#     bash Project_Topic1/setup_postgresql.sh
#
# After a restart of the Codespace, the server must be started again:
#     sudo service postgresql start

set -e

echo "1/4 Install the PostgreSQL server"
sudo apt-get update
sudo apt-get install -y postgresql

echo "2/4 Start the PostgreSQL server"
sudo service postgresql start || sudo pg_ctlcluster "$(ls /etc/postgresql | head -1)" main start

echo "3/4 Set the password of the user 'postgres' and create the database 'topic1'"
# Local test password, only used inside the Codespace
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
if ! sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname = 'topic1'" | grep -q 1; then
    sudo -u postgres createdb topic1
fi

echo "4/4 Install the Python driver psycopg2"
pip install psycopg2-binary

echo "Done. PostgreSQL is running; open Project_Topic1/07b_database_postgresql.ipynb"
