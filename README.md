# Hoverfly GitHub Action

[![tests](https://github.com/agilepathway/hoverfly-github-action/workflows/Test/badge.svg?branch=main&event=push)](https://github.com/agilepathway/hoverfly-github-action/actions?query=workflow%3ATest+event%3Apush+branch%3Amain)
[![reviewdog](https://github.com/agilepathway/hoverfly-github-action/workflows/reviewdog/badge.svg?branch=main&event=push)](https://github.com/agilepathway/hoverfly-github-action/actions?query=workflow%3Areviewdog+event%3Apush+branch%3Amain)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?maxAge=43200)](LICENSE)

**[GitHub Action](https://github.com/features/actions) that installs [Hoverfly](https://docs.hoverfly.io/), so that it can be used in subsequent steps in your GitHub Actions CI/CD pipeline (e.g. when running tests that use Hoverfly).**


## Using the Hoverfly action

Using this action is as simple as:

1. **create a `.github\workflows` directory** in your repository
2. **create a 
   [YAML](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#about-yaml-syntax-for-workflows) 
   file** in the `.github\workflows` directory (file name can be anything you like, 
   with either a `.yml` or `.yaml` file extension), with this content:
 
```
---
name: Hoverfly
on:
  push:

jobs:

  install-hoverfly:
  name: Install
  runs-on: ubuntu-latest
  steps:
    - name: Install Hoverfly
      uses: agilepathway/hoverfly-github-action@main
      with:
        runner_github_workspace_path: ${{ github.workspace }}
```

You will also typically have additional steps both before and after the Hoverfly installation step,
e.g. to checkout your code and to run your tests. Here's an example:

```
---
name: Run tests
on:
  push:

jobs:

  run-tests:
  name: Install Hoverfly and run tests
  runs-on: ubuntu-latest
  steps:
    - name: Checkout code
        uses: actions/checkout@v2
    - name: Install Hoverfly
      uses: agilepathway/hoverfly-github-action@main
      with:
        runner_github_workspace_path: ${{ github.workspace }}
    - name: Run Tests
        run: <command-to-run-your-tests>
```

Once the Hoverfly installation has completed, both the 
[Hoverfly](https://docs.hoverfly.io/en/latest/pages/reference/hoverfly/hoverflycommands.html) and 
[Hoverctl](https://docs.hoverfly.io/en/latest/pages/keyconcepts/hoverctl.html) 
commands are available to you for the remainder of your GitHub Actions workflow:
- `hoverfly`
- `hoverctl`


## Specifying the Hoverfly version

Example:

```
  steps:
    - name: Install Hoverfly
      uses: agilepathway/hoverfly-github-action@main
      with:
        version: v1.3.0
        runner_github_workspace_path: ${{ github.workspace }}
```

`version` can be any [released Hoverfly version](https://github.com/SpectoLabs/hoverfly/releases).
If you do not provide a version, it will default to the 
[latest](https://github.com/SpectoLabs/hoverfly/releases/latest) release.


## Runner GitHub Workspace path and Hoverfly installation location

As per the above examples, you have to provide the following parameter:

`runner_github_workspace_path: ${{ github.workspace }}`

The value must always be `${{ github.workspace }}`

This is so that the Hoverfly binaries are added to the path properly.

The Hoverfly binaries are installed at `${{ github.workspace }}/bin`

(The [GitHub workspace directory is persistent throughout the GitHub Action workflow](https://docs.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#filesystems-on-github-hosted-runners), which means that the binaries are available to any subsequent workflow steps.)


## Enabling HTTPS Hoverfly simulations

To enable [HTTPS Hoverfly simulations](https://docs.hoverfly.io/en/latest/pages/tutorials/basic/https/https.html), follow this example:

```
  steps:
    - name: Install Hoverfly
      uses: agilepathway/hoverfly-github-action@main
      with:
        runner_github_workspace_path: ${{ github.workspace }}
      - name: Enable https calls to be simulated by Hoverfly
        run: install-and-trust-hoverfly-default-cert.sh
```

This script 
[installs and trusts the default Hoverfly certificate](https://docs.hoverfly.io/en/latest/pages/tutorials/advanced/configuressl/configuressl.html),
after which you can go ahead and simulate HTTPS calls (see 
[this example](https://github.com/agilepathway/hoverfly-github-action/blob/a0a08dae5c28d0980205c7997ce4accc20d1fc48/.github/workflows/tests.yml#L95-L113) 
in the [end-to-end tests](.github/workflows/tests.yml)).

Our Hoverfly GitHub Action automatically makes this https cert
[install script](./install-and-trust-hoverfly-default-cert.sh) available
(in the same `${{ github.workspace }}/bin` directory which we add to the path and which the
Hoverfly binaries are located in too).




## Tests / examples

The [tests](.github/workflows/tests.yml) contain further configuration examples.


## Suggestions / bug reports / contributions

The project is [open source](https://opensource.guide/how-to-contribute/) and all contributions are very welcome :slightly_smiling_face: :boom: :thumbsup:

* [How to report a bug or suggest a new feature](CONTRIBUTING.md#how-to-report-a-bug-or-suggest-a-new-feature)

* [How to make a contribution](CONTRIBUTING.md#how-to-make-a-contribution)


## Updating dependencies

See the [DEPENDENCIES.md](.github/DEPENDENCIES.md)
