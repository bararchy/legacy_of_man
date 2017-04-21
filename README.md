# legacy_of_man

This repo holds the server side of Legacy Of Man game.  
The game is written in the Crystal programming languge.  

## Installation

```bash
git clone https://github.com/bararchy/legacy_of_man.git
cd legacy_of_man
crystal deps
crystal build --release src/legacy_of_man.cr
./legacy_of_man
```

## Usage

Right now you will need to setup a Mysql\MariaDB database and add the relevant information to the `conf.json` file.  
Remmber that to connect you will need a telnet\nc (tcp client) and just connect to the port.  
The server will create all relevant tables and data if it's not there.  

So basiclly after running the server, just 
```
telnet 127.0.0.1 3000 # or whatever your configured port is
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/bararchy/legacy_of_man/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [bararchy](https://github.com/[your-github-name]) - creator, maintainer
