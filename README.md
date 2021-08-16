# Jenkins CI CD

## Installation

```bash
mkdir data
```
```bash
mkdir ssh
```
```bash
sudo chmod 700 ssh
sudo chmod 600 ssh/config
sudo chmod 600 ssh/id_rsa
sudo chmod 644 ssh/id_rsa.pub

```
```bash
sudo chmod 777 -R data
docker-compose up 
```

Check ownership of .ssh dir (should be jenkins)
```bash
docker exec -it test_jenkins-server bash 
ls -la ~
sudo chown jenkins ~/.ssh -R
```

## Optain password
```bash
docker exec -it test_jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword
```

Use password to login

## Git Plugin

1. Select Manage Jenkins and Manage Plugins.
2. On the Available tab, use the Filter box to find Git Plugin.
3. Select the Install check box next to Git Plugin.
4. Choose Download now and install after restart.

## Set up project

1. From the Jenkins home page, select New Item.
2. Select Build a free-style software project.
3. For the project name, enter project name.
4. In source Code Management add Repository ssh URL.
5. For the Build Trigger, select Poll SCM with a schedule of H/05 * * * *
6. For the Build under Add Build Step select Execute Shell and in the Command text box, type build script. 
7. Save

## Discord notifier integration
1. Add plugin : Discord notifier
2. Add a post-build feature after build : Discord notifier
3. Create discord server, create a integration webbook in channel, copy webhook url.
4. Paste webhook url in the text box.
5. Save

## Examples
Example of build script:
```bash 
npm install
npm build
sh ./bin/deploy_single_prod.sh
```
Example of ./bin/deploy_single_prod.sh
```bash
export SINGLE_PROD_ADDRESS=<user>@<server_ip>
echo $SINGLE_PROD_ADDRESS
scp -i ~/.ssh/<ssh-key> -r <project-build-address> $SINGLE_PROD_ADDRESS:<project-address>
ssh -i ~/.ssh/<project> $SINGLE_PROD_ADDRESS << EOF
  cd <docker-file-destination>
  docker-compose up --build -d
EOF
```