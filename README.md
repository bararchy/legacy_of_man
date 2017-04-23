# legacy_of_man

This repo holds the server side of Legacy Of Man game.  
The game is written in the Crystal programming language.  

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
Remember that to connect you will need a telnet\nc (tcp client) and just connect to the port.  
The server will create all relevant tables and data if it's not there.  

So basically after running the server, just 
```
telnet 127.0.0.1 3000 # or whatever your configured port is
```

## Development

- [ ] Item class, handle all items as objects  
- [ ] Save user data as a blob and not json, so we can marshal the data  
- [ ] World class, handle world global events  (day,night | server announcements | chat | etc..)  
- [ ] Map class, Should handle moving around, keep track of users place in the world  
- [ ] Add to User class: Movement, save (update DB), attack, other basic commands, health (and mana?) increase decrease  
- [ ] Combat class, handles ... combat :) will take an array of users\mobs and will allow them to attack and fight  

I'll add more needs as the game will come along.  

## Contributing

1. Fork it ( https://github.com/bararchy/legacy_of_man/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [bararchy](https://github.com/[your-github-name]) - creator, maintainer
