git_commit_msg=

if [[ $1 == '' ]]
then
    git_commit_msg=fix
else
    git_commit_msg="$1"
fi

# if [[ $2 == 'dev' ]]
# then
#     heroku git:remote -a dev-iriversland
# else
#     heroku git:remote -a iriversland
# fi

git add .
git commit -m "$git_commit_msg"
git push

# git push heroku # heroku git:remote -a iriversland || dev-iriversland
# git push github