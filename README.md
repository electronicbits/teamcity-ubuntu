# teamcity-ubuntu

<h4>Teamcity</h4>

	sudo wget -c https://raw.githubusercontent.com/electronicbits/teamcity-ubuntu/master/teamcity-install.sh -O teamcity-install.sh
	sudo sh teamcity-install.sh
	sudo rm -rf teamcity-install.sh

<h4>MySql</h4>

Install mysql

	sudo apt-get update
	sudo apt-get install mysql-server

	sudo mysql -u root -p
	
	create database teamcity default charset utf8;
	grant all privileges on teamcity.* to <user>@localhost identified by '<password>';
	
	sudo /etc/init.d/mysql restart
	
	
<h4>Postgres</h4>

Install postgres

	sudo apt-get update
	sudo apt-get install postgresql postgresql-contrib

	# open the file and append the lines below
	sudo nano /etc/postgresql/9.3/main/pg_hba.conf

	# remote access (where x.x.x.x is your IP)
	host all all x.x.x.x/32 md5

	# servers (repeat this line per server)
	host all all x.x.x.x/32 md5

	# open the file and change the lines below
	sudo nano /etc/postgresql/9.3/main/postgresql.conf
	listen_addresses = '*'

	# switch user to the postgres user
	sudo su - postgres

	# load the command line
	psql

	# create the team city user
	create role teamcity with login password '<password>';
	create database teamcity owner teamcity;

	#update database properties
	sudo nano /srv/.BuildServer/config/database.properties

	sudo /etc/init.d/postgresql restart

<h4>Nginx</h4>

	sudo wget -c https://raw.githubusercontent.com/electronicbits/teamcity-ubuntu/master/nginx.sh -O nginx.sh
	sudo sh nginx.sh
	sudo rm -rf nginx.sh

	#update nginx config
	sudo nano /etc/nginx/sites-available/teamcity

	#remove default nginx server
	sudo rm -rf /etc/nginx/sites-enabled/default
	sudo rm -rf /etc/nginx/sites-available/default

Start nginx and Teamcity

	sudo /etc/init.d/nginx start
	sudo /etc/init.d/teamcity start
	