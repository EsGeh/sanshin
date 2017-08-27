#!/bin/bash

REMOTE=sanshin
INSTALL_DIR=sanshin

rsync --exclude-from=.ignore_patterns -r . "$REMOTE:$INSTALL_DIR"
 
ssh $REMOTE "cd $INSTALL_DIR && ./scripts/production/install.sh"
