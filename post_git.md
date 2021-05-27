
### Working on a new branch

See: [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)

When working on a new branch:

```shell
git checkout -b newbranch
```

do your stuff

```shell
git add .
git commit -m "message"
git push -u origin newbranch
```

when finished and merging, remember not using fast-forwading:

```shell
git checkout master # switch to master branch
git merge --no-ff newbranch # merge without ff
git branch -d newbranch # delete branch
git push origin master # push to remote
```
