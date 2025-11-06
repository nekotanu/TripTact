# TripTact - Your Smart Travel Planner

**TripTact** is a Flutter-based travel planning app that helps users create, organize, and explore trips in a simple and intuitive way.
It allows users to plan destinations, discover popular places, select restaurants, and view personalized trip summaries — all in one clean interface.

---

## Features

* Create custom trips and add destinations easily
* Explore handpicked attractions and places to visit
* Choose from recommended restaurants for your trip
* Save and view trip summaries with detailed guides
* Open destinations directly in Google Maps
* Modern and responsive Flutter UI
* Offline-friendly and lightweight design

---

## Tech Stack

* **Framework:** Flutter (Dart)
* **State Management:** Provider
* **Navigation:** Material 3
* **Integration:** Google Maps (for directions)
* **Planned:** Firebase backend and live APIs

---

## Folder Structure

```
lib/
│
├── core/
│   ├── constants/
│   └── theme/
│
├── models/
│   ├── place.dart
│   └── trips.dart
│
├── provider/
│   └── trip_provider.dart
│
├── screens/
│   ├── home/
│   ├── create_trips/
│   ├── itinerary/
│   ├── loading/
│   └── splash/
│
└── services/
    ├── city_service.dart
    ├── places_service.dart
    └── restaurant_service.dart
```

---

## Getting Started

### 1. Clone this repository

```bash
git clone https://github.com/nekotanu/TripTact.git
```

### 2. Open the project folder

```bash
cd TripTact
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
flutter run
```

---

## Future Plans

* Dynamic data using live travel APIs
* Map-based route planner
* User authentication and cloud sync
* AI-based itinerary recommendations
* Offline trip caching

---

## Author

**Developed by:** Aayush ([@nekotanu](https://github.com/nekotanu))
