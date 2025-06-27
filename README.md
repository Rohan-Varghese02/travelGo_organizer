# TravLGO Organizer

**TravLGO Organizer** is the companion **event management application** for event organizers using **TravLGO**. Built with **Flutter**, this app empowers organizers to manage events, post blogs, communicate with platform admins, track analytics, and generate custom coupon codes—all in one place.

---

## 📖 Table of Contents
- [Description](#description)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Dependencies](#dependencies)

---

## 📝 Description

TravLGO Organizer is designed to give event hosts the power and flexibility to manage their events seamlessly. From creating new listings to tracking engagement, this app provides all the tools necessary to promote, analyze, and control event logistics effectively.

Whether you're organizing a concert, seminar, or virtual meetup, TravLGO Organizer ensures you're always in charge.

---

## ✨ Features

- **Add & Manage Events** – Create, update, or delete your own events  
- **Event Blog Posts** – Share announcements, highlights, and behind-the-scenes via in-app blogging  
- **Admin Communication** – Send requests or queries directly to platform administrators  
- **Analytics Dashboard** – View engagement metrics and ticket sales insights in real-time  
- **Coupon Code Generator** – Create promotional discount codes for specific events  
- **Secure Access** – Role-based authentication for organizers  

---

## 🛠️ Technologies Used

- **Flutter** – Cross-platform UI toolkit  
- **Dart** – Primary development language  
- **HTTP** – For secure API communication  
- **Hive / Secure Storage** – Local caching and secure token handling  
- **Charts Flutter / Custom Analytics UI** – For visualizing organizer data  
- **BLoC or setState** – Depending on module complexity  
- **Firebase Core** – Backend services integration  
- **Socket.IO** – For real-time notifications or admin communication

---

## 📦 Dependencies

```yaml
dependencies:
  bloc: ^9.0.0
  build_runner: ^2.4.15
  buttons_tabbar: ^1.3.15
  carousel_slider: ^5.0.0
  cloud_firestore: ^5.6.5
  crypto: ^3.0.6
  cupertino_icons: ^1.0.8
  dio: ^5.8.0+1
  dotted_border: ^2.1.0
  firebase_auth: ^5.5.1
  firebase_core: ^3.12.1
  flutter:
    sdk: flutter
  flutter_bloc: ^9.1.0
  flutter_stripe: ^11.5.0
  flutter_svg: ^2.0.17
  font_awesome_flutter: ^10.8.0
  google_fonts: ^6.2.1
  google_nav_bar: ^5.0.7
  google_sign_in: ^6.3.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  hive_generator: ^2.0.1
  http: ^1.3.0
  image_picker: ^1.1.2
  intl: ^0.20.2
  lottie: ^3.3.1
  shared_preferences: ^2.5.3
