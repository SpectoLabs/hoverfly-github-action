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

See the [DEPENDENCIES.md](.github/DEPENDENCIES.md)


