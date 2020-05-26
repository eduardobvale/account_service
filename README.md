# Account Service

This is an account opening service focused on protecting 'Sensitive Data' through the process. Client applications must authenticate with a valid Brazilian Identification (CPF) then use the bearer JWT to update account information. Only a complete account will have a referral code.

A especific authentication with JWT was built so the user can authenticate only with a valid CPF, there is no focus on email, password and email confirmations workflows (Reference used https://www.pluralsight.com/guides/token-based-authentication-with-ruby-on-rails-5-api).

A symmetric encryption and https://github.com/ankane/lockbox was chosen so data can retrieved easier, but its important to set up a strong secret key when in production environment (Use lockbox generator Lockbox.generate_key).

Since Identification needs to unique but we also need to encrypt data, https://github.com/ankane/blind_index was used to allow using rails validators, the strategy used by this gem allows an attacker reading the database to identify repeated values, since we only wanted to use the gem on a unique field, this is not a problem.

All validations were made using Active Record attr validators, easier to extend and avoid changes in the controller.

## Installation

This project requires Ruby ('2.6.3'), Bunlder and PostgresQL

Setup your database credentials in the yml file
```
config/database.yml
```

This project uses https://github.com/bkeepers/dotenv, so setup a .env file to setup encryption key, for example:
```
LOCKBOX_MASTER_KEY=0000000000000000000000000000000000000000000000000000000000000000
```

Install project gems
```bash
bundle install
```
Setup your database
```bash
rails db:setup
```

## Tests

This project was tested using RSpec, run with the command below

```bash
bundle exec rspec
```

## API Usage

To start using, inform a valid identification to authenticate:
```
POST /authenticate

Request Body: { cpf: 'xxx.xxx.xxx-xx' }

Response: { "auth_token": "[JWT]" }
```

Update other fields
```
PUT /account
Authorization: Bearer [JWT]

Request Body: 
{
  "account": {
    "gender": "Male",
    "city": "NYC",
    "state": "NY",
    "country": "USA",
    "name": "Joe",
    "email": "joemasel@email.com",
    "birth_date": "21/10/1932"
  }
}

Response: 
{
    "status": "[Status]",
    "referral_code": "[Referral Code]"
}

```

```
GET /account/referrals

Authorization: Bearer [JWT]

Response: 
[{
    "id": "[id]",
    "name": "[Name]"
}]

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.