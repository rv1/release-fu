#! /bin/bash

set -e

tag() {
  VERSION=$(< ./contract/CLIENTS_VERSION)
  case "${ACTION_ARG}" in
    major)
      echo "🤾 Do: Creating a major version release."
      NEW_VERSION=$(cat ./contract/CLIENTS_VERSION | awk -F. -v OFS=. '{$1++;print}')
    ;;
    minor)
      echo "🤾 Do: Creating a minor version release."
      NEW_VERSION=$(cat ./contract/CLIENTS_VERSION | awk -F. -v OFS=. '{$2++;print}')
    ;;
    patch)
      echo "🤾 Do: Creating a patch version release."
      NEW_VERSION=$(cat ./contract/CLIENTS_VERSION | awk -F. -v OFS=. '{$3++;print}')
    ;;
    *)
      echo "⚠️  Unknown action. Please use 'major', 'minor' or 'patch' with the shell command."
      exit 1
    ;;
  esac
  echo $NEW_VERSION > ./contract/CLIENTS_VERSION
  git add ./contract/CLIENTS_VERSION
  git commit -m "Update RPC to v$NEW_VERSION"
  git tag -a "v$NEW_VERSION" -m "v$NEW_VERSION"

  read -p "Do you want to push the commit and tag? (y/n): " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      git push origin HEAD
      git push --tags
  fi
}

echo "🚪 Welcome to Release Fu (Node) 🚪"
ACTION=$1
ACTION_ARG=$2

case "${ACTION}" in
  tag)
    tag
  ;;
  *)
    echo "⚠️  Unknown action."
  ;;
esac
