##### public saltstack files
srv/pillar/private/ is a default pillar with generic values so topfile doesn't think they're missing.
this is where all secret stuff should go, ideally encrypted or stored in a vault.
* public-packer also relies on this repo to exist to build out images/ami's
