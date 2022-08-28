git config --global core.autocrlf true

ECHO ADD PACKAGE JSON
git add 01-Web/SparkIt.Web/package.json

ECHO status
git status 

ECHO COMMIT PACKAGE JSON
git commit -m "update Version" 

ECHO PUSH REMOTE MASTER
git push origin HEAD:master

ECHO LAST COMMIT
for /f %%i in ('git rev-parse HEAD') do set HASH=%%i

ECHO REST LOCAL CHANGES
git reset --hard

ECHO CHECKOUT DEV
git checkout -f Dev

git config --global core.autocrlf true

ECHO CHECK BRANCH
git branch

ECHO PULL
git pull

ECHO CHERRY PICK
git cherry-pick %HASH%

echo status
git status

ECHO Resolve Conflict
git checkout --theirs 01-Web/SparkIt.Web/package.json

echo
git add 01-Web/SparkIt.Web/package.json

ECHO COMMIT PACKAGE JSON
git commit -m "update Version" 

ECHO PUSH REMOTE Dev
git push
