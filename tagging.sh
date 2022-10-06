CURRENT_TAG=$(git describe --tags)
MAJOR_TAG=$(awk -F'.' '{print $1}' <<<"$CURRENT_TAG")

# Remove remote old major tag if exists
FIND_RESULT=$(git tag -l '$MAJOR_TAG')
if [[ $FIND_RESULT ]]; then
    echo "Moving major tag '$MAJOR_TAG' to the same commit as '$CURRENT_TAG' tag"
    git push --delete origin $MAJOR_TAG
else
    echo "'$MAJOR_TAG' tag does not exists and will be created at the same commit as '$CURRENT_TAG' tag"
fi

# Tag current commit with major tag
git tag $MAJOR_TAG
git push --tags
