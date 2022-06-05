# SDVX-EST
## 技術スタック
- Ruby 2.7.5
- Rails 6.1.4
- MySQL 5.7

## Usage

### install

```sh
$ docker-compose build
$ docker-compose run --rm web rails db:migrate
$ docker-compose run --rm web rails db:seed
```

### start up

```sh
$ docker-compose up -d
```

http://localhost:3000/
