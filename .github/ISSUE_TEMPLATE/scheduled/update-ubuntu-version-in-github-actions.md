---
name: Update Ubuntu version in GitHub Actions
about: Stay up to date with Ubuntu
title: Update Ubuntu version in GitHub Actions
labels: ''
assignees: ''

---

[Ubuntu releases annually in April](https://wiki.ubuntu.com/Releases).  

In 2020 the GitHub Actions team [supported the April release for that year by mid June](https://github.com/actions/virtual-environments/issues/228#issuecomment-644065532), so this GitHub Issue gets automatically created annually each year on 15 July for us to do the update (as hopefully GitHub Actions will support the new version by then each year).  

We can find out if we can update yet [here](https://docs.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#supported-runners-and-hardware-resources).  

When we do the update to the new version it involves e.g. for 2021, simply replacing every case of `ubuntu-20.04` with `ubuntu-21.04`.
