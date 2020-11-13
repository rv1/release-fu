# release-fu

## Creating new release

In local environment, checkout the main branch and execute:

```
./do tag patch
```

replace options available for tag are `patch`, `minor` or `major`

After the tag is created and the new commit is created, push the commit and tags to origin:

```
git push origin main
git push --tags
```

## Using github actions

Access the `Create Tag` workflow in github actions, and run the workflow.
