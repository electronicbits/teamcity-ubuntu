# How to install Teamcity on Ubuntu on an EC2 instance on AWS

First create an EC2 instance using an available Ubuntu Server image

SSH into your EC2 instance and follow the instructions

<h4>Install Teamcity</h4>

	sudo wget -c https://raw.githubusercontent.com/electronicbits/teamcity-ubuntu/master/teamcity-install.sh -O teamcity-install.sh
	sudo sh teamcity-install.sh
	sudo rm -rf teamcity-install.sh
	
<h4>Install postgres</h4>

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
	
	# open the config file and change the config settings
	sudo nano /etc/postgresql/9.3/main/postgresql.conf
	
	#shared_buffers
	shared_buffers=512MB
	
	#checkpoint_segments
	checkpoint_segments=32
	checkpoint_completion_target=0.9

	#synchronous_commit
	synchronous_commit=off

	# switch user to the postgres user
	sudo su - postgres

	# load the command line
	psql

	# create the team city user
	create role teamcity with login password '<password>';
	create database teamcity owner teamcity;

<h4>Install Nginx</h4>

	sudo wget -c https://raw.githubusercontent.com/electronicbits/teamcity-ubuntu/master/nginx.sh -O nginx.sh
	sudo sh nginx.sh
	sudo rm -rf nginx.sh

	#update nginx config
	sudo nano /etc/nginx/sites-available/teamcity

	#remove default nginx server
	sudo rm -rf /etc/nginx/sites-enabled/default
	sudo rm -rf /etc/nginx/sites-available/default

Start postgres, nginx and Teamcity

	sudo /etc/init.d/postgresql start
	sudo /etc/init.d/nginx start
	sudo /etc/init.d/teamcity start
	
<h4>Bonus: Installing TeamCity plugins</h4>

More often than not, you would like to extend TeamCity's functionality with available plugins on the Internet.

We happen to have two requirements that neede such extensions: 

- run Grunt tasks on the build nodes, hence we needed to have a plugin that executes node, npm package manager and grunt commands.
- deploy the artifacts using SSH to the DEV, UAT and PROD servers.

Details about the plugins are here:

https://github.com/jonnyzzz/TeamCity.Node

https://confluence.jetbrains.com/display/TW/Deployer+plugin

Keep a copy of each zip file on your home directory.

We like to SSH to our TeamCity server from an Ubuntu desktop instance, while doing so, and keeping a copy of each plugin/zip file on your home directory, execute the following command to copy the files using ssh:

	sudo scp deploy-runner.zip <remote-username>@<ip-address-server>:~
	sudo scp jonnyzzz.node.zip <remote-username>@<ip-address-server>:~



