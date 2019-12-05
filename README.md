# Kata Master

The master server for a fully deployed kata session 

## How to launch the project

To start your Phoenix server, please do the following steps :

#### 1. Install asdf and the sdks

with erlang, elixir, node and postgres

##### Install asdf

    brew install asdf  
    echo -e '\n. $(brew --prefix asdf)/asdf.sh' >> ~/.bash_profile
    echo -e '\n. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash' >> ~/.bash_profile
    brew install \
    coreutils automake autoconf openssl \
    libyaml readline libxslt libtool unixodbc \
    unzip curl gpg wget

For more precisions of asdf install, see the [asdf website](https://asdf-vm.com/#/core-manage-asdf-vm?id=install-asdf-vm)

##### Configure asdf

    asdf plugin-add erlang
    asdf plugin-add elixir
    asdf plugin-add nodejs
    asdf plugin-add postgres

In project directory :

    asdf install

It will install all required SDK dependencies.

##### Install Overmind

MacOS:

    brew install tmux
    brew install overmind

Debian/Linux:

    apt-get install tmux
    Download and install the latest binary from here:
    [github.com/DarthSim/overmind](https://github.com/DarthSim/overmind/releases)

#### 2. Configure Postgres user

First, launch postgres server:

     ~/.asdf/installs/postgres/11.5/bin/pg_ctl -D \
     ~/.asdf/installs/postgres/11.5/data start

Then connect to postgres server:

    psql postgres

And once you are connected to the postgres server on the postgres database:  

    CREATE ROLE postgres WITH PASSWORD 'postgres';
    ALTER ROLE postgres WITH SUPERUSER;
    ALTER ROLE postgres WITH LOGIN;

#### 3. Get project dependencies

To install all dependencies :

    npm install

There is a postinstall script in `./package.json` that call `./scripts/install-app-dependencies.js`
This script will install the backend and frontend dependencies as well as the monorepo tooling.

To install manually backend dependencies :

    cd back && mix deps.get
    cd back/assets && npm

To install manually frontend dependencies :

    cd front && npm

#### 4. Setup project database

    cd back && mix ecto.setup

#### 5. Complete env file

Copy `.env.example` and rename it `.env`

Complete then all the env variables for the application to launch.

#### 6. Launch projects

    npm start


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
Now you can visit [`localhost:5000`](http://localhost:5000) from your browser.

## Development standards

### Git style

 The project follows the git flow conventions, with `master` as the production branch,
 `develop` the development branch, `feature/XX_something` the feature branches, and `bug_fix/XX_something`
 for bug fixes.
 The commit should start by `#XX` to be correctly recognized by Gitlab.

  All branches should be rebased on `develop` before merging the pull request.

#### Feature branch naming

 The development should be done on feature branches named like : `feature/<number of the ticket>_<small_description>`

 example: `feature/23_transporter_creation`

 Add the end of the development of the feature, the feature should be reviewed with pull request.
 If validated, it should be merged on `develop` and the feature branch deleted.

#### Git hooks

Two git hooks are used on this project (installed with husky library and configured on root
 `./package.json` ) :


1. `pre-commit hook: `cd ./back && mix format`
2. `commit-msg` hook: script `node ./scripts/git_hooks/prepend-commit-msg.js` that prepends the commits
 with `[#TECH branch name]` or `[#213 branch name]` (effectively enforcing git commit naming conventions)

To commit without passing the hooks use the `no-verify` option: `git commit --no-verify`.

## Tools

  `yarn start`: start back & front app with overmind
  `yarn docker:start`: start back & front app with docker
  `yarn test`: run tests suites on back & front
  `yarn lint`: lint on back & front
  `yarn format`: format code on back & front
  `yarn back:start`: start back only
  `yarn front:start`: start front only
  `yarn back:test`: run tests suites on back
  `yarn front:test`: run tests suites on front
  `yarn back:lint`: lint on back
  `yarn front:lint`: lint on front
  `yarn back:format`: format code on back
  `yarn front:format`: format code on front

## Learn more

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
