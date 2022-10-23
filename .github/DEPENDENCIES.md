# Updating dependencies

## Dependabot

We use [GitHub Dependabot](https://docs.github.com/en/github/administering-a-repository/keeping-your-dependencies-updated-automatically) 
([bought by GitHub in 2019](https://dependabot.com/blog/hello-github/) and now 
[baked into GitHub](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/)) 
to manage our dependencies.

Whenever possible we let Dependabot update our dependencies automatically (by 
[automatically creating a PR](https://docs.github.com/en/github/administering-a-repository/managing-pull-requests-for-dependency-updates#about-github-dependabot-pull-requests)
for us to merge).

Dependabot will 
[automatically update non-Docker dependencies in our GitHub Actions](https://github.blog/2020-06-25-dependabot-now-updates-your-actions-workflows/).

### Workaround for other dependencies

For our other dependencies which cannot be updated automatically by Dependabot, we employ a bit of a hack.  
We have a [`dependabot_hack.yml`](workflows/dependabot_hack.yml) GitHub Action which triggers a Dependabot PR when these other dependencies have a new version to update to.  This GitHub Action is set to never actually run; it exists just so that Dependabot can do its thing.  The `dependabot_hack.yml` documents where in our codebase that we then need to **update to the new version manually** (we then **add this manual update as another commit to the PR that Dependabot creates**).  NB we are able to use this hack to **manage _any_ dependency that uses 
[GitHub releases](https://docs.github.com/en/github/administering-a-repository/about-releases)** - we are not limited to just dependencies which are themselves GitHub Actions (this is because Dependabot doesn't care
whether the dependencies are valid GitHub Actions, it just parses the file and updates any versions that are
managed through GitHub releases).

We could in theory automate this entirely (by e.g. having a GitHub Action that is triggered by Dependabot PRs,
which updates the version in the requisite files and then adds the change in a new commit to the Dependabot PR),
but that would be overkill for now.

Eventually as Dependabot adds more features we may be able to remove this workaround.


## Devcontainer base image version

We always pin to the most specific ([patch-level](https://semver.org/)) version of the [devcontainer Docker base image](https://github.com/microsoft/vscode-dev-containers/tree/master/containers/debian#using-this-definition-with-an-existing-folder) that we can, to ensure that the devcontainer builds are always reproducible.  

This is despite the general guidance from Microsoft for these images being to use ["the major release version of this tag to avoid breaking changes while still taking fixes and content additions as they land. e.g. `0-buster`"](https://hub.docker.com/_/microsoft-vscode-devcontainers?tab=description)

The reason we are comfortable pinning to a specific patch-level version is that we still take fixes and content additions as they land, because we use Dependabot to keep us up to date (using the [above workaround](#workaround-for-other-dependencies)).

NB when we manually update the version in the `devcontainer.json`, we need to be careful as the version format is
e.g. `0.123.0-buster`, compared to `v0.123.0` in the [`dependabot_hack.yml`](workflows/dependabot_hack.yml)

When the new version is a patch or minor level update, we don't bother to test manually that the new remote container works (before merging the Dependabot PR).  In the (hopefully rare) event that it doesn't, we can simply put in another PR to downgrade the version to one that does work.  

For major version updates, we should test that the remote container works successfully before merging the Dependabot PR.  The most failsafe way to test this is to [open the Dependabot PR branch in a remote Visual Studio Code container](https://code.visualstudio.com/docs/remote/containers#_quick-start-open-a-git-repository-or-github-pr-in-an-isolated-container-volume).  Alternatively starting a new [Codespace](https://github.com/features/codespaces/) that points to the Dependabot PR branch should also be a valid test.


## Dockerfile dependencies

We do not pin the linux apt-get dependencies in the devcontainer Dockerfile as
[Dependabot currently does not support this](https://github.com/dependabot/dependabot-core/issues/2129), and also the
risk of side effects due to an updated apt-get dependency in the devcontainer is very small indeed (and there's zero
risk to production, as this is just in the devcontainer).
