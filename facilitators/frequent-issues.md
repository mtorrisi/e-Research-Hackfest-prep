# warmup problems

This should contain the typical frequently-encountered issues for various things. Try to list them according to the place where the _solution_ is made, not necessarily where the _problem_ is diagnosed.

## General HowTos

### How to broadcast information to the participants

You need a reliable way to broadcast information to the participants. This could be slack, gitter, twitter, or etherpad, or could also simply be a whiteboard or flipchart. Whilst most of the information necessary to participate in the event is on the hack website, you still need to broadcast specific time-dependent updates, or the url of the hack website.



## Longer-term problems without clear solutions

Stuff that doesn't fit anywhere else

  * At some point, the users "get" it, and they start looking at the big picture. We need some kind of growth path that suggests how the applications can move to production.
  * Macbook keyboards show the `"` as a wierd character which maks the curl warmups fail.


## Network problems

  * ensure that the firewall on the services provided (FG, Jenkins, etc) can allow several connections on ssh - no throttling

## Git problems

  * Installing Git Bash : there isn't a very clear process to install git bash
  * Git bash on Windows doesn't allow https cloning - use the GUI


## SSH problems

  * Git bash ssh - git bash creates ssh keys with a file name `github_rsa` instead of `id_rsa`. This should be circumvented by copying the `github_rsa` files to `id_rsa`

## OAR problems

  * would be nice to have a json<->xml converter  
