<div align="center">
  <img src="assets/images/muslim_logo.png" width="128" height="128" alt="Muslim App Logo">
  <h1>🕋 Muslim App</h1>
  <p><b>Your Elegant Daily companion for Spiritual Growth</b></p>

  [![Flutter](https://img.shields.io/badge/Flutter-v3.10+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
  [![License](https://img.shields.io/badge/License-Open%20Source-brightgreen)](LICENSE)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)](https://flutter.dev)
  [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-orange.svg)](CONTRIBUTING.md)
</div>

---

## 🌟 Overview

**Muslim App** is a modern, elegant, and comprehensive Islamic application built with Flutter. It's designed to be more than just an app; it's a daily companion for every Muslim, providing a seamless and spiritually enriching experience. 

Whether you're looking for high-quality Quran recitations, precise prayer timings, or a smart Zakat calculator, this app delivers it all with a premium Material 3 interface.

---

## ✨ Features

### 📖 Holy Quran
*   **Complete Quran**: Full Quran with all 114 Surahs in a clean, readable interface.
*   **Audio Recitation**: Crystal-clear audio from world-renowned Qaris (e.g., Mishary Rashid Alafasy).
*   **Surah Browser**: Browse and search through all Surahs with detailed information.
*   **Background Playback**: Continue listening with lock-screen controls and background audio support.

### 🕌 Prayer Times
*   **Precision Adhan**: Location-aware prayer times using the industry-standard `adhan` package.
*   **Visual Notifications**: Beautiful, custom-designed Adhan alerts via `awesome_notifications`.
*   **Daily Schedule**: View all five daily prayers (Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha) with accurate timings.

### 🧭 Qibla Finder
*   **Live Qibla**: Real-time direction finding using advanced device sensors and GPS integration.
*   **Visual Compass**: Animated compass pointing toward the Kaaba in Mecca.
*   **Location Awareness**: Automatically adjusts based on your current location.

### 📿 Azkar (Morning & Evening)
*   **Daily Supplications**: Complete collection of morning and evening remembrance (Athkar).
*   **Offline Access**: All Azkar available without internet connection.
*   **Categorized**: Organized by time of day for easy access.

### 📚 Hadith Collection
*   **Curated Hadith**: Authentic Hadith collections for daily reading.
*   **Offline Library**: Full access to Hadith without requiring internet.

### 🌟 99 Names of Allah
*   **Asma ul-Husna**: Complete list of Allah's beautiful names with meanings.
*   **Offline Access**: Available anytime, anywhere without connectivity.

### 📿 Digital Sebha (Tasbih)
*   **Minimalist Counter**: Simple and elegant digital prayer beads counter.
*   **Haptic Feedback**: Responsive tactile feedback on each count.
*   **Reset Functionality**: Easy reset to start new dhikr sessions.

### 💰 Zakat Calculator
*   **Intelligent Calculations**: Calculate Zakat based on current wealth, gold, silver, and assets.
*   **Gold Rate Integration**: Real-time gold price fetching via API for accurate Zakat values.
*   **Nisab Threshold**: Automatic calculation of minimum wealth requirements.

### ⚙️ Settings
*   **Localization**: Multi-language support (Arabic & English).
*   **Notifications**: Configure prayer time alerts and reminders.
*   **App Preferences**: Customize app behavior and appearance.

---

## 📸 App Experience

<div align="center">
  <table>
    <tr>
      <td><img src="app_review/WhatsApp Image 2026-01-16 at 3.44.11 AM (1).jpeg" width="200" alt="Home Screen"></td>
      <td><img src="app_review/WhatsApp Image 2026-01-16 at 3.44.11 AM.jpeg" width="200" alt="Quran Player"></td>
      <td><img src="app_review/WhatsApp Image 2026-01-16 at 3.44.10 AM (2).jpeg" width="200" alt="Qibla Finder"></td>
    </tr>
    <tr>
      <td align="center"><b>Home Dashboard</b></td>
      <td align="center"><b>Holy Quran</b></td>
      <td align="center"><b>Live Qibla</b></td>
    </tr>
    <tr>
      <td><img src="app_review/WhatsApp Image 2026-01-16 at 3.44.10 AM (4).jpeg" width="200" alt="Hadith"></td>
      <td><img src="app_review/WhatsApp Image 2026-01-16 at 3.44.10 AM.jpeg" width="200" alt="Names of Allah"></td>
      <td><img src="app_review/WhatsApp Image 2026-01-16 at 3.44.10 AM (1).jpeg" width="200" alt="Digital Sebha"></td>
    </tr>
    <tr>
      <td align="center"><b>Hadith Library</b></td>
      <td align="center"><b>99 Names</b></td>
      <td align="center"><b>Digital Sebha</b></td>
    </tr>
  </table>
</div>

---

## 🛠️ Technical Excellence

### Built With
| Category | Technology |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) v3.10+ |
| **State Management** | [flutter_bloc](https://pub.dev/packages/flutter_bloc) (BLoC/Cubit) |
| **Audio Engine** | [just_audio](https://pub.dev/packages/just_audio) + [audio_service](https://pub.dev/packages/audio_service) |
| **Prayer Times** | [adhan](https://pub.dev/packages/adhan) + [hijri](https://pub.dev/packages/hijri) |
| **Location & Qibla** | [geolocator](https://pub.dev/packages/geolocator) + [flutter_qiblah](https://pub.dev/packages/flutter_qiblah) |
| **Notifications** | [awesome_notifications](https://pub.dev/packages/awesome_notifications) |
| **DI & Architecture** | [get_it](https://pub.dev/packages/get_it) + [dartz](https://pub.dev/packages/dartz) (Either pattern) |
| **Persistence** | [shared_preferences](https://pub.dev/packages/shared_preferences) |
| **UI Enhancement** | [google_fonts](https://pub.dev/packages/google_fonts), [skeletonizer](https://pub.dev/packages/skeletonizer), [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) |
| **Utilities** | [url_launcher](https://pub.dev/packages/url_launcher), [share_plus](https://pub.dev/packages/share_plus), [in_app_review](https://pub.dev/packages/in_app_review) |

### Architecture Highlights
- **Clean Architecture**: Separation of concerns between UI, Business Logic (BLoC), and Data layers.
- **Offline-First Strategy**: Local caching ensures the app remains functional in low-connectivity areas.
- **Responsive Layouts**: Fully optimized for both phone and tablet form factors.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.10.0 or higher)
- Android Studio / VS Code
- An active Internet connection for the initial setup

### Installation
1.  **Clone the Repo**
    ```bash
    git clone https://github.com/MahmoudMagdy001/Muslim.git
    cd muslim
    ```
2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```
3.  **Launch the App**
    ```bash
    flutter run
    ```

---

## 🤝 Roadmap & Contributions
We are constantly improving! Future updates will include:
- [ ] Apple Watch & WearOS support.
- [ ] Community prayer tracking.
- [ ] Multi-language support expansion.

**Want to contribute?** We love PRs! Check out our [Contribution Guidelines](CONTRIBUTING.md) to get started.

---

## 📄 License & Contact

Distributed under the MIT License. See `LICENSE` for more information.

**Mahmoud Magdy**  
📧 [mahmodmansour2001@gmail.com](mailto:mahmodmansour2001@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/mahmoud-magdy-001/) | [GitHub](https://github.com/MahmoudMagdy001)

<div align="center">
  <sub>Built with ❤️ for the Ummah</sub>
</div>
