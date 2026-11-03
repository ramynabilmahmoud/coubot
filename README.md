# Coubot 🤖: Flutter App for an Autonomous Delivery Robot

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![State](https://img.shields.io/badge/state-Bloc%20%2F%20Cubit-1E88E5)
![Backend](https://img.shields.io/badge/backend-Supabase-3ECF8E?logo=supabase)
![AI](https://img.shields.io/badge/AI-Google%20Gemini-8E75B2?logo=googlegemini&logoColor=white)

> Order food and drinks, pay, and watch a **real robot** deliver them to you, live.
> B.Tech graduation project, New Cairo Technological University (2026). I built the mobile app.

## ✨ Features
- **Menu & smart cart**: browse food, drinks and essentials, add to cart in one tap
- **Checkout & orders**: authenticated orders through Supabase Auth, with order history
- **Real-time robot tracking**: follow the robot's status and location to your delivery point
- **AI food recommendations**: suggestions from **Google Gemini**, called through a **Supabase Edge Function** so the AI key never ships inside the app
- **Notifications**: local notifications for order updates
- **Arabic / English**: full localization with RTL support
- **Light & dark themes**
- **Deep links**: open specific screens from links (app_links)
- **Forced updates**: prompts users to update old versions (upgrader)

## 🏗 Architecture

Clean Architecture with feature-first folders. Features with business logic have `data / domain / presentation` layers; simple UI-only features keep just `presentation`.

```
lib/
├── ai/                  # Gemini recommendations: config, models, service, widgets
├── config/
│   ├── routes/          # auto_route router + paths
│   └── themes/          # light & dark themes, colors
├── core/
│   ├── errors/          # failure types
│   ├── extensions/
│   ├── services/        # notification service
│   ├── utils/
│   └── widgets/         # shared widgets
├── features/
│   ├── app_splash/      # data · domain · presentation
│   ├── app_layout/      # data · domain · presentation
│   ├── auth/            # data · domain · presentation
│   ├── home/            # data · domain · presentation
│   ├── cart/            # data · presentation
│   ├── notifications/   # data · presentation
│   ├── checkout/        # presentation
│   ├── orders/          # presentation
│   └── profile/         # presentation
├── generated/intl/      # generated localization code
└── l10n/                # Arabic & English strings
```

```
UI (Widgets) → Cubit → Repository → Data source (Supabase / Hive)
```

**Why Bloc/Cubit?** Predictable state transitions (loading → success → error) that are easy to unit test. Cubits are tested without any UI (see `test/`).

**Errors:** `dartz` `Either<Failure, T>`, so repository calls return a success or a typed failure instead of throwing.

## 🧰 Tech stack
| Area | Packages |
|---|---|
| State | flutter_bloc (Cubit) |
| DI | get_it, injectable |
| Navigation | auto_route, app_links |
| Backend | supabase_flutter (Auth, PostgreSQL, Edge Functions, **Row Level Security**) |
| AI | Google Gemini (via Supabase Edge Function) |
| Network | dio, http |
| Local storage | hive, shared_preferences |
| UI | flutter_svg, lottie, cached_network_image, google_fonts, pinput |
| i18n | intl, flutter_localizations, intl_utils |
| Notifications | flutter_local_notifications |

## 🔐 Security
- Supabase **Row Level Security** is enabled, so users can only access their own data.
- The Gemini API key lives on the server (Edge Function), not in the app.
- Secrets live in `.env` (not committed). Copy `.env.example` to `.env` and fill in your values.

## 🚀 Getting started
```bash
git clone https://github.com/ramynabilmahmoud/coubot.git
cd coubot
cp .env.example .env        # add SUPABASE_URL and SUPABASE_ANON_KEY
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```
Requires Flutter 3.x / Dart SDK ^3.9.

## 🧪 Testing
```bash
flutter test
```
Includes unit tests for `HomeCubit` and cart state, plus widget tests. See also [TEST_PLAN.md](TEST_PLAN.md).

## 📚 Docs
- [Test plan](TEST_PLAN.md) · [Localization audit](LOCALIZATION_AUDIT.md) · [Responsive audit](RESPONSIVE_AUDIT.md)

## 🗺 Roadmap
- [ ] Integration tests for the order flow
- [ ] Payment gateway integration
- [ ] Push notifications (FCM)

## 👤 Author
**Ramy Nabil Mahran**, Flutter Developer · [LinkedIn](https://www.linkedin.com/in/ramynabilmahran/) · ramynabilmahran@gmail.com
