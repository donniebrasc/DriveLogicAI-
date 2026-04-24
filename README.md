<div align="center">
<img width="1200" height="475" alt="GHBanner" src="https://github.com/user-attachments/assets/0aa67016-6eaf-458a-adb2-6e31a0763ed6" />
</div>

# DriveLogicAI

**Package name (Play Console):** `com.DriveLogicAI`

## Run Locally (Web)

**Prerequisites:** Node.js

1. Install dependencies:
   `npm install`
2. Set the `GEMINI_API_KEY` in [.env.local](.env.local) to your Gemini API key
3. Run the app:
   `npm run dev`

## Build Release AAB (Android App Bundle)

A release AAB is required for uploading to Google Play.

### One-time keystore setup

```bash
keytool -genkeypair -v -keystore android/app/release.jks -alias drivelogicai \
  -keyalg RSA -keysize 2048 -validity 10000
```

Copy `android/app/key.properties.example` to `android/app/key.properties` and fill in your keystore details:

```
storeFile=release.jks
storePassword=<your_store_password>
keyAlias=drivelogicai
keyPassword=<your_key_password>
```

> ⚠️ Never commit `key.properties` or `release.jks` to source control.

### Build steps

```bash
# 1. Build the web assets
npm install
npm run build

# 2. Sync to Android
npx cap sync android

# 3. Build the signed release AAB
cd android
chmod +x gradlew
./gradlew bundleRelease
```

The AAB will be at:
`android/app/build/outputs/bundle/release/app-release.aab`

### Automated CI/CD

Push a version tag (e.g. `v1.0.0`) to trigger the GitHub Actions workflow at
[`.github/workflows/release.yml`](.github/workflows/release.yml).

Required repository secrets:
| Secret | Description |
|---|---|
| `KEYSTORE_BASE64` | Base64-encoded `.jks` keystore (`base64 -w 0 release.jks`) |
| `STORE_PASSWORD` | Keystore store password |
| `KEY_ALIAS` | Key alias (e.g. `drivelogicai`) |
| `KEY_PASSWORD` | Key password |

Optionally add `SERVICE_ACCOUNT_JSON` and uncomment the Play Store upload step to publish automatically.
