# IBM's version of [Knative](https://github.com/coligo/xxx)

For each branch in the OSS repo that we want to track, we'll have a
corresponding `oss-...` branch in here. We'll then also have an `ibm-...`
branch with the same suffix name that will hold the IBM specific changes/files.
This should always be needed even if to just have the IBM specific build
files (like the Travis file).

When doing a build we will most likely always build the `ibm-...` branch.

When making IBM specific changes, PRs will need to be submitted against
the appropriate `ibm-...` branch, never `master` (unless the update is to
docs about our process, like this README).

## Creating a new release

When a new release of the OSS repo is published:

1 - Create a new `oss-` branch

```
git fetch oss vX.Y.Z
git checkout FETCH_HEAD
git checkout -b oss-vX.Y.Z
git push origin oss-vX.Y.Z
```

2 - Create a new `ibm-` branch based on the appropriate original release
branch. The "original" branch will vary depending on the history of the
new release. In the cases of new major or minor release, this will most
likely be `master`. All other cases will likely be previousing created
`ibm-vX.Y.Z` releases.

```
git checkout ibm-v.PREVIOUS
git checkout -b ibm-vX.Y.Z
git rebase -i oss-vX.Y.Z
# Resolve any merge conflicts
git push origin ibm-vX.Y.Z
```

## Updating an existing OSS branch:

Used when we need to grab the latest version of the OSS branch. Hopefully this
should only be for `master` and not a published release.

```
git checkout oss-master
git pull oss master
git push origin oss-master
git checkout ibm-master
git rebase -i oss-master
# Resolve any merge conflicts
git push origin ibm-master -f
```

## Misc

While it might be nice to have a seprate commit for each patch we apply, this
actually could make the rebasing harder. So, we may want to consider squashing
all of our commits down to just one. Any history of why a change is made can
still be kept by having the appropriate comment in the code, along with a
pointer to the github PR, explaining why we're making this change. That's
probably a better place for the info anyway since we should have more history
and commentary there. Plus, people wanting to understand why a change was
made will most likely start with the code itself so good comments in there
are a requirement. More ramblings after that should be in the PR. Long-winded
git logs, and therefore a separate commit, should be unnecessary.


## Building

The travis build system will build based on what's in the `.travis.yml` file,
e.g.  https://github.ibm.com/coligo/xxx/blob/ibm-master/.travis.yml .

Basically, it'll run: https://github.ibm.com/coligo/xxx/blob/ibm-master/ibm/do-all .
Each step in the process should have it's own bash file and ideally if you
setup the env vars listed at the top of `do-all` then you should be abel to run
each script locally and independently. I'm not sure we're there yet but
it's a WIP.

