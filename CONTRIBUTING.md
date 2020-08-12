# How to contribute

Firstly thanks for thinking of contributing - the project is [open source](https://opensource.guide/how-to-contribute/) and all contributions are very welcome :slightly_smiling_face: :boom: :thumbsup:

## How to report a bug or suggest a new feature

[Create an issue](https://github.com/agilepathway/hoverfly-github-action/issues), describing the bug or new feature in as much detail as you can.

## How to make a contribution

  * [Create an issue](https://github.com/agilepathway/hoverfly-github-action/issues) describing the change you are proposing.
  * [Create a pull request](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests).  The project uses the _[fork and pull model](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-collaborative-development-models)_:
    * [Fork the project](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/working-with-forks)
    * Make your changes on your fork
    * Write a [good commit message(s)](https://chris.beams.io/posts/git-commit/) for your changes
    * [Create the pull request for your changes](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/proposing-changes-to-your-work-with-pull-requests)
      * [Update the tests or add new tests](#running-the-tests) to cover the new behaviour.

## Running the tests

The [tests](.github/workflows/tests.yml) are [end-to-end black box tests](http://softwaretestingfundamentals.com/black-box-testing), to verify that the GitHub Action installs [Hoverfly](https://docs.hoverfly.io) and [Hoverctl](https://docs.hoverfly.io/en/latest/pages/keyconcepts/hoverctl.html) successfully.

[GitHub Actions cannot be run locally](https://github.community/t/can-i-run-github-actions-on-my-laptop/17019/2), so that means that these tests cannot be run locally either.  Instead, they run automatically as a [GitHub Action themselves](https://github.com/agilepathway/hoverfly-github-action/actions?query=workflow%3ATest), triggered on every push.

There is no need for a separate language for the tests - as we are running the actual GitHub Action we are able to use the [GitHub Action workflow syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions), which gives us what we need (e.g. [expressions](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#about-contexts-and-expressions)) to write clean tests.


## Updating dependencies

We use [GitHub Dependabot](https://docs.github.com/en/github/administering-a-repository/keeping-your-dependencies-updated-automatically) 
([bought by GitHub in 2019](https://dependabot.com/blog/hello-github/) and now 
[baked into GitHub](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/)) 
to manage our dependencies.

Whenever possible, we let Dependabot update our dependencies automatically (by 
[automatically creating a PR](https://docs.github.com/en/github/administering-a-repository/managing-pull-requests-for-dependency-updates#about-github-dependabot-pull-requests)
for us to merge).

Dependabot will 
[automatically update non-Docker dependencies in our GitHub Actions](https://github.blog/2020-06-25-dependabot-now-updates-your-actions-workflows/).

For our other dependencies which cannot be updated automatically by Dependabot, we employ a bit of a hack.  
We have a [`dependabot_hack.yml`](.github/workflows/dependabot_hack.yml) GitHub Action which triggers a Dependabot PR when these other dependencies have a new version to update to.  This GitHub Action is set to never actually run; it exists just so that Dependabot can do its thing.  The `dependabot_hack.yml` documents where in our codebase that we then need to **update to the new version manually** (we then **add this manual update as another commit to the PR that Dependabot creates**).  NB we are able to use this hack to **manage _any_ dependency that uses 
[GitHub releases](https://docs.github.com/en/github/administering-a-repository/about-releases)** - we are not limited to just dependencies which are themselves GitHub Actions (this is because Dependabot doesn't care
whether the dependencies are valid GitHub Actions, it just parses the file and updates any versions that are
managed through GitHub releases).

We could in theory automate this entirely (by e.g. having a GitHub Action that is triggered by Dependabot PRs,
which updates the version in the requisite files and then adds the change in a new commit to the Dependabot PR),
but that would be overkill for now.

Eventually as Dependabot adds more features we may be able to remove this workaround.

