# Getting started

```
docker-compose build
docker-compose up
```

# First-time initialization

The container doesn't automatically run `drush site-install` because we want it to be possible to stop and start an existing container without rebuilding the site every time. Instead, you need to manually run this after starting the container the first time:

`docker-compose exec php composer run-script install:with-mysql`

# Persistence

Persistent state is stored in a database volume named `data`. You can destroy and recreate the containers as much as you like and your site will be preserved until you also destroy the volume.

The codebase is linked directly to the filesystem in `www` so you can develop/contribute while seeing the changes synchronized. In some setups (we're looking at you, macOs) this can be slow (even if we're using the recommended cached option from Docker), for those cases, using (Docker sync)[https://github.com/EugenMayer/docker-sync] can improve speed a lot.
