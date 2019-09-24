remove-item -Recurse -Force ./output
New-Item -Type Directory output
elm make --optimize .\src\Main.elm --output ./output/app.js
Copy-Item  -Path static/* -Destination ./output