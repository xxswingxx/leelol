# Leelol

Leelol is designed to work as an unofficial API for League of Legends ~~due to the lack of a public official one~~. 
Our source data are the [League of Legends  Wiki](http://leagueoflegends.wikia.com/wiki/Base_champion_statistics) and [Mobafire](http://mobafire.com/league-of-legends/). The app is currently hosted at heroku: [http://leelol.herokuapp.com]()

# Status (29/06/2013)
The main point of the app is currently up. Example request with curl
```shell
curl -u authentication_token:pass -X GET 'https://leelol.herokuapp.com/api/v1/champions.json'
```
The api only responds to json, so make sure your requests are in this format.

## Where is my token?
In order to work with the API, you will need an authentication token. To get yours, please visit the web side of the application and create an account. After that you will be able to generate a new token in your profile section.

The API has two main resources: champions and items.

# Champions
OK, who doesn't know what a champion is? 
## Get Champions
`GET 'api/v1/champions.json'` will return an array with all the champions in the database. Each position of the array contains the identifier of the champion in the database and his name. Example:

```json
  [
    {
      "id":1,
      "name":"Aatrox"
    },
    {
      "id":2,
      "name":"Ahri"
    },
    {
      "id":3,
      "name":"Akali"
    },
    {
      "id":4,
      "name":"Alistar"
    },
    {
      "id":5,
      "name":"Amumu"
    } 
    ...
  ]
```
You can also filter the result by passing the parameter q like this:

`GET 'api/v1/champions.json?q=twi'` will return the following json:


```json
  [
    {
      "id":96,
      "name":"Twisted Fate"
    },
    {
      "id":97,
      "name":"Twitch"
    }
  ]
```

## Get a single champion detailed information
`GET 'api/v1/champions/champion_id'` will return the information about a single champion. For instance, let's get Aatrox stats:
`GET 'api/v1/champions/1.json'`

```json
{
  "id":1,
  "name":"Aatrox",
  "image":"http://cdn2.mobafire.com/images/champion/icon/aatrox.png",
  "health_base":395.0,
  "health_per_lvl":85.0,
  "health_regen_base":5.75,
  "health_regen_per_lvl":0.5,
  "mana_base":0.0,
  "mana_per_lvl":0.0,
  "mana_regen_base":0.0,
  "mana_regen_per_lvl":0.0,
  "attack_base":55.0,
  "attack_per_lvl":3.2,
  "attack_speed_base":0.651,
  "attack_speed_per_lvl":3.0,
  "armor_base":14.0,
  "armor_per_lvl":3.8,
  "magic_resist_base":30.0,
  "magic_resist_per_level":1.25,
  "movement_speed":345.0
}
```
Those base stats are counted starting with the level 0, so you can calculate each level detailed stats thanks to the per lvl increments.

# Items
The values returned are the items you can find in the in-game base store. Currently, we do not classify the items by Summoner's Rift, Twisted Treeline or Dominion items.
## Get Items
`GET 'api/v1/items.json'` will return an array with all the items in the database. Each position of the array contains the identifier of the champion in the database and his name. Example:
```json
[
  {
    "id":1,
    "name":"Abyssal Scepter"
  },
  {
    "id":2,
    "name":"Aegis of the Legion"
  },
  {
    "id":3,
    "name":"Amplifying Tome"
  },
  {
    "id":4,
    "name":"Archangel's Staff"
  },
  {
    "id":5,
    "name":"Athene's Unholy Grail"
  },
  {
    "id":6,
    "name":"Atma's Impaler"
  },
  ...
]
```

You can also filter the result by passing the parameter q like this:

`GET 'api/v1/items.json?q=scpeter'` will return the following json:


```json
[
  {
    "id":1,
    "name":"Abyssal Scepter"
  },
  {
    "id":173,
    "name":"Rylai's Crystal Scepter"
  },
  {
    "id":216,
    "name":"Vampiric Scepter"
  }
]
```

## Get a single item detailed information
`GET 'api/v1/items/champion_id'` will return the information about a single item. For instance, let's get the Archangel's Staff stats:
`GET 'api/v1/items/4.json'`

```json
{
  "id":4,
  "name":"Archangel's Staff",
  "image":"http://cdn2.mobafire.com/images/item/archangels-staff.gif",
  "cost":2700,
  "stats":{
            "ability_power":"60",
            "mana":"250",
            "mana_regeneration":"10"
          },
  "special":[
              "UNIQUE Passive- Insight- Gain Ability Power equal to 3% of your Maximum Mana.UNIQUE Passive- Mana Charge- Each time you cast a spell or spend Mana, you gain 6 maximum Mana (3 second cooldown). Bonus caps at +750 Mana.Transforms into Seraph's Emb"
            ]
}
```

# Disclaimer

Remember I have no access to any League of Legends sort of API. I just built one after observing the difficulties for low-profile developers to get League of Legends stats for little projects and as a mere hobby project. I just populated my database information from other sources aforementioned using scrapping and http requests, so maybe there will be some outdated values in the future. If you have any question or doubt open a new issue in this project page and I'll try to answer as soon as possible. 
