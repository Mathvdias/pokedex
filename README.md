# PokéDex Flutter

> App retrô de Pokémon com visual pixel-art, PWA web, lazy loading e parallel fetching — desenvolvido em Flutter 3.41.

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Flutter](https://img.shields.io/badge/Flutter-3.41-blue?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.11-blue?logo=dart)](https://dart.dev/)
[![PWA](https://img.shields.io/badge/PWA-ready-purple)](https://web.dev/progressive-web-apps/)
[![PokeAPI](https://img.shields.io/badge/API-PokeAPI-red)](https://pokeapi.co/)
[![Vercel](https://img.shields.io/badge/Deploy-Vercel-black?logo=vercel)](https://pokedex-matheus-vinicius.vercel.app/)

---

## 🌐 Demo — Web / PWA

**[pokedex-matheus-vinicius.vercel.app](https://pokedex-matheus-vinicius.vercel.app/)**

> Instalável como PWA no Chrome/Edge/Safari — clique em "Adicionar à tela inicial".

---

## 📸 Screenshots

> _Grave a tela com **Kap** (macOS gratuito → [getkap.co](https://getkap.co/)) ou `⌘ Shift 5` nativo, salve como GIF e cole aqui._

<!-- Demo GIF aqui -->

---

## Arquitetura

O projeto segue **Clean Architecture + MVVM**, organizado em camadas bem separadas:

```
lib/
├── main.dart                        # Entry point
└── src/
    ├── app/
    │   ├── app_widget.dart          # MaterialApp.router + tema
    │   ├── router.dart              # GoRouter — rotas com lazy loading
    │   ├── app_providers.dart       # Injeção de dependências (Provider)
    │   └── text_theme.dart          # Tokens de design (cores, fontes)
    │
    ├── pages/
    │   ├── home/
    │   │   ├── pokemons_page.dart   # LayoutBuilder mobile/web
    │   │   ├── mobile/              # ListView + cards
    │   │   └── web/                 # GridView responsivo (2-5 colunas)
    │   ├── details/
    │   │   ├── details_pokemon_page.dart
    │   │   ├── mobile/              # GIF hero + TabBar
    │   │   ├── states/              # State pattern (Start/Loading/Loaded/Error)
    │   │   └── components/          # Stats, About, Moves, TextFormatter
    │   └── splash/
    │
    ├── viewmodels/
    │   ├── pokemons_viewmodel.dart  # Infinite scroll + parallel fetch
    │   └── pokemon_detail_viewmodel.dart  # Parallel stats+species fetch
    │
    ├── services/
    │   ├── data/
    │   │   ├── providers/
    │   │   │   └── impl/
    │   │   │       └── http_client_provider.dart  # InterceptedHttp (log + retry)
    │   │   └── repository/impl/     # PokemonList / Pokemon / Details repos
    │   └── domain/models/           # PokemonModel, PokemonDetailModel, etc.
    │
    ├── states/                      # Sealed state classes (MVVM states)
    └── common/                      # ChipComponent, cores, ícones de tipo
```

### Fluxo de dados

```
PokeAPI
  └─► InterceptedHttp (log + retry automático)
        └─► IRestClient (interface)
              └─► Repositories (list / pokemon / details / species)
                    └─► ViewModels (ValueNotifier)
                          └─► Widgets (AnimatedBuilder / context.watch)
```

### Decisões de design

| Decisão | Motivo |
|---|---|
| **ValueNotifier** em vez de BLoC/Riverpod | Suficiente para o escopo; zero boilerplate |
| **GoRouter** | Deep linking nativo, URL limpa (`/details/pikachu`), compatível com PWA |
| **Future.wait** no fetch | Pokémon da página carregam em paralelo — 12× mais rápido que loop sequencial |
| **Deferred imports** | Cada rota é um chunk JS separado — bundle inicial ~76% menor na web |
| **intercepted_http** | Log + retry em erros de rede sem trocar o `http.Client` |

---

## Stack

| Categoria | Package | Versão |
|---|---|---|
| Navegação | `go_router` | ^16 |
| HTTP | `intercepted_http` + `http` | ^0.2 / ^1.3 |
| Web perf | `flutter_lazy_load_web` | ^0.1 |
| Estado | `provider` | ^6.1 |
| Imagens | `cached_network_image` | ^3.4 |
| Fonts | `google_fonts` | ^6 (Press Start 2P + VT323) |
| Resultado | `multiple_result` | ^5 |
| i18n | `intl` | ^0.20 |

---

## Rodando localmente

**Pré-requisitos:** Flutter 3.41+ (`flutter --version`)

```bash
git clone https://github.com/Mathvdias/pokedex.git
cd pokedex
flutter pub get

# Mobile
flutter run

# Web
flutter run -d chrome

# Build PWA
flutter build web --release
```

---

## Deploy (Vercel)

O projeto usa `build.sh` para instalar o Flutter SDK no ambiente da Vercel:

```bash
# vercel.json
buildCommand: "chmod +x build.sh && ./build.sh"
outputDirectory: "build/web"
```

O `build.sh` clona o Flutter stable, roda `pub get` e `flutter build web --release`.

---

## API

Todas as chamadas são para a [PokéAPI v2](https://pokeapi.co/docs/v2) — pública e sem autenticação.

| Endpoint | Uso |
|---|---|
| `/pokemon?limit=20&offset=N` | Lista paginada |
| `/pokemon/:id` | Stats, sprites, tipos, golpes |
| `/pokemon-species/:id` | Descrição, espécie, categoria |

As chamadas de stats e species disparam **em paralelo** (`Future.wait`) — sem waterfall.

---

## Desenvolvido por

**Matheus Dias** — [github.com/Mathvdias](https://github.com/Mathvdias)
