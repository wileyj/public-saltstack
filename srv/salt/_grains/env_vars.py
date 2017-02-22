import os
import logging
log = logging.getLogger(__name__)
def env_vars():
    '''
    Finds all Environment Variables and adds them to a a dict as '[env_vars][$KEY] = $VALUE'
    '''
    grains = {}
    grains['env_vars'] = {}
    for item in os.environ:
        if item != "_":
            log.debug("Found Env Var: %s" % (item))
            log.debug("\t - Adding env key '%s' with value: %s" % (item.lower(), os.environ[item]))
            grains['env_vars'][item.lower()] = os.environ[item]
    return grains
