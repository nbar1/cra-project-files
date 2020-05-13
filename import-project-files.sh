#!/bin/sh

# copying files
echo "Copying custom settings files to $PWD"
origin_dir="/Users/$USER/repos/cra-project-files"
#client
cp $origin_dir/.eslintrc $PWD
cp $origin_dir/.prettierrc $PWD
cp $origin_dir/jsconfig.json $PWD
cp $origin_dir/.env $PWD
mkdir .vscode
cp $origin_dir/.vscode/settings.json $PWD/.vscode/settings.json
#server
mkdir server
mkdir server/routes
mkdir server/lib
cp $origin_dir/server/index.js $PWD/server/index.js
cp $origin_dir/server/routes/index.js $PWD/server/routes/index.js


# add yarn deps
echo "Adding Yarn dependencies"
yarn add --dev babel-eslint eslint eslint-plugin-babel eslint-config-prettier eslint-plugin-html eslint-plugin-prettier eslint-plugin-react eslint-plugin-react-hooks prettier express minimist body-parser
yarn add styled-components

# lock packages
sed -i '' 's/\"\^/\"/g' package.json

# run prettier
echo "Running Prettier"
npx prettier --loglevel error --write .

# commit files
echo "Committing preference files"
git add .
git commit -m "Add preference files, install default deps, run prettier on all files (automatic commit via init-cra)"

echo "************"
echo "Don't forget to proxy your server in package.json"
echo "\"proxy\": \"http://localhost:8080\","
echo "************"
echo "Update your start script to the following:"
echo "\"start\": \"nodemon server/index.js & react-scripts start\","
echo "************"
