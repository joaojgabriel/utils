#!/bin/bash
mkdir src dist
echo "# $(basename $(pwd))" > README.md
echo '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script defer src="./main.js"></script>
  </head>
  <body></body>
</html>' > dist/index.html
echo "import './style.css'" > src/index.js
echo "/* http://meyerweb.com/eric/tools/css/reset/ 
   v2.0 | 20110126
   License: none (public domain)
*/

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
	display: block;
}
body {
	line-height: 1;
}
ol, ul {
	list-style: none;
}
blockquote, q {
	quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
	content: '';
	content: none;
}
table {
	border-collapse: collapse;
	border-spacing: 0;
}" > src/style.css
git init
echo 'node_modules
package-locks.json
.vscode' > .gitignore  
git add .
git commit -m "First commit"
git branch -M main
echo "Is there a remote repo? (y/n)" && read answer
if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
	echo "Paste the link" && read link
	git remote add origin $link
	git push -u origin main
	git subtree push --prefix dist origin gh-pages
fi
npm init --yes 
npm install --save-dev webpack webpack-cli webpack-dev-server eslint-config-prettier style-loader css-loader
npm init @eslint/config 
npm install --save-dev --save-exact prettier 
cat .gitignore | tee .prettierignore .eslintignore
echo 'webpack.config.js' >> .eslintignore
echo {} > .prettierrc.json 

echo '{
  "env": {
    "browser": true,
    "es2021": true
  },
  "extends": ["airbnb-base", "prettier"],
  "overrides": [],
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "rules": {}
}' > .eslintrc.json
echo 'const path = require("path");

module.exports = {
  mode: "development",
  entry: "./src/index.js",
  output: {
    filename: "main.js",
    path: path.resolve(__dirname, "dist"),
  },
  devtool: "inline-source-map",
  devServer: {
    static: "./dist",
  },
  module: {
    rules: [
      {
        test: /\.css$/i,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i,
        type: "asset/resource",
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/i,
        type: "asset/resource",
      },
    ],
  },
};' > webpack.config.js
git add .
git commit -m "Initial config"
