# Sample Keycloak Theme

> A Keycloak theme for Holisticon

- [Holisticon Keycloak Theme](#holisticon-keycloak-theme)
  - [Using](#using)
  - [Releasing](#releasing)
  - [Developing](#developing)
    - [Building](#building)
    - [SASS Naming](#sass-naming)
    - [Local Keycloak server](#local-keycloak-server)
    - [Testing Keycloak e-mails](#testing-keycloak-e-mails)
  - [Testuser](#testuser)
  - [Releasing](#releasing-1)

## Using
This theme helps to develop the holisticon keycloak theme.


To create new setup sql dump:
```
./bin/dev-dump-sql-docker.sh
```

The theme will now be used for all Keycloak login screens on your realm - including logging in to the admin console. If you sign out, you should see the Holisticon themed log in screen.

## Releasing

This repo is using gitflow and semver. To create a new version just run the release scripts, e.g.:

```
npm run release:patch // or release:minor for new feature releases or release:major for major changes
```

This will do the following:
* create a new git tag, create a changelog and push it to Gitlab
* Afterwards a merge request should be created manually
* Jenkins will publish the package


## Developing

### Building
The theme can be built using the following commands:
```bash
$ npm install
$ npm run build
```
The theme will then be built at `/dist/holisticon`, ready for use in the local Keycloak server.


### SASS Naming

kl - keycloak login
ke - keycloak email
ka - keycloak account

### Local Keycloak server
A local Keycloak server for developing and testing the theme is available as a Docker container.

To bring up the server, make sure you’ve installed and started [Docker Community Edition](https://docs.docker.com/engine/installation/), then use the following commands:
```bash
$ npm run clean
$ npm run watch
$ docker-compose up
```
The Keycloak server will now be available on <http://localhost:8888>. You can log into the Administration Console using “**admin**” as both username and password.

To enable the Holisticon theme in the local Keycloak server, follow steps 2 and 3 in [the “Using” section above](#using).

You will now see the Holisticon theme when logging into the local Keycloak server. Changes made to the theme files in `/dist` will be visible on the local Keycloak server when you refresh the page in your browser.

### Testing Keycloak e-mails
The local Keycloak server includes MailDev, a mock SMTP server that you can use to receive and view Keycloak e-mails. It is available on <http://localhost:9999>.

To set up the local Keycloak server to send e-mails to MailDev:

1. Log in to [the local Keycloak server](http://localhost:8888).

2. Go to the “Email” tab in “Realm Settings”

3. Enter the following details:

    - Host: **maildev**

    - From: **keycloak@keycloak**

4. Click on “Save”

5. Click on “Admin” in the top-right-hand corner of the page, and click on “Manage Account”

6. Add an e-mail address to the admin account.

    It doesn’t matter what e-mail address you add, as all e-mails will be caught by MailDev. But you do need to add one, otherwise Keycloak will not send e-mails for this account.

The local Keycloak server should now be set up to send e-mails to MailDev. To check that it’s working:

1. Click on the “Back to Security Admin Console” link

2. Click on the “Login” tab in “Realm Settings”

3. Enable “Forgot password”, and click on “Save”

4. Sign out.

5. On the Keycloak log in screen, click on the “Forgot your password?” link

6. Enter your username (**admin**) in the text field, and submit the form.

7. Visit [MailDev](http://localhost:9999). You should see a reset password e-mail from Keycloak.


## Testuser

* admin/admin
* user/user

## Releasing

**Automatic**
The theme can be packaged for release using the following command:
```bash
$ npm install
$ npm run build
$ docker-compose up -d
$ npm run release:patch // or :minor or :major
```

**Manual**:
```bash
npm run dist
cd dist/holisticon && npm publish
```

>Make sure that you have the docker setup up and running for the end2end tests.

The theme will then be packaged at `/dist/holisticon.tar.gz`.
