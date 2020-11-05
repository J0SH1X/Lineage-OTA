# Information

This repository provides LineageOS OTA releases for the V30, V40 and V50

# Requirements

You need to install `hub` ([Instructions](https://stackoverflow.com/questions/21214562/how-to-release-versions-on-github-through-the-command-line/52353299#52353299))

# Usage

`./gen_ota_json.sh $DEVICE $PATH_REPO1 $PATH_REPO2 ...`

where $DEVICE is the codename of your device, and $PATH_REPOx are your repositories you want to include in your changelog
e.g.: 
`./gen_ota_json.sh flashlmdd device/lge/flashlmdd device/lge/flash-common device/lge/sm8150-common kernel/lge/sm8150`
