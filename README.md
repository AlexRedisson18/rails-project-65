### Hexlet tests and linter status:
[![Actions Status](https://github.com/AlexRedisson18/rails-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/AlexRedisson18/rails-project-65/actions)
[![CI](https://github.com/AlexRedisson18/rails-project-65/actions/workflows/main.yml/badge.svg)](https://github.com/AlexRedisson18/rails-project-65/actions/workflows/main.yml)

[Bulletin Board](https://rails-project-65-4x27.onrender.com) is a service analogous to Avito, in which users can place ads and respond to them and contact the seller. Each ad is pre-moderated by the service administrators. Administrators can return the ad for revision, publish it, or archive it.


### Installation

You can install project and prepare DB by one command.


```bash
make setup
```

or you can do it separately


```bash
make install # install dependecies

make db-prepare # reset DB, run migrations, run seed file

make copy-env # copy ENV variables
```
