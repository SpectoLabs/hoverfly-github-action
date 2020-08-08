#!/bin/sh

# This script installs and trusts the default Hoverfly certificate[1],
# after which you can go ahead and simulate HTTPS calls[2] (see this example[3] in the end-to-end tests[4]).
#
# [1] https://docs.hoverfly.io/en/latest/pages/tutorials/advanced/configuressl/configuressl.html
# [2] https://docs.hoverfly.io/en/latest/pages/tutorials/basic/https/https.html
# [3] https://github.com/agilepathway/hoverfly-github-action/blob/a0a08dae5c28d0980205c7997ce4accc20d1fc48/.github/workflows/tests.yml#L95-L113
# [4] https://github.com/agilepathway/hoverfly-github-action/blob/main/.github/workflows/tests.yml

wget https://raw.githubusercontent.com/SpectoLabs/hoverfly/master/core/cert.pem
sudo mv cert.pem /usr/local/share/ca-certificates/hoverfly.crt
sudo update-ca-certificates
