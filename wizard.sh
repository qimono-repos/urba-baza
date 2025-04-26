#! /bin/bash

# Check if a project name was provided
if [ -z "$1" ]; then
 echo "Usage: $0 <ProjectName>"
   exit 1
fi

PROJECT_NAME="$1"
COMPANY_NAME="qimono" # Your fixed company name
PACKAGE_PATH="com/${COMPANY_NAME}/${PROJECT_NAME,,}" # Use lowercase for package path

echo "Creating new Android project: ${PROJECT_NAME}"
echo "Package name: com.${COMPANY_NAME}.${PROJECT_NAME,,}" # Convert project name to lowercase for package

# Create main project directories
mkdir -p "${PROJECT_NAME}"
cd "${PROJECT_NAME}"
mkdir -p app
mkdir -p app/src
mkdir -p app/src/main
mkdir -p app/src/main/kotlin
mkdir -p app/src/main/kotlin/${PACKAGE_PATH//.//\/} # Replace dots with slashes for directory path
mkdir -p app/src/main/res
mkdir -p app/src/main/res/drawable
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values

cat << EOF > build.gradle
buildscript {
  repositories {
    google()
    mavenCentral()
  }
  dependencies {
    classpath 'com.android.tools.build:gradle:8.1.0' 
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0" 
  }
}

allprojectsf {
  repositories {
    google()
    mavenCentral()
  }
}

tasks.register('clean', Delete) {
  delete rootProject.buildDir
}
EOF

cat << EOF > settings.gradle
include ':app'
EOF

cat << EOF > gradle.properties
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAppBundle=true
android.enableJetifier=true 
EOF

cat << EOF > ./app/build.gradle
plugins {
  id 'com.android.application'
  id 'org.jetbrains.kotlin.android'
}

android {
  namespace "com.${COMPANY_NAME}.${PROJECT_NAME,,}"
  compileSdk 34  
  defaultConfig {
    applicationId "com.${COMPANY_NAME}.${PROJECT_NAME,,}"
    minSdk 24   
    targetSdk 34 
    versionCode 1
    versionName "1.0"

    testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
  }

  buildTypes {
    release {
      minifyEnabled false
      proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
  }
  compileOptions {
    sourceCompatibility JavaVersion.VERSION_17 
    targetCompatibility JavaVersion.VERSION_17 
  }
  kotlinOptions {
    jvmTarget = '17'
  }
}

dependencies {
  implementation("androidx.core:core-ktx:1.10.1")
  implementation("androidx.appcompat:appcompat:1.6.1")
  implementation("com.google.android.material:material:1.9.0")
  implementation("androidx.constraintlayout:constraintlayout:2.1.4")
  testImplementation("junit:junit:4.13.2")
  androidTestImplementation("androidx.test.ext:junit:1.1.5")
  androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}
EOF

cat << EOF > ./app/src/main/AndroidManifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest 
  xmlns:android="http://schemas.android.com/apk/res/android" 
  xmlns:tools="http://schemas.android.com/tools"
>

  <application
    android:allowBackup="true"
    android:dataExtractionRules="@xml/data_extraction_rules"
    android:fullBackupContent="@xml/backup_rules"
    android:icon="@mipmap/ic_launcher"
    android:label="@string/app_name"
    android:roundIcon="@mipmap/ic_launcher_round"
    android:supportsRtl="true"
    android:theme="@style/Theme.${PROJECT_NAME}" 
    tools:targetApi="31"
  >
    <activity
      android:name=".MainActivity"
      android:exported="true"
    >
      <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
      </intent-filter>
    </activity>
  </application>
</manifest>
EOF

cat << EOF > ./app/src/main/kotlin/${PACKAGE_PATH//.//\/}/MainActivity.kt
package com.${COMPANY_NAME}.${PROJECT_NAME,,}

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
  }
}
EOF

cat << EOF > ./app/src/main/res/layout/activity_main.xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout 
  xmlns:android="http://schemas.android.com/apk/res/android"
  xmlns:app="http://schemas.android.com/apk/res-auto"
  xmlns:tools="http://schemas.android.com/tools"
  android:layout_width="match_parent"
  android:layout_height="match_parent"
  tools:context=".MainActivity"
>

  <TextView
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="Say hello to ${PROJECT_NAME} by QiMono!"
    app:layout_constraintBottom_toBottomOf="parent"
    app:layout_constraintEnd_toEndOf="parent"
    app:layout_constraintStart_toStartOf="parent"
    app:layout_constraintTop_toTopOf="parent" 
  />

</androidx.constraintlayout.widget.ConstraintLayout>
EOF

cat << EOF > ./app/src/main/res/values/colors.xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
  <color name="black">#FF000000</color>
  <color name="white">#FFFFFFFF</color>
  <color name="purple_200">#FFBB86FC</color>
  <color name="purple_500">#FF6200EE</color>
  <color name="purple_700">#FF3700B3</color>
  <color name="teal_200">#FF03DAC5</color>
  <color name="teal_700">#FF018786</color>
</resources>
EOF

cat << EOF > ./app/src/main/res/values/strings.xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
  <string name="app_name">${PROJECT_NAME}</string>
</resources>
EOF

cat << EOF > app/src/main/res/values/themes.xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
  <style name="Theme.${PROJECT_NAME}" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
    <item name="colorPrimary">@color/purple_500</item>
    <item name="colorPrimaryVariant">@color/purple_700</item>
    <item name="colorOnPrimary">@color/white</item>
    <item name="colorSecondary">@color/teal_200</item>
    <item name="colorSecondaryVariant">@color/teal_700</item>
    <item name="colorOnSecondary">@color/black</item>
    <item name="android:statusBarColor" tools:targetApi="l">?attr/colorPrimaryVariant</item>
  </style>
</resources>
EOF

mkdir -p app/src/main/res/xml
touch app/src/main/res/xml/data_extraction_rules.xml
touch app/src/main/res/xml/backup_rules.xml

touch app/proguard-rules.pro

echo ""
echo "Project ${PROJECT_NAME} scaffolded successfully!"
echo "Directory structure:"
tree 
