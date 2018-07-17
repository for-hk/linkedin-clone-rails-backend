# API to power a software similar to LinkedIn

[![Build Status](https://travis-ci.org/ghoshnirmalya/linkedin-rails.svg?branch=master)](https://travis-ci.org/ghoshnirmalya/linkedin-rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/44ac5eaed20a31c9b97c/maintainability)](https://codeclimate.com/github/ghoshnirmalya/linkedin-rails/maintainability)

A clone of LinkedIn software with basic functionalities.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them:

- [Docker](https://docs.docker.com/)

### Installing

1.  Clone the repository: `git clone git@github.com:ghoshnirmalya/linkedin-rails.git && cd linked-rails`
2.  Build the project: `docker-compose run linkedin.rails rails new . --api --force --database=postgresql --T`
3.  Rebuild the project: `docker-compose build`
4.  Create the database: `docker-compose run linkedin.rails rake db:create`
5.  Copy the env files: `cp .env.development.example .env.development && cp .env.test.example .env.test`
6.  Run the migrations: `docker-compose run linkedin.rails rake db:migrate`

Please have a look at [Quickstart: Compose and Rails](https://docs.docker.com/compose/rails/) if you run into any trouble while installing.

## Running the tests

You can run all the specs using the following command:

```
docker exec -it linkedin-rails_linkedin.rails.web_1 rspec .
```

If you want to run a single spec, use the following pattern:

```
docker exec -it linkedin-rails_linkedin.rails.web_1 rspec spec/controllers/v1/users_controller_spec.rb
```

## Built With

- [Ruby on Rails](https://rubyonrails.org/) - The web framework used to build the app
- [Docker](https://www.docker.com/) - Used to containerize the app

## Contributing

If you find any bugs, please feel free to create an issue for that.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

- [How to Test Rails Models with RSpec](https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-rspec)
- [Writing One-Liner RSpec Tests in Rails with Shoulda-Matchers](https://semaphoreci.com/community/tutorials/writing-one-liner-rspec-tests-in-rails-with-shoulda-matchers)
- [An Introduction to Using JWT Authentication in Rails](https://www.sitepoint.com/introduction-to-using-jwt-in-rails/)
- [Token-based authentication with Ruby on Rails 5 API](https://www.pluralsight.com/guides/token-based-authentication-with-ruby-on-rails-5-api)
- [Simple approach to Rails 5 API authentication with Json Web Token](https://www.codementor.io/omedale/simple-approach-to-rails-5-api-authentication-with-json-web-token-cpqbgrdo6)

## Todo

- [x] Authentication
- [x] Make APIs follow JSON-API specification
- [x] Users Listing API
- [ ] Companies Listing API
- [ ] Job Listing API
- [ ] User Profile
- [ ] Company Profile
- [ ] Newsfeed
- [ ] Search (for Users)
- [ ] Search (for Companies)
- [ ] Messages
- [ ] Blogs
- [ ] Stats about your profile views
- [ ] Stats about your article views
