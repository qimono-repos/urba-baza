#! /bin/bash

mkdir -p urba
cd urba
mkdir -p app
mkdir -p app/src
mkdir -p app/src/main
mkdir -p app/src/main/kotlin
mkdir -p app/src/main/kotlin/com/qimono/urba
mkdir -p app/src/main/res
mkdir -p app/src/main/res/drawable
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values

touch build.gradle 
touch settings.gradle 
touch gradle.properties

touch ./app/build.gradle

touch ./app/src/main/AndroidManifest.xml

touch ./app/src/main/kotlin/com/qimono/urba/MainActivity.kt

touch ./app/src/main/res/layout/activity_main.xml

touch ./app/src/main/res/values/colors.xml
touch ./app/src/main/res/values/strings.xml
touch ./app/src/main/res/values/themes.xml

echo 'New Project Scaffolding'
tree
