## sec-pedloot 
With this script you can loot dead corps.
this script also works with zombie scripts, if you add the ped model name to the list inside config.lua.

## NOTE 
- This loot system will not work if you dont have qb-target.
- make sure `qb-target` is installed `correctly` on your server.
- check if you have `setr UseTarget true` in your server.cfg or this script will not work.


## Dependencies
- ✅ [qb-core](https://github.com/qbcore-framework/qb-core)
- ✅ [qb-target](https://github.com/qbcore-framework/qb-target)


## Install
- create a folder in `resources` [mh]
- put the `sec-pedloot` in `resources/[mh]/`
- open F8 type `refresh`
- ater `refresh` type `ensuresec-pedloot` or you can restart the server.
- don't forget the admin command to `enable` or `disable` the loot system.

## Admin Command
- `/pedloot On`
- `/pedloot Off`


## Server side triggers Enable or Disable Lootsystem
- Enable Loot System For All Players
```lua
TriggerEvent('sec-pedloot:server:enable')
```

- Disable Loot System For All Players
```lua
TriggerEvent('sec-pedloot:server:disable')
```

# 🙈 Youtube
- [Youtube](https://www.youtube.com/c/MaDHouSe79)
