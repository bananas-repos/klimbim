#!/bin/sh

# copywrite by Johannes 'Banana' Keßler 2015 

git filter-branch --env-filter '
OLD_EMAIL="OLD OR INVALID EMAIL"
CORRECT_NAME="NEW AUTHOR NAME"
CORRECT_EMAIL="NEW AUTHOR EMAIL"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
